class Asteroid extends GameObject
{
  int s;

  Asteroid()
  {
    theta = random(0, 360);
    pos = new PVector(250, 250);
    w = 60;
    h = 60;
    level = 3;
  } 

  Asteroid(float posx, float posy, int _level)
  {
    level = _level;
    theta = random(0, 360);
    pos = new PVector(posx, posy);

    if (level == 2)
    {
      w = 30;
      h = 30;
    } else
    {
      w = 15;
      h = 15;
    }
  }

  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);
    speed = 5;
    s = 1;

    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(theta);

    stroke(255);
    float halfWidth = w / 2;
    float halfHeight = h / 2;    

    noFill();

    if (s==0)
    {
      line( -5, 0, 5, 0);
    } else if (s==1)
    {
      ellipse(0, 0, w, h);
      line(-halfWidth, 0, -halfWidth, w/5);
      line(-halfWidth, w/5, -w/6, halfHeight);
      line(-w/6, halfHeight, w/6, w/4);
      line(w/6, w/4, w/4, halfHeight);
      line(w/4, halfHeight, halfWidth, h/5);
      line(halfWidth, h/5, w/3, 0);
      line(w/3, 0, halfWidth, -h/5);
      line(halfWidth, -h/5, w/4, -halfHeight);
      line(w/4, -halfHeight, 0, -h/3);
      line(0, -h/3, -w/4, -halfHeight);
      line(-w/4, -halfHeight, -halfWidth, 0);
    } else if (s==2)
    {
      //ellipse(0,0,w,h);
      line(-halfWidth, 0, -halfWidth, h/8);
      line(-halfWidth, h/8, -w/6, halfHeight);
      line(-w/6, halfHeight, w/4, halfHeight);
      line(w/4, halfHeight, halfWidth, h/6);
      line(halfWidth, h/6, halfWidth, 0);
      line(halfWidth, 0, w/4, - h/3);
      line(w/4, - h/3, w/5, -h/6);
      line(w/5, -h/6, w/9, -h/3); 
      line(w/9, - h/3, - w/10, -h/4);
      line(- w/10, -h/4, 0, -h/8);
      line(0, -h/8, - halfWidth, 0);
    } else if (s==3)
    {
    }
    popMatrix();

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

