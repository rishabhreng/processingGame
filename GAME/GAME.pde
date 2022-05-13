import processing.sound.*; //<>//
//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (like a coin)
//TODO add ways to get to SETTINGS,WIN,and LOSESCREENS
Player player = new Player(120, 60);
Enemy enemy = new Enemy(300, 300);
Coin coin = new Coin(200, 200);
ArrayList<Wall> wallArr = new ArrayList<Wall>();
PFont font;
String mode = "STARTSCREEN";

SoundFile startScreenSound, loseScreenSound, winScreenSound;

PImage STARTSCREEN, PAUSESCREEN, SETTINGSCREEN, WINSCREEN, LOSESCREEN;

int numWalls = 20; //change
void setup() {
  size(580, 580);
  background(255);
  stroke(1);
  textAlign(CENTER);
  font = loadFont("Impact-48.vlw");
  textFont(font, 48);

  //images
  imageMode(CENTER);
  STARTSCREEN = loadImage("STARTSCREEN.png");
  PAUSESCREEN = loadImage("PAUSESCREEN.png");
  SETTINGSCREEN = loadImage("SETTINGSCREEN.png");
  WINSCREEN = loadImage("WINSCREEN.png");
  LOSESCREEN = loadImage("LOSESCREEN.png");
  
  
  
  //sounds
  startScreenSound = new SoundFile(this, "startScreen.wav");
  loseScreenSound = new SoundFile(this, "loseScreen.wav");
  winScreenSound = new SoundFile(this, "winScreen.wav");

  startScreenSound.play();
}


void draw() {
  //checks for win/lose and/or displays appropriate screen
  checkScreen();
  if (mode == "PLAYSCREEN") {
    //keeps player from phasing thru wall
    player.checkWallCollision();
    player.updatePrevPos();
  }
}

void keyPressed() {
  // moves player in playscreen, and/or pauses
  if (key == CODED) {
    if (mode == "PLAYSCREEN" && (keyCode==UP || keyCode==DOWN || keyCode==LEFT || keyCode==RIGHT)) {
      //enemy and player move any time arrow keys are pressed
      enemyMove();
      playerMove();
    }
  } else if (key == 'p' && mode == "PLAYSCREEN") mode = "PAUSESCREEN";
}

void mousePressed() {
  println(mouseX + ", " + mouseY);
  
  //might change when part of screen is clicked
  screenChange();
}
