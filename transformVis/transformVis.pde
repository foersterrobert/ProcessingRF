float i1 = 0;
float i2 = 0;

void setup() {
  size(300, 300);
}

void draw() {
  translate(width/2, height/2);
  float x1 = sin(radians(i1)) * width / 8;
  float y1 = cos(radians(i1)) * height / 8;
  translate(x1, y1);
  float x2 = sin(radians(i2)) * width / 30;
  float y2 = cos(radians(i2)) * height / 30;
  stroke(255, 0, 0);
  line(x1, y1, x2, y2);
  i1 += .2;
  i2 += 2;
}
