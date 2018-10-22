class Car 
{
  //data
  color c;
  float xPos, yPos;
  float xSpeed;
  //constructor
  Car(color tempc, float tempXpos, float tempYpos, float tempXspeed){
    c = tempc;
    xPos = tempXpos;
    yPos = tempYpos;
    xSpeed = tempXspeed;
  }
  
  //methods
  void move()
  {
    xPos += xSpeed;
    if(xPos > width)
      xPos = 0;
  }

  void display()
  {
    fill(c);
    rectMode(CENTER);
    rect(xPos, yPos, 30, 10);
  }

}
