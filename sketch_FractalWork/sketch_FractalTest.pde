import com.hamoid.*;
import controlP5.*;

ControlP5 bar;
VideoExport videoExport;

ArrayList<Boid> movers;
ArrayList<Boid> staticers;

int maxMovers = 1000, moversColor = 220;
boolean limit = false;
float mu, sigma;

void setup()
{
  mu = width / 2;
  sigma = width / 4;
  movers = new ArrayList<Boid>(maxMovers);
  staticers = new ArrayList<Boid>(5000);
  size(800, 800);
  staticers.add(new Boid(new PVector(random(0, width), height)));
  for (int i = 0; i < maxMovers/8; i++)
  {
    movers.add(new Boid(mu, sigma));
  }
  videoExport = new VideoExport(this);
  videoExport.setFrameRate(60);
  videoExport.startMovie();
  UI();
}

void draw()
{
  videoExport.saveFrame();
  background(255);
  for (Boid m : movers)
  {
    m.display(color(moversColor));
  }
  for (Boid s : staticers)
  {
    s.changeColor();
    s.display();

    //当图像增长到边界时停止
    if (s.postion.y < s.d)
    {
      limit = true;
    }
  }
  for (int i = 0; i < movers.size(); i++)
  {
    Boid b = movers.get(i);
    b.move();
    for (Boid s : staticers)
    {
      if (b.checkStatic(s))
      {
        b.isStatic = true;
        staticers.add(b);
        movers.remove(i);
        break;
      }
    }
  }

  while (movers.size() < maxMovers && random(0, 1) >= 0.5 && limit == false)
  {
    movers.add(new Boid(mu, sigma));
  }
}

int canvasLeftCornerX = 30;
int canvasLeftCornerY = 30;
void UI()
{
  bar = new ControlP5(this, createFont("微软雅黑", 14));
  int barSize = 200;
  int barHeight = 20;
  int barInterval = barHeight + 10;
  bar.addSlider("mu", 0, width, width/2, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("生成的动态粒子的正态分布对称轴").setColorLabel(20);
  bar.addSlider("sigma", 10, width/2, width/4, canvasLeftCornerX, canvasLeftCornerY + barInterval, barSize, barHeight).setLabel("生成的动态粒子的正态分布离散程度").setColorLabel(20);
  bar.addSlider("moversColor", 200, 255, 220, canvasLeftCornerX, canvasLeftCornerY + barInterval * 2, barSize, barHeight).setLabel("动态粒子的可见度").setColorLabel(20);
}
