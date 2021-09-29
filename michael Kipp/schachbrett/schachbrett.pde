void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (j % 2 == 0 && i % 2 == 0 || j % 2 != 0 && i % 2 != 0) {
        fill(0);
      } else {
        fill(255);
      }
      rect(i*50, j*50, 50, 50);
    }
  }
}
