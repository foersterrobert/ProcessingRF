float r = 0;
PImage wallimg;
PImage roofimg;
PImage doorimg;
PImage bgimg;

void setup() {
  size(700, 400, P3D);
  wallimg = loadImage("wall.jpg");
  roofimg = loadImage("roof.jpg");
  doorimg = loadImage("door.jpg");
  bgimg = loadImage("bg.jpg");
}

void draw() {
  background(200);

  drawHouse();
  r+=0.5;
}

void drawHouse() {
  noStroke();
  translate(350, 200, -100);
  
  textureMode(NORMAL);
  
  beginShape(); // bg
  texture(bgimg);
  vertex(-700, -400, -200, 0, 0);
  vertex(700, -400, -200, 1, 0);
  vertex(700, 400, -200, 1, 1);
  vertex(-700, 400, -200, 0, 1);
  endShape(CLOSE);
  
  translate(0, 50, 0);
  rotateY(radians(r));
  rotateX(radians(r));
  
  beginShape(); // wall back
  texture(wallimg);
  vertex(-100, -100, -100, 0, 0);
  vertex(100, -100, -100, 1, 0);
  vertex(100, 100, -100, 1, 1);
  vertex(-100, 100, -100, 0, 1);
  endShape(CLOSE);
  
  beginShape(); // wall front
  texture(wallimg);
  vertex(-100, -100, 100, 0, 0);
  vertex(100, -100, 100, 1, 0);
  vertex(100, 100, 100, 1, 1);
  vertex(-100, 100, 100, 0, 1);
  endShape(CLOSE);
  
  beginShape(); // wall left
  texture(wallimg);
  vertex(-100, -100, 100, 0, 0);
  vertex(-100, -100, -100, 1, 0);
  vertex(-100, 100, -100, 1, 1);
  vertex(-100, 100, 100, 0, 1);
  endShape(CLOSE);
  
  beginShape(); // wall right
  texture(wallimg);
  vertex(100, -100, 100, 0, 0);
  vertex(100, -100, -100, 1, 0);
  vertex(100, 100, -100, 1, 1);
  vertex(100, 100, 100, 0, 1);
  endShape(CLOSE);
  
  beginShape(); // wall bottom
  texture(wallimg);
  vertex(-100, 100, 100, 0, 0);
  vertex(-100, 100, -100, 1, 0);
  vertex(100, 100, -100, 1, 1);
  vertex(100, 100, 100, 0, 1);
  endShape(CLOSE);
  
  beginShape(); // roof front
  texture(roofimg);
  vertex(-120, -100, 120, 0, 1);
  vertex(0, -200, 0, 0, 0.5);
  vertex(120, -100, 120, 1, 1);
  endShape(CLOSE);
  
  beginShape(); // roof back
  texture(roofimg);
  vertex(-120, -100, -120, 0, 1);
  vertex(0, -200, 0, 0, 0.5);
  vertex(120, -100, -120, 1, 1);
  endShape(CLOSE);
  
  beginShape(); // roof left
  texture(roofimg);
  vertex(-120, -100, -120, 0, 1);
  vertex(0, -200, 0, 0, 0.5);
  vertex(-120, -100, 120, 1, 1);
  endShape(CLOSE);
  
  beginShape(); // roof right
  texture(roofimg);
  vertex(120, -100, -120, 0, 1);
  vertex(0, -200, 0, 0, 0.5);
  vertex(120, -100, 120, 1, 1);
  endShape(CLOSE);
  
  beginShape(); // roof bottom
  texture(roofimg);
  vertex(-120, -100, 120, 0, 0);
  vertex(-120, -100, -120, 1, 0);
  vertex(120, -100, -120, 1, 1);
  vertex(120, -100, 120, 0, 1);
  endShape(CLOSE);
  
  beginShape(); // door
  texture(doorimg);
  vertex(-50, -20, 101, 0, 0);
  vertex(0, -20, 101, 1, 0);
  vertex(0, 100, 101, 1, 1);
  vertex(-50, 100, 101, 0, 1);
  endShape(CLOSE);
}
