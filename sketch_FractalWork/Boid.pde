class Boid
{
  PVector postion, velocity;
  boolean isStatic;
  int d, counter, timer, colorLimit;
  color boidColor;

  Boid()
  {
    d = 6;
    counter = 0;
    timer = 0;
    colorLimit = 100;
  }
  Boid(float m, float s)
  {
    this();
    postion = randomBP(m, s);
    velocity = new PVector(0, 0);
    isStatic = false;
    boidColor = color(220);
  }
  Boid(PVector p)
  {
    this();
    postion = p;
    velocity = new PVector(0, 0);
    isStatic = true;
    boidColor = color(0, 200, 0);
  }

  PVector randomBP(float muu, float sigmaa)
  {
    return new PVector((randomGaussian() * sigmaa) + muu, 0);
  }

  //移动函数
  void move()
  {
    velocity = PVector.random2D().mult(4);
    PVector downP = new PVector(0, random(0, 2));
    velocity.add(downP);
    postion.add(velocity);
    checkEdge();
  }
  private void checkEdge()
  {
    if (postion.x > width) 
    {
      postion.x = 0;
    } else if (postion.x < 0) 
    {
      postion.x = width;
    }
    /*if (postion.y > height) 
     {
     postion.y = 0;
     } else if (postion.y < 0) 
     {
     postion.y = height;
     }*/
  }

  //检查一个粒子是否该处于静止状态
  boolean checkStatic(Boid boid)
  {
    float distance = dist(postion.x, postion.y, boid.postion.x, boid.postion.y);
    if (distance <= d || postion.y >= height - d/2)
    {
      boidColor = color(0, 200, 0);
      return true;
    }
    return false;
  }

  void changeColor()
  {
    counter++;
    if (counter == 30)
    {
      timer++;
      counter = 0;
      if (timer < colorLimit)
      {
        boidColor = color(0, 200-timer, 0);
      }
    }
  }

  //显示该粒子
  void display()
  {
    noStroke();
    fill(boidColor);
    ellipse(postion.x, postion.y, d, d);
  }
  void display(color C)
  {
    noStroke();
    boidColor = C;
    fill(boidColor);
    ellipse(postion.x, postion.y, d, d);
  }
}
