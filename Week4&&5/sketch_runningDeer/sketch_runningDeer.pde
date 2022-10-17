import com.hamoid.*;

PImage img[], deer;
color bgColor = #404040, delColor;
int c = 0, stepCount = 8, rectW = 7;
int InX,InY,imgX,imgY,targetX,targetY;
float delatY;
VideoExport videoExport;

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
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  frameRate(30);
  loadImgs();
  delColor = color(0,0,0,0);
  size(1500,1000);
  background(bgColor);
  InX = width - img[0].width;
  InY = height - img[0].height;
  geneateImg();
  deer = get(InX,InY,img[0].width, img[0].height);
  targetX = InX;
  imgX = InX;
  imgY = InY;
  clear();
  background(bgColor);
  deer.save("deer.png");
  image(deer,imgX-80,imgY-150,deer.width,deer.height);
  noStroke();
  fill(bgColor);
  for(int i = 0; i < width/stepCount; i++)
  {
    rect(i*(rectW+1),0,rectW,height);
  }
}

void draw()
{
  videoExport.saveFrame();
  if(imgX > targetX)
  {
    Move();
  }
}

void mouseReleased()
{
  targetX = mouseX;
  targetY = mouseY;
  if(imgX > targetX)
  {
    float count = (imgX - targetX)/(2*stepCount + 1);
    delatY = (targetY - imgY)/count;
  }
  else
  {
    delatY = 0;
  }
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
void Move()
{
  if(imgX > targetX && frameCount % 3 == 0)
  {
    clear();
    background(#404040);
    imgX-=2*stepCount + 1;
    imgY += delatY;
    image(deer,imgX-80,imgY-150,deer.width,deer.height);
    for(int i = 0; i < width/stepCount; i++)
    {
      rect(i*(rectW+1),0,rectW,height);
    }
  }
}
