/*
reference for library before I lose the link - http://www.ricardmarxer.com/fisica/reference/index.html
 TODO: 
 Add Houses - make the snow interact with it
 Different shaped for flakes?
 
 
 */
import fisica.*;

FWorld world;  // create world
Snowflake snowflake; // create snow flake
PImage clouds; // cloud background
ArrayList<Snowflake> allFlakes;
int state = 0; // simulation state - do not change
int operatingFlake = 0;
int scale = 12;
float scaleInc = 1;
int arms = 6; // starting arms
int maxarms = 10; // max arms
int minarms = 2; // min arms
int boxSize = 50; // button size - do not change
int len = 1000; // snow flake point array size - if anything lower this
int freq = 10; // freq at which to drop flakes - dont change by much this is very un optimized - default 40

boolean preview = false; // preview button state

boolean debug = true; // enable/disable debug keys

void setup()
{
  size(800, 600);
  smooth();
  allFlakes = new ArrayList<Snowflake>(); // list of custom snowlakes
  allFlakes.add(new Snowflake(len, scale)); // add the first flake
  clouds = loadImage("Cloud.png"); // add cloud BG
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
        allFlakes.get(operatingFlake).addPoint(mouseX, mouseY, pmouseX, pmouseY);
    }

    if (preview) // if the preview toggle is on show the scaled flake
    {
      allFlakes.get(operatingFlake).displayWhole(arms, width/2, height/2); // display unImageified flake
    } else allFlakes.get(operatingFlake).displayarm(); // otherwise just display the unscaled arm

    break;
    // END CREATION

  case 1: // simulation state
    imageMode(CORNER);
    background(128); // a nice grey sky
    image(clouds, 0, 0); // amazing looking clouds
    int whichFlake = int(random(0, allFlakes.size()));
    if (frameCount%freq == 1)  // determine when to drop flakes
    {
      FCircle flake = new FCircle(allFlakes.get(whichFlake).size); // circle are probably the best to represent a snowflake - especially with many arms
      flake.setPosition(random(width), 100); // spawn randomly in the clouds
      flake.setVelocity(random(-100, 100), 0); //should i keep this?
      //flake.attachImage(allFlakes.get(whichFlake).flake);
      flake.setFillColor(0);
      // ***DEBUG STUFF***
      if (!debug)
      {
        flake.setNoStroke();
      } else
      {
        surface.setTitle(str(frameRate));
      }
      // *** END DEBUG STUFF***
      world.add(flake); // add it to the world
    }

    world.step(); // step the world 1/60th of a second
    ArrayList<FBody> bodies=world.getBodies(); // create a list of bodies in the world
    for (int i = 0; i < bodies.size(); i++) // for each body draw a flake over it
    {
        if( bodies.get(i) instanceof FCircle ) {
          float sz = ((FCircle)bodies.get(i)).getSize();
          for(int flake = 0; flake < allFlakes.size(); flake++)
          {
            if(allFlakes.get(flake).size == sz)
            {
              allFlakes.get(flake).display(bodies.get(i).getX(), bodies.get(i).getY()); // if it wasnt removed show the beautiful flake
            }
          }
        if ((bodies.get(i).getY() > height+sz || bodies.get(i).getX() > width+sz || bodies.get(i).getX() < 0-sz))
          world.remove(bodies.get(i)); // delete teh flake if its off the screen
      }
    }
    world.draw(); // draw the world bodies in the new state
    drawSimButtons(); // draw the butttons to be displayed during the simulation
    break;
  }
}

void canvas()
{
  //make canvas
  fill(255);
  rect(width/4, 0, 2*(width/4), height); // drawing area
  fill(0);
  if (!preview) ellipse(width/2, height/2, 10, 10); // draw center dot
  fill(255);
}

