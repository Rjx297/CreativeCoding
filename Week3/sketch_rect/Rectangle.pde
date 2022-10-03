class Rectangle
{
  PVector point1;
  float legthh;
  float widthh;
  int unitL = 80;
  color rectColour;
  
  Rectangle(float p1x, float p1y, float w, float l, int colorr)
  {
    point1 = new PVector(p1x, p1y);
    legthh = l;
    widthh = w;
    rectColour = colorr;
  }
  
  void drawRect()
  {
    stroke(#211D1D);
    strokeWeight(8);
    fill(rectColour);
    rect(point1.x*unitL, point1.y*unitL, widthh*unitL, legthh*unitL); 
  }
}
