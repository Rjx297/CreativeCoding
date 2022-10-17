PImage img;
int imgX,targetX,imgFrame = 8, updateF;

void setup()
{
  size(1800,447);
  background(#404040);
  img = loadImage("res.png");
  imgX = width-img.width;
  targetX = imgX;
  updateF = imgFrame - 1;
  image(img,imgX,0,img.width,img.height);
  noStroke();
  fill(0);
  for(int i = 0; i < width/(imgFrame+1); i++)
  {
    rect(i*(imgFrame+1),0,8,height);
  }
}

void draw()
{
  if(imgX != targetX)
  {
    Move();
  }
}

void mouseReleased()
{
  targetX = mouseX;
}

void Move()
{
  if(imgX > targetX && frameCount % 7 == 0)
  {
    clear();
    background(#404040);
    imgX-=19;
    image(img,imgX,0,img.width,img.height);
    for(int i = 0; i < width/(8+1); i++)
    {
      rect(i*(8+1),0,8,height);
    }
  }
}
