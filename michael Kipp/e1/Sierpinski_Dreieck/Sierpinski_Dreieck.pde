int depth = 1;
int i;

void setup() {
  size(300, 200);
}

void draw() {
  background(255);
  i = 1;
  fill(0);
  translate(width/2, height/2);
  triangle(0, -height/2, -width/2, height/2, width/2, height/2);
  fill(255);
  sierpinski();
}

void sierpinski() {
  triangle(0, height/(2*i), -width/(4*i), 0, width/(4*i), 0);
  if (i < depth) {
    i++;
    for (int j = -1; j < 2; j++) {
      pushMatrix();
      if (j == 0) {
        translate(0, -height/(2*i));
      }
      else {
        translate(width/(2*i)*j, height/(2*i));
      }
      sierpinski();
      popMatrix();
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    depth++;
  }
  else if (keyCode == DOWN && depth > 1) {
    depth--;
  }
}
