// Example 10-10: The raindrop catching game

class Drop {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop\
  int lane;


  Drop(int tempLane, float[] tempLanes, int tempSpeed) {
    r = 16;                   // All raindrops are the same size
    lane = tempLane;
    speed = tempSpeed;    // set speed
    y = tempLanes[lane];       // Start with a random x location
    if (speed > 0) // determine the direction the car is headed based on the sign of the speed
      x = -r*4;                // Start a little above the window
    else
      x = width+(r*4);
    c = color(random(255), random(255), random(255)); // Color
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
    ellipse(x, y, r, r);
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    x = -1000;
  }
}
