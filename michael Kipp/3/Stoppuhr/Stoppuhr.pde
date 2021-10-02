int x = 0;

void setup() {
  size(100, 100);
}

void draw() {
  translate(width/2, height/2);
  background(0);
  fill(0);
  stroke(255);
  ellipse(0, 0, 80, 80);
  fill(255);
  arc(0, 0, 80, 80, radians(-90), radians((x % 360) - 90));
  x+=5;
}
