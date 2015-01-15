class GameObject
{
   PVector pos;
   PVector forward;
   color colour;
   float theta;
   float speed;
   boolean alive;
   float tAlive = 5.0f;
   float born = 0.0f;
   float timeDelta = 1.0f /60.0f;

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
