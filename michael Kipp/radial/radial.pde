void setup() {
  size(100, 100);
}

void draw() {
  translate(width / 2, height / 2);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 8; j++) {
      ellipse(i, j, 5, 5);
    }
  }
}
