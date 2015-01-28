import ddf.minim.*;
AudioSnippet laser;
AudioSnippet enemyLaser;
AudioSnippet jump;
AudioSnippet explosion;
AudioSnippet enemy;
Minim minim;

boolean play = false;
boolean gameOver = false;
boolean ship = true;
boolean twinshoot = true;
int lives = 3;
int score = 0;
int oneUp = 10000;
float angle;
float timer = 0;
Level lvl;

ArrayList<GameObject> objects = new ArrayList<GameObject>();
boolean[] keys = new boolean[526];

void setup()
{
  minim = new Minim(this);
  laser =  minim.loadSnippet("Laser.wav");
  enemyLaser = minim.loadSnippet("enemyLaser.wav");
  jump =  minim.loadSnippet("jump.wav");
  explosion = minim.loadSnippet("Explosion.wav");
  enemy = minim.loadSnippet("enemy.wav");
  size(displayWidth, displayHeight);
  setUpPlayerControllers();
}

boolean sketchFullScreen() {
  return true;
}

void draw()
{
  if (!play && !gameOver)
  {
    reset();
    startScreen();
  } else if (play && !gameOver)
  {
    background(0);
    info();

    Boolean isEnemyAlive = false;
    Boolean isAsteroidsLeft = false;
    for (int i = 0; i < objects.size (); i++)
    {
      //println("Size: " + objects.size());
      objects.get(i).update();
      objects.get(i).display();

      if (objects.get(i) instanceof Asteroid)
      {
        isAsteroidsLeft = true;
      }

      if (objects.get(i) instanceof Enemy)
      {
        isEnemyAlive = true;
        for (int j = 0; j < objects.size (); j++)
        {
          if (objects.get(j) instanceof Player)
          {
            GameObject eny = objects.get(i);
            GameObject play = objects.get(j);
            float radAngle = atan2(eny.pos.y - play.pos.y, eny.pos.x - play.pos.x);
            //float DegAngle = degrees(radAngle);

            //println("Radians???: " + radAngle + "   Degrees???: " +  DegAngle + 90);

            if (frameCount % 60 == 0)
            {
              enemyLaser.rewind();
              enemyLaser.play();
              Bullet bullet = new Bullet(2, eny.pos.get(), radAngle - PI/2, 0);
              objects.add(bullet);
            }
          }
        }
      }

      if ( ! objects.get(i).alive)
      {
        objects.remove(i);
      }
    }

    if (isEnemyAlive == false)
    {
      enemy.pause();
      timer += 1.0f / 60.0f;
      if ( timer > 10)
      {
        Enemy e = new Enemy((int) random(0, 2));
        objects.add(e);
        timer = 0;
      }
    }

    if (isAsteroidsLeft == false)
    {
      if (lvl != null)
      {
        lvl.NextLevel();
      }
    }
    collision();
  } else
  {
    gameOver();
  }
}
void Respawn(GameObject player)
{
  player.respawn = 0;
  player.pos.x = width/2; 
  player.pos.y = height/2;
  player.speed = 0;
  for ( int k = 0; k < 100; k++)
  {
    objects.add(new Explosion(player.pos.x + random(-5, 5), player.pos.y + random(-5, 5), 2) );
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
    Player p = new Player(i, color((255)), playerXML, ship);

    p.pos.x = width/2;
    p.pos.y = height/2;    
    objects.add(p);
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
        if (object2 instanceof Asteroid || object2 instanceof Bullet || object2 instanceof Enemy)
        {
          //println("check player at " + object1.pos.x + " " + object1.pos.y + " Asteroid: " + object2.pos.x + " " + object2.pos.y);
          if (object2.friendly != 1 && object1.respawn > 2)
          {
            if (object1.collides(object2))
            {
              explosion.rewind();
              explosion.play();
              if (object2 instanceof Enemy || object2 instanceof Asteroid)
              {
                for ( int k = 0; k < 10; k++)
                {
                  objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 1) );
                }
              }
              objects.remove(object2);
              for ( int k = 0; k < 3; k++)
              {
                objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 2) );
              }
              if (lives > 0)
              {
                Respawn(object1);
                lives--;
              } else
              {
                gameOver = true;
              }
            }
          }
        }
      }
    }
    if (object1 instanceof Bullet || object1 instanceof Enemy )
    {
      for ( int j = 0; j < objects.size (); j++)
      {
        GameObject Asteroids = objects.get(j);
        if (Asteroids instanceof Asteroid)
        {
          //println("check bullet " + object1.name + " at " + object1.pos.x + " " + object1.pos.y + " Collidable: " + object2.pos.x + " " + object2.pos.y);    
          if (Asteroids.collides(object1))
          {
            // println("bullet hit");
            if (object1 instanceof Enemy)
            {
              for ( int k = 0; k < 10; k++)
              {
                objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 1) );
              }
            }
            objects.remove(object1);

            //println("Asteroid Level: " +Asteroids.level);
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
            explosion.rewind();
            explosion.play();
            objects.remove(Asteroids);

            break;
          }
        }
      }
    }
    if (object1 instanceof Enemy)
    {
      for ( int j = 0; j < objects.size (); j++)
      {
        GameObject object2 = objects.get(j);
        if ( object2 instanceof Bullet)
        {
          if (object2.friendly != 2)
          {
            if (object2.collides(object1))
            {
              for ( int k = 0; k < 10; k++)
              {
                objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 1) );
              }
              explosion.rewind();
              explosion.play();
              objects.remove(object1);
              score = score + 250;
            }
          }
        }
      }
    }
  }
}

void reset()
{
  score = 0;
  lives = 3;
  oneUp = 10000;
  if (lvl != null)
  {
    lvl.currentLevel = 0;
  }
  for (int i = 0; i < objects.size (); i++)
  {
    if (objects.get(i) instanceof Player)
    {
      //Processing not allowing NOT is silly
    } else
    {
      objects.remove(i);
    }
  }
}

