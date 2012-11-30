import SimpleOpenNI.*;
SimpleOpenNI kinect;

Hero hero;
Obstacle obst;
Star[] stars;

// For the star movement:
PVector offset;

int randX;
color c1 = color(0, 0, 0);

void setup() {
  size((600+640), 850);
  smooth();
  randX = (int) random(0, 600); // SET TO 600 - CHANGE BACK LATER
  background(c1);
  textSize(30);
  

  // define hero, obstacle, and stars
  hero = new Hero(600/2, height-80, 70); //SET TO 600 - CHANGE BACK LATER
  obst = new Obstacle(randX, 10);
  stars = new Star[width];
  for (int i = 0; i < stars.length; i ++) stars[i] = new Star();
  offset = new PVector(width / 2, height / 2);
  
  //Kinect init
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
}

void draw() {
  background(c1);
  starField();
  fill(255);
  text (frameRate, width-60, height-60);
  kinectDraw();
  hero.display();
  obst.display();
  hero.moveCheck();
  obst.move();
  obst.collideDetect(hero.x, hero.y, hero.rad);
}

void starField() {
  for (int i = 0; i < stars.length; i ++) stars[i].display();

  // Make stars float down from top of screen
  //  PVector angle = new PVector(mouseX - width / 2, mouseY - height / 2);
  PVector angle = new PVector(0, 0);
  angle.y--;
  angle.normalize();
  //angle.mult(dist(width / 2, height / 2, mouseX, mouseY) / 50);

  // this multiplier controls speed
  angle.mult(5); 

  offset.add(angle);
}

