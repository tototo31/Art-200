/*
reference for library before I lose the link - http://www.ricardmarxer.com/fisica/reference/index.html
 TODO: 
 fix arm rotationsc - DONE
 Implement increasing arms - DONE
 Calculate body size based on flake size - DONE
 
 optimize - use lists? - DONEISH
 
 implement back to creation
 
 */
import fisica.*;

FWorld world;  // create world
Snowflake snowflake; // create snow flake
PImage clouds; // cloud background
int state = 0; // simulation state - do not change
int arms = 6; // starting arms
int maxarms = 10; // max arms
int minarms = 2; // min arms
int boxSize = 50; // button size - do not change
int len = 1000; // snow flake point array size - if anything lower this
int freq = 20; // freq at which to drop flakes - dont change by much this is very un optimized - default 40

boolean preview = false; // preview button state

boolean debug = true; // enable/disable debug keys

void setup()
{
  size(800, 600);
  smooth();
  snowflake = new Snowflake(len);
  clouds = loadImage("Cloud.png");
  imageMode(CORNER);

  Fisica.init(this); // not sure why this is here or what it means but all the examples have it

  world = new FWorld();
  world.setGravity(0, 300); // set world gravity

  world.setEdges();
  world.remove(world.left);
  world.remove(world.right);
  world.remove(world.top);

  world.setGrabbable(true); // you can grab the flakes now
}

void draw()
{
  switch(state)
  {
  case 0: // draw state
    background(0);
    //make canvas
    canvas(); // draw the canvas
    drawButtons(); // draw buttons

    //end make canvas
    if (!preview && mousePressed) // if your trying to draw
    {
      if (mouseX > width/4 && mouseX < 3*(width/4) && (mouseX != pmouseX || mouseY != pmouseY)) // make sure the mouse is on the canvas, and add the point
        snowflake.addPoint(mouseX, mouseY, pmouseX, pmouseY);
    }

    if (preview) // if the preview toggle is on show the scaled flake
    {
      snowflake.displayWhole(arms, width/2, height/2);
    } else snowflake.displayarm(); // otherwise just display the unscaled arm

    break;
    // END CREATION

  case 1: // simulation state
    background(128); // a nice grey sky
    image(clouds, 0, 0); // amazing looking clouds
    if (frameCount%freq == 1)  // determine when to drop flakes
    {
      FCircle flake = new FCircle(snowflake.size); // circle are probably the best to represent a snowflake - especially with many arms
      flake.setPosition(random(width), 200); // spawn randomly in the clouds
      //circle.setVelocity(0, 200);
      flake.setFillColor(0);
      if (!debug)
      {
        flake.setNoStroke();
      }

      world.add(flake); // add it to the world
    }

    world.step(); // step the world 1/60th of a second
    ArrayList<FBody> bodies=world.getBodies(); // create a list of bodies in the world
    for (int i = 0; i < bodies.size(); i++) // for each body draw a flake over it
    {
      if (!bodies.get(i).isStatic()) // if a flake leaves the display delete it
      {
        snowflake.displayWhole(arms, bodies.get(i).getX(), bodies.get(i).getY()); // if it wasnt removed show the beautiful flake
        if ((bodies.get(i).getY() > height || bodies.get(i).getX() > width || bodies.get(i).getX() < 0))
          world.remove(bodies.get(i));
      }
      /*
      if(!bodies.get(i).isStatic())
       {
       snowflake.displayWhole(arms, bodies.get(i).getX(), bodies.get(i).getY()); // if it wasnt removed show the beautiful flake
       }
       */
    }
    world.draw(); // draw the world bodies in the new state
    break;
  }
}

void canvas()
{
  //make canvas
  fill(255);
  rect(width/4, 0, 2*(width/4), height); // drawing area
  fill(0);
  ellipse(width/2, height/2, 10, 10); // draw center dot
  fill(255);
}

void drawButtons()
{

  //textSize(12);
  if (preview) // toggle color of preview button when toggled
    fill(180);
  else
    fill(255);
  rect(width/16, height/10, 2*(width/16), boxSize); // preview button

  fill(255);
  rect(width/16, 2*(height/10), 2*(width/16), boxSize); // restart button
  rect(13*(width/16), 4*(height/10), 2*(width/16), boxSize); //Start simulation button
  rect(width/16, 6*(height/10), 2*(width/16), boxSize); // +/- arms button

  // rect(width/16, 7*(height/10), 2*(width/16), boxSize); // +/- scale button

  //TEXT
  fill(0);
  textAlign(CENTER, CENTER);
  text("Preview", width/16, height/10, 2*(width/16), boxSize);
  text("Restart", width/16, 2*(height/10), 2*(width/16), boxSize);
  text("Start", 13*(width/16), 4*(height/10), 2*(width/16), boxSize);
  text(str(arms), width/16, 6*(height/10), 2*(width/16), boxSize); // +/- arms button State
  text("+", 2*(width/16), 6*(height/10), (width/16), boxSize); // + arms button
  text("-", (width/16), 6*(height/10), (width/16), boxSize); // - arms button

  textAlign(CENTER, TOP);
  text("Arms", width/16, 6*(height/10), 2*(width/16), boxSize); // +/- arms button text
}

void keyPressed() // debug buttons
{
  if (debug)
  {
    if (key == '1')
      state = 1;
    else if (key == '0')
      state = 0;
  }
}

void mousePressed()
{
  if (state == 0) // buttons for draw state
  {
    if (mouseX >= width/16 && mouseY >= height/10 && mouseX <= 3*(width/16) && mouseY <= (height/10)+boxSize) //preview Button
    {
      println("CLICKED PREVIEW");
      preview = !preview;
      println(preview);
    }
    if (mouseX >= width/16 && mouseY >= 2*(height/10) && mouseX <= 3*(width/16) && mouseY <= 2*(height/10)+boxSize) // restart button
    {
      println("CLICKED RESTART");
      snowflake.restart();
    }
    if (mouseX >= 13*(width/16) && mouseY >= 4*(height/10) && mouseX <= 15*(width/16) && mouseY <= 4*(height/10)+boxSize) // start simulation button
    {
      println("CLICKED START");
      world.clear();
      world.setEdges();
      world.remove(world.left);
      world.remove(world.right);
      world.remove(world.top);
      snowflake.finish();
      state = 1;
    }
    if (mouseX >= 2*(width/16) && mouseY >= 6*(height/10) && mouseX <= 3*(width/16) && mouseY <= 6*(height/10)+boxSize) // "+" arm button
    {
      if (arms < maxarms)
        arms += 1;
    }
    if (mouseX >= width/16 && mouseY >= 6*(height/10) && mouseX <= 2*(width/16) && mouseY <= 6*(height/10)+boxSize) // "-" arm button
    {
      if (arms > minarms)
        arms -= 1;
    }
  } else if (state == 1) // run state
  {
    ;
  }
}
