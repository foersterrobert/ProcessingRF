String Stext = "hallo";
int x = 0;

void setup() {
  size(100, 100);
}

void draw() {
  background(0);
  textSize(14);
  text("click", 20, height-10);
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
