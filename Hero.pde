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


  void moveCheck() {
    if (leftHandMagnitude <= 300) {
      x-=3;
    }
    if (rightHandMagnitude <= 300) {
      x+=3;
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

