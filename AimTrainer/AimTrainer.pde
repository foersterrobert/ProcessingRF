PImage scopeImage;
PImage gunImage;
float cameraRotateX;
float cameraRotateY;
float cameraSpeed;

class Player {
  float eyeX, eyeY, eyeZ; // Position Kamera
  float centerX, centerY, centerZ; // Zielpunkt der Kamera

  // Konstruktor
  Player() {
    eyeX = 0;
    eyeY = -height/6.0;
    eyeZ = (height/2.0)/tan(PI*30.0/180.0);
    centerX = 0;
    centerY = 0;
    centerZ = 0;
  }

  void drawPlayer() {
    camera(eyeX, eyeY, eyeZ,
      centerX, centerY, centerZ,
      0, 1, 0);
    noStroke();
    beginShape();
    texture(scopeImage);
    vertex(centerX - 20, centerY - 20, centerZ, 0, 0);
    vertex(centerX + 20, centerY - 20, centerZ, scopeImage.width, 0);
    vertex(centerX + 20, centerY + 20, centerZ, scopeImage.width, scopeImage.height);
    vertex(centerX - 20, centerY + 20, centerZ, 0, scopeImage.height);
    endShape();

    beginShape();
    texture(gunImage);
    vertex(centerX + 200, centerY + 100, centerZ, 0, 0);
    vertex(centerX + 460, centerY + 100, centerZ, gunImage.width, 0);
    vertex(centerX + 460, centerY + 240, centerZ, gunImage.width, gunImage.height);
    vertex(centerX + 200, centerY + 240, centerZ, 0, gunImage.height);
    endShape();
  }
}

class Target {
  boolean hit;
  float x, y, z;

  Target(float posx, float posy) {
    hit = false;
    x = posx;
    y = posy;
    z = -100;
  }

  void drawTarget() {
    if (hit == false) {
      pushMatrix();
      translate(x, y, z);
      sphere(20);
      popMatrix();
    }
  }
}

class Ground {
float cellNum = 4;
  float cellSize = 20;

  Ground(float aCellNum, float aCellSize) {
    cellNum = aCellNum;
    cellSize = aCellSize;
  }

  void update() {
    stroke(200);

    float size = cellNum * cellSize;
    float halfSize = size / 2.0;

    // Zeichne Linien entlang der x-Achse
    for (int i = 0; i < cellNum+1; i++) {
      float x = -halfSize + i * cellSize;
      line(x, 0, -halfSize, x, 0, halfSize);
    }

    // Zeichne Linien entlang der z-Achse
    for (int i = 0; i < cellNum+1; i++) {
      float z = -halfSize + i * cellSize;
      line(-halfSize, 0, z, halfSize, 0, z);
    }
  }
}

Ground ground;
Player player;
Target targets[];

void setup() {
  size(900, 600, P3D);
  player = new Player();
  ground = new Ground(40, 20);
  cameraSpeed = TWO_PI / width;
  cameraRotateY = -PI/6;
  targets = new Target[5];
  for (int i = 0; i < targets.length; i++) {
    targets[i] = new Target(i * 45, 0);
  }
  scopeImage = loadImage("scope.png");
  gunImage = loadImage("gun.png");
}

void draw() {
  noCursor();
  background(0);
  for (int i = 0; i < targets.length; i++) {
    targets[i].drawTarget();
  }
  ground.update();
  player.drawPlayer();
}

void mouseClicked() {
  for (int i = 0; i < targets.length; i++) {
    if (player.centerX == targets[i].x && player.centerY == targets[i].y) {
      targets[i].hit = true;
    }
  }
}

void mouseMoved() {
  player.centerX += (mouseX - pmouseX) * cameraSpeed * 30;
  player.centerY -= (pmouseY - mouseY) * cameraSpeed * 50;
}
