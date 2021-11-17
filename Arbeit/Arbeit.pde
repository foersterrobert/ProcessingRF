String[] infoText = {"I", "n", "f", "o", "r", "m", "a", "t", "i", "k"};
int i = -1;
PImage bgImg;
int RotateSpeed = 1;
float BigRotateI = 0;

House[] houses = new House[10];
House[] rotateHouses = new House[10];
int nHouses = 0;

class House {
  PVector pos;
  float houseWidth;
  color LerpColor;
  int RotateI = 0;
  
  House (PVector _pos, float _HouseWidth, color _LerpColor) {
    pos = _pos;
    houseWidth = _HouseWidth;
    LerpColor = _LerpColor;
  }
  
  void drawHouse() {
    RotateI+=1*RotateSpeed;
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(RotateI));
    color oC = color(200);
    fill(lerpColor(oC, LerpColor, 0.3));
    beginShape(); // schornstein
    vertex(-90*houseWidth, -180*houseWidth);
    vertex(-30*houseWidth, -180*houseWidth);
    vertex(-30*houseWidth, 0);
    vertex(-90*houseWidth, 0);
    endShape(CLOSE);
    
    oC = color(160, 200, 100);
    fill(lerpColor(oC, LerpColor, 0.3));
    rectMode(CENTER);
    rect(0, 0, 200*houseWidth, 160*houseWidth); // haus
  
    oC = color(220, 80, 15);
    fill(lerpColor(oC, LerpColor, 0.3));
    triangle(-120*houseWidth, -80*houseWidth, 0, -200*houseWidth, 120*houseWidth, -80*houseWidth); // dach
    
    oC = color(180, 110, 15);
    fill(lerpColor(oC, LerpColor, 0.3));
    beginShape(); // tür
    vertex(-40*houseWidth, 20*houseWidth);
    vertex(0, 20*houseWidth);
    vertex(0, 80*houseWidth);
    vertex(-40*houseWidth, 80*houseWidth);
    endShape(CLOSE);
    
    oC = color(255);
    fill(lerpColor(oC, LerpColor, 0.3));
    rect(50*houseWidth, -10*houseWidth, 40*houseWidth, 40*houseWidth); // fenster
    
    line(30*houseWidth, -10*houseWidth, 70*houseWidth, -10*houseWidth);
    line(50*houseWidth, -30*houseWidth, 50*houseWidth, 10*houseWidth);
    popMatrix();
  }
}

void setup() {
  size(600, 600);
  bgImg = loadImage("house.jpg");
  bgImg.resize(width, height);
  for (int j = 0; j<rotateHouses.length; j++) {
    rotateHouses[j] = new House(new PVector(0, 0), 0.2, 
                          color(random(255), random(255), random(255)));
  }
}

void draw () {
  background(bgImg);
  noCursor();
  for (int j = 0; j<nHouses; j++) {
    houses[j].drawHouse();
  }
  drawHouse();
  drawInfoText();
  textSize(20);
  text("Click, +, -, mouseX, mouseY", width-240, 30);
}

void drawHouse() {
  pushMatrix();
  translate(mouseX, mouseY);
  
  for (int j = 0; j<rotateHouses.length; j++) {
    BigRotateI += 0.1*RotateSpeed;
    float housePosX = cos(radians(j * 36 + BigRotateI)) * 150;
    rotateHouses[j].pos.x = housePosX;
    float housePosY = sin(radians(j*36 + BigRotateI)) * 150;
    rotateHouses[j].pos.y = housePosY;
    rotateHouses[j].drawHouse();
  }
  
  fill(200);
  beginShape(); // schornstein
  vertex(-90, -180);
  vertex(-30, -180);
  vertex(-30, 0);
  vertex(-90, 0);
  endShape(CLOSE);
  
  fill(160, 200, 100);
  rectMode(CENTER);
  rect(0, 0, 200, 160); // haus

  fill(220, 80, 15);
  triangle(-120, -80, 0, -200, 120, -80); // dach
  
  fill(180, 110, 15);
  beginShape(); // tür
  vertex(-40, 20);
  vertex(0, 20);
  vertex(0, 80);
  vertex(-40, 80);
  endShape(CLOSE);
  
  fill(255);
  rect(50, -10, 40, 40); // fenster
  
  line(30, -10, 70, -10);
  line(50, -30, 50, 10);
  popMatrix();
}

void drawInfoText() {
  String strInfoText = "";
  for (int j = 0; j-1<i % infoText.length; j++) {
    strInfoText += infoText[j];
  }
  fill(0);
  textSize(28);
  text(strInfoText, 10, 30);
}

void mousePressed() {
  i += 1;
  if (i % infoText.length == 0) {
    println("");
  }
  print(infoText[i % infoText.length]);
  RotateSpeed *= -1;
}

void keyPressed() {
  if (key == '+' && nHouses < houses.length -1) {
    houses[nHouses] = new House(new PVector(random(width), random(height)), 
    random(0.8), 
    color(random(255), random(255), random(255)));
    nHouses += 1;
  }
  else if (key == '-' && nHouses > 0) {
    houses[nHouses] = null;
    nHouses -= 1;
  }
}
