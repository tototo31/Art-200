



void setup() {

  size(800, 600);
  background(255);
  noStroke();
}
/* stroke(0); */

// draw checkers
/* int iter = 0; */
void draw() {
  int rectSize = 10;
  boolean filled = true;
  for (int y = 0; y <= height; y+=rectSize)
  {
    for (int x = 0; x <= width; x+= rectSize)
    {
      if (filled)
        fill(0);
      else
        fill(255);
      filled = !filled;
      rect(x, y, rectSize, rectSize, 10);
    }
  }

  // draw center square
  //rectMode(CENTER);
  ellipseMode(CENTER);
  float[] sizes = {2, 1.2};
  for (int y = rectSize/2; y <= height; y += rectSize)
  {
    filled = !filled;
    for (int x = rectSize/2; x <= width; x += rectSize)
    {
      if (!filled)
      {
        fill(0);
        ellipse(x, y, rectSize/sizes[int(random(sizes.length))], rectSize/sizes[int(random(sizes.length))]);
      } else
      {
        fill(255);
        ellipse(x, y, rectSize/sizes[int(random(sizes.length))], rectSize/sizes[int(random(sizes.length))]);
        /* ellipse(x, y, rectSize/1.2, rectSize/2); */
      }
      filled = !filled;
    }
  }
  delay(100);
  /* while(iter < 3) */
  /* { */
  /*   saveFrame(); */
  /*   break; */
  /* } */
  /* iter += 1; */
}
