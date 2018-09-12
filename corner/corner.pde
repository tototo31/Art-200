


void setup()
{
  size(200, 200);
}

void draw()
{
  background(0);

    if(mouseX > width/2) // right side blocks
    {
      if(mouseY > height/2) // bottom
        rect(width/2, height/2, width/2, height/2);
      else // top
        rect(width/2, 0, width/2, height/2);
    }
    else // left side blocks
    {
      if(mouseY < height/2) //top
        rect(0,0, width/2, height/2);
      else // bottom
        rect(0, height/2, width/2, height/2);
    }
}
