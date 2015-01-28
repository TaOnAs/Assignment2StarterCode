class Enemy extends GameObject
{
  int type; 

  Enemy()
  {
  }

  Enemy(int type)
  {
    this.type = type;
    if ( type == 1)    //controls what side of the screen the enemy spawns on and its direction
    {
      pos = new PVector(0, random(0, height));
      theta = PI/2;
    } else 
    {
      pos = new PVector(width, random(0, height));
      theta = - (PI / 2);
      this.type = -1;
    }
    w = 35;
    h = 15;
    speed = 3;
    enemy.loop();
  }

  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);
    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);

    if (frameCount % 60 == 0)        //every second changes movement direction
    {
      int t = (int) random(0, 3);    //calculates direction
      if ( t == 0)
      {
        theta = (PI / 2) * type;    //move horozontally left or right depending on the value of type
      } else if (  t == 1)
      {
        theta =  (PI / 4) * type;   //move diagonally up left or right depending on the value of type
      } else if (  t == 2)
      {
        theta = 3 * (PI / 4) * type;// diagonally down left or right depending on the value of type
      }
    }

    if (pos.x > width)              //sets alive to false if the ship touches the left or right side of the screen
    {
      alive = false;
    } else if (pos.x < 0)
    {
      alive = false;
    } else if (pos.y > height)      //keeps the enemey on the screen
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
    
    //draws the enemy
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