void drawSimButtons()
{
  fill(128);
  rect(width/16, height/20, 2*(width/16), boxSize); // back to customization button

  fill(0);
  textAlign(CENTER, CENTER);
  text("Customize Again", width/16, height/20, 2*(width/16), boxSize); // back to customization text
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
  rect(13*(width/16), 4*(height/10), 2*(width/16), boxSize); //navigate Flakes button
  rect(width/16, 4*(height/10), 2*(width/16), boxSize); //scale button
  rect(13*(width/16), 2*(height/10), 2*(width/16), boxSize); //remove flake simulation button
  //rect(13*(width/16), (height/10), 2*(width/16), boxSize); //new flake simulation button
  rect(13*(width/16), 6*(height/10), 2*(width/16), boxSize); // start Flakes button
  rect(width/16, 6*(height/10), 2*(width/16), boxSize); // +/- arms button

  // rect(width/16, 7*(height/10), 2*(width/16), boxSize); // +/- scale button

  //TEXT
  fill(0);
  textAlign(CENTER, CENTER);
  text("Flake Number", width/2, 10);
  text(operatingFlake+1, width/2, 25);
  text("Preview", width/16, height/10, 2*(width/16), boxSize);
  text("Restart", width/16, 2*(height/10), 2*(width/16), boxSize);
  text("Start", 13*(width/16), 6*(height/10), 2*(width/16), boxSize);
  text(str(arms), width/16, 6*(height/10), 2*(width/16), boxSize); // +/- arms button State
  text("+", 2*(width/16), 6*(height/10), (width/16), boxSize); // + arms button
  text("-", (width/16), 6*(height/10), (width/16), boxSize); // - arms button
  text(str(operatingFlake+1), 13*(width/16), 4*(height/10), 2*(width/16), boxSize); // +/- flake button State
  text("+", 14*(width/16), 4*(height/10), (width/16), boxSize); // + flake button
  text("-", 13*(width/16), 4*(height/10), (width/16), boxSize); // - flake button
  text("Delete This Flake", 13*(width/16), 2*(height/10), 2*(width/16), boxSize); // remove Flake
  //text("New Flake", 13*(width/16), (height/10), 2*(width/16), boxSize); // new flake
  text("1/"+str(allFlakes.get(operatingFlake).scale), width/16, 4*(height/10), 2*(width/16), boxSize);
  text("+", 2*(width/16), 4*(height/10), (width/16), boxSize); // + scale
  text("-", (width/16), 4*(height/10), (width/16), boxSize); // - scale

  textAlign(CENTER, TOP);
  text("Arms", width/16, 6*(height/10), 2*(width/16), boxSize); // +/- arms button text
  text("Select Flake", 13*(width/16), 4*(height/10), 2*(width/16), boxSize); //navigate flakes text
  text("Scale", width/16, 4*(height/10), 2*(width/16), boxSize);
}

void keyPressed() // debug buttons
{
  if (debug)
  {
    if (key == '1')
      state = 1;
    else if (key == '0')
      state = 0;
    else if (key == 'n')
    {
      operatingFlake++;
      allFlakes.add(new Snowflake(len, scale));
    } else if (key == 'd')
    {
      allFlakes.remove(operatingFlake);
      operatingFlake--;
    }
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
      allFlakes.get(operatingFlake).restart();
    }
    if (mouseX >= 13*(width/16) && mouseY >= 6*(height/10) && mouseX <= 15*(width/16) && mouseY <= 6*(height/10)+boxSize) // start simulation button
    {

      for (int i = allFlakes.size()-1; i >= 0; i--) //finish flakes - delete empty ones
      {
        if (allFlakes.get(i).posX.size() > 0) // should only need to check one of these lists as they should all be the same size
        {
          allFlakes.get(i).finish(arms);
        } else
        {
          allFlakes.remove(i);
        }
      }
      if (allFlakes.size() > 0)
      {
        for (int i = 0; i < allFlakes.size(); i++) // make sure theres a flake with some size
        {
          if (allFlakes.get(i).posX.size() > 0) // if theres atleast one flake with a non zero size start the world
          {
            println("Starting Simulation");
            world.clear();
            world.setEdges();
            world.remove(world.left);
            world.remove(world.right);
            world.remove(world.top);
            break;
          }
        }
        state = 1; // goto sim state
        operatingFlake=0; // go back to beginning flake for customization
      } else
      {
        allFlakes.add(new Snowflake(len, scale));
        operatingFlake = 0;
      }
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
    if (mouseX >= 14*(width/16) && mouseY >=  4*(height/10) && mouseX <= 15*(width/16) && mouseY <= 4*(height/10)+boxSize) // navigate flake +
    {
      //println("clicked +"); 
      operatingFlake++;
      if (operatingFlake > allFlakes.size()-1)
      {
        allFlakes.add(new Snowflake(len, scale));
      }
    }
    if (mouseX >= 13*(width/16) && mouseY >= 4*(height/10) && mouseX <= 14*(width/16) && mouseY <= 4*(height/10)+boxSize) // navigate flake -
    {
      //println("clicked -");
      if (operatingFlake > 0) // move backa a flake but not past flake 0
      {
        operatingFlake--;
      }
    }
    if (mouseX >= 2*(width/16) && mouseY >= 4*(height/10) && mouseX <= 3*(width/16) && mouseY <= 4*(height/10)+boxSize) // + scale
    {
      allFlakes.get(operatingFlake).addScale(scaleInc);
    }
    if (mouseX >= (width/16) && mouseY >= 4*(height/10) && mouseX <= 2*(width/16) && mouseY <= 4*(height/10)+boxSize) // - scale
    {
      allFlakes.get(operatingFlake).addScale(-scaleInc);
    }
    if (mouseX >= 13*(width/16) && mouseY >= 2*(height/10) && mouseX <= 15*(width/16) && mouseY <= 2*(height/10)+boxSize) // delete flake button
    {
      //println("DELETE FLAKE"); 
      if (operatingFlake > 0) // delete the flake and move back a flake
      {
        allFlakes.remove(operatingFlake);
        operatingFlake--;
      } else // otherwise if there was only one flake reset the current flake
      {
        allFlakes.get(operatingFlake).restart();
      }
    }
  } else if (state == 1) // run state buttons
  {
    if (mouseX >= width/16 && mouseY >= height/20 && mouseX <= 3*(width/16) && mouseY <= (height/20)+boxSize) // back to customizing button
    {
      state = 0;
    }
  }
}
