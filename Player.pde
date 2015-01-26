class Player extends GameObject
{
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  char bup;
  char bdown;
  char bleft;
  char bright;
  int index;
  float fireRate = 5.0f;

  Player()
  {
  }

  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2, char bup, char bdown, char bleft, char bright)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    this.bup = bup;
    this.bdown = bdown;
    this.bleft = bleft;
    this.bright = bright;
    w = 30;
    h = 30;
    theta = 0;
  }

  Player(int index, color colour, XML xml)
  {
    this(index, colour
      , buttonNameToKey(xml, "up")
      , buttonNameToKey(xml, "down")
      , buttonNameToKey(xml, "left")
      , buttonNameToKey(xml, "right")
      , buttonNameToKey(xml, "start")
      , buttonNameToKey(xml, "button1")
      , buttonNameToKey(xml, "button2")
      , buttonNameToKey(xml, "bup")
      , buttonNameToKey(xml, "bdown")
      , buttonNameToKey(xml, "bleft")
      , buttonNameToKey(xml, "bright")
      );
    w = 30;
    h = 30;
    theta = 0;
  }

  void update()
  {
    born += timeDelta;
    forward.x = sin(theta);
    forward.y = -cos(theta);

    if (checkKey(up))
    {
      if (speed < 10)
      {
        speed = speed + 0.15;
      }
      PVector velocity = PVector.mult(forward, speed);
      pos.add(velocity);
    } else
    {
      if (speed > 0)
      {
        speed = speed - 0.05;
        PVector velocity = PVector.mult(forward, speed);
        pos.add(velocity);
      } else
      {
        pos.x = pos.x;
        pos.y = pos.y;
      }
    }

    if (checkKey(down))
    {
      //pos.y += 1;
    }

    if (checkKey(left))
    {
      theta -= 0.1f;
    }   

    if (checkKey(right))
    {
      theta += 0.1f;
    }

    if (checkKey(start))
    {
      println("Player " + index + " start");
    }

    if (checkKey(button1))
    {

    }

    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }

    if (checkKey(bup) && checkKey(bright))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = PI/4;        
        born = 0.0f;
      }
    }
    else if (checkKey(bup) && checkKey(bleft))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = -(PI/4);        
        born = 0.0f;
      }
    }
    else if (checkKey(bdown) && checkKey(bright))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = PI/4 * 3;        
        born = 0.0f;
      }
    }
    else if (checkKey(bdown) && checkKey(bleft))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = (PI/4) * 5;        
        born = 0.0f;
      }
    }
    else if (checkKey(bup))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = 0;        
        born = 0.0f;
      }
    }
    else if (checkKey(bdown))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = PI;        
        born = 0.0f;
      }
    }
    else if (checkKey(bleft))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = (PI/2 * 3);        
        born = 0.0f;
      }
    }
    else if (checkKey(bright))
    {
      if (frameCount % (60/fireRate) == 0)
      {
        Bullet bullet = new Bullet();
        objects.add(bullet);
        bullet.pos = pos.get();
        bullet.theta = (PI/2);        
        born = 0.0f;
      }
    }
  }

  void display()
  {    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);

    stroke(colour);
    float halfWidth = w / 3;
    float  halfHeight = h / 2;    

    //ellipse(0, 0, w, h);
    line(-halfWidth, halfHeight, 0, - halfHeight);
    line(0, - halfHeight, halfWidth, halfHeight);
    line(-halfWidth + 4, halfHeight - 6, halfWidth - 4, halfHeight - 6);
    if (checkKey(up))
    {
      line(-w/4, halfHeight - 6, 0, halfHeight + 4);
      line(0, halfHeight + 4, w/4, halfHeight-6);
    }
    popMatrix();
    

    //Keeps ship on the screen
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

