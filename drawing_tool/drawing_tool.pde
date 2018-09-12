




void setup()
{
  size(800, 600);
  background(0);
  ellipseMode(CENTER);
}


int time = millis();
int prevTime = time;
int tol = 50; //how big the random shape can be
int r = 0;
int b = 0;
void draw()
{
  /* fill(round(random(0,255)), round(random(0,255)), round(random(0,255))); // choose a random color for the shape */
  /* stroke(round(random(0,255)), round(random(0,255)), round(random(0,255))); // choose a random color for the shape */

  time = millis();

  // slow the rate of growth
  if(mousePressed && mouseButton == LEFT && tol < 100)
  {
     if(time-prevTime > 50)
    {
    prevTime = time;
    tol++;
    println(tol);
    }
  }
  if(mousePressed && mouseButton == RIGHT && tol > 0)
  {
    if(time-prevTime > 50)
    {
    prevTime = time;
    tol--;
    println(tol);
    }
  }
    int r = int(map(mouseX, 0, 800, 0, 255));
    int b = int(map(mouseY, 0, 600, 0, 255));
    int g = int(map(mouseX+mouseY, 1400, 0, 0, 255));
    fill(r, g, b);
    int sr = int(map(mouseX, 800, 0, 0, 255));
    int sb = int(map(mouseX, 600, 0, 0, 255));
    int sg = int(map(mouseX+mouseY, 0, 1400, 0, 255));
    stroke(sr, sg, sb);

  //draw shape - only if mouse has moved
  if(mouseX != pmouseX || mouseY != pmouseY) 
      ellipse(mouseX, mouseY, mouseX%tol, mouseX%tol);
    /* if(mouseX-pmouseX <= 0 && mouseY-pmouseY <= 0) */
    /*   ellipse(mouseX, mouseY, mouseX%tol, mouseY%tol); */
    /* else if(mouseX-pmouseX >= 0 && mouseY-pmouseY >= 0) */
    /*   ellipse(mouseX, mouseY, mouseX%tol, mouseY%tol); */
    /* else */
    /*   triangle(mouseX, mouseY, random(mouseX-tol, mouseX+tol), random(mouseY-tol/2, mouseY+tol/2), pmouseX, pmouseY); */

  // wipe screen
  if(keyPressed == true && key == ' ')
    background(128);
  if(keyPressed == true && key == 's')
    saveFrame();
}
