class Obstacle {

  int maxSize = 150; //dictates maximum size of obstacle
  int x, y;
  int w = (int) random(30, maxSize);
  float rad;

  Obstacle (int tx, int ty) {
    x = tx;
    y = ty;
    rad = w/2;
  }

  void display() {
    fill(255, 0, 0);
    stroke(255);
    ellipse(x, y, w, w);
  }

  void move() {
    y+=4; // move down the screen
    if (y >= height + rad) { // if circle leaves bottom of screen:
      y = (int) -rad; // reset to top of screen
      x = (int) random(0, 600); // get a new random width - SET TO 600 FOR NOW, CHANGE BACK LATER
      w = (int) random(30, maxSize); // get a new random size
      rad = w/2; // correct the radius variable with the new width
    }
  }

  void collideDetect (int heroX, int heroY, float heroRad) {
    float distFromHero = dist(x, y, heroX, heroY);
    if (distFromHero < rad + heroRad) {
      c1 = color(0, 0, 255);
//      println("Hit!");
    } 
    else {
      c1 = color(0, 0, 0);
    }
  }
  
}

