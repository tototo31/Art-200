float[] laneBounds;


void setup()
{
  laneBounds = new float[16];
  for(int i = 0; i < laneBounds.length; i++)
  laneBounds[i] = i * 2;
}

void draw()
{
  println(whichLane(3, laneBounds, 0));
  println(laneBounds);
}

int whichLane(int pos, float[] lanes, int start)
{
  if(start > lanes.length)
  return 0;
  else
  {
    if(pos > lanes[start])
    return whichLane(pos, lanes, start+1);
    else
    return start;
  }
}
