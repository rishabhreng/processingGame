//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (a coin) //<>//
//highScore file updates every time you lose or every time you press escape key (which also closes the game)

//player is blue
//red enemies are based on an engine
//pink enemies move the same direction the player moves
//green ememies move randomly
import processing.sound.*;

Player player = new Player(RandPos(), RandPos());
ArrayList<Enemy> enemies=new ArrayList<Enemy>();
ArrayList<Wall> wallArr = new ArrayList<Wall>();
Coin coin = new Coin(200, 200);

String mode;
int aiLevel = 0;//level 1 is unpredictable/random movement
//0-engine
//1-random
//2-following
//3-all three
int numEnemies=50;

boolean keyPush = false;

SoundFile startScreenSound, loseScreenSound, winScreenSound, moveSound, wallHitSound;
PImage STARTSCREEN, PAUSESCREEN, SETTINGSCREEN, WINSCREEN, LOSESCREEN, COIN;

int highScore = 0;

int numWalls = 20; //change
void setup() {
  mode = "STARTSCREEN";

  frameRate(120);
  size(580, 580);
  stroke(1);

  //images
  imageMode(CENTER);
  STARTSCREEN = loadImage("STARTSCREEN.png");
  PAUSESCREEN = loadImage("PAUSESCREEN.png");
  SETTINGSCREEN = loadImage("SETTINGSCREEN.png");
  WINSCREEN = loadImage("WINSCREEN.png");
  LOSESCREEN = loadImage("LOSESCREEN.png");
  COIN = loadImage("SmallCoin.png");
  //sounds
  startScreenSound = new SoundFile(this, "startScreen.wav");
  loseScreenSound = new SoundFile(this, "loseScreen.wav");
  winScreenSound = new SoundFile(this, "winScreen.wav");
  moveSound = new SoundFile(this, "MoveSound.wav");
  wallHitSound = new SoundFile(this, "WallHitSound.wav");

  startScreenSound.play();
  for (int i=0; i<numEnemies; i++) {
    enemies.add(new Enemy(0, 0));
  }
}

void draw() {
  //checks for win/lose and/or displays appropriate screen
  if (mode == "PLAYSCREEN") {
    //keeps player from phasing thru wall
    if (player.checkWallCollision() == 1) {
      if (moveSound.isPlaying()) moveSound.stop();
      wallHitSound.play();
    }
    player.updatePrevPos();
    for (Enemy enemy : enemies) {
      enemy.checkWallCollision();
      enemy.updatePrevPos();
    }
  }
  checkScreen();
}

void keyPressed() {
  // moves player in playscreen, and/or pauses
  if (!keyPush) {
    if (key == CODED) {
      if (mode == "PLAYSCREEN" && (keyCode==UP || keyCode==DOWN || keyCode==LEFT || keyCode==RIGHT)) {
        //enemy and player move any time arrow keys are pressed
        for (Enemy enemy : enemies) {
          enemyMove(enemy);
        }
        playerMove();
      }
    } 
    else if (key == 'p' && mode == "PLAYSCREEN") mode = "PAUSESCREEN";
    else if (key == 'p' && mode == "PAUSESCREEN") mode = "PLAYSCREEN";
    else if ((int) key == 27) appendTextToFile("highScore.txt", "High Score is: " + highScore);
  }
  keyPush = true;
}

void keyReleased() {
  keyPush = false;
}

void mousePressed() {
  //might change the screen when a "button" on screen is clicked
  screenChange();
}
