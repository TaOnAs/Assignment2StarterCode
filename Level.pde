class Level 
{
  int numberOfLevels;
  int currentLevel;
  XML[] children;
  Level()
  {
  }


  void setupLevel()
  {

    XML xml = loadXML("levels.xml");
    children = xml.getChildren("level");
    numberOfLevels = children.length;
    currentLevel = 0;


    //int NumberOfAsteroids =  children[currentLevel].getInt("asteroids");
    int NumberOfAsteroids =  Integer.parseInt(children[currentLevel].getContent().trim()); //reads the xml file levels and gets the current level and returns the number of asteroids
    //println(NumberOfAsteroids);
    for (int i = 0; i < NumberOfAsteroids; i++)    //draws asteroids based on the number returned from the xml file
    {
      Asteroid a = new Asteroid();
      objects.add(a);
      //println("A: " + i + " Size: " + objects.size());
    }
  }

  void NextLevel()
  {
    currentLevel++;                       //increment the level
    if (currentLevel > numberOfLevels)    //if there are no more levels display the gameover screen
    {
      gameOver = true;
    } else
    {
      int NumberOfAsteroids =  Integer.parseInt(children[currentLevel].getContent().trim()); //get the next level data from the xml file
      for (int i = 0; i < NumberOfAsteroids; i++)
      {
        Asteroid a = new Asteroid();
        objects.add(a);
      }
    }
  }
}

