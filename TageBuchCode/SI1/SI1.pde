PImage img_Ship;

class Ship {
  int x = width / 2 - img_Ship.width / 2;
  int state = 0;
  
  public void move() {
    if (state == 1 && x >= 0) {
      x -= 5;
    }
    if (state == 2 && x <= width - img_Ship.width) {
      x += 5;
    }
  }
  
  public void blit() {
    image(img_Ship, x, height - img_Ship.height);
  }
}

Ship ship;

void setup() {
  size(600, 400);
  img_Ship = loadImage("ship.png");
  img_Ship.resize(100, 100);
  ship = new Ship();
}

void draw() {
  background(255);
  ship.move();
  ship.blit();
}

void keyPressed() {
  if (keyCode == LEFT) {
    ship.state = -1;
  }
  if (keyCode == RIGHT) {
    ship.state = 1;
  }
}
