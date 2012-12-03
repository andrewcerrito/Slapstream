// Slapstream
// By Andrew Cerrito
// Stars and parallax motion modified very slightly from William Smith's sketch on OpenProcessing:
// http://www.openprocessing.org/sketch/63495
// Thanks to Dan Shiffman, who reworked some of my code into cleaner, more usable code.

import SimpleOpenNI.*;
SimpleOpenNI kinect;

Hero hero;
Obstacle obst;
Star[] stars;

PVector rhand = new PVector(width/2, height/2);
PVector prhand = new PVector(width/2, height/2);
PVector rhandvel = new PVector(0, 0);

PVector lhand = new PVector(width/2, height/2);
PVector plhand = new PVector(width/2, height/2);
PVector lhandvel = new PVector(0, 0);

// For the star movement:
PVector offset;

// These probably shouldn't be global but they're going to be
float leftHandMagnitude, rightHandMagnitude;

int randX;
color c1 = color(0, 0, 0);
PFont f;


void setup() {
  size((600+640), 850);
  smooth();
  randX = (int) random(0, 600); // SET TO 600 - CHANGE BACK LATER
  background(c1);
  f = createFont("C64Pro-Style", 24, true);


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
  PFont.list();
}

void draw() {
  background(c1);
  starField();
  fill(255);
  text (frameRate, width-60, height-60);
//  text (topSpeed, width-60, height-100);

  PVector rvelocity = PVector.sub(rhand, prhand);

  rhandvel.x = lerp(rhandvel.x, rvelocity.x, 0.4);
  rhandvel.y = lerp(rhandvel.y, rvelocity.y, 0.4);

  PVector lvelocity = PVector.sub(lhand, plhand);

  lhandvel.x = lerp(lhandvel.x, lvelocity.x, 0.4);
  lhandvel.y = lerp(lhandvel.y, lvelocity.y, 0.4);


  kinectDraw();
  hero.display();
  obst.display();
  hero.moveCheck();
  obst.move();
  obst.collideDetect(hero.x, hero.y, hero.rad);


  strokeWeight(1);
  stroke(0, 255, 0);
  pushMatrix();
  translate(width/2, height/2);
  scale(10);

  stroke(0, 255, 0);
  line(0, 0, rhandvel.x, rhandvel.y);
  text (rhandvel.mag(), 0, 40);

  stroke(255, 0, 0);
  line(0, 0, lhandvel.x, lhandvel.y);
  text (lhandvel.mag(), 0, 30);
  
  popMatrix();
}

void starField() {
  for (int i = 0; i < stars.length; i ++) stars[i].display();

  // Make stars float down from top of screen
  //  PVector angle = new PVector(mouseX - width / 2, mouseY - height / 2);
  PVector angle = new PVector(0, 0);
  angle.y--;
  angle.normalize();
  //angle.mult(dist(width / 2, height / 2, mouseX, mouseY) / 50);

  // this multiplier controls speed of stars
  angle.mult(5); 

  offset.add(angle);
}


// tracks top speeds - for testing only
//void topSpeedCheck() {
//  if (leftSpeed > topSpeed && leftSpeed <=150) topSpeed = leftSpeed;
//  if (rightSpeed > topSpeed && rightSpeed <=150) topSpeed = rightSpeed;
//  println(topSpeed);
//}

