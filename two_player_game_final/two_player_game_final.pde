// Example 10-10: The raindrop catching game

/*
TODO:
 draw lines  - DONE
 create player + movement (HOPS) 
 increase speed of cars as time goes on - DONE
 fix car drop locations - DONE
 Lane jamming
 speed meter?
 
 PASS direct x coord to drop class for creation from reference array created when drawing road centers - DONE
 
 
 */

Catcher catcher;    // One catcher object
Timer timer;        // One timer object
Drop[] drops;       // An array of drop objects

// **** Customization Options **** //
int lanes = 16; // number of lanes -2 for lawns
int minSpeed = 1; //Car starting speed
int maxSpeed = 10; // max car speed
int timeBetweenDrops = 500; //time between drops in ms

// **** End Customization Options **** //

float[] roadCenters;
float[] roadBounds;
int totalDrops = 0; // totalDrops
int catchRad = 16;
int catcherX;
int catcherXSpeed = 50;
int catcherY;
String run = "start";
int newLane = 1;
String winner = "";
boolean w, a, s, d;
int start = 0; // timer for determining car speed
int end = 0; // timer for determining car speed
PImage runner;
PImage chaser;
PImage chaser2;
PImage chaser3;
int scroll = 0;

void setup() {
  size(800, 600);
  w = false; // key press checks 
  a = false;
  s = false;
  d = false;
  imageMode(CENTER);
  runner = loadImage("Chicken.png");
  chaser = loadImage("rcarb.png");
  chaser2 = loadImage("rcarp.png");
  chaser3 = loadImage("rcarg.png");
  catcher = new Catcher(catchRad); // Create the catcher with a radius of 32
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(timeBetweenDrops);    // Create a timer that goes off every 300 milliseconds
  roadCenters = new float[lanes+1]; // create lane center reference
  roadBounds = new float[lanes]; // create lane center reference
  startScreen(); // diplay start screen
  timer.start();             // Starting the timer
}


void draw() {
  switch(run)
  {
  case "start":
    startScreen(); // display start screen
    catcherX = height/16; // set a starting position for the chicken
    catcherY = 0;
    if (keyPressed) // start the game if a key is pressed
      run = "game"; //enable the end screen
    break;

  case "end":
    println("END GAME"); // debug output
    println(winner); // more debug

    end();      // call the end function
    if (mousePressed) // go back to start if mouse is clicked
      run = "start";
    break;

  default: // default is game state
    background(0, 128, 0);  // make green grass
    road();  // draw road
    // Set catcher location
    catcher.setLocation(catcherX, roadCenters[catcherY]); 
    // Display the catcher
    catcher.display(); 
    // Move and display all drops
    for (int i = 0; i < totalDrops; i++ ) {
      drops[i].move();
      drops[i].display();
      if (catcher.intersect(drops[i])) {   // CHECK FOR GAME END
        drops[i].caught();
        winner = "MOUSE";  // if any drops are caught the game ends
        run = "end"; // set to end state
      }
      // dont know what this for loop was for. if things break bring it back
      /* for (int j = 0; j < 9; j++) */
      /* { */
      /*   line(j*width/8, 0, j*width/8, height); */
      /* } */
    }
    break;
  }
}

void end() // run when the game ends
{
  println("END FUNCTION"); // debug
  
  scroll = 0;
  for (int i = 0; i < totalDrops; i++) // catch all drops so they wont show up during the next game
  {
    drops[i].caught();
  }
  background(0); // clear screen and proint text
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(255);
  text("THE WINNER IS:", width/2, height/2-32);
  text(winner, width/2, height/2);
  fill(128, 128, 0);
  text("Click anywhere to continue", width/2, height/2+64);
  fill(0);
}

