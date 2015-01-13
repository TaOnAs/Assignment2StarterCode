class GameObject
{
   PVector pos;
   PVector forward;
   color colour;
   float theta;
   boolean alive;

  GameObject()
  {
    alive = true;
    pos = new PVector(width / 2, height / 2);
    forward = new PVector(0, -1);
  }
 
 void update()
 {
   
 }
 
 void display()
 {
   
 }
}
