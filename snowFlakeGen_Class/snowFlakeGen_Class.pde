

Snowflake snowflake;
int state = 0;
int fronds = 2;
void setup()
{
  size(800, 600);
  snowflake = new Snowflake(1000);
}

void draw()
{
  switch(state)
  {

  case 0: // draw state
    background(255);
    //make canvas
    canvas();    

    //end make canvas
    if (mousePressed)
    {
      if (snowflake.addPoint(mouseX, mouseY, pmouseX, pmouseY))
        ;
      else
        println("reached end of mem press x to reset");
    }

    if (keyPressed && key =='x')
      snowflake.restart();

    if (keyPressed && key == 's')
    {
      snowflake.displayWhole(fronds, width/2, height/2);
      /*
      for(int i = 0; i < 4; i++)
       {
       snowflake.displayWhole(fronds, int(random(width)), int(random(height)));
       i++;
       }
       */
    } else snowflake.displayFrond();
    break;
    
    case 1:
    break;
  }
}

void canvas()
{
  //make canvas
  fill(255);
  rect(width/4, 0, 2*(width/4), height);
  fill(0);
  ellipse(width/2, height/2, 10, 10); // draw center dot
  fill(255);

  // draw guide lines
  //area();
}
void area() // draws 2 lines creating an arc based on how many fronds selected to prevent overlap
{
  float angle = ((2*PI)/(fronds+1));
  println(angle);
  pushMatrix();
  translate(width/2, height/2);
  rotate(angle);
  //ellipse(0, 0, 5, 5);
  line(0, 0, 0, -100);

  popMatrix();
}
