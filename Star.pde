// Modified very slightly from William Smith's sketch on OpenProcessing:
// http://www.openprocessing.org/sketch/63495

class Star {
  //Location
  PVector loc;
  //Size
  int size;
  //Brightness
  int bright;

  Star() {
    //Randomize all of the values
    size = (int) random(1, 6);
    loc = new PVector(random(width * map(size, 1, 7, 7, 1)), random(height * map(size, 1, 7, 7, 1)));
    bright = (int) random(200, 255);
  }

  void display() {
    pushStyle();

    //Setup the style
    stroke(bright);
    strokeWeight(size);

    //Find the actual location and constrain it to within the bounds of the screen
    int x = (int) (((loc.x - offset.x) * size / 8)) % width;
    int y = (int) (((loc.y - offset.y) * size / 8)) % height;
    if (x < 0) x += width;
    if (y < 0) y += height;

    //Display the point
    point(x, y);

    popStyle();
  }
}

