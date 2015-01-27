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
    int NumberOfAsteroids =  Integer.parseInt(children[currentLevel].getContent().trim());

    for (int i = 0; i < NumberOfAsteroids; i++)
    {
      Asteroid a = new Asteroid();
      objects.add(a);
    }
  }

  void NextLevel()
  {
    currentLevel++;
      if (currentLevel > numberOfLevels)
    {
      //Go to GAME COMPLETE SCREEN
    } else
    {
      //TO DO show level on screen
      int NumberOfAsteroids =  Integer.parseInt(children[currentLevel].getContent().trim());
      for (int i = 0; i < NumberOfAsteroids; i++)
      {
        Asteroid a = new Asteroid();
        objects.add(a);
      }
    }
  }
}

