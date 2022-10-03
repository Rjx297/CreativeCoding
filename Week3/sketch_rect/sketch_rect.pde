import com.hamoid.*;

boolean map[][];
ArrayList<Rectangle> rectList;
int mapC = 15, mapR = 10;
color colorArray[];
VideoExport videoExport;

void initializeData()
{
  frameRate(30);
  map = new boolean[mapR][mapC];
  rectList = new ArrayList<Rectangle>(200);
  colorArray = new color[7];
  colorArray[0] = #FFFFFF;
  colorArray[1] = #f40f0e;
  colorArray[2] = #fae417;
  colorArray[3] = #0e80bf;
  colorArray[4] = #FFFFFF;
  colorArray[5] = color(0);
  colorArray[6] = #FFFFFF;
  videoExport = new VideoExport(this);
}

void setup()
{
  initializeData();
  videoExport.startMovie();
  size(1200,800);
  background(#FFFFFF);
}
void draw()
{
  videoExport.saveFrame();
}
void keyPressed()
{
  if(key == 'g')
  {
    for(int i = 0; i < mapR; i++)
    {
      for(int j = 0; j < mapC; j++)
      {
        map[i][j] = false;
      }
    }
    rectList.clear();
    generateRect();
  }
}

void generateRect()
{
  for(int i = 0; i < mapR; i++)
  {
    for(int j = 0; j < mapC; j++)
    {
      if(map[i][j] == false)
      {
        float w = generateW(j);
        float l = generateL(i);
        while(map[i][j + (int)w-1])
        {
          w--;
        }
        Rectangle rectangle = new Rectangle(j, i, w, l, colorArray[(int)random(0, 7)]);
        for(int r = i; r < i + l; r++)
        {
          for(int c = j; c < j + w; c++)
          {
            map[r][c] = true;
          }
        }
        rectangle.drawRect();
        rectList.add(rectangle);
      }
    }
  }
}

float generateW(float conlum)
{
  float w = (int)random(1, 5); 
  while(conlum + w > mapC)
  {
    w--;
  }
  return w;
}
float generateL(float row)
{
  float l = (int)random(1, 5);
  while(l + row > mapR)
  {
    l--;
  }
  return l;
}