void startScreen() // run when the game begins
{
  textAlign(CENTER, CENTER); //print title screen
  textSize(32);
  background(0);
  fill(255);
  if(scroll < width+400)
  scroll += 3;
  image(runner, scroll, height/2-128);
  image(chaser, scroll-100, height/2-128);
  image(chaser2, scroll-200, height/2-128);
  image(chaser3, scroll-300, height/2-128);
  text("WHY DID THE CHICKEN", width/2, 32);
  text("CROSS THE ROAD?", width/2, 64);
  text("Keyboard:", width/2, height/2-64);
  text("Use w, a, s, d to move the chicken", width/2, height/2-32);
  text("Your goal is to get to the other side of the road", width/2, height/2);
  text("Mouse:", width/2, height/2+64);
  text("Click to create a car", width/2, height/2+92); 
  text("Hold the button down for a  faster car", width/2, height/2+124);
  text("Your goal is to prevent a safe crossing", width/2, height/2+156);
  fill(128, 128, 0);
  text("Press any key to start the game", width/2, height/2+220);
  fill(0);
}

void road() // for drawing and populating road related arrays
{
  fill(0);
  rect(0, height/(2*lanes), width, (2*lanes-2)*height/(2*lanes));
  for (int j = 0; j <= 2*lanes; j++) // draw the road lanes
  {

    if (j%2 == 1) // drw partitions
    {
      roadBounds[(j)/2] = j*height/(lanes*2);
      stroke(255);
      strokeWeight(1);
      line(0, j*height/(2*lanes), width, j*height/(2*lanes)); // draw solids
    } else // draw dashes
    {
      if (j != 0) // dont want dashes at the very top of the screen
      {

        for (int i = 0; i < width; i+= 50)
        {
          roadCenters[j/2] = j*height/(lanes*2);
          stroke(255, 255, 100);
          strokeWeight(5);
          if (j < 2*lanes)
            line(i, j*height/(lanes*2), i+25, j*height/(lanes*2)); // draw dashes
        }
      }
    }
  }
  strokeWeight(1);
  stroke(0);
}



int whichLane(int pos, float[] lanes, int start) // this function is to determine where to put the new car based on mouse position
{
  if (start >= lanes.length) // base case to avoid index errors
    return 0;
  else
  {
    if (pos > lanes[start])  //while the test value is grater than the bottom of the specific lane continue
      return whichLane(pos, lanes, start+1); // some tasty recursion to make things interesting
    else // if its smaller return the index for the edge of the lane
    return start;
  }
}

void keyPressed()
{
  if (run == "game")
  {
    if (key == 'w' && !w)
    {
      w = true;
      catcherY -= 1; // this is actually the index used for the roadCenters array
      if (catcherY < 0) // keep chicken in the screen
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
      if (roadCenters[catcherY] > roadCenters[roadCenters.length-2]) // check if we reach the other side of the road
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
    catcherY = constrain(catcherY, 0, roadCenters.length-1); // dont go off the screen and cause index errors
  }
}
void keyReleased()
{
  // this is to prevent key repeating. Only move one lane for each key press
  if (key == 'w') 
    w = false;
  else if (key == 'a')
    a = false;
  else if (key == 's')
    s = false;
  else if (key == 'd')
    d = false;
}

void mousePressed()
{
  start = millis(); // start a faux timer used to determine car speed
}

void mouseReleased()
{
  end = millis();
  if (run == "game")
  {
    int totalTime = (end-start)/100; // determine # of 100 millis passed
    int carSpeed = constrain(totalTime, minSpeed, maxSpeed) ; // for every 100 ms increment speed by 1
    newLane =  whichLane(mouseY, roadBounds, 0); //determine what lane the car is in
    //println(newLane); // show car lane
    if (newLane != 0) // no cars in the median
    {
      if (timer.isFinished()) {
        // Deal with raindrops
        // Initialize one drop
        if (mouseX < width/2) // set directions
          drops[totalDrops] = new Drop(newLane, roadCenters, carSpeed);
        else
          drops[totalDrops] = new Drop(newLane, roadCenters, -carSpeed);
        // Increment totalDrops
        totalDrops ++ ;
        // If we hit the end of the array
        if (totalDrops >= drops.length) {
          totalDrops = 0; // Start over
        }
        timer.start();
      }
    }
  }
}
