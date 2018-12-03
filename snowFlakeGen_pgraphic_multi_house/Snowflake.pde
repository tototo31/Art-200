

class Snowflake {
  int len;
  FloatList posX;
  FloatList pPosX;
  FloatList posY;
  FloatList pPosY;
  int size;
  float scale;
  float maxScale;
  float minScale;
  PGraphics flake;

  Snowflake(int templen, float initialScale)
  {
    len = templen;
    scale = initialScale;  // scale factor ie 1/scale
    size = 0;
    maxScale = 20;
    minScale = 3;

    posX = new FloatList();
    posY = new FloatList();
    pPosX = new FloatList();
    pPosY = new FloatList();
    //flake = createGraphics(width/4, height/2);
    println("initialized flake");
  }

  float addScale(float tempScale)
  {
    scale += tempScale;
    if (scale < minScale)
    {
      scale = minScale;
    } else if (scale > maxScale)
    {
      scale = maxScale;
    }
    return scale;
  }

  void displayarm() // draw one arm
  {
    for (int i = 0; i<posX.size(); i++)
    {
      line(posX.get(i), posY.get(i), pPosX.get(i), pPosY.get(i));
    }
  }

  void displayWhole(int arms, float x, float y) // draw the previe
  {
    pushMatrix();
    translate(x, y);
    fill(255);
    fill(0);
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
    size = 0;
    posX.clear();
    posY.clear();
    pPosX.clear();
    pPosY.clear();
  }


  void addPoint(float x, float y, float px, float py) // add a point to recreate arms
  {
    posX.append(x);
    posY.append(y);
    pPosX.append(px);
    pPosY.append(py);
  }

  void finish(int arms) // create an image of the finished flake to alleviate any lag
  {
    size = int(flakeWidth()/scale);
    flake = createGraphics(size, size);
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

    for (int i = 0; i < posX.size(); i++)
    {
      float flakeWidth = abs(dist((posX.get(i)), (posY.get(i)), width/2, height/2));
      if (flakeWidth > greatest)
        greatest = flakeWidth;
    }
    return int(2*greatest); // figure out what to divide by to get right circle size
  }
}
