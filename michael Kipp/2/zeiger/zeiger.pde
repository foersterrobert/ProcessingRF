void setup() {
  size(100, 100);
}

void draw() {
  translate(50, 50);
  background(255);
  ellipse(0, 0, 80, 80);
  float lineY = cos(radians(mouseY * 3.6)) * -35;
  float lineX = sin(radians(mouseY * 3.6)) * 35;
  line(0, 0, lineX, lineY);
}
