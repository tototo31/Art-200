


Catcher catcher;


void setup()
{
  size(400, 400);

  catcher = new Catcher();
}

void draw()
{
  background(255);
  catcher.display(mouseX, mouseY);
}
