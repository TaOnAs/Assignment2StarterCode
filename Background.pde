void startScreen()
{
  background(0);
  textSize(displayWidth/12);
  fill(255);
  text("Asteroids", width/3, height/5, (width/3 * 2), height/5);  
  
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
