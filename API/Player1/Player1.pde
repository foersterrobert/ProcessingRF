import http.requests.*;
import processing.sound.*;

int id = 1;
String name = "Robert";

boolean started = false;
int x = 0;
int load = 0;
PFont scoreFont;
int n;
int round;
String wallCords;
String alivePlayers = "";
PImage bg;
PImage groundImage;
PShape[] model = new PShape[5];
PShape rocket;
SoundFile music;

class Player {
  float eyeX, eyeY, eyeZ; // Position Kamera
  float centerX, centerY, centerZ; // Zielpunkt der Kamera
  float SPEED = 5; // Fortbewegung pro Schritt
  int charRotate = 0;
  float animation = 0;
  boolean dead;

  // Konstruktor
  Player() {
    eyeX = 0.01;
    eyeY = -100;
    eyeZ = -0.01;
    centerX = 0;
    centerY = -20;
    centerZ = -240;
  }

  void drawPlayer(boolean cam) {
    if (cam) {
      camera(eyeX, eyeY, eyeZ, 
        centerX, centerY, centerZ, 
        0, 1, 0);
    }
    if (dead == false) {
      pushMatrix();
      translate(eyeX, 0, eyeZ - 100);
      rotateX(radians(180));
      rotateY(radians(charRotate));
      scale(750);
      shape(model[floor(animation) % model.length]);
      popMatrix();
    }
  }
}

class Wall {
  float x;
  float z;
  int h;
  int w;
  float speed;
  float r = random(255);
  float g = random(255);
  float b = random(255);
  boolean active = true;

  Wall(float posx, float posz, int posw, int posh, float nspeed) {
    x = posx;
    z = posz;
    h = posh;
    w = posw;
    speed = nspeed;
  }

  void drawWall() {
    pushMatrix();
    noStroke();
    fill(color(r, g, b));
    translate(x, 0-w/2, z);
    box(w);
    for (int i = 0; i < h; i++) {
      translate(0, -w, 0);
      box(w);
    }
    popMatrix();
  }

  void move() {
    z += speed;
  }
}

class Ground {
  void update() {
    beginShape();
    texture(groundImage);
    vertex(-200, 0, -800, 0, 0);
    vertex(200, 0, -800, groundImage.width, 0);
    vertex(200, 0, 0, groundImage.width, groundImage.height);
    vertex(-200, 0, 0, 0, groundImage.height);
    endShape();
  }
}

Wall walls[];
Player player;
Player players[];
Ground ground;

void setup() {
  size(1200, 800, P3D);
  ground = new Ground();
  player = new Player();
  walls = new Wall[3 + id + round];
  for (int i = 0; i < walls.length; i++) {
    walls[i] = new Wall(random(-180, 180), random(-1400, -820), 40, 3, random(2, 2 + round / 4));
  }
  bg = loadImage("bg.jpg");
  bg.resize(400, 210);
  groundImage = loadImage("ground.jpg");
  scoreFont = createFont("Terminator Two", 20);
  round = 1;
  wallCords = "";
  for (int i = 0; i < walls.length; i++) {
    wallCords += walls[i].x + "$";
    wallCords += walls[i].z + "$";
    wallCords += walls[i].w + "$";
    wallCords += walls[i].h + "$";
    wallCords += walls[i].speed + "$";
    wallCords += walls[i].r + "$";
    wallCords += walls[i].g + "$";
    wallCords += walls[i].b + "$";
    wallCords += walls[i].active + "_";
  }
  PutRequest put = new PutRequest("http://127.0.0.1:5000/3d/1/" + id);
  put.addHeader("Content-Type", "application/json");
  put.addData("{\"x\":" + player.eyeX + ",\"y\":" + player.eyeY + ",\"z\":" + player.eyeZ + ",\"r\":" + player.charRotate + ",\"animation\":" + player.animation + ",\"round\":" + round + ",\"walls\":\"" + wallCords + "\",\"dead\":\"" + player.dead + "\",\"name\":\"" + name + "\"}");
  put.send();
  JSONObject response = parseJSONObject(put.getContent());
  n = response.getInt("n");
  String data = response.getString("data");
  players = new Player[n];
  if (n > 0) {
    String[] dataList = split(data, ",");
    for (int i = 0; i < dataList.length; i++) {
      players[i] = new Player();
    }
  }
  for (int i = 0; i < model.length; i++) {
    model[i] = loadShape("base" + (i + 1) + ".obj");
  }
  rocket = loadShape("rocket.obj");
  music = new SoundFile(this, "music.mp3");
  music.loop();
}

void draw() {
  x += round;
  if (newRound()) {
    round += 1;
    walls = new Wall[4 + round];
    for (int i = 0; i < walls.length; i++) {
      walls[i] = new Wall(random(-180, 180), random(-1400, -820), 40, 3, random(2, 2 + round / 4));
    }
  }

  if (keyPressed) {
    if (id == 1) {
      if (key == 32) {
        started = true;
      }
      if (key == 'r' || key == 'R') {
        restart();
      }
    }
    if (keyCode == LEFT && player.eyeX > -200) {
      player.eyeX -= player.SPEED;
      player.centerX -= player.SPEED;
      player.charRotate = -90;
      player.animation += 0.2;
    }
    if (keyCode == RIGHT && player.eyeX < 200) {
      player.eyeX += player.SPEED;
      player.centerX += player.SPEED;
      player.charRotate = 90;
      player.animation += 0.2;
    }
    if (keyCode == UP && player.eyeZ > -600) {
      player.eyeZ -= player.SPEED;
      player.centerZ -= player.SPEED;
      player.charRotate = 1;
      player.animation += 0.2;
    }
    if (keyCode == DOWN && player.eyeZ < 0) {
      player.eyeZ += player.SPEED;
      player.centerZ += player.SPEED;
      player.charRotate = 180;
      player.animation += 0.2;
    }
  }
  music.amp(0.5 + abs(player.eyeZ / 1200));
  if (started == true) {
    moveScreen();
  }
  for (int i = 0; i < walls.length; i++) {
    if (abs(player.eyeZ - 70 - walls[i].z) <= walls[i].w && abs(player.eyeX - walls[i].x) <= walls[i].w && walls[i].active == true) {
      player.dead = true;
      break;
    }
  }
  if (load % 10 == 0) {
    thread("loadApi");
  }
  load += 1;
  updateScreen();
}

