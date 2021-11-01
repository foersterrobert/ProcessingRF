int i = 1;
int j = 1;
int k;
int x = 0;

void setup() {
  size(100, 100);
}

void draw() {
  k = i + j;
  i = j;
  j = k;
  translate(0, height);
  ellipse(x*8+10, -k, 4, 4);
  x++;
}
