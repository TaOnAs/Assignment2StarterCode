void startScreen()
{
  background(0);
  textSize(displayWidth/20);
  fill(255);
  text("Asteroids", width/3, height/8, (width/3 * 2), height/8); 

  if (keyPressed)
  {
    //starts the game
    if ( key == ENTER)
    {
      play = true;
      gameOver = false;
    }
  }
}

void info()
{
  float w = 30;
  float h = 30;
  float halfWidth = w / 3;
  float halfHeight = h / 2;
  int x = width / 10;
  int y = height / 16;
  int y2 = height / 24;
  int dist = 30;

  textSize(20);
  fill(255);
  text(score, x, y2);

  if (score > oneUp)
  {
    lives++;
    oneUp = oneUp + oneUp;
  }

  for ( int i = 0; i < lives; i++)
  {
    line(x + -halfWidth + (dist * i), y + halfHeight, x + 0 + (dist * i), y - halfHeight);
    line(x + 0 + (dist * i), y - halfHeight, x + halfWidth + (dist * i), y +halfHeight);
    line(x + -halfWidth + 4 + (dist * i), y + halfHeight - 6, x + halfWidth - 4 + (dist * i), y + halfHeight - 6);
  }
  
}

