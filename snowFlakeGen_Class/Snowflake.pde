

class Snowflake {
  int len;
  float[] posX;
  float[] pPosX;
  float[] posY;
  float[] pPosY;
  int index;
  float scale;

  Snowflake(int templen)
  {
    len = templen;
    posX = new float[len];
    pPosX = new float[len];
    posY = new float[len];
    pPosY = new float[len];
    index = 0;
    scale = 4;  // scale factor ie 1/scale
    println("initialized flake");
    for ( int i = 0; i < len; i++)
    {
      posX[i] = -1000;
      posY[i] = -1000;
      pPosX[i] = -1000;
      pPosY[i] = -1000;
    }
  }

  void displayFrond()
  {
    //println("drawing flake");
    for (int i = 0; i<len; i++)
    {
      //if ( posX[i] != -1 && pPosX[i] != -1 && posY[i] != -1 && pPosY[i] != -1)
      line(posX[i], posY[i], pPosX[i], pPosY[i]);
      //println(posX);
      //else
      //break;
    }
  }

  void displayWhole(int fronds, int x, int y)
  {
    pushMatrix();
    translate(x, y);

    //snowflake.displayFrond();
    for (int j = 0; j <= fronds; j++)
    {
      rotate(j*((2*PI)/fronds));
      for (int i = 0; i<len; i++)
      {
        //if ( posX[i] != -1 && pPosX[i] != -1 && posY[i] != -1 && pPosY[i] != -1)
        line((posX[i]-(width/2))/scale, (posY[i]-(height/2))/scale, (pPosX[i]-(width/2))/scale, (pPosY[i]-(height/2))/scale);
        //println(posX);
        //else
        //break;
       }
    }
    popMatrix();
  }

  void restart()
  {
    index = 0;
    for ( int i = 0; i < len; i++)
    {
      posX[i] = -1000;
      posY[i] = -1000;
      pPosX[i] = -1000;
      pPosY[i] = -1000;
    }
  }


  boolean addPoint(float x, float y, float px, float py)
  {
    //println("adding point to flake");
    //translate(height/2, width/2);
    if (index > len-1) 
    {
      return false; // make sure not to overwrite work weve already done
    } else
    {
      //println("index =", len);
      posX[index] = x;
      posY[index] = y;
      pPosX[index] = px;
      pPosY[index] = py;
      index += 1;
      return true;
    }
  }
}
