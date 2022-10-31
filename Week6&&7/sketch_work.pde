import com.hamoid.*;
import controlP5.*;
import peasy.*;
import nervoussystem.obj.*;


boolean record;
int horizontalSides = 200, verticalSides = 50;//每层水平方向上、竖直方向上有多少面
float A = 10, omega = 4, twistA = 20, layerTwistOmega = 0.3, layerTwistIV = 0;
int totaltall = 500, totalRadius = 100, layers = 5;
float minRadiusP = 2;//管最最小半径是设定半径几分之一的参数
//没加前缀的A，Omega管每层的波浪形状
//Twist前缀是管每层内的内凹程度，layer前缀的管总的所有层总的扭曲程度

ControlP5 bar;
PeasyCam cam;
VideoExport videoExport;

void setup()
{
  size(1000, 1000, P3D);
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  frameRate(30);
  cam = new PeasyCam(this, 2000);
  background(0);
  noStroke();
  translate(width / 2, 200);
  UI();
}
void draw()
{
  videoExport.saveFrame();
  background(0); 
  lights();
  if (record) 
  {
    beginRecord("nervoussystem.obj.OBJExport", "designWork/pot-####.obj");
  }
  drawLoop(totaltall, totalRadius, layers);
  if (record) 
  {
    endRecord();
    record = false;
  }
  UIShow();
}

void drawLoop(float tall, float radius, float layers)
{
  float minRadius = radius / minRadiusP;
  float layTall = tall / layers, deltaLayerTwist = TWO_PI / (verticalSides * layers);
  float deltaAngle = TWO_PI / horizontalSides, deltaTwist = PI / verticalSides, deltaTall = layTall / verticalSides;
  float currentTall = 0, currentLayerTwist = 0, currentAngle = 0, twistAngle = 0, finalRadius = 0;
  beginShape(QUAD_STRIP);
  for (int k = 0; k < layers; k++)
  {
    currentAngle = 0;
    twistAngle = 0;
    for (int i = 0; i <= verticalSides; i++)
    {
      currentAngle = 0;
      float topRadius = (radius - twistA*sin(twistAngle)) * abs(sin(layerTwistOmega * (currentLayerTwist + layerTwistIV))) + minRadius, 
        bottomRadius = (radius - twistA*sin(twistAngle + deltaTwist)) * abs(sin(layerTwistOmega * ((currentLayerTwist + layerTwistIV) + deltaLayerTwist))) + minRadius;
      for (int j = 0; j < horizontalSides; j++)
      {
        vertex(topRadius * sin(currentAngle), currentTall + A * sin(omega*currentAngle), topRadius * cos(currentAngle));
        vertex(bottomRadius * sin(currentAngle), currentTall + deltaTall + A * sin(omega*currentAngle), bottomRadius * cos(currentAngle));
        if (k == layers - 1 && i == verticalSides - 1)
        {
          finalRadius = bottomRadius;
        }
        currentAngle += deltaAngle;
      }
      twistAngle += deltaTwist;
      currentLayerTwist += deltaLayerTwist;
      currentTall += deltaTall;
    }
  }
  endShape();

  currentAngle = 0;
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= horizontalSides; i++)
  {
    vertex(finalRadius * sin(currentAngle), currentTall + A * sin(omega*currentAngle), finalRadius * cos(currentAngle));
    vertex(finalRadius * sin(currentAngle), currentTall + deltaTall + A, finalRadius * cos(currentAngle));
    currentAngle += deltaAngle;
  }
  endShape();
  currentTall = currentTall + deltaTall + A;

  currentAngle = 0;
  beginShape(TRIANGLE_FAN);
  vertex(0, currentTall, 0);
  for (int i = 0; i <= horizontalSides; i++) 
  {
    vertex(finalRadius * cos(currentAngle), currentTall, finalRadius * sin(currentAngle));
    currentAngle += deltaAngle;
  }
  endShape();
}

int canvasLeftCornerX = 30;
int canvasLeftCornerY = 60;
void UI() 
{
  bar = new ControlP5(this, createFont("微软雅黑", 14));

  int barSize = 200;
  int barHeight = 20;
  int barInterval = barHeight + 10;

  bar.addSlider("totaltall", 100, 1000, 500, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("罐体总长度");
  bar.addSlider("totalRadius", 30, 300, 100, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("罐体基础半径");
  bar.addSlider("minRadiusP", 1, 10, 2, canvasLeftCornerX, canvasLeftCornerY+barInterval*2, barSize, barHeight).setLabel("罐体最狭窄部分半径是基础的几分之一");
  bar.addSlider("layers", 1, 15, 5, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("罐体的层数");
  bar.addSlider("A", 1, 30, 10, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("每层波浪的幅度");
  bar.addSlider("omega", 0, 10, 4, canvasLeftCornerX, canvasLeftCornerY+barInterval*5, barSize, barHeight).setLabel("每层波浪的波出现数量相关(w)");
  bar.addSlider("twistA", 0, 50, 20, canvasLeftCornerX, canvasLeftCornerY+barInterval*6, barSize, barHeight).setLabel("每层内凹的幅度");
  bar.addSlider("layerTwistOmega", 0.1, 1, 0.3, canvasLeftCornerX, canvasLeftCornerY+barInterval*7, barSize, barHeight).setLabel("罐体总体的扭曲形状");
  bar.addSlider("layerTwistIV", 0, PI, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*8, barSize, barHeight).setLabel("罐体总体扭曲的偏移");
  bar.addSlider("verticalSides", 10, 100, 50, canvasLeftCornerX, canvasLeftCornerY+barInterval*9, barSize, barHeight).setLabel("竖直方向上每层的面数");
  bar.addSlider("horizontalSides", 50, 500, 200, canvasLeftCornerX, canvasLeftCornerY+barInterval*10, barSize, barHeight).setLabel("水平方向上每层的面数");

  bar.setAutoDraw(false);
}
void UIShow() 
{
  cam.beginHUD();  
  lights();
  bar.draw();
  cam.endHUD();

  if (mouseX<400 && mouseY< height) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}

void keyPressed()
{
  if (key == 's') 
  {
    record = true;
  }
}
