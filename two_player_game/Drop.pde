// Example 10-10: The raindrop catching game

class Drop {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop\
  int lane;

  Drop(int tempLane, int maxLanes, int tempSpeed) {
    r = 16;                   // All raindrops are the same size
    lane = tempLane;
    x = lane*(width/maxLanes);       // Start with a random x location
    print("Drop on line #");
    println(x/width*maxLanes);
    y = -r*4;                // Start a little above the window
    speed = tempSpeed;    // set speed
    c = color(random(255), random(255), random(255)); // Color
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    y += speed;
  }

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
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
    y = -1000;
  }
}
