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
  }
  
  void update()
  {
    if (checkKey(up))
    {
      pos.y -= 1;
    }
    if (checkKey(down))
    {
      pos.y += 1;
    }
    if (checkKey(left))
    {
      pos.x -= 1;
    }    
    if (checkKey(right))
    {
      pos.x += 1;
    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
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
    rotate(theata);
    
    stroke(colour);
    float halfWidth = w / 3;
    float  halfHeight = h / 2;    
    
    line(-halfWidth, halfHeight, 0, - halfHeight);
    line(0, - halfHeight, halfWidth, halfHeight);
    line(-halfWidth + 4, + halfHeight - 6, halfWidth - 4, halfHeight - 6);
    
    
    popMatrix();
  }  
}
