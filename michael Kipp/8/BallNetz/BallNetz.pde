Ball[] balls;
Link[] links;
int linkn;

void setup() {
  size(200, 200);
  balls = new Ball[20];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(width, height, 8);
  }
  links = new Link[500];
  linkn = 0;
}

void draw() {
  background(0);
  for (int i = 0; i < balls.length; i++) {
    balls[i].render();
  }
  for (int i = 0; i < linkn; i++) {
    links[i].render();
  }
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
  }
  for (int i = 0; i < balls.length; i++) {
    for (int j = i+1; j < balls.length; j++) {
      if (collide(balls[i], balls[j]) && linkn < links.length) {
        links[linkn] = new Link(balls[i], balls[j]);
        linkn++;
      }
    }
  }
}

boolean collide(Ball b1, Ball b2) {
  if (abs(b1.pos.x - b2.pos.x) <= b1.d / 2 && abs(b1.pos.y - b2.pos.y) <= b1.d / 2) {
    return true;
  }
  return false;
}
