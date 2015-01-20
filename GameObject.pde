class GameObject
{
   PVector pos;
   PVector forward;
   color colour;
   float w, h;
   float theta;
   float speed;
   float born = 0.0f;
   float timeDelta = 1.0f /60.0f;
   boolean alive;
   
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
