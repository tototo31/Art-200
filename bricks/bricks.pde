 int rectSize = 10;
 boolean filled = true;
 int incSize = 25;
 
 size(800, 800);
  stroke(200);
  strokeWeight(2);
  for (int y = 0; y <= height; y+=rectSize)
  {
    for (int x = 0; x <= width; x+= incSize)
    {
      if (filled)
        fill(191, 90, 55);
      else
        fill(135, 48, 24);
      filled = !filled;
      rect(x, y, incSize, rectSize);
    }
  }
  
  //stroke(0);
  fill(255);
  stroke(0);
  rect(200, 100, 400, 600);
  line(width/2, 100, width/2, 600);
