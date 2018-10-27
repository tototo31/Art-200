// Example 10-10: The raindrop catching game

/*
TODO:
 draw lines
 create player + movement (HOPS)
 increase speed of cars as time goes on
 fix car drop locations
 
 PASS direct x coord to drop class creation from reference array created when drawing road centers
 
 
 */

Catcher catcher;    // One catcher object
Timer timer;        // One timer object
Drop[] drops;       // An array of drop objects

// **** Customization Options **** //
int lanes = 16; // number of lanes -2 for lawns
int speed = 5; //Car starting speed
int timeBetweenDrops = 500; //time between drops in ms
// **** End Customization Options **** //

float[] roadCenters;
int totalDrops = 0; // totalDrops
int catchRad = 16;
int catcherX;
int catcherYSpeed = 50;
int catcherY;
boolean endGame = false;
int run = 0;
int newLane = 1;
String winner = "";

void setup() {
  size(600, 800);
  catcher = new Catcher(catchRad); // Create the catcher with a radius of 32
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(timeBetweenDrops);    // Create a timer that goes off every 300 milliseconds
  roadCenters = new float[lanes-1]; // create lane senter reference
  startScreen();
  timer.start();             // Starting the timer
}


void draw() {
  if (!endGame)
  {
    if (run == 0)
    {
      startScreen();
      catcherX = 0;
      catcherY = height/16;
      if (keyPressed)
        run = 1; //enable the end screen
    } else
    {
      background(0, 128, 0);
      road();
      // Set catcher location
      catcher.setLocation(catcherX, catcherY); 
      // Display the catcher
      catcher.display(); 
      int newLane = 1;

      if (mousePressed)
      {
        newLane =  int(map(mouseX, 0, width, 1, lanes));
        println(newLane);
        if (timer.isFinished()) {
          // Deal with raindrops
          // Initialize one drop
          drops[totalDrops] = new Drop(newLane, lanes, speed);
          // Increment totalDrops
          totalDrops ++ ;
          // If we hit the end of the array
          if (totalDrops >= drops.length) {
            totalDrops = 0; // Start over
          }
          timer.start();
        }
      }

      // Move and display all drops
      for (int i = 0; i < totalDrops; i++ ) {
        drops[i].move();
        drops[i].display();
        if (catcher.intersect(drops[i])) {   // CHECK FOR GAME END
          drops[i].caught();
          winner = "Mouse";
          endGame = true;
        }
        for (int j = 0; j < 9; j++)
        {
          line(j*width/8, 0, j*width/8, height);
        }
      }
    }
  } else
  {
    println("END GAME");
    println(winner);
    if (run == 1)
    {
      end();      
      run = 0;
    }
    if (mousePressed)
      endGame = false;
  }
}

void end()
{
  println("END FUNCTION");

  for (int i = 0; i < totalDrops; i++)
  {
    drops[i].caught();
  }
  background(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(255);
  text("THE WINNER IS:", width/2, height/2-32);
  text(winner, width/2, height/2);
}
void road()
{
  fill(0);
  rect(width/(2*lanes), 0, (2*lanes-2)*width/(2*lanes), height);
  for (int j = 0; j < 2*lanes; j++) // draw the road lanes
  {

    if (j%2 == 1) // drw partitions
    {
      stroke(255);
      strokeWeight(1);
      line(j*width/(2*lanes), 0, j*width/(2*lanes), height); // draw solids
    } else // draw dashes
    {
      if (j != 0)
        for (int i = 0; i < height; i+= 50)
        {
          stroke(255, 255, 100);
          strokeWeight(5);
          line(j*width/(lanes*2), i, j*width/(lanes*2), i+25); // draw dashes
        }
    }
  }
  strokeWeight(1);
  stroke(0);
}

void startScreen()
{
  textAlign(CENTER, CENTER);
  textSize(32);
  background(255);
  fill(0);
  text("WHY DID THE CHICKEN", width/2, height/2-32);
  text("CROSS THE ROAD?", width/2, height/2);
}

void keyPressed()
{
  if (key == 'w')
  {
    catcherY -= catcherYSpeed;
    if (catcherY < 0)
      catcherY = 0;
  } else if (key == 'a')
  {
    catcherX -= width/lanes;
    if (catcherX < 0)
      catcherX = 0;
  } else if (key == 's')
  {
    catcherY += catcherYSpeed;
    if (catcherY > height)
      catcherY = height;
  } else if (key == 'd')
  {
    catcherX += width/lanes;
    if (catcherX > width)
    {
      catcherX = width;
      winner = "KEYBOARD";
      endGame = true;
    }
  } else if (key == 'j')

    endGame = true;
}
