float w = 30;
float h = 30;
float halfWidth = w / 3;
float halfHeight = h / 2;

void startScreen()
{

  background(0);
  textSize(displayWidth/20);
  fill(255);
  text("Asteroids", width/2 - 200, height/8, (width/3), height/8); 

  textSize(displayWidth/80);
  text("Ship select", width/2 - 50, height/3, width/4, height/3);

  int x = width/2 - 60;
  int y = height/3 + 80 ;
  stroke(255);
  line(x - halfWidth, y + halfHeight, x, y - halfHeight);
  line(x, y - halfHeight, x + halfWidth, y + halfHeight);
  line(x - halfWidth + 4, y + halfHeight - 6, x + halfWidth - 4, y + halfHeight - 6);

  x = width/2 + 60;
  y = height/3 + 80;

  line(x - halfWidth, y + halfHeight, x + halfWidth, y + halfHeight);
  line(x + halfWidth, y + halfHeight, x + halfWidth, y);
  line(x + halfWidth, y, x + halfWidth/2, y - halfHeight/2);
  line(x + halfWidth/2, y - halfHeight/2, x, y - halfHeight);
  line(x, y - halfHeight, x - halfWidth/2, y - halfHeight/2);
  line(x - halfWidth/2, y - halfHeight/2, x - halfWidth, y);
  line(x - halfWidth, y, x - halfWidth, y + halfHeight);
  line(x - halfWidth/2, y + halfHeight, x - halfWidth/2, y + halfHeight + 4);
  line(x - halfWidth/2, y + halfHeight + 4, x + halfWidth/2, y + halfHeight + 4);
  line(x + halfWidth/2, y + halfHeight + 4, x + halfWidth/2, y + halfHeight);

  textSize(12);
  x = width/2 - 70;
  y = height/3 + 130;
  if (ship)
  {
    text("This ship has greater turning but slower acceleration", x, y, 200, y + 50);
  } else
  {
    text("This ship has greater acceleration but slower turning", x, y, 200, y + 50);
    x = width/2 + 50; 
    y = height/3 + 130;
  }
  fill(255);
  triangle(x, y, x + 10, y - 20, x + 20, y);

  x = width/2 - 60; 
  y = height/3 + 180;
  fill(255);
  text("Twin Stick Shooting:", x, y);
  text("Toggle with button2 or 'r'", x, y+20);
  if (twinshoot)
  {
    fill(0, 255, 0);
    text("Enabled", x + 120, y);
  } else
  {
    fill(255, 0, 0);
    text("Disabled", x + 120, y);
  }

  textSize(32);
  fill(0, 255, 0);
  x = width/2;
  y = height/4*3;
  text("Press Button1 or 'e' to Start", x - 200, y, x, y);

  timer = timer - 1.0f / 60.0f;
  if (keyPressed)
  {
    //starts the game
    if ( key == 'e' && timer < 0)
    {
      play = true;
      gameOver = false;
      lvl = new Level();
      lvl.setupLevel();
    }
    if ( key == 'a')
    {
      ship = true;
    }
    if (key == 'd')
    {
      ship = false;
    }

    if ( key == 'r' && timer < 0)
    {
      twinshoot = !twinshoot;
      timer = .5;
    }
  }
}
void info()
{
  int x = width / 10;
  int y = height / 16;
  int y2 = height / 24;
  int dist = 30;

  textSize(20);
  fill(255);
  text(score, x, y2);
  text(lvl.currentLevel, width/2, height/24);

  if (score > oneUp)
  {
    lives++;
    oneUp = oneUp + oneUp;
  }

  for ( int i = 0; i < lives; i++)
  {
    line(x + -halfWidth + (dist * i), y + halfHeight, x + 0 + (dist * i), y - halfHeight);
    line(x + 0 + (dist * i), y - halfHeight, x + halfWidth + (dist * i), y +halfHeight);
    line(x - halfWidth + 4 + (dist * i), y + halfHeight - 6, x + halfWidth - 4 + (dist * i), y + halfHeight - 6);
  }
}

void gameOver()
{
  background(0);
  int x = width/2;
  int y = height/2;
  textSize(50);
  fill(255, 0, 0);
  text("GAME   OVER", x-150, y); 
  text(score, x, 200);

  textSize(20);
  text("Press button1 or e to Conitinue", x - 140, height - 100);

  if (keyPressed)
  {
    //goes back to the main menu
    if (key == 'e')
    {
      play = false;
      gameOver = false;
      timer = 0.5;
    }
  }
}

