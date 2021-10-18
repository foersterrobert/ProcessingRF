
int score;
Ball[] ballList;

class Ball {
  int score;
  float r;
  PVector speed;
  PVector pos;
  boolean active = true;

  Ball (int nscore, float nr, PVector nspeed, PVector npos) {
    r = nr;
    score = nscore;
    speed = nspeed;
    pos = npos;
  }

  void move() {
    pos.add(speed);
    if (pos.x >= width - r || pos.x <= r) {
      speed.x *= -1;
    }
    if (pos.y >= height - r || pos.y <= r) {
      speed.y *= -1;
    }
  }

  void blit() {
    if (active) {
      fill(255);
      ellipse(pos.x, pos.y, r, r);
      fill(0);
      textAlign(CENTER);
      textSize(r-1);
      text(score, pos.x, pos.y + r/3);
    }
  }
}

void setup() {
  size(300, 300);
  score = 0;
  ballList = new Ball[10];
  for (int i = 0; i < ballList.length; i++) {
    float nr = random(15, 25);
    ballList[i] = new Ball(int(random(1, 10)), nr, new PVector(random(-2.5, 2.5), random(-2.5, 2.5)), new PVector(random(nr, width - nr), random(nr, height - nr)));
  }
}

void draw() {
  background(0);
  cursor(CROSS);
  for (int i = 0; i < ballList.length; i++) {
    ballList[i].move();
  }
  for (int i = 0; i < ballList.length; i++) {
    ballList[i].blit();
  }
  fill(255);
  textAlign(CENTER);
  textSize(28);
  text("score: " + score, width/2, 280);

  if (newRound()) {
    ballList = new Ball[10];
    for (int i = 0; i < ballList.length; i++) {
      float nr = random(15, 25);
      ballList[i] = new Ball(int(random(1, 10)), nr, new PVector(random(-2.5, 2.5), random(-2.5, 2.5)), new PVector(random(nr, width - nr), random(nr, height - nr)));
    }
  }
}

void mousePressed() {
  println("true");
  for (int i = 0; i < ballList.length; i++) {
    if (ballList[i].active == true && abs(ballList[i].pos.x - mouseX) <= ballList[i].r && abs(ballList[i].pos.y - mouseY) <= ballList[i].r) {
      ballList[i].active = false;
      score += ballList[i].score;
    }
  }
}

boolean newRound() {
  for (int i = 0; i < ballList.length; i++) {
    if (ballList[i].active == true) {
      return false;
    }
  }
  return true;
}
