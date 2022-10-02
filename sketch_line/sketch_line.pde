import com.hamoid.*;

VideoExport videoExport;
Line verticalLines[];
Line horizontalLines[];
int numV = 0, numH = 0;

void initializeData()
{
  videoExport = new VideoExport(this);
  verticalLines = new Line[20];
  horizontalLines = new Line[20];
}

void setup()
{
  initializeData();
  size(1600, 700);
  background(0);
  videoExport.startMovie();
  Line vLine0 = new Line(7.5, 0, 7.5, height);
  vLine0.drawLine();
  verticalLines[0] = vLine0;
  numV++;
}
void draw()
{
  videoExport.saveFrame();
}
void keyPressed()
{
  if (key == 'g')
  {
    if (width - verticalLines[numV - 1].point1.x <= 400)
    {
      Line vLine = new Line(1592.5, 0, 1592.5, height);
      vLine.drawLine();
      verticalLines[numV] = vLine;
      numV++;
      generateHorizontalLine();
      videoExport.saveFrame();
      videoExport.endMovie();
      exit();
    }
    generateVerticalLine();
    generateHorizontalLine();
  }
}

void generateVerticalLine()
{
  float pointx = random(150, 400) + verticalLines[numV - 1].point1.x;
  Line newLine = new Line(pointx, 0, pointx, height);
  verticalLines[numV] = newLine;
  numV++;
  newLine.drawLine();
}
void generateHorizontalLine()
{
  float pointy = random(100, 600);
  Line newLine = new Line(verticalLines[numH].point1.x, pointy, verticalLines[numH + 1].point1.x, pointy);
  horizontalLines[numH] = newLine;
  numH++;
  newLine.drawLine();
}
