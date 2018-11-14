

int len = 100;
float[] posX = new float[len];
float[] pPosX = new float[len];
float[] posY = new float[len];
float[] pPosY = new float[len];
int index = 0;


void setup()
{
  size(800, 600);
  for (int i = 0; i < len; i++)
  {
    posX[i] = -1;
    posY[i] = -1;
  }
}

void draw()
{
  if (index > len-1)
    index = 0;
  //println(index);
  if (mousePressed)
  {
    posX[index] = mouseX;
    posY[index] = mouseY;
    pPosX[index] = pmouseX;
    pPosY[index] = pmouseY;
  }

  println(posX);

  for (int i = 0; i<len; i++)
  {
    if ( posX[i] != -1 && pPosX[i] != -1 && posY[i] != -1 && pPosY[i] != -1)
      line(posX[i], posY[i], pPosX[i], pPosY[i]);
    //else
    //break;
  }
  index++;
  if (keyPressed && key == 's')
  {
    pushMatrix();
    translate(50, 50);
    for (int i = 0; i<len; i++)
    {
      if ( posX[i] != -1 && pPosX[i] != -1 && posY[i] != -1 && pPosY[i] != -1)
        line(posX[i], posY[i], pPosX[i], pPosY[i]);
      //else
      //break;
    }
    popMatrix();
  }
}
