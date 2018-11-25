

class Snowflake {
  int len;
  FloatList posX;
  FloatList pPosX;
  FloatList posY;
  FloatList pPosY;
  int index;
  float scale;

  Snowflake(int templen)
  {
    len = templen;
    index = 0;
    scale = 4;  // scale factor ie 1/scale
    this.addPoint(width/2, height/2, width/2, height/2);
    println("initialized flake");
  }

  void displayFrond()
  {
    //println("drawing flake");
    for (int i = 0; i<posX.size(); i++)
    {
      //if ( posX[i] != -1 && pPosX[i] != -1 && posY[i] != -1 && pPosY[i] != -1)
      line(posX.get(i), posY.get(i), pPosX.get(i), pPosY.get(i));
      //println(posX);
      //else
      //break;
    }
  }

  void displayWhole(int fronds, float x, float y)
  {
    pushMatrix();
    translate(x, y);

    //snowflake.displayFrond();
    for (int j = 0; j <= fronds; j++)
    {
      rotate(j*((2*PI)/fronds));
      for (int i = 0; i<posX.size(); i++)
      {
        //if ( posX[i] != -1 && pPosX[i] != -1 && posY[i] != -1 && pPosY[i] != -1)
        line((posX.get(i)-(width/2))/scale, (posY.get(i)-(height/2))/scale, (pPosX.get(i)-(width/2))/scale, (pPosY.get(i)-(height/2))/scale);
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
    posX.clear();
    posY.clear();
    pPosX.clear();
    pPosY.clear();
  }


  void addPoint(float x, float y, float px, float py)
  {
    posX.append(x);
    posY.append(y);
    pPosX.append(px);
    pPosY.append(py);
    index += 1;
  }
}
