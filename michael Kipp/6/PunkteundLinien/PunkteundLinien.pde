PVector[] cords = new PVector[100];
int n = 0;
float zoom = 1.0;

void setup(){
  size(200, 200);
}

void draw(){
  pushMatrix();
  translate(width/2, height/2);
  background(0);
  stroke(200);
  for (int i = 0; i < n; i++) {
    ellipse(cords[i].x, cords[i].y, width/50*zoom, height/50*zoom);
    if (i + 1 < n) {
      line(cords[i].x, cords[i].y, cords[i + 1].x, cords[i + 1].y); 
    }
  }
  popMatrix();
  textSize(14);
  textAlign(CENTER);
  text("+, -, click, up, down, left, right", width/2, height-10);
}

void mouseClicked() {
  int found = -1;
  float transX = mouseX - width/2;
  float transY = mouseY - height/2;
  for (int i = 0; i < n; i++) {
    if (abs(cords[i].x - transX) <= width/50*zoom && abs(cords[i].y - transY) <= height/50*zoom) {
      found = i;
      break;
    }
  }
  if (found >= 0) {
    n--;
    for (int i = found; i < n; i++) {
      cords[i].x = cords[i+1].x;
      cords[i].y = cords[i+1].y;
    }
  }
  else {
    cords[n] = new PVector(transX, transY);
    n++;
  }
}

void keyPressed() {
  if (key == 32 && n > 0) {
    n--;
  }
  
  else if (key == '+') {
    for (int i = 0; i < n; i++) {
      cords[i].x *= 1.1;
      cords[i].y *= 1.1;
      zoom *= 1.025;
    }
  }
  
  else if (key == '-') {
    for (int i = 0; i < n; i++) {
      cords[i].x /= 1.1;
      cords[i].y /= 1.1;
      zoom /= 1.025;
    }
  }
  
  else if (keyCode == UP) {
    for (int i = 0; i < n; i++) {
      cords[i].y += 2;
    }
  } 
  else if (keyCode == DOWN) {
    for (int i = 0; i < n; i++) {
      cords[i].y -= 2;
    }
  }
  else if (keyCode == LEFT) {
    for (int i = 0; i < n; i++) {
      cords[i].x += 2;
    }
  }
  else if (keyCode == RIGHT) {
    for (int i = 0; i < n; i++) {
      cords[i].x -= 2;
    }
  }
}
