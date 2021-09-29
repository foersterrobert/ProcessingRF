void setup() {
  size(120, 120);
}

void draw() {
  translate(60, 60);
  background(0);
  for (int i = 0; i < 200; i++) {
    float range = map(i, 0, 200, 0, 50);
    float x = map(i, 0, 50, 0, 2*PI);
    noStroke();
    ellipse(-sin(x)*range, cos(x)*range, 3, 3);
  }
}
