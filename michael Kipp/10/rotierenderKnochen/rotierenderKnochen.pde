int x = 0;
int dir = 1;

void setup() {
  size(100, 100);
}

void draw() {
  background(0);
  fill(255);
  noStroke();
  translate(width/2, height/2);
  rotate(radians(x));
  pushMatrix();
  rectMode(CENTER);
  rect(0, 0, 60, 5);
  translate(30, 2.5);
  rotate(radians(x));
  fill(0, 255, 0);
  rect(0, 0, 20, 20);
  popMatrix();
  translate(-30, -2.5);
  rotate(radians(x));
  fill(255, 0, 0);
  rect(0, 0, 20, 20);
  x+=dir;
}

void mouseClicked() {
  dir *= -1;
}
