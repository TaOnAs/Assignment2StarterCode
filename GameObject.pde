class GameObject
{
   PVector pos;
   PVector forward;
   color colour;
   float theta;
   float speed;
   boolean alive;
   float born = 0.0f;
   float timeDelta = 1.0f /60.0f;

  GameObject()
  {
    alive = true;
    forward = new PVector(0, -1);
    pos = new PVector(width / 2, height / 2);
    
  }
 
 void update()
 {
   
 }
 
 void display()
 {
   
 }
}
