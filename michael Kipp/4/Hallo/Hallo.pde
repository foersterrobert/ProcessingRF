String Stext = "hallo";
int x = 0;

void setup() {
  size(100, 100);
}

void draw() {
  background(0);
  textAlign(CENTER);
  textSize(28);
  text(Stext.substring(x), width/2, height/2);
}

void mouseClicked() {
  if (x < Stext.length()){
  x++;
  }
  else {
    x = 0;
  }
}
