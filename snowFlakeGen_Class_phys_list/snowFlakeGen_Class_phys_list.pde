
import fisica.*;

FWorld world;  // create world
Snowflake snowflake;
PImage clouds;
int state = 0;
int fronds = 2;
void setup()
{
  size(800, 600);
  smooth();
  snowflake = new Snowflake(1000);
  clouds = loadImage("Cloud.png");
  imageMode(CORNER);

  Fisica.init(this); // not sure why this is here or what it means but all the examples have it

  world = new FWorld();
  world.setGravity(0, 300);
  //world.setEdges();
  //world.remove(world.left);
  //world.remove(world.right);
  //world.remove(world.top);
  world.setGrabbable(true);
}

void draw()
{
  switch(state)
  {

  case 0: // draw state
    background(0);
    //make canvas
    canvas();    

    //end make canvas
    if (mousePressed)
    {
      snowflake.addPoint(mouseX, mouseY, pmouseX, pmouseY);
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
    background(128);
    image(clouds, 0,0);
    if(frameCount%40 == 1) 
   {
   FCircle circle = new FCircle(40);
   circle.setPosition(random(width), 200);
   //circle.setVelocity(0, 200);
   circle.setFillColor(0);
   world.add(circle);
   }
  
  world.step();
  ArrayList<FBody> bodies=world.getBodies();
  for (int i = 0; i < bodies.size(); i++)
  {
    println(bodies.get(i).getX());
  }
  for(int i = 0; i < bodies.size()-1; i++)
  {
  if(bodies.get(i).getY() > height)
  world.remove(bodies.get(i));
  snowflake.displayWhole(fronds, bodies.get(i).getX(), bodies.get(i).getY());
  }
  println();
  world.draw();
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

void keyPressed()
{
  if (key == '1')
  state = 1;
  else if(key == '0')
  state = 0;
  
}
