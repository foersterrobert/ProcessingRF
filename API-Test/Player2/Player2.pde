import http.requests.*;

int x = 0;
int load = 0;
PFont scoreFont;
int score;
int round;
PImage bg;
PImage groundImage;
PShape threedchar;
PShape rocket;

class Player {
  float eyeX, eyeY, eyeZ; // Position Kamera
  float centerX, centerY, centerZ; // Zielpunkt der Kamera
  float SPEED = 5; // Fortbewegung pro Schritt
  int charRotate = 0;

  // Konstruktor
  Player() {
    eyeX = 0;
    eyeY = -100;
    eyeZ = 0;
    centerX = 0;
    centerY = -20;
    centerZ = -240;
  }
  
  void drawPlayer(boolean cam) {
    if (cam) {
      camera(eyeX, eyeY, eyeZ,
      centerX, centerY, centerZ,
      0, 1, 0);
    }
    pushMatrix();
    translate(eyeX, 0, eyeZ - 100);
    rotateX(radians(180));
    rotateY(radians(charRotate));
    scale(3);
    shape(threedchar);
    popMatrix();
  }
}


class Ground {
  void update() {
    beginShape();
    texture(groundImage);
    vertex(-200, 0, -800, 0, 0);
    vertex(200, 0, -800, groundImage.width, 0);
    vertex(200, 0, 0, groundImage.width, groundImage.height);
    vertex(-200, 0, 0, 0, groundImage.height);
    endShape();
  }
}

Player player1;
Player player2;
Ground ground;

void setup() {
  size(1200, 800, P3D);
  ground = new Ground();
  player1 = new Player();
  player2 = new Player();
  PutRequest put = new PutRequest("https://processing-api.herokuapp.com/3d/2/1");
  put.addHeader("Content-Type", "application/json");
  put.addData("{\"color\":\"255\",\"x\":" + player1.eyeX + ",\"y\":" + player1.eyeY + ",\"z\":" + player1.eyeZ + ", \"r\":" + player1.charRotate + "}");
  put.send();
  println(put.getContent());
  bg = loadImage("bg.jpg");
  bg.resize(400, 210);
  groundImage = loadImage("ground.jpg");
  scoreFont = createFont("Terminator Two", 26);
  score = 0;
  round = 1;
  threedchar = loadShape("base.obj");
  threedchar.setFill(color(247, 237, 178));
  rocket = loadShape("rocket.obj");
}

void draw() {
  x += round;
  if (keyPressed) {
    if (keyCode == LEFT && player1.eyeX > -200) {
      player1.eyeX -= player1.SPEED;
      player1.centerX -= player1.SPEED;
      player1.charRotate = -90;
    }
    if (keyCode == RIGHT && player1.eyeX < 200) {
      player1.eyeX += player1.SPEED;
      player1.centerX += player1.SPEED;
      player1.charRotate = 90;
    }
    if (keyCode == UP && player1.eyeZ > -600) {
      player1.eyeZ -= player1.SPEED;
      player1.centerZ -= player1.SPEED;
      player1.charRotate = 0;
    }
    if (keyCode == DOWN && player1.eyeZ < 0) {
      player1.eyeZ += player1.SPEED;
      player1.centerZ += player1.SPEED;
      player1.charRotate = 180;
    }
  }
  if (load % 100 == 0) {
    loadApi();
  }
  load += 1;
  updateScreen();
}

void updateScreen() {
  background(0);
  colorMode(HSB);
  pointLight(0, 0, 1000, 100, -200, 0);
  colorMode(RGB);
  textFont(scoreFont);
  pushMatrix();
  translate(0, 0, -780);
  image(bg, - bg.width/ 2, - bg.height);
  translate(0, 0, 4);
  text("Score " + score, -180, -180);
  text("Round " + round, 40, -180);
  popMatrix();
  player1.drawPlayer(true);
  player2.drawPlayer(false);
  ground.update();
  pushMatrix();
  noStroke();
  fill(255, 255, 0);
  translate(cos(radians(x/3)) * 160, - abs(sin(radians(x/3)) * 160), -750);
  rotateX(radians(abs(cos(radians(x/3))) * 90 + 90));
  scale(.2);
  shape(rocket);
  popMatrix();
}


void loadApi() {
  PostRequest post = new PostRequest("https://processing-api.herokuapp.com/3d/2/1");
  post.addHeader("Content-Type", "application/json");
  post.addData("{\"color\":\"255\",\"x\":" + player1.eyeX + ",\"y\":" + player1.eyeY + ",\"z\":" + player1.eyeZ + ", \"r\":" + player1.charRotate + "}");
  post.send();
  print(post.getContent());
  JSONObject response = parseJSONObject(post.getContent());
  player2.eyeX = response.getInt("x");
  player2.eyeY = response.getInt("y");
  player2.eyeZ = response.getInt("z");
  player2.charRotate = response.getInt("r");
}
