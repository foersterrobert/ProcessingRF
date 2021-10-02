void setup() {
  size(100, 100);
}

void draw() {
  background(200);
  translate(width / 2, height / 2);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 8; j++) {
      fill(255);
      ellipse(sin(radians(j*(360/8.)))*i*20, cos(radians(j*(360/8.)))*i*20, 8, 8);
    }
  }
}
