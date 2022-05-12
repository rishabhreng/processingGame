//not a class, just organized functions
void grid() {
  int grid=20;
  for (int i = 0; i < width; i+=grid) {
    line (i, 0, i, height);
  }
  for (int i = 0; i < height; i+=grid) {
    line (0, i, width, i);
  }
}

void checkScreen() {
  if (player.getX() == enemy.getX() && player.getY() == enemy.getY())
    mode = "LOSESCREEN";
  if (player.getX() == coin.getX() && player.getY() == coin.getY())
    mode = "WINSCREEN";

  switch (mode) {
  case "STARTSCREEN":
    startScreen();
    break;
  case "PLAYSCREEN":
    playScreen();
    break;
  case "PAUSESCREEN":
    pauseScreen();
    break;
  case "WINSCREEN":
    winScreen();
    break;
  case "LOSESCREEN":
    loseScreen();
    break;
  case "SETTINGSCREEN":
    settingScreen();
    break;
  default:
    pauseScreen();
    break;
  }
}

void startScreen() {
  image(STARTSCREEN, width/2, height/2);
}

void playScreen() {
  background(255);
  graph();
  grid();
  player.display();
  enemy.display();
  coin.display();
  
  //obsolete walls
  //for (Wall wall : wallArr) {
  //  wall.display();
  //}
  
  player.checkSideCollision();
  enemy.checkSideCollision();
  }

void pauseScreen() {
  image(PAUSESCREEN, width/2, height/2);
}

void winScreen() {
  image(WINSCREEN, width/2, height/2);
}

void loseScreen() {
  image(LOSESCREEN, width/2, height/2);
}

void settingScreen() {
  image(SETTINGSCREEN, width/2, height/2);
}

boolean startScreenSettingsPressed = false;


//the logic for changing the screens
void screenChange() {
  switch (mode) {
  case "STARTSCREEN":
    if ((mouseX > 105 && mouseX < 485) && (mouseY > 215 && mouseY < 380)) mode = "PLAYSCREEN";
    else if ((mouseX > 145 && mouseX < 450) && (mouseY > 415 && mouseY < 485)) {
      mode = "SETTINGSCREEN";
      startScreenSettingsPressed = true;
    }
    break;
  case "PAUSESCREEN":
    startScreenSettingsPressed = false;
    if ((mouseX > 55 && mouseX < 540) && (mouseY > 235 && mouseY <350)) mode = "PLAYSCREEN";
    else if ((mouseX > 145 && mouseX < 450) && (mouseY > 385 && mouseY < 440)) mode = "SETTINGSCREEN";
    break;
  case "WINSCREEN":
    if ((mouseX > 35 && mouseX < 565) && (mouseY > 505 && mouseY < 575)) mode = "STARTSCREEN";
    player.move(100, 100);
    break;
  case "LOSESCREEN":
    if ((mouseX > 35 && mouseX < 555) && (mouseY > 505 && mouseY < 575)) mode = "STARTSCREEN";
    player.move(100, 100);
    break;
  case "SETTINGSCREEN":
    if ((mouseX > 105 && mouseX < 485) && (mouseY > 520 && mouseY < 580)) {
      if (startScreenSettingsPressed) mode = "STARTSCREEN";
      else {
        mode = "PAUSESCREEN";
        startScreenSettingsPressed = !startScreenSettingsPressed;
      }
    }
    break;
  }
}
