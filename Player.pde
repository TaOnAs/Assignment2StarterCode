class Player extends GameObject
{
  int index;
  float fireRate = 5.0f;
  float accelerate;
  float rotate;
  float power = 30;  //used for jump

  //button mappings
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
    if (ship)  //if ship is true set these stats for the player
    {
      accelerate = 0.05f;
      rotate = 0.08f;
    } else    //otherwise set these stats
    {
      accelerate = 0.1f;
      rotate = 0.04f;
    }

    if (power < 30)    //increment power if its less then 50
    {
      power += timeDelta;
    }
    respawn += timeDelta;
    forward.x = sin(theta);
    forward.y = -cos(theta);

    if (checkKey(up))
    {
      if (speed < 7)    //increase speed if up is pressed and speed is less then 7
      {
        speed = speed + accelerate;
      }
      PVector velocity = PVector.mult(forward, speed);
      pos.add(velocity); //move the player
    } else
    {
      if (speed > 0)  //decrease speed if up is not pressed and speed is greater then 0
      {
        speed = speed - 0.05;
        PVector velocity = PVector.mult(forward, speed);
        pos.add(velocity);
      } else  //otherwise dont change the position
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
    if (!twinshoot)  //if twinshoot is disabled map shooting to button1 
    {
      if (checkKey(button1))
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), theta, 0);
          objects.add(bullet);
        }
      }
    }

    if (checkKey(button2)) //jump 200 units forward
    {
      if (power >= 30)
      {
        if (ship)
        {
          jump.rewind();
          jump.play();
          PVector jump = PVector.mult(forward, 200);
          pos.add(jump);

          for ( int k = 0; k < 100; k++)  //display animation
          {
            objects.add(new Explosion(pos.x + random(-5, 5), pos.y + random(-5, 5), 2) );
          }
        }
        else
        {
         respawn = -1; 
        }
        power = 0;
      }
    }
    if (twinshoot)  //if twinshooting is enabled
    {
      if (checkKey(bup) && checkKey(bright))    //shoot diagonally up and right
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/4, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bup) && checkKey(bleft)) //shoot diagonally up and left
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), -(PI/4), 0);
          objects.add(bullet);
        }
      } else if (checkKey(bdown) && checkKey(bright)) //shoot diagonally down and right
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/4 * 3, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bdown) && checkKey(bleft))  //shoot diagonally down and left
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), (PI/4) * 5, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bup))                      //shoot up
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), 0, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bdown))                    //shoot down
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI * 3, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bleft))                  //shoot left
      {
        if (frameCount % (60/fireRate) == 0)
        {
          laser.rewind();
          laser.play();
          Bullet bullet = new Bullet(1, pos.get(), PI/2 * 3, 0);
          objects.add(bullet);
        }
      } else if (checkKey(bright))                //shoot right
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
    float halfHeight = h / 2;    

    if (ship)  //if ship is true draw ship 1
    {
      if (respawn < 2)  // if ship is just made draw a shiled for 2 seconds to indicate invincibility
      {
        noFill();
        ellipse(0, 0, w + 10, h + 10);
      }
      line(-halfWidth, halfHeight, 0, - halfHeight);
      line(0, - halfHeight, halfWidth, halfHeight);
      line(-halfWidth + 4, halfHeight - 6, halfWidth - 4, halfHeight - 6);
      if (checkKey(up) && (frameCount % 3 > 0))    //draw thrust
      {
        line(-w/4, halfHeight - 6, 0, halfHeight + 4);
        line(0, halfHeight + 4, w/4, halfHeight-6);
      }
    } else  //draw ship 2
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
      if (checkKey(up) && (frameCount % 3 > 0))
      {
        line(-halfWidth/2, halfHeight + 4, 0, halfHeight + 8);
        line(0, halfHeight + 8, halfWidth/2, halfHeight + 4);
      }
    }
    popMatrix();

    if (power >= 30)  //draw the power bar if its full set fill to 255
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

