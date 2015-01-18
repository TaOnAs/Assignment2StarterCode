class Bullet extends GameObject
{
  float tAlive = 100.0f;
  
  Bullet()
  {
    
  }
  
  void update()
  {
    born += timeDelta;
    if(born > tAlive)
    {
      alive = false;
    }
    forward.x = sin(theta);
    forward.y = -cos(theta);
    speed = 22.0f;
    
    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);
  }
  
  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    line(0, -2, 0, 2); 
    popMatrix();
  }
}
