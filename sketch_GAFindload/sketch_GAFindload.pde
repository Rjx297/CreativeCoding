import com.hamoid.*;

int populationSize = 100, falseNumber = 0;

VideoExport videoExport;
Particle[] population;

ArrayList<Particle> matingPool;
PVector birthP;
PVector goalP;

void setup()
{
  size(1280, 720);

  birthP = new PVector(100, 100);
  goalP = new PVector(random(10, width), random(10, height));
  population = new Particle[populationSize];

  for (int i = 0; i < populationSize; i++)
  {
    PVector direction = new PVector(random(-1, 1), random(-1, 1));
    population[i] = new Particle(birthP, direction.normalize());
  }

  fill(255);
  ellipse(goalP.x, goalP.y, 10, 10);
  
  videoExport = new VideoExport(this);
  videoExport.setFrameRate(60);
  videoExport.startMovie();
}

void draw()
{
  videoExport.saveFrame();
  background(0);
  fill(255);
  ellipse(goalP.x, goalP.y, 10, 10);
  
  if(mouseButton == LEFT)
  {
    goalP.x = mouseX;
    goalP.y = mouseY;
  }

  if (falseNumber == populationSize)
  {
    mutate();
    crossover();
  }
  
  falseNumber = 0;
  
  for (int i = 0; i < populationSize; i++)
  {
    if (!population[i].status)
    {
      falseNumber++;
      continue;
    }

    population[i].display();
    population[i].move();
    calculateDistance(population[i]);
  }
}

void calculateDistance(Particle particle)
{
  float dis = PVector.sub(goalP, particle.postion).mag();
  if (dis < particle.distance)
  {
    particle.distance = dis;
  }
}
void mutate()
{
  matingPool = new ArrayList<Particle>();
  float B2G = PVector.sub(goalP, birthP).mag();
  float fitness;
  int num;

  for (int i = 0; i < populationSize; i++)
  {
    fitness = B2G - population[i].distance;
    num = (int)fitness / 10;
    for (int j = 0; j < num; j++)
    {
      matingPool.add(population[i]);
    }
  }
}
void crossover()
{
  for (int i = 0; i < populationSize; i++)
  {
    int numberA = (int)random(matingPool.size());
    int numberB = (int)random(matingPool.size());

    Particle parentA = matingPool.get(numberA);
    Particle parentB = matingPool.get(numberB);

    float per = random(0, 1);

    PVector dir = PVector.add(parentA.velocity.mult(per), parentB.velocity.mult(1-per));

    population[i] = new Particle(birthP, dir.normalize());
  }
}
