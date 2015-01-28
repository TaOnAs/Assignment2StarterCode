class Bullet extends GameObject
{
  float tAlive = 2.0f;

  Bullet()
  {
  }

  Bullet(int friendly, PVector pos, float theta, float born)
  {
    this.friendly = friendly;
    this.pos= pos;
    this.theta = theta;
    this.born = born;
  }

  void update()
  {
    born += timeDelta;
    if (born > tAlive)
    {
      alive = false;
    }
    forward.x = sin(theta);
    forward.y = -cos(theta);
    speed = 10.0f;
    w = 2;

    PVector velocity = PVector.mult(forward, speed);    //move the bullet
    pos.add(velocity);
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    if (friendly == 1)
    {
      stroke(color(0, 0, 255));
    } else
    {
      stroke(color(255, 0, 0));
    }
    line(0, -2, 0, 2); 
    stroke(255);
    popMatrix();

    //keeps bullets on the screen
    if (pos.x > width)
    {
      pos.x = 0;
    } else if (pos.x < 0)
    {
      pos.x = width;
    }
    if (pos.y > height)
    {
      pos.y = 0;
    } else if ( pos.y < 0)
    {
      pos.y = height;
    }
  }
}

