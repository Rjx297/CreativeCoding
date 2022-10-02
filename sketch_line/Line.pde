class Line
{
  PVector point1;
  PVector point2;
  
  Line(float p1x, float p1y, float p2x, float p2y)
  {
    PVector p1 = new PVector(p1x, p1y);
    PVector p2 = new PVector(p2x, p2y);
    point1 = p1;
    point2 = p2;
  }
  Line(PVector p1, PVector p2)
  {
    point1 = p1;
    point2 = p2;
  }
  
  void drawLine()
  {
    stroke(#FFFFFF);
    strokeWeight(15);
    line(point1.x, point1.y, point2.x, point2.y);
  }
}
