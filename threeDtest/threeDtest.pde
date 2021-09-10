boolean started = false;
int x = 0;
PFont scoreFont;
int score;
int round;
PImage bg;
PImage groundImage;
PShape threedchar;
PShape rocket;

class Player {
  float eyeX, eyeY, eyeZ; // Position Kamera
  float centerX, centerY, centerZ; // Zielpunkt der Kamera
  float SPEED = 5; // Fortbewegung pro Schritt
  int charRotate = 0;

  // Konstruktor
  Player() {
    eyeX = 0;
    eyeY = -100;
    eyeZ = 0;
    centerX = 0;
    centerY = -20;
    centerZ = -240;
  }
  
  void drawPlayer() {
    camera(eyeX, eyeY, eyeZ,
    centerX, centerY, centerZ,
    0, 1, 0);
    pushMatrix();
    translate(eyeX, 0, eyeZ - 100);
    rotateX(radians(180));
    rotateY(radians(charRotate));
    scale(3);
    shape(threedchar);
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
    w = posw;
    h = posh;
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
Player player;
Ground ground;

void setup() {
  size(600, 400, P3D);
  ground = new Ground();
  player = new Player();
  walls = new Wall[4 + round];
  for (int i = 0; i < walls.length; i++) {
    walls[i] = new Wall(random(-180, 180), 0, random(-1400, -820), 40, 3, random(2, 2 + round / 4));
  }
  bg = loadImage("bg.jpg");
  bg.resize(400, 210);
  groundImage = loadImage("ground.jpg");
  scoreFont = createFont("Terminator Two", 26);
  score = 0;
  round = 1;
  threedchar = loadShape("3DScan_Man_016.obj");
  threedchar.setFill(color(247, 237, 178));
  rocket = loadShape("rocket.obj");
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
    if (keyCode == LEFT && player.eyeX > -200) {
      player.eyeX -= player.SPEED;
      player.centerX -= player.SPEED;
      player.charRotate = -90;
    }
    if (keyCode == RIGHT && player.eyeX < 200) {
      player.eyeX += player.SPEED;
      player.centerX += player.SPEED;
      player.charRotate = 90;
    }
    if (keyCode == UP && player.eyeZ > -600) {
      player.eyeZ -= player.SPEED;
      player.centerZ -= player.SPEED;
      player.charRotate = 0;
    }
    if (keyCode == DOWN && player.eyeZ < 0) {
      player.eyeZ += player.SPEED;
      player.centerZ += player.SPEED;
      player.charRotate = 180;
    }
  }
  
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
  text("Score " + score, -180, -180);
  text("Round " + round, 40, -180);
  if (started == false) {
    text("Press Space", -110, -60);
  }
  popMatrix();
  noCursor();
  player.drawPlayer();
  for (int i = 0; i < walls.length; i++) {
    if (walls[i].active == true) {
      walls[i].drawWall();
    }
  }
  ground.update();
  pushMatrix();
  noStroke();
  fill(255, 255, 0);
  translate(cos(radians(x/3)) * 160,  - 80 - abs(sin(radians(x/3)) * 100), -750);
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
    if (abs(player.eyeZ - 70 - walls[i].z) <= walls[i].w && abs(player.eyeX - walls[i].x) <= walls[i].w && walls[i].active == true) {
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


boolean newRound() {
  for (int i = 0; i < walls.length; i++) {
    if (walls[i].active == true) {
      return false;
    }
  }
  return true;
}
