void setup() {
  size(100, 100);
}

void draw() {
  background(255);
  ellipse(50, 50, 80, 80);
  float liney = sin(radians(mouseY * 1.8)) * 100;
  float linex = abs(sin(radians(mouseY * 1.8))) * 100;
  line(50, 50, linex, liney);
}
