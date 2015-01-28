//Audio Variables
import ddf.minim.*;
AudioSnippet laser;
AudioSnippet enemyLaser;
AudioSnippet jump;
AudioSnippet explosion;
AudioSnippet enemy;
Minim minim;

//Game Control
boolean play = false;
boolean gameOver = false;
boolean ship = true;
boolean twinshoot = true;

//
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
  if (!play && !gameOver)                     //Display the main menu and reset all variables
  {
    reset();
    startScreen();
  } else if (play && !gameOver)              //Start the game
  {
    background(0);
    info();

    Boolean isEnemyAlive = false;
    Boolean isAsteroidsLeft = false;

    for (int i = 0; i < objects.size (); i++)
    {
      //println("Size: " + objects.size());
      objects.get(i).update();                        //updates all objects in the arraylist
      objects.get(i).display();                       //display all objects in the arraylist

      if (objects.get(i) instanceof Asteroid)         //checks if there are any asteoids left
      {
        isAsteroidsLeft = true;
      }

      if (objects.get(i) instanceof Enemy)            //checks if there are any enemies alive
      {
        isEnemyAlive = true;                        
        for (int j = 0; j < objects.size (); j++)
        {
          if (objects.get(j) instanceof Player)
          {
            GameObject eny = objects.get(i);
            GameObject play = objects.get(j);
            float radAngle = atan2(eny.pos.y - play.pos.y, eny.pos.x - play.pos.x);    //calculates the angle between an enemy ship and the player
            //float DegAngle = degrees(radAngle);
            //println("Radians???: " + radAngle + "   Degrees???: " +  DegAngle + 90);

            if (frameCount % 60 == 0)  //Enemy shoots a bullet at the player every second
            {
              enemyLaser.rewind();
              enemyLaser.play();
              Bullet bullet = new Bullet(2, eny.pos.get(), radAngle - PI/2, 0);
              objects.add(bullet);
            }
          }
        }
      }

      if ( ! objects.get(i).alive)  //if an object isnt alive remove it
      {
        objects.remove(i);
      }
    }

    if (isEnemyAlive == false)      //if there are no enemies alive spawn a new one in 10 seconds
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

    if (isAsteroidsLeft == false)    //if there are no asteroids on the screen 
    {
      if (lvl != null)               //call the next level if there is one
      {
        lvl.NextLevel();
      }
    }
    collision();
  } else                            //display the gameover screen
  {
    gameOver();
  }
}

void Respawn(GameObject player)     //Respawns the player in the centre of the screen and reset its variables when it dies
{
  player.respawn = 0;
  player.pos.x = width/2; 
  player.pos.y = height/2;
  player.speed = 0;

  //respawn animation
  for ( int k = 0; k < 100; k++)
  {
    objects.add(new Explosion(player.pos.x + random(-5, 5), player.pos.y + random(-5, 5), 2) );
  }
}

void keyPressed()                   //Mark that a key is pressed
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;            //Mark that a key is not pressed
}

boolean checkKey(char theKey)       //return a key in upper case
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)            //read an xml file and return the key in the tag specified
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

void setUpPlayerControllers()      //load the xml file and create the player passing the xml file to the player constructor
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

void collision()    //collsion detection for all objects
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
          if (object2.friendly != 1 && object1.respawn > 2)    //if object2 isnt friendly to the player (object1)
          {
            if (object1.collides(object2))
            {
              explosion.rewind();
              explosion.play();
              if (object2 instanceof Enemy || object2 instanceof Asteroid)    //if object 2 is an enemny or asteroid create the explosion animation
              {
                for ( int k = 0; k < 10; k++)
                {
                  objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 1) );
                }
              }
              objects.remove(object2);

              for ( int k = 0; k < 3; k++) //create the explosion animation for the player
              {
                objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 2) );
              }
              if (lives > 0)
              {
                Respawn(object1);    //respawn the player in the centre of the screen if there is a life left
                lives--;
              } else                 //display the game over screen
              {
                gameOver = true;
              }
            }
          }
        }
      }
    }
    if (object1 instanceof Bullet || object1 instanceof Enemy )    //if object1 is a bullet or an enemy
    {
      for ( int j = 0; j < objects.size (); j++)
      {
        GameObject Asteroids = objects.get(j);
        if (Asteroids instanceof Asteroid)                         //if the second object Asteroids is an asteroid
        {
          //println("check bullet " + object1.name + " at " + object1.pos.x + " " + object1.pos.y + " Collidable: " + object2.pos.x + " " + object2.pos.y);    
          if (Asteroids.collides(object1))
          {
            // println("bullet hit");
            if (object1 instanceof Enemy)                          //if object 1 is an enemy create the explosion animation
            {
              for ( int k = 0; k < 10; k++)
              {
                objects.add(new Explosion(object1.pos.x + random(-5, 5), object1.pos.y + random(-5, 5), 1) );
              }
            }
            objects.remove(object1);

            //println("Asteroid Level: " +Asteroids.level);
            if (Asteroids.level > 1)                             //if the asteroids level is greater then 1 summon to asteroids with the level decremented
            {
              objects.add(new Asteroid(Asteroids.pos.x, Asteroids.pos.y, Asteroids.level - 1));
              objects.add(new Asteroid(Asteroids.pos.x+5, Asteroids.pos.y-5, Asteroids.level -1));
            }
            if (Asteroids.level == 3)  //increases score based on asteroid level
            {
              score = score + 20;
            } else if (Asteroids.level == 2)
            {
              score = score + 50;
            } else
            {
              score = score + 100;
            }

            for ( int k = 0; k < 10; k++)  //create explosion for the asteroid
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
    if (object1 instanceof Enemy)            //if object1 is an enemy
    {
      for ( int j = 0; j < objects.size (); j++)
      {
        GameObject object2 = objects.get(j);
        if ( object2 instanceof Bullet)      //if object 2 is a bullet
        {
          if (object2.friendly != 2)         //if the bullet is not friendly to the enemy
          {
            if (object2.collides(object1))
            {
              for ( int k = 0; k < 10; k++)  //create explosion
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

void reset()  //
{
  score = 0;
  lives = 3;
  oneUp = 10000;
  if (lvl != null)
  {
    lvl.currentLevel = 0;
  }
  for (int i = 0; i < objects.size (); i++)    //remove all objects that are not a player
  {
    if (!(objects.get(i) instanceof Player))
    {
      objects.remove(i);
    }
  }
}

