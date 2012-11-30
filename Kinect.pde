void kinectDraw() {
  kinect.update();
  image(kinect.depthImage(), 600, 100);

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  if (userList.size() > 0) {
    int userId = userList.get(0);

    if (kinect.isTrackingSkeleton(userId)) {
      PVector leftHand = new PVector();
      PVector rightHand = new PVector();
      PVector head = new PVector();

      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, rightHand);
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, leftHand);
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, head);

      // subtract hand vectors from head to get difference vectors
      PVector rightHandVector = PVector.sub(head, rightHand);
      PVector leftHandVector = PVector.sub(head, leftHand);

      // calculate the distance and direction of the difference vector
      rightHandMagnitude = rightHandVector.mag();
      leftHandMagnitude = leftHandVector.mag();
      // this is for unit vectors - uncomment it if you need to do something with direction
      //      rightHandVector.normalize();
      //      leftHandVector.normalize();


      // draw a line between the two hands
      kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_RIGHT_HAND);
      kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_LEFT_HAND);
      // display
      pushMatrix();
      fill(255, 0, 0);
      text("left: " + leftHandMagnitude, 10, height-200);
      text("right: " + rightHandMagnitude, width-200, height-200);
      popMatrix();
    }
  }
}





// User tracking:
void onNewUser(int userId) {
  println("start pose detection");
  kinect.startPoseDetection("Psi", userId);
}

void onEndCalibration(int userId, boolean successful) {
  if (successful) {
    println("  User calibrated !!!");
    kinect.startTrackingSkeleton(userId);
  }
  else {
    println("Failed to calibrate user !!!");
    kinect.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId) {
  println("Started pose for user");
  kinect.stopPoseDetection(userId);
  kinect.requestCalibrationSkeleton(userId, true);
}

