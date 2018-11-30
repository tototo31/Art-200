


PGraphics pg;

int i = 0;
void setup()
{
  size(500, 500);

  pg = createGraphics(100, 100);
  pg.beginDraw();
  pg.background(102);
  pg.stroke(255);
  pg.line(pg.width*0.5, pg.height*0.5, mouseX, mouseY);
  pg.endDraw();
}

void draw() {

  background(0);
  ellipse(i, i, 10, 10);

  image(pg, i, i); 
  i++;
}
