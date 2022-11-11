class Boid
{
  float mass, r;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector AlForce, SpForce;
  color boidColor;

  Boid(float l_x, float l_y, float v_x, float v_y, float a_x, float a_y)
  {
    location = new PVector(l_x, l_y);
    velocity = new PVector(v_x, v_y);
    acceleration = new PVector(a_x, a_y);
  }
  Boid()
  {
    mass = 2;
    r = 5 * mass;
    location = new PVector(random(width/4) + width/3, random(height/4) + height/3);
    velocity = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(0, 0);
    AlForce = new PVector(0, 0);
    SpForce = new PVector(0, 0);
    boidColor = color(200);
  }

  void applyAlForce(PVector f)
  {
    AlForce.add(f);
  }
  void applySpForce(PVector f)
  {
    SpForce.add(f);
  }
  void calculateAcceleration()
  {
    //AlForce.limit(0.5);
    PVector F = PVector.add(AlForce, SpForce);
    acceleration = PVector.div(F, mass);
    //print(AlForce.mag() + " " + SpForce.mag() + '\n');
    AlForce.mult(0);
    SpForce.mult(0);
  }
  void display()
  {
    noStroke();
    fill(boidColor);
    ellipse(location.x, location.y, 2 * r, 2*r);
  }
  void move(float topspeed)
  {

    calculateAcceleration();

    checkEdge();
    velocity.add(acceleration);
    velocity.limit(topspeed);
    changeColor();
    location.add(velocity);
  }
  
  private void changeColor()
  {
    PVector normalizeV = velocity.get();
    normalizeV.normalize();
    float r = 128, g = 128, b = 128;
    r += normalizeV.x * 127;
    g += normalizeV.y * 127;
    boidColor = color(r, g, b);
  }
  private void checkEdge()
  {
    if (location.x > width) 
    {
      //velocity.x = -velocity.x;
      location.x = 0;
    } else if (location.x < 0) 
    {
      //velocity.x = -velocity.x;
      location.x = width;
    }

    if (location.y > height) 
    {
      //velocity.y = -velocity.y;
      location.y = 0;
    } else if (location.y < 0) 
    {
      //velocity.y = -velocity.y;
      location.y = height;
    }
  }
}
