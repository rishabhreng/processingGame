//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (like a coin) //<>// //<>//
//TODO add ways to get to SETTINGS,WIN,and LOSESCREENS
Player player = new Player(100, 100);
Enemy enemy = new Enemy(300, 300);
Coin coin = new Coin(200, 200);
ArrayList<Wall> wallArr = new ArrayList<Wall>();
PFont font;
String mode = "STARTSCREEN";

PImage STARTSCREEN, PAUSESCREEN, SETTINGSCREEN, WINSCREEN, LOSESCREEN;

int numWalls = 20; //change
void setup() {
  size(580, 580);
  background(255);
  stroke(1);
  textAlign(CENTER);
  font = loadFont("Impact-48.vlw");
  textFont(font, 48);

  STARTSCREEN = loadImage("STARTSCREEN.png");
  PAUSESCREEN = loadImage("PAUSESCREEN.png");
  SETTINGSCREEN = loadImage("SETTINGSCREEN.png");
  WINSCREEN = loadImage("WINSCREEN.png");
  LOSESCREEN = loadImage("LOSESCREEN.png");
  imageMode(CENTER);
  
  wallsCreate();
}
 

void draw() {
  //checks for win/lose and displays appropriate screen
  checkScreen();
  if (mode == "PLAYSCREEN") {
    player.checkWallCollision();
    player.updatePrevPos();
  }
}

void keyPressed() {
  // moves player in playscreen, and/or pauses
  if (key == CODED) {
    if (mode == "PLAYSCREEN") {
      enemyMove();
      playerMove();
    }
  } else if (key == 'p' && mode == "PLAYSCREEN") mode = "PAUSESCREEN";
}

void mousePressed() {
  println(mouseX + ", " + mouseY);
  screenChange();
}
