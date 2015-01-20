class Asteroid extends GameObject
{


  Asteroid()
  {
    theta = random(0, 360);
    pos = new PVector(random(0, width), random(0, height));
  } 

  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);

    speed = 8;
    
    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);

    stroke(255);
    float halfWidth = w / 3;
    float  halfHeight = h / 2;    

    line( -5, 0, 5, 0);

    popMatrix();
  }
}

