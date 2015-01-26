class Enemy extends GameObject
{
  Enemy()
  {
  }

  Enemy(float posx, float posy)
  {
    pos = new PVector(posx, posy);
    theta =
      w = 35;
    h = 15;
    speed = 0;
  }

  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);

    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);

    if (pos.x > width)
    {
      alive = false;
    } else if (pos.x < 0)
    {
      alive = false;
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

