// Example 10-10: The raindrop catching game

class Drop {
  PImage car;
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop
  int lane;
  String[] fileNames = {"carg.png", "carp.png", "carb.png"};
  String[] revFileNames = {"rcarg.png", "rcarp.png", "rcarb.png"};


  Drop(int tempLane, float[] tempLanes, int tempSpeed) {
    car = loadImage(fileNames[int(random(fileNames.length))]);
    r = 16;                   // All raindrops are the same size
    lane = tempLane;  // lane index
    speed = tempSpeed;    // set speed
    y = tempLanes[lane];       // Start with a random x location
    if (speed > 0) // determine the direction the car is headed based on the sign of the speed
    { // right to left
      car = loadImage(revFileNames[int(random(fileNames.length))]);
      x = -r*4;                // Start a little above the window
    } else
    { // left to right
      x = width+(r*4);
      car = loadImage(fileNames[int(random(fileNames.length))]);
    }
    print("Drop on line #");
    print(lane);
    print(", with speed ");
    println(tempSpeed);
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    x += speed;
  }

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (x > width + r*4) { 
      return true;
    } else {
      return false;
    }
  }
  // Display the raindrop
  void display() {
    // Display the drop
    fill(c);
    noStroke();
    image(car, x, y);
    //ellipse(x, y, r, r);
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    x = -1000;
  }
}
