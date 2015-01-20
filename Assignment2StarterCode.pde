

ArrayList<GameObject> objects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];

void setup()
{
  size(displayWidth, displayHeight);
  setUpPlayerControllers();

  objects.add(new Asteroid());
  objects.add(new Asteroid());
  objects.add(new Asteroid());
  objects.add(new Asteroid());
  objects.add(new Asteroid());
  objects.add(new Asteroid());
}

Asteroid asteroid = new Asteroid();


boolean sketchFullScreen() {
  return true;
}

void draw()
{
  background(0);
  for (int i = 0; i < objects.size (); i++)
  {
    objects.get(i).update();
    objects.get(i).display();

    if ( ! objects.get(i).alive)
    {
      objects.remove(i);
    }
  }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);

  for (int i = 0; i < children.length; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(i, color((255)), playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = 300;
    objects.add(p);
  }
}

