/*
 * Creature by Ethan Flubacher
 * email: ejf5367@psu.edu
 */

void setup(){
  size(800, 600);
  background(255);
  ellipseMode(CENTER);
  bg();
}

void draw()
{
  //legs 
  fill(0);
  rectMode(CORNER);
  int pos = 300; // variable for leg position
  int rnd = 10; // variable for leg roundness
  for (int i=0; i < 4; i=i+1) //generate each leg with a certain offset
  {
    if(i >= 2)
    rect(pos+115, 320, 10, 80, rnd);
    else
    rect(pos, 320, 10, 80, rnd);
   
    pos = pos + 25;
  }
  //body
  rectMode(CENTER);
  fill(0, 0, 128);
  rect(400, 300, 200, 100, 25);
  fill(150, 0, 255);
  triangle(320, 250, 480, 250, 400, 349);
  noFill();
  //ears
  fill(200, 100, 95);
  strokeWeight(5);
  ellipse(310, 200, 20, 50);
  ellipse(280, 200, 20, 50);
  //head
  //fill(0, 65, 130);
  fill(0, 0, 128);
  strokeWeight(3);
  ellipse(300, 250, 100, 100); // center at 300, 250 radius 50
  strokeWeight(0);
  //head decor
  //fill(18,126,36);
  fill(150, 0, 255);
  triangle(310, 200, 280, 203, 300, 230);
  //eyes
  fill(255);
  ellipse(280, 230, 20, 10);
  ellipse(320, 230, 20, 10);
  //Pupils
  fill(0);
  ellipse(320, 230, 5, 5);
  ellipse(280, 230, 5, 5);
  //mouth
  fill(200, 100, 95);
  arc(300, 260, 20, 20, 0, PI, CHORD);
}

void bg() // draw background
{
  for(int i = 0; i <= 600; i++)
  {
    float green = map(i, 0, 600, 0, 100);
    stroke(156, green, 0);
    /* println(green); */
    line(800, i, 0, i);
  }
  noStroke();
  fill(34, 128, 34);
  rect(0, 401, 800, 399);
  fill(255);
  stroke(0);
}
