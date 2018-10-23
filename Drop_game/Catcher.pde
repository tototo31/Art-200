// Example 10-10: The raindrop catching game

class Catcher {
  float r;    // radius
  color col;  // color
  float x, y; // location

  Catcher(float tempR) {
    r = tempR;
    col = color(255);
    x = 0;
    y = 0;
  }

  void setLocation(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void display() {
    stroke(255);
    fill(col);
    
    line(x-r/2, y, x-r/2, y+2*r); //leg
    line(x+r/2, y, x+r/2, y+2*r); // leg
    ellipse(x, y, r*2, r*2); // detecable part - body
    ellipse(x, y-r, r, r); //head
  }

  // A function that returns true or false based on
  // if the catcher intersects a raindrop
  boolean intersect(Drop d) {
    // Calculate distance
    float distance = dist(x, y, d.x, d.y); 

    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
}
