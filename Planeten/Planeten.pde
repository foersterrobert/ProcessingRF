boolean start = false;
PImage img;

class Planet {
  float radius;
  PVector pos;
  PVector ellipseSize;
  color Color;
  int x;
  float speed;
  
  Planet (int _x, float _radius, float _speed, PVector _ellipseSize, color _Color) {
    x = _x;
    radius = _radius;
    speed = _speed;
    ellipseSize = _ellipseSize;
    pos = new PVector(cos(radians(x)) * ellipseSize.x, sin(radians(x)) * ellipseSize.y);
    Color = _Color;
  }
  
  void blit() {
    fill(lerpColor(color(255, 100, 30), Color, .5));
    beginShape();
    vertex(cos(radians(x-speed*10)) * ellipseSize.x, sin(radians(x-speed*10)) * ellipseSize.y);
    vertex(pos.x+radius/3, pos.y+radius/3);
    vertex(pos.x+radius/3, pos.y-radius/3);
    vertex(pos.x-radius/3, pos.y+radius/3);
    vertex(pos.x-radius/3, pos.y-radius/3);
    endShape(CLOSE);
    fill(Color);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void move() {
    x += speed;
    pos.x = cos(radians(x)) * ellipseSize.x;
    pos.y = sin(radians(x)) * ellipseSize.y;
  }
}

Planet[] planets;

void setup() {
  size(400, 400);
  planets = new Planet[8];
  planets[0] = new Planet(0, 30, 1, new PVector(width/40, height/40), color(255, 190, 60));
  for (int i = 1; i<planets.length; i++) {
    float _radius = random(10, 15);
    planets[i] = new Planet(int(random(0, 180)), _radius, random(1, 1.5), new PVector(random(width/6, width/2-_radius), random(height/6, height/2-_radius)), color(random(255), random(255), random(255)));
  }
  img = loadImage("img.jpg");
  img.resize(width, height);
}

void draw() {
  background(img);
  cursor(ARROW);
  noStroke();
  translate(width / 2, height / 2);
  
  for (int i = 0; i<planets.length; i++) {
    planets[i].blit();
  }
  
  fill(200);
  textAlign(CENTER);
  textSize(28);
  text(
    "" + day() + "." + month() + "." + year() + "-" + hour() + ":" + minute(), 
    0, 
    -height/2.25  
  );
  
  if (start) {
    for (int i = 0; i<planets.length; i++) {
      planets[i].move();
    }
    textSize(20);
    text("+, -, SPACE", -width/2.7, height/2.1);
  }
  
  else {
    fill(0, 200, 0);
    rect(-width/2.5, height/3, width/2.5*2, 50);
    fill(0);
    text("PRESS SPACE", 0, height/2.4);
  }
}

void keyPressed() {
  if (key == '+' && start) {
    for (int i = 0; i<planets.length; i++) {
      planets[i].radius *= 1.5;
      planets[i].ellipseSize.mult(1.5);
    }
  }
  
  else if (key == '-' && start) {
    for (int i = 0; i<planets.length; i++) {
      planets[i].radius /= 1.5;
      planets[i].ellipseSize.mult(1/1.5);
    }
  }
  
  if (key == 32) {
    start = !start;
  }
}
