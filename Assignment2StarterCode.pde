boolean play = false;
boolean gameOver = false;
int lives = 3;
int score = 9800;
int oneUp = 10000;

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

  if (!play && !gameOver)
  {
    startScreen();
  } else if (play && !gameOver)
  {
    background(0);
    info();
    for (int i = 0; i < objects.size (); i++)
    {
      objects.get(i).update();
      objects.get(i).display();

      if ( ! objects.get(i).alive)
      {
        objects.remove(i);
      }
    }
    collision();
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
    Enemy e = new Enemy(50,50);
    p.pos.x = width/2;
    p.pos.y = height/2;
    objects.add(p);
    objects.add(e);
  }
}

void collision()
{
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
            for ( int k = 0; k < 3; k++)
            {
              objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 2) );
            }
            objects.remove(object1);
            lives--;
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
            if (Asteroids.level == 3)
            {
              score = score + 20;
            } else if (Asteroids.level == 2)
            {
              score = score + 50;
            } else
            {
              score = score + 100;
            }

            for ( int k = 0; k < 10; k++)
            {
              objects.add(new Explosion(Asteroids.pos.x + random(-5, 5), Asteroids.pos.y + random(-5, 5), 1) );
            }

            objects.remove(Asteroids);

            break;
          }
        }
      }
    }
  }
}

