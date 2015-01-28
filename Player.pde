class Player extends GameObject
{
  int index;
  float fireRate = 5.0f;
  float accelerate;
  float rotate;
  float power = 50;

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

  Player(int index, color colour, XML xml, boolean ship)
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
    if (ship)
    {
      accelerate = 0.05f;
      rotate = 0.08f;
    } else
    {
      accelerate = 0.1f;
      rotate = 0.04f;
    }

    if (power < 50)
    {
      power += timeDelta;
    }
    respawn += timeDelta;
    forward.x = sin(theta);
    forward.y = -cos(theta);

    if (checkKey(up))
    {
      if (speed < 7)
      {
        speed = speed + accelerate;
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
      theta -= rotate;
    }   

    if (checkKey(right))
    {
      theta += rotate;
    }

    if (checkKey(start))
    {
      //println("Player " + index + " start");
    }
    if (!twinshoot)
    {
      if (checkKey(button1))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          Bullet bullet = new Bullet(1, pos.get(), theta, 0);
          objects.add(bullet);
        }
      }
    }

    if (checkKey(button2))
    {
      if (power >= 50)
      {
        jump.rewind();
        jump.play();
        PVector jump = PVector.mult(forward, 200);
        pos.add(jump);

        for ( int k = 0; k < 100; k++)
        {
          objects.add(new Explosion(pos.x + random(-5, 5), pos.y + random(-5, 5), 2) );
        }
        power = 0;
      }
    }
    if (twinshoot)
    {
      if (checkKey(bup) && checkKey(bright))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/4, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bup) && checkKey(bleft))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), -(PI/4), 0);
          objects.add(bullet);
        }
      } else if (checkKey(bdown) && checkKey(bright))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/4 * 3, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bdown) && checkKey(bleft))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), (PI/4) * 5, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bup))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), 0, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bdown))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI * 3, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bleft))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/2 * 3, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bright))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/2, 0);
          objects.add(bullet);
        }
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

    if (ship)
    {
      if (respawn < 2)
      {
        noFill();
        ellipse(0, 0, w + 10, h + 10);
      }
      line(-halfWidth, halfHeight, 0, - halfHeight);
      line(0, - halfHeight, halfWidth, halfHeight);
      line(-halfWidth + 4, halfHeight - 6, halfWidth - 4, halfHeight - 6);
      if (checkKey(up))
      {
        line(-w/4, halfHeight - 6, 0, halfHeight + 4);
        line(0, halfHeight + 4, w/4, halfHeight-6);
      }
    } else
    {
      if (respawn < 2)
      {
        noFill();
        ellipse(0, 0, w + 12, h + 12);
      }
      line(-halfWidth, halfHeight, halfWidth, halfHeight);
      line(halfWidth, halfHeight, halfWidth, 0);
      line(halfWidth, 0, halfWidth/2, -halfHeight/2);
      line(halfWidth/2, -halfHeight/2, 0, -halfHeight);
      line(0, -halfHeight, -halfWidth/2, -halfHeight/2);
      line(-halfWidth/2, -halfHeight/2, -halfWidth, 0);
      line(-halfWidth, 0, -halfWidth, halfHeight);
      line(-halfWidth/2, halfHeight, -halfWidth/2, halfHeight + 4);
      line(-halfWidth/2, halfHeight + 4, halfWidth/2, halfHeight + 4);
      line(halfWidth/2, halfHeight + 4, halfWidth/2, halfHeight);
      if (checkKey(up))
      {
        line(-halfWidth/2, halfHeight + 4, 0, halfHeight + 8);
        line(0, halfHeight + 8, halfWidth/2, halfHeight + 4);
      }
    }
    popMatrix();

    if (power >= 50)
    {
      fill(255);
    } else
    {
      fill(0);
    }
    rect(width/20, height/14, 10, -power);

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

