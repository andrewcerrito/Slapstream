import SimpleOpenNI.*;
SimpleOpenNI kinect;

Hero hero;
Obstacle obst;
Star[] stars;

// array and variables for storing previous magnitudes
int[] leftMagArray = new int[5];
int[] rightMagArray = new int[5];
int leftSpeed, rightSpeed, topSpeed;
float leftSpeedAdj, rightSpeedAdj;

// For the star movement:
PVector offset;

//These probably shouldn't be global but they're gonna be
float leftHandMagnitude, rightHandMagnitude;

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
  text (topSpeed, width-60, height-100);
  
  kinectDraw();
  topSpeedCheck();
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

// Calculate average speed of hands over past 5 frames and return an adjusted value.
// This is messy because I couldn't get my arrays to work (they're commented out below)
void speedCalc() { 

leftMagArray[4] = leftMagArray[3];
leftMagArray[3] = leftMagArray[2];
leftMagArray[2] = leftMagArray[1];
leftMagArray[1] = leftMagArray[0];
leftMagArray[0] = (int) leftHandMagnitude;

int lspd = abs(leftMagArray[4] - leftMagArray[3]);
int lspd1 = abs(leftMagArray[3] - leftMagArray[2]);
int lspd2 = abs(leftMagArray[2] - leftMagArray[1]);
int lspd3 = abs(leftMagArray[1] - leftMagArray[0]);

leftSpeed = ((lspd+lspd1+lspd2+lspd3)/(leftMagArray.length - 1));
leftSpeedAdj = map(leftSpeed,0,150,0,4);

//println("Left Speed: " + leftSpeed);
  
rightMagArray[4] = rightMagArray[3];
rightMagArray[3] = rightMagArray[2];
rightMagArray[2] = rightMagArray[1];
rightMagArray[1] = rightMagArray[0];
rightMagArray[0] = (int) rightHandMagnitude;

int rspd = abs(rightMagArray[4] - rightMagArray[3]);
int rspd1 = abs(rightMagArray[3] - rightMagArray[2]);
int rspd2 = abs(rightMagArray[2] - rightMagArray[1]);
int rspd3 = abs(rightMagArray[1] - rightMagArray[0]);

rightSpeed = ((rspd+rspd1+rspd2+rspd3)/(rightMagArray.length - 1));
rightSpeedAdj = map(rightSpeed,0,150,0,4);


//println("Right Speed: " + rightSpeed);

//  // Shift of old values: position 4 gets position 3's value, etc.
//  for (int i=(leftMagArray.length)-1; i<=1; i--) {
//    leftMagArray[i] = leftMagArray[i-1];
//    println("Left array " + i + ": " + leftMagArray[i]);
//  }
//  // First value gets current magnitude.
//  leftMagArray[0] = (int) leftHandMagnitude;
//  // println("Left Current Magnitude: " + leftMagArray[0]);
//
//
//  // Shift of old values: position 4 gets position 3's value, etc.
//  for (int i=(rightMagArray.length)-1; i<=1; i--) {
//    rightMagArray[i] = rightMagArray[i-1];
//  }
//  // First value gets current magnitude.
//  rightMagArray[0] = (int) rightHandMagnitude;
}

// tracks top speeds - for testing only
void topSpeedCheck() {
  if (leftSpeed > topSpeed && leftSpeed <=150) topSpeed = leftSpeed;
  if (rightSpeed > topSpeed && rightSpeed <=150) topSpeed = rightSpeed;
  println(topSpeed);
}
