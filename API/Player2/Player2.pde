import http.requests.*;
import processing.sound.*;

boolean started = false;
int x = 0;
int load = 0;
PFont scoreFont;
int score;
int otherScore;
int round;
String wallCords;
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

  // Konstruktor
  Player() {
    eyeX = 0;
    eyeY = -100;
    eyeZ = 0;
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
    pushMatrix();
    translate(eyeX, 0, eyeZ - 100);
    rotateX(radians(180));
    rotateY(radians(charRotate));
    scale(750);
    shape(model[floor(animation) % model.length]);
    popMatrix();
  }
}

class Wall {
  float x;
  float y;
  float z;
  int h;
  int w;
  float speed;
  color c = color(random(255), random(255), random(255));
  boolean active = true;

  Wall(float posx, float posy, float posz, int posw, int posh, float nspeed) {
    x = posx;
    y = posy;
    z = posz;
    h = posh;
    w = posw;
    speed = nspeed;
  }

  void drawWall() {
    pushMatrix();
    noStroke();
    fill(c);
    translate(x, y-w/2, z);
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
Player player1;
Player player2;
Ground ground;

void setup() {
  size(1200, 800, P3D);
  ground = new Ground();
  player1 = new Player();
  player2 = new Player();
  walls = new Wall[4 + round];
  for (int i = 0; i < walls.length; i++) {
    walls[i] = new Wall(random(-180, 180), 0, random(-1400, -820), 40, 3, random(2, 2 + round / 4));
  }
  bg = loadImage("bg.jpg");
  bg.resize(400, 210);
  groundImage = loadImage("ground.jpg");
  scoreFont = createFont("Terminator Two", 22);
  score = 0;
  otherScore = 0;
  round = 1;
  wallCords = "";
  for (int i = 0; i < walls.length; i++) {
    wallCords += walls[i].x + "$";
    wallCords += walls[i].z + "$";
    wallCords += walls[i].h + "$";
    wallCords += walls[i].w + "$";
    wallCords += walls[i].speed + "$";
    wallCords += walls[i].c + "$";
    wallCords += walls[i].active + "_";
  }
  PutRequest put = new PutRequest("http://127.0.0.1:5000/3d/1/1");
  put.addHeader("Content-Type", "application/json");
  put.addData("{\"x\":" + player1.eyeX + ",\"y\":" + player1.eyeY + ",\"z\":" + player1.eyeZ + ",\"r\":" + player1.charRotate + ",\"animation\":" + player1.animation + ",\"score\":" + score + ",\"walls\":\"" + wallCords + "\"}");
  put.send();
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
      walls[i] = new Wall(random(-180, 180), 0, random(-1400, -820), 40, 3, random(2, 2 + round / 4));
    }
  }

  if (keyPressed) {
    if (started == false) {
      if (key == 32) {
        started = true;
      }
    }
    if (keyCode == LEFT && player1.eyeX > -200) {
      player1.eyeX -= player1.SPEED;
      player1.centerX -= player1.SPEED;
      player1.charRotate = -90;
      player1.animation += 0.2;
    }
    if (keyCode == RIGHT && player1.eyeX < 200) {
      player1.eyeX += player1.SPEED;
      player1.centerX += player1.SPEED;
      player1.charRotate = 90;
      player1.animation += 0.2;
    }
    if (keyCode == UP && player1.eyeZ > -600) {
      player1.eyeZ -= player1.SPEED;
      player1.centerZ -= player1.SPEED;
      player1.charRotate = 1;
      player1.animation += 0.2;
    }
    if (keyCode == DOWN && player1.eyeZ < 0) {
      player1.eyeZ += player1.SPEED;
      player1.centerZ += player1.SPEED;
      player1.charRotate = 180;
      player1.animation += 0.2;
    }
  }


  if (load % 100 == 0) {
    thread("loadApi");
  }
  load += 1;

  music.amp(0.5 + abs(player1.eyeZ / 1200));

  if (started == true) {
    moveScreen();
  }
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
  text("Player 1 " + score, -180, -180);
  text("Player 2 " + otherScore, -180, -150);
  text("Round " + round, 40, -180);
  if (started == false) {
    text("Press Space", -110, -60);
  }
  popMatrix();
  noCursor();
  player1.drawPlayer(true);
  player2.drawPlayer(false);
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
      score += round;
    }
  }

  for (int i = 0; i < walls.length; i++) {
    if (abs(player1.eyeZ - 70 - walls[i].z) <= walls[i].w && abs(player1.eyeX - walls[i].x) <= walls[i].w && walls[i].active == true) {
      score = 0;
      round = 1;
      walls = new Wall[4 + round];
      for (int j = 0; j < walls.length; j++) {
        walls[j] = new Wall(random(-180, 180), 0, random(-1400, -800), 40, 3, random(2, 2 + round / 4));
      }
      started = false;
      delay(400);
      break;
    }
  }
}


void loadApi() {
  wallCords = "";
  for (int i = 0; i < walls.length; i++) {
    wallCords += walls[i].x + "$";
    wallCords += walls[i].z + "$";
    wallCords += walls[i].h + "$";
    wallCords += walls[i].w + "$";
    wallCords += walls[i].speed + "$";
    wallCords += walls[i].c + "$";
    wallCords += walls[i].active + "_";
  }
  PostRequest post = new PostRequest("http://127.0.0.1:5000/3d/1/1");
  post.addHeader("Content-Type", "application/json");
  post.addData("{\"x\":" + player1.eyeX + ",\"y\":" + player1.eyeY + ",\"z\":" + player1.eyeZ + ",\"r\":" + player1.charRotate + ",\"animation\":" + player1.animation + ",\"score\":" + score + ",\"walls\":\"" + wallCords + "\"}");
  post.send();
  JSONObject response = parseJSONObject(post.getContent());
  int n = response.getInt("n");
  String data = response.getString("data");
  if (n > 0) {
    print("see you tomorrow, deutsch nicht vergessen"
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
