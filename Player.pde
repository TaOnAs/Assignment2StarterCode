class Player extends GameObject
{
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  float w, h;
  float fireRate = 10.0f;
  float toPass = 1.0f / fireRate;
      
  Player()
  {
    pos = new PVector(width / 2, height / 2);
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
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
        );
    w = 30;
    h = 30;
    theta = 0;
  }
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);
    
    
    if (checkKey(up))
    {
      if(speed < 10)
      {
        speed = speed + 0.15;
      }
      PVector velocity = PVector.mult(forward, speed);
      pos.add(velocity);
      //pos.add(forward);
      
    }
    else
    {
      if(speed > 0)
      {
        speed = speed - 0.05;
        PVector velocity = PVector.mult(forward , speed);
        pos.add(velocity);
      }
      else
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
      println(born);
      println(toPass);
      if (born < toPass)
      {
        Bullet bullet = new Bullet();
        bullet.pos = pos.get();
        bullet.theta = theta;
        objects.add(bullet);
        born = 0.0f;
      }
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
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
    
    line(-halfWidth, halfHeight, 0, - halfHeight);
    line(0, - halfHeight, halfWidth, halfHeight);
    line(-halfWidth + 4, + halfHeight - 6, halfWidth - 4, halfHeight - 6);
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
