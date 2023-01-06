class Particle
{
  PVector postion;
  PVector velocity;

  float speed = 1, r = 4;
  boolean status = true;
  float fitness;
  float distance = 999999;

  Particle(PVector birthP, PVector direction)
  {
    speed = 3;
    r = 4;
    status = true;
    fitness = 0;
    distance = 999999;
    postion = new PVector(birthP.x, birthP.y);
    velocity = PVector.mult(direction, speed);
  }

  void display()
  {
    noStroke();
    fill(200);
    ellipse(postion.x, postion.y, 2*r, 2*r);
  }
  void move()
  {
    checkEdge();
    if (!status) return ;

    postion.add(velocity);
  }  
  void checkEdge()
  {
    if (postion.x > width || postion.x < 0 || postion.y > height || postion.y < 0 || distance < 10)
    {
      status = false;
    }
  }
}
