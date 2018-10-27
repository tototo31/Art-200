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
int catcherXSpeed = 50;
int catcherY;
String run = "start";
int newLane = 1;
String winner = "";
boolean w, a, s, d;

void setup() {
  size(800, 600);
  w = false;
  a = false;
  s = false;
  d = false;
  catcher = new Catcher(catchRad); // Create the catcher with a radius of 32
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(timeBetweenDrops);    // Create a timer that goes off every 300 milliseconds
  roadCenters = new float[lanes+1]; // create lane senter reference
  startScreen();
  timer.start();             // Starting the timer
}


void draw() {
  switch(run)
  {
  case "start":
    startScreen();
    catcherX = height/16;
    catcherY = 0;
    if (keyPressed)
      run = "game"; //enable the end screen
    break;
  case "end":
    println("END GAME");
    println(winner);

    end();      
    if (mousePressed)
      run = "start";
    break;

  default:
    background(0, 128, 0);
    road();
    // Set catcher location
    catcher.setLocation(catcherX, roadCenters[catcherY]); 
    // Display the catcher
    catcher.display(); 
    int newLane = 1;

    if (mousePressed)
    {
      newLane =  constrain(int(map(mouseY, 0, height, 1, lanes)), 1, lanes-1);
      //println(newLane); // show car lane
      if (timer.isFinished()) {
        // Deal with raindrops
        // Initialize one drop
        drops[totalDrops] = new Drop(newLane, roadCenters, speed);
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
        run = "end"; // set to end state
      }
      for (int j = 0; j < 9; j++)
      {
        line(j*width/8, 0, j*width/8, height);
      }
    }
    break;
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
  rect(0, height/(2*lanes), width, (2*lanes-2)*height/(2*lanes));
  for (int j = 0; j <= 2*lanes; j++) // draw the road lanes
  {

    if (j%2 == 1) // drw partitions
    {
      stroke(255);
      strokeWeight(1);
      line(0, j*height/(2*lanes), width, j*height/(2*lanes)); // draw solids
    } else // draw dashes
    {
      if (j != 0)
      {

        for (int i = 0; i < width; i+= 50)
        {
          roadCenters[j/2] = j*height/(lanes*2);
          stroke(255, 255, 100);
          strokeWeight(5);
          if(j < 2*lanes)
          line(i, j*height/(lanes*2), i+25, j*height/(lanes*2)); // draw dashes
        }
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
  if (key == 'w' && !w)
  {
    w = true;
    catcherY -= 1;
    if (catcherY < 0)
      catcherY = 0;
  } else if (key == 'a' && !a)
  {
    a = true;
    catcherX -= catcherXSpeed;
    if (catcherX < 0)
      catcherX = 0;
  } else if (key == 's' && !s)
  {
    s = true;
    catcherY += 1;
    if (catcherY > height)
    {
      catcherY = height;
      winner = "KEYBOARD";
      run = "end";
    }
  } else if (key == 'd' && !d)
  {
    d = true;
    catcherX += catcherXSpeed;
    if (catcherX > width)
      catcherX = width;
  } else if (key == 'j')
    run = "end";
  catcherY = constrain(catcherY, 0, roadCenters.length-1);
}
void keyReleased()
{
  if (key == 'w')
    w = false;
  else if (key == 'a')
    a = false;
  else if (key == 's')
    s = false;
  else if (key == 'd')
    d = false;
}
