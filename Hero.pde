class Hero {

  float x, y, w;
  float rad;

  Hero (float tx, float ty, float tw) {
    x = tx;
    y = ty;
    w = tw;
    rad = w/2;
  }

  void display() {
    stroke(255);
    fill(0, 255, 0);
    ellipse(x, y, w, w);
  }

// move hero if user is slapping and sprite is within bounds
  void moveCheck() {
    if (leftHandMagnitude <= 300 && x>=0) {
      x = (x -(lhandvel.mag()/2));
      pushStyle();
      textSize(65);
      popStyle();
    }
    if (rightHandMagnitude <= 300 && x<=600) {
      x = int (x+(rhandvel.mag())/2);
      pushStyle();
      textSize(65);
      popStyle();
      
    }
  }
}

