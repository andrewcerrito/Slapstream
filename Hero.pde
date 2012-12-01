class Hero {

  int x, y, w;
  float rad;

  Hero (int tx, int ty, int tw) {
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
      x =int(x -(3*leftSpeedAdj));
      pushStyle();
      textSize(65);
      text(3*leftSpeedAdj, 600/2, height/2);
      popStyle();
    }
    if (rightHandMagnitude <= 300 && x<=600) {
      x = int (x+(3*rightSpeedAdj));
      pushStyle();
      textSize(65);
      text(3*rightSpeedAdj, 600/2, height/2);
      popStyle();
      
    }

    //    if (keyPressed) {
    //      if (key == CODED) {
    //        if (keyCode == LEFT) {
    //          //          println("left pressed");
    //          x-=3;
    //        }
    //        if (keyCode == RIGHT) {
    //          //          println("right pressed");
    //          x+=3;
    //        }
    //      }
    //    }
  }
}

