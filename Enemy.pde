class Enemy extends GameObject
{
  int type; 

  Enemy()
  {
  }

  Enemy(int type)
  {
    this.type = type;
    if ( type == 1)
    {
      pos = new PVector(0, random(0, height));
      theta = PI/2;
    } else 
    {
      type = -1;
      pos = new PVector(width, random(0, height));
      theta = - (PI / 2);
    }

    w = 35;
    h = 15;
    speed = 4;
  }

  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);

    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);

    if (frameCount % 120 == 0)
    {
      int t = (int) random(0, 3);
      if ( t == 0)
      {
        theta = (PI / 2) * type;
      } else if (  t == 1)
      {
        theta =  (PI / 4) * type;
      } else if (  t == 2)
      {
        theta = 3 * (PI / 4) * type;
      }
    }

    if (pos.x > width)
    {
      alive = false;
    } else if (pos.x < 0)
    {
      alive = false;
    } else if (pos.y > height)
    {
      pos.y = 0;
    } else if ( pos.y < 0)
    {
      pos.y = height;
    }
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);

    float halfWidth = w/2;
    float halfHeight = h/2;

    line(-halfWidth, 0, halfWidth, 0);
    line(-halfWidth, 0, -w/4, halfHeight);
    line(-w/4, halfHeight, w/4, halfHeight);
    line(w/4, halfHeight, halfWidth, 0);
    line(-halfWidth, 0, -w/4, -halfHeight);
    line(-w/4, -halfHeight, w/4, -halfHeight);
    line(w/4, -halfHeight, halfWidth, 0);
    line(-w/4, -halfHeight, -w/8, -halfHeight - 5);
    line(-w/8, -halfHeight - 5, w/8, -halfHeight - 5);
    line(w/8, -halfHeight - 5, w/4, -halfHeight);

    popMatrix();
  }
}

