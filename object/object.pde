// data:
// car color
// car location x,y
// car x speed
// Setup
// initialize color
// initialize location
// initialize speed
// Draw:
// fill bg
// display car at location with color
// increment car location by speed
//
//

Car myCar;
Car second;

void setup()
{
  size(200, 200);
  myCar = new Car(color(255,0,0), 0, 100, 2);
  second = new Car(color(0, 0, 255), 0, 10, 1);
}

void draw()
{
  background(0);
  myCar.move();
  myCar.display();
  second.move();
  second.display();
}
