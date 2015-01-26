class Explosion extends GameObject
{
  float tAlive = 1.0f;

  Explosion()
  {
  }

  Explosion(float posx, float posy)
  {
    this.pos.x = posx;
    this.pos.y = posy; 
    theta = random(0, TWO_PI);
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
    point(0, 0);
    popMatrix();
  }
}

