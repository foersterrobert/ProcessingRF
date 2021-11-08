class Ball {
  PVector pos;
  float speed;
  int radius;
  color c;
  
  
  Ball(PVector _pos, float _speed, int _radius, color _c) {
    pos = _pos;
    speed = _speed;
    radius = _radius;
    c = _c;
  }
  
  void blit() {
    fill(c);
    ellipse(pos.x, pos.y, radius, radius);
  }
}

Ball player;
Ball[] enemies;

void setup() {
  size(400, 400);
  player = new Ball(new PVector(0, 0), 2, 8, color(255, 0, 0));
  enemies = new Ball[20];
  for (int i = 0; i<enemies.length; i++) {
    float eX = map(i, 0, enemies.length-1, 0, 360);
    float eFactor = map(i, 0, enemies.length-1, width/4, width/2.1);
    PVector ePos = new PVector(sin(radians(eX))*eFactor, cos(radians(eX))*eFactor);
    enemies[i] = new Ball(ePos, 2, 6, color(255));
  }
}

void draw() {
  translate(width/2, height/2);
  background(0);
  player.blit();
  for (int i = 0; i<enemies.length; i++) {
    enemies[i].blit();
  }
}

void keyPressed() {
}
