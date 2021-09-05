PImage img_Ship;
PImage img_Alien;
PImage img_Bullet;
PFont scoreFont;
int score;
int round;
int fleetDirection = 1;
boolean started = false;

class Bullet {
  int x = 0;
  int y = height - img_Ship.height;
  boolean active = false;
  
  public void move() {
    y -= 8;
  }
  
  public void Blit() {
    image(img_Bullet, x, y);
  }
}

class Ship {
  int x = width / 2 - 50;
  int state = 0;
  Bullet bullets[] = new Bullet[3];
  
  public void move() {
    if (state == 1 && x >= 0) {
      x -= 5;
    }
    if (state == 2 && x <= width - 100) {
      x += 5;
    }
  }
  
  public void shoot() {
    for (int i = 0; i < bullets.length; i++) {
      if (bullets[i].active == false) {
        bullets[i].active = true;
        bullets[i].x = ship.x + img_Ship.width / 2;
        bullets[i].y = height - img_Ship.height;
        break;
      }
    }
  }
  
  public void Blit() {
    image(img_Ship, x, height - img_Ship.height);
  }
}

class Alien {
  int x;
  int y;
  boolean dead = false;
  
  Alien (int posx, int posy) {
    x = posx;
    y = posy;
  }
  
  public void move() {
    x += 3 * fleetDirection * pow(1.05, round);
  }
  
  public boolean checkEdges() {
    if (x >= width - img_Alien.width || x <= 0){
      return true;
    } 
   return false;
  }
  
  public void Blit() {
    image(img_Alien, x, y);
  }
}

Ship ship;
Alien aliens[];

void setup () {
  size(1400, 800);
  img_Ship = loadImage("ship.png");
  img_Ship.resize(100, 100);
  img_Alien = loadImage("alien.png");
  img_Alien.resize(100, 100);
  img_Bullet = loadImage("bullet.png");
  img_Bullet.resize(8, 25);
  scoreFont = createFont("Terminator Two", 32);
  score = 0;
  round = 1;
  ship = new Ship();
  for (int i = 0; i < ship.bullets.length; i++) {
    ship.bullets[i] = new Bullet();
  }
  aliens = new Alien[40];
  for (int i = 0; i < aliens.length; i++) {
    aliens[i] = new Alien((i%10)*120 + 100, 120 * floor(i / 10) + 50);
  }
}

void draw() {
  if (started == true) {
    for (int i = 0; i < ship.bullets.length; i++) {
      if (ship.bullets[i].active == true) {
        ship.bullets[i].move();
        if (ship.bullets[i].y + img_Bullet.height < 0) {
          ship.bullets[i].active = false;
        }
      }
    }
    ship.move();
    updateAliens();
  }
  updateScreen();
}

void updateScreen() {
  background(255);
  for (int i = 0; i < ship.bullets.length; i++) {
    if (ship.bullets[i].active == true) {
      ship.bullets[i].Blit();
    }
  }
  ship.Blit();
  for (int i = 0; i < aliens.length; i++) {
    if (aliens[i].dead == false) {
      aliens[i].Blit();
    }
  }
  
  textFont(scoreFont);
  if (started == false) {
    fill(50, 240, 50);
    rect(500, 300, width - 1000, height - 700);
    fill(204, 102, 0);
    text("Press Space", 540, 350);
    if (keyPressed) {
      if (key == 32) {
        started = true;
        aliens = new Alien[40];
        for (int i = 0; i < aliens.length; i++) {
          aliens[i] = new Alien((i%10)*120 + 100, 120 * floor(i / 10) + 50);
        }
        for (int i = 0; i < ship.bullets.length; i++) {
          ship.bullets[i] = new Bullet();
        }
      }
    }
    if (mouseX > 500 && mouseX < 900 && mouseY > 300 && mouseY < 400) {
      cursor(HAND);
    }
    
    else {
      cursor(ARROW);
    }
  }
  
  else {
    noCursor();
  }
  
  fill(204, 102, 0);
  text("Score " + score, 20, 40);
  text("Round " + round, width - 300, 40);
}

void keyPressed() {
  if (started == true) {
    if (keyCode == LEFT) {
      ship.state = 1;
    }
    
    if (keyCode == RIGHT) {
      ship.state = 2;
    }
    
    if (keyCode == UP) {
      ship.shoot();
    }
  }
}

void mouseClicked() {
  if (mouseX > 500 && mouseX < 900 && mouseY > 300 && mouseY < 400 && started == false) {
    started = true;
    aliens = new Alien[40];
    for (int i = 0; i < aliens.length; i++) {
      aliens[i] = new Alien((i%10)*120 + 100, 120 * floor(i / 10) + 50);
    }
    for (int i = 0; i < ship.bullets.length; i++) {
      ship.bullets[i] = new Bullet();
    }
  }
}

void updateAliens() {
  // check aliens touching bullets, ship or ground
  for (int i = 0; i < aliens.length; i++) {
      for (int j = 0; j < ship.bullets.length; j++) {
        if (aliens[i].dead == false && ship.bullets[j].active == true) {
        if (checkCollide(img_Alien.height, img_Bullet.height, aliens[i].y, ship.bullets[j].y)) {
          if (checkCollide(img_Alien.width, img_Bullet.width, aliens[i].x, ship.bullets[j].x)) {
            aliens[i].dead = true;
            ship.bullets[j].active = false;
            score += 1 * round;
            break;
          }
        }
      }
    }
  }
  
  // check edges
  for (int i = 0; i < aliens.length; i++) {
    if (aliens[i].dead == false) {
      if (aliens[i].checkEdges()) {
        fleetDirection *= -1;
        for (int j = 0; j < aliens.length; j++) {
          aliens[j].y += 20 * pow(1.05, round);
        }
        break;
      }
    }
  }
  
  // ckeck ship
  for (int i = 0; i < aliens.length; i++) {
    if (aliens[i].dead == false) {
      if (checkCollide(img_Alien.height, img_Ship.height, aliens[i].y, height - img_Ship.height)) {
        if (checkCollide(img_Alien.width, img_Ship.width, aliens[i].x, ship.x)) {
          started = false;
          break;
        }
      }
    }
  }
  
  // check bottom
  for (int i = 0; i < aliens.length; i++) {
    if (aliens[i].y > height - img_Alien.height && aliens[i].dead == false) {
              started = false;
              break;
            }
  }
  
  // move aliens
  for (int i = 0; i < aliens.length; i++) {
    if (aliens[i].dead == false) {
      aliens[i].move();
    }
  }
  
  if (newRound()) {
    for (int i = 0; i < aliens.length; i++) {
      aliens[i] = new Alien((i%10)*120 + 100, 120 * floor(i / 10) + 50);
    }
    for (int i = 0; i < ship.bullets.length; i++) {
      ship.bullets[i].active = false;
    }
    round += 1;
  }
}


boolean checkCollide (int big, int small, int bigx, int smallx) {
  if (abs(bigx - smallx) <= big) {
    if (smallx < bigx) {
      if (abs(bigx - smallx) <= small) {
        return true;
      }
    }
    else {
      return true;
    }
  }
  return false;
}

boolean newRound () {
  for (int i = 0; i < aliens.length; i++) {
    if (aliens[i].dead == false) {
      return false;
    }
  }
  
  return true;
}
  
