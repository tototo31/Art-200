
int radius = 20;
float x = 0;
float y = 100;
float speed = 2.2;
float speedY = 2;

int bounce = -1;

int rectSize = 40;
int rectX, rectY;
boolean button = false;

void setup()
{
  size(200, 200);
  ellipseMode(RADIUS);

  x = width/2;
  y = height/3;
  rectX = 10;
  rectY = 10;
}

void draw()
{
  background(255);
  stroke(0);
  ellipse(x, y, radius, radius);
 // ellipse moves all the time
 x += speed;
 y += speedY;
 // if ellipse reaches border change speed direction
 if(x >= width - radius || x <= radius)
 {
   speed = speed * bounce;
 }

 if(y >= height - radius || y <= radius)
 {
   speedY = speedY * bounce;
 }

 // draw button
 rect(rectX, rectY, rectSize, rectSize);
 if(button)
 {
   x += speed;
   y += speedY;
 }
}

void mousePressed(){
  if (mouseX > rectX && mouseY > rectY && mouseX < rectX+rectSize && mouseY < rectY+rectSize)
  {
    button = !button;
  }
}
