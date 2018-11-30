

class Snowflake {
  int len;
  FloatList posX;
  FloatList pPosX;
  FloatList posY;
  FloatList pPosY;
  int index;
  int size;
  float scale;
  PGraphics flake;

  Snowflake(int templen, float tempScale)
  {
    len = templen;
    index = 0;
    scale = tempScale;  // scale factor ie 1/scale
    size = 0;
    
    posX = new FloatList();
    posY = new FloatList();
    pPosX = new FloatList();
    pPosY = new FloatList();
    flake = createGraphics(width/4, height/2);
    println("initialized flake");
  }

  void displayarm() // draw one arm
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

  void displayWhole(int arms, float x, float y) // draw the previe
  {
    pushMatrix();
    translate(x, y);

    for (int j = 0; j <= arms; j++)
    {
      rotate((2*PI)/arms);
      for (int i = 0; i<posX.size(); i++)
      {
        line((posX.get(i)-(width/2))/scale, (posY.get(i)-(height/2))/scale, (pPosX.get(i)-(width/2))/scale, (pPosY.get(i)-(height/2))/scale);
      }
    }
    popMatrix();
  }

  void display(float x, float y) // must be called afer .finish();
  {
    imageMode(CENTER); 
    image(flake, x, y);
  }

  void restart() // clear everything to restart flake customization
  {
    index = 0;
    size = 0;
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

  void finish(int arms) // anything that needs run when finishing the flake
  {
    //size = 40;
    size = flakeWidth();
    flake.beginDraw();
    flake.background(0, 0);
    flake.stroke(255);
    flake.pushMatrix();
    flake.translate(flake.width/2, flake.height/2);
    for (int j = 0; j <= arms; j++)
    {
      flake.rotate((2*PI)/arms);
      for (int i = 0; i<posX.size(); i++)
      {
        flake.line((posX.get(i)-(width/2))/scale, (posY.get(i)-(height/2))/scale, (pPosX.get(i)-(width/2))/scale, (pPosY.get(i)-(height/2))/scale);
      }
    }
    flake.popMatrix();
    flake.endDraw();
  }

  int flakeWidth() // used to determine radius of physics bodies
  { 
    float greatest = 0;

    for (int i = 0; i < index; i++)
    {
      float flakeWidth = abs(dist((posX.get(i)-(width/2)), (posY.get(i)-(height/2)), 0, 0));
      if (flakeWidth > greatest)
        greatest = flakeWidth;
    }
    //println(int(greatest/2));
    return int(greatest/(scale/2)); // figure out what to divide by to get right circle size
  }
}
