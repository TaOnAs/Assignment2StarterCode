class GameObject
{
  PVector pos;        //holds object positions
  PVector forward;    //holds objects direction
  color colour;
  float w, h;
  float theta;        //hold rotation angle
  float speed;
  float born = 0.0f;
  float timeDelta = 1.0f / 60.0f;  // 1 second timer
  boolean alive;  
  int level;
  float respawn = 0;
  int friendly = 0;    //used for enemy and friendly bullets to differentiate which is which
  
  
  
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

  boolean collides(GameObject s)
  {
    float dist = PVector.dist(s.pos, pos);
    //println(dist + "  " +  s.w + " " + w + "if less than " + (s.w/2+w/2));
    return (dist < (s.w/2+w/2));
  }
}

