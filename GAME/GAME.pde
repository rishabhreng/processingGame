//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (like a coin) //<>//
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
  size(600, 600);
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
  
  //horizontal walls
  int index=0;
  for(int x=0;x<gridX;x++){
    for(int y=0;y<gridY-1;y++){
      walls[index]=new Wall(x, y, true);
      index++;
    }
  }
  //vertical walls
  for(int x=0;x<gridX-1;x++){
   for(int y=0;y<gridY;y++){
    walls[index]=new Wall(x, y, false);
    index++;
   }
  }
  for(Wall wall:walls){
   wall.randomize(); 
  }
  accessibleSquares.add(new int[] {0, 0});
  generateMaze();
}
 

void draw() {
  //checks for win/lose and displays appropriate screen
  checkScreen();
}

void grid() {
  int grid=20;
  for (int i = 0; i < width; i+=grid) {
    line (i, 0, i, height);
  }
  for (int i = 0; i < height; i+=grid) {
    line (0, i, width, i);
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