void updateScreen() {
  background(0);
  colorMode(HSB);
  pointLight(0, 0, 1000, 100, -200, 0);
  colorMode(RGB);
  textFont(scoreFont);
  pushMatrix();
  translate(0, 0, -780);
  image(bg, - bg.width/ 2, - bg.height);
  translate(0, 0, 4);
  text(alivePlayers, -180, -180);
  text("Round " + round, 40, -180);
  if (started == false && id == 1) {
    text("Press Space", -110, -60);
  }
  popMatrix();
  noCursor();
  player.drawPlayer(true);
  for (int i = 0; i < players.length; i++) {
    players[i].drawPlayer(false);
  }
  for (int i = 0; i < walls.length; i++) {
    if (walls[i].active == true) {
      walls[i].drawWall();
    }
  }
  ground.update();
  pushMatrix();
  noStroke();
  fill(255, 255, 0);
  translate(cos(radians(x/3)) * 160, - abs(sin(radians(x/3)) * 160), -750);
  rotateX(radians(abs(cos(radians(x/3))) * 90 + 90));
  scale(.2);
  shape(rocket);
  popMatrix();
}

void moveScreen() {
  for (int i = 0; i < walls.length; i++) {
    walls[i].move();
    if (walls[i].z > 0 & walls[i].active == true) {
      walls[i].active = false;
    }
  }
}

void restart() {
  round = 1;
  player.dead = false;
  walls = new Wall[4 + round];
  for (int j = 0; j < walls.length; j++) {
    walls[j] = new Wall(random(-180, 180), random(-1400, -800), 40, 3, random(2, 2 + round / 4));
  }
  started = false;
}

void loadApi() {
  wallCords = "";
  for (int i = 0; i < walls.length; i++) {
    wallCords += walls[i].x + "$";
    wallCords += walls[i].z + "$";
    wallCords += walls[i].w + "$";
    wallCords += walls[i].h + "$";
    wallCords += walls[i].speed + "$";
    wallCords += walls[i].r + "$";
    wallCords += walls[i].g + "$";
    wallCords += walls[i].b + "$";
    wallCords += walls[i].active + "_";
  }
  PostRequest post = new PostRequest("http://127.0.0.1:5000/3d/1/" + id);
  post.addHeader("Content-Type", "application/json");
  post.addData("{\"x\":" + player.eyeX + ",\"y\":" + player.eyeY + ",\"z\":" + player.eyeZ + ",\"r\":" + player.charRotate + ",\"animation\":" + player.animation + ",\"round\":" + round + ",\"walls\":\"" + wallCords + "\",\"dead\":\"" + player.dead + "\",\"name\":\"" + name + "\"}");
  post.send();
  JSONObject response = parseJSONObject(post.getContent());
  String data = response.getString("data");
  if (response.getInt("n") != n) {
    n = response.getInt("n");
    players = new Player[n];
    if (n > 0) {
      String[] dataList = split(data, ",");
      for (int i = 0; i < dataList.length; i++) {
        players[i] = new Player();
      }
    }
  }
  alivePlayers = "";
  if (player.dead == false) {
    alivePlayers += name + " ";
  }
  data = data.replace("[", "");
  data = data.replace("]", "");
  if (n > 0) {
    String[] dataList = split(data, ",");
    for (int i = 0; i < dataList.length; i++) {
      String[] playerList = split(dataList[i], ";");
      players[i].eyeX = float(trim(playerList[2]));
      players[i].eyeZ = float(trim(playerList[4]));
      players[i].charRotate = int(trim(playerList[5]));
      players[i].animation = int(trim(playerList[6]));
      players[i].dead = boolean(trim(playerList[9]));
      if (players[i].dead == false) {
        alivePlayers += playerList[10];
      }

      if (int(trim(playerList[0])) == 1) {
        round = int(playerList[7]);
        playerList[8] = playerList[8].substring(0, playerList[8].length()-1);
        String[] wallsList = split(playerList[8], "_");
        if (wallsList.length != walls.length) {
          walls = new Wall[wallsList.length];
          for (int j = 0; j < wallsList.length; j++) {
            String[] wallList = split(wallsList[j], "$");
            walls[j] = new Wall(float(wallList[0]), float(wallList[1]), int(wallList[2]), int(wallList[3]), float(wallList[4]));
            walls[j].r = float(wallList[5]);
            walls[j].g = float(wallList[6]);
            walls[j].b = float(wallList[7]);
            walls[j].active = boolean(wallList[8]);
          }
        }
        else {
          for (int j = 0; j < wallsList.length; j++) {
            String[] wallList = split(wallsList[j], "$");
            walls[j].z = float(wallList[1]);
          }
        }
      }
    }
  }
}

boolean newRound() {
  for (int i = 0; i < walls.length; i++) {
    if (walls[i].active == true) {
      return false;
    }
  }
  return true;
}
