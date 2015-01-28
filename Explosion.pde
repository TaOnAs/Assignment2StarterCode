class Explosion extends GameObject
{
  float tAlive = 1.0f;     //controls the duration of the explosion
  int type;                //controls the explosion type

  Explosion()
  {
  }

  Explosion(float posx, float posy, int type)
  {
    this.pos.x = posx;
    this.pos.y = posy; 
    this.type = type;
    theta = random(0, TWO_PI);    //creates random direction for each particle
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
    speed = 0.5f;
    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    if (type == 1)    //controls the explosion type
    {
      point(0, 0);
    } else
    {
      line(-15, 0, 15, 0);
    }
    popMatrix();
  }
}

