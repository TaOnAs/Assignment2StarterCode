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
    //println(NumberOfAsteroids);
    for (int i = 0; i < NumberOfAsteroids; i++)
    {
      Asteroid a = new Asteroid();
      objects.add(a);
      //println("A: " + i + " Size: " + objects.size());
    }
  }

  void NextLevel()
  {
    currentLevel++;
    if (currentLevel > numberOfLevels)
    {
      gameOver = true;
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

