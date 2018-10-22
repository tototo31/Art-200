

int bg = 0;


void setup()
{
  size(800, 600);
  background(bg);
  ellipseMode(CENTER);
}


int time = millis();
int prevTime = time;
int tol = 50; 
int r = 0;
int b = 0;

int controlWidth = 40;

//increase size
int plusrectx = 10;
int plusrecty = 10;
int plusWidth = 20;
boolean plusrect = false;

// decrease size
int minusrectx = 10;
int minusrecty = 40;
int minusWidth = 20;
boolean minusRect = false;

// switch which deveation is used
int dirrectx = 10;
int dirrecty = 100;
int dirWidth = 20;
boolean dirRect = false;

// xy simultaneous toggle
boolean xy = false;
// erase screen button
int erasex = 10;
int erasey = 500;
int eraseWidth = 20;

void draw()
{
  /* fill(round(random(0,255)), round(random(0,255)), round(random(0,255))); // choose a random color for the shape */
  /* stroke(round(random(0,255)), round(random(0,255)), round(random(0,255))); // choose a random color for the shape */

  time = millis();

  int r = int(map(mouseX, 0, height, 0, 255));
  int b = int(map(mouseY, 0, width, 0, 255));
  int g = int(map(mouseX+mouseY, height+width, 0, 0, 255));
  fill(r, g, b);
  int sr = int(map(mouseX, height, 0, 0, 255));
  int sb = int(map(mouseX, width, 0, 0, 255));
  int sg = int(map(mouseX+mouseY, 0, height+width, 0, 255));
  stroke(sr, sg, sb);

  //draw shape - only if mouse has moved
  if(!xy)
  {
    if ((mouseX != pmouseX || mouseY != pmouseY) && dirRect && mousePressed) 
    {
      /* ellipse(mouseX, mouseY, (mouseX+mouseY)%tol, (mouseX+mouseY)%tol); */
      ellipse(mouseX, mouseY, mouseX%tol, mouseX%tol);
    } else if ((mouseX != pmouseX || mouseY != pmouseY) && !dirRect && mousePressed) 
    {
      ellipse(mouseX, mouseY, mouseY%tol, mouseY%tol);
    }
  }
  else
  {
    ;
  }

  // draw menu bar
  fill(128);
  stroke(0);
  rect(0, 0, controlWidth, height);
  fill(255);
  rect(erasex, erasey, eraseWidth, eraseWidth);
  line(erasex, erasey, erasex+eraseWidth, erasey+eraseWidth);
  rect(plusrectx, plusrecty, plusWidth, plusWidth);
  line(plusrectx, plusrecty+(plusWidth/2), plusrectx+plusWidth, plusrecty+(plusWidth/2));
  line(plusrectx+(plusWidth/2), plusrecty, plusrectx+(plusWidth/2), plusrecty+plusWidth);
  rect(minusrectx, minusrecty, minusWidth, minusWidth);
  line(minusrectx, minusrecty+(minusWidth/2), minusrectx+minusWidth, minusrecty+(minusWidth/2));
  rect(dirrectx, dirrecty, dirWidth, dirWidth);
  textSize(12);
  fill(0);
  text(tol, minusrectx, minusrecty);


  // mark which way mod is acting on
  if(!xy)
  {
  if (dirRect)
    text("x", dirrectx+(dirWidth/3), dirrecty+(dirWidth/1.5));
  else
    text("y", dirrectx+(dirWidth/3), dirrecty+(dirWidth/1.5));
  }
  else
  {
    ;
  }
  // plus button
  if (mouseX > plusrectx && mouseX < plusrectx+plusWidth && mouseY > plusrecty && mouseY < plusrecty+plusWidth && mousePressed)
  {
    if (time - prevTime > 50)
    {
      prevTime = time;
      tol++;
      println(tol);
    }
  }
  // minus button
  if (mouseX > minusrectx && mouseX < minusrectx+minusWidth && mouseY > minusrecty && mouseY < minusrecty+minusWidth && mousePressed)
  {
    if (time - prevTime > 50)
    {
      prevTime = time;
      tol--;
      println(tol);
    }
  }
  tol = constrain(tol, 10, 100);

  // wipe screen
  if (keyPressed == true && key == ' ')
    background(bg);
  // save frame
  if (keyPressed == true && key == 's')
    saveFrame();
}

void mousePressed() {
  if (mouseX > dirrectx && mouseX < dirrectx+dirWidth && mouseY > dirrecty && mouseY < dirrecty+dirWidth)
    dirRect = !dirRect;
  if (mouseX > erasex && mouseX < erasex+eraseWidth && mouseY > erasey && mouseY < erasey+eraseWidth)
    background(0);
}
