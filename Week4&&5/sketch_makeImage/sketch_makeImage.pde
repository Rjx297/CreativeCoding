PImage img[];
color bgColor = #404040, delColor;
int c = 0, stepCount = 8, rectW = 7;
int InX, InY;

void loadImgs()
{
  img = new PImage[stepCount];
  for(int i = 0; i < stepCount; i++)
  {
    img[i] = loadImage("step" + i + ".png");
  }
}

void setup()
{
  loadImgs();
  delColor = color(0,0,0,0);
  size(500,500);
  background(bgColor);
  InX = width - img[0].width;
  InY = height - img[0].height;
  geneateImg();
  save("res.png");
}

void draw()
{
  
}

void geneateImg()
{
  for(int i = 0; i < stepCount; i++)
  {
    c = i;
    while(c < img[i].width)
    if(c < img[i].width)
    {
      int targetW = c+rectW;
      for(; c < targetW; c++)
      {
        if(c == img[i].width) break;
        for(int r = 0; r < img[i].width; r++)
        {
          img[i].set(c,r,delColor);
        }
      }
      c++;
    }
    image(img[i],InX,InY,img[i].width,img[i].height);
  }
  
}
