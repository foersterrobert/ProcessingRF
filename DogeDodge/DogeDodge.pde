import processing.sound.*;

class Ball {
  PVector pos;
  PVector speed;
  int radius;
  color c;
  boolean active = true;
  
  Ball(PVector _pos, float _speed, int _radius, color _c, PVector _target) {
    pos = _pos;
    radius = _radius;
    c = _c;
    float disX = _target.x - pos.x;
    float disY = _target.y - pos.y;
    float disMax = abs(disX) + abs(disY);
    float factor = _speed / disMax;
    speed = new PVector(disX * factor, disY * factor);
  }
  
  void blit() {
    if (active) {
      fill(c);
      ellipse(pos.x, pos.y, radius, radius);
    }
  }
  
  void move() {
    pos.add(speed);
  }
}

class Player {
  PVector pos = new PVector(0, 0);
  int size = 30;
  int mode = 0;
  int Maxhp = 3;
  int hp = 3;
  float speed = 3;
  int x;
  
  void move() {
    if (mode == 0 && pos.y >= -height/2 + speed + doge.size/2) {
      pos.y -= speed;
    }
    else if (mode == 1 && pos.y <= height/2 - speed - doge.size/2) {
      pos.y += speed;
    }
    else if (mode == 2 && pos.x >= -width/2 + speed + doge.size/2) {
      pos.x -= speed;
    }
    else if (mode == 3 && pos.x <= width/2 - speed - doge.size/2) {
      pos.x += speed;
    }
    x+=1;
  }
    
  void blit() {
    image(dogeImg, doge.pos.x - doge.size/2, doge.pos.y - doge.size/2);
    pushMatrix();
    translate(doge.pos.x, doge.pos.y);
    fill(25, 255, 100);
    for (int i = 0; i<hp; i++) {
      float eX = map(i, 0, Maxhp, 0, 360)+x;
      ellipse(sin(radians(eX))*size*0.8, cos(radians(eX))*size*0.8, 3, 3);
    }
    popMatrix();
  }
}

Player doge;
PImage dogeImg;
PImage bgImg;
SoundFile music;
Ball[] enemies;
boolean run = false;
int round;

void setup() {
  size(400, 400);
  doge = new Player();
  dogeImg = loadImage("doge.png");
  dogeImg.resize(doge.size, doge.size);
  bgImg = loadImage("bg.jpg");
  bgImg.resize(width, height);
  reset();
  music = new SoundFile(this, "doge.mp3");
  music.loop();
}

void draw() {
  translate(width/2, height/2);
  background(bgImg);
  noStroke();
  if (run) {
    checkCollide();
    doge.move();
    for (int i = 0; i<enemies.length; i++) {
      enemies[i].move();
    }
    if (roundOver()) {
      enemies = new Ball[20];
      for (int i = 0; i<enemies.length; i++) {
        float eX = map(i, 0, enemies.length-1, 0, 720);
        float eFactor = map(i, 0, enemies.length-1, width/3.2, width);
        PVector ePos = new PVector(sin(radians(eX))*eFactor+doge.pos.x, cos(radians(eX))*eFactor+doge.pos.y);
        enemies[i] = new Ball(ePos, 2, 8, color(255, 0, 0), new PVector(doge.pos.x, doge.pos.y));
      }
      round += 1;
    }
  }
  for (int i = 0; i<enemies.length; i++) {
    enemies[i].blit();
  }
  doge.blit();
  fill(255);
  textSize(20);
  text("Round: " + round, -height/2.6, -height/2.3);
  text("HP: " + doge.hp, height/2.4, -height/2.3);
  if (run == false) {
    fill(200);
    rect(-width/4, height/3, width/2, height/10);
    fill(200, 50, 50);
    textAlign(CENTER);
    text("PRESS SPACE", 0, height/2.55);
  }

}

void keyPressed() {
  if (key == 32 && run == false) {
    reset();
    run = true;
  }
  char[] codes = {UP, DOWN, LEFT, RIGHT};
  for (int i = 0; i<codes.length; i++) {
    if (keyCode == codes[i]) {
      doge.mode = i;
    }
  }
}

void checkCollide() {
  for (int i = 0; i<enemies.length; i++) {
    if (abs(enemies[i].pos.x - doge.pos.x) <= doge.size / 2 && abs(enemies[i].pos.y - doge.pos.y) <= doge.size / 2 && enemies[i].active == true) {
      doge.hp -= 1;
      enemies[i].active = false;
      if (doge.hp <= 0) {
        run = false;
      }
    }
  }
}

boolean roundOver() {
  for (int i = 0; i<enemies.length; i++) {
     if (abs(enemies[i].pos.x) <= width / 2 && abs(enemies[i].pos.y) <= height / 2) {
       return false;
     }
  }
  return true;
}

void reset() {
  enemies = new Ball[20];
  for (int i = 0; i<enemies.length; i++) {
    float eX = map(i, 0, enemies.length-1, 0, 720);
    float eFactor = map(i, 0, enemies.length-1, width/3.2, width);
    PVector ePos = new PVector(sin(radians(eX))*eFactor+doge.pos.x, cos(radians(eX))*eFactor+doge.pos.y);
    enemies[i] = new Ball(ePos, 2, 8, color(255, 0, 0), new PVector(doge.pos.x, doge.pos.y));
  }
  doge.pos = new PVector(0, 0);
  doge.hp = doge.Maxhp;
  round = 1;
}
