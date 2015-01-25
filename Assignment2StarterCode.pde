

ArrayList<GameObject> objects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];

void setup()
{
  size(displayWidth, displayHeight);
  setUpPlayerControllers();

  objects.add(new Asteroid());
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
  for ( int i = 0; i < objects.size (); i++)
  {
    GameObject object1 = objects.get(i);

    if (object1 instanceof Player)
    {
      for ( int j = 0; j < objects.size (); j++)
      {
        GameObject object2 = objects.get(j);
        if (object2 instanceof Asteroid)
        {
          //println("check player at " + object1.pos.x + " " + object1.pos.y + " Asteroid: " + object2.pos.x + " " + object2.pos.y);
          if (object1.collides(object2))
          {
            println("player hit");
          }
        }
      }
    }
    if (object1 instanceof Bullet)
    {
      for ( int j = 0; j < objects.size (); j++)
      {
        GameObject Asteroids = objects.get(j);
        if (Asteroids instanceof Asteroid)
        {
          //println("check bullet " + object1.name + " at " + object1.pos.x + " " + object1.pos.y + " Collidable: " + object2.pos.x + " " + object2.pos.y);    
          if (Asteroids.collides(object1))
          {
            println("bullet hit");
            objects.remove(object1);
            println("Asteroid Level: " +Asteroids.level);
            if (Asteroids.level > 1)
            {
              objects.add(new Asteroid(Asteroids.pos.x, Asteroids.pos.y, Asteroids.level - 1));
              objects.add(new Asteroid(Asteroids.pos.x+5, Asteroids.pos.y-5, Asteroids.level -1));
            }
            objects.remove(Asteroids);

            break;
          }
        }
      }
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

