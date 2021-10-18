class Ball {
   PVector pos;
   PVector speed;
   int d;
   color c = color(random(255), random(255), random(255));
   
   Ball (int w, int h, int du) {
     pos = new PVector(random(du/2, w-du/2), random(d/2, h-d/2));
     speed = new PVector(random(-2, 2), random(-2, 2));
     d = du;
   }
   
   void update() {
     pos.add(speed);
     if (pos.x < d / 2 || pos.x > width - d/2) {
       speed.x*=-1;
     }
     if (pos.y < d / 2 || pos.y > height - d/2) {
       speed.y*=-1;
     }
   }
   
   void render() {
     noStroke();
     fill(c);
     ellipse(pos.x, pos.y, d, d);
   }
}
