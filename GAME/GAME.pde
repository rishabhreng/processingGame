//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (like a coin) //<>//
Player player = new Player(100, 100);
Enemy enemy = new Enemy(300, 300);
Coin coin = new Coin(200, 200);
ArrayList<Wall> wallArr = new ArrayList<Wall>();
PFont font;
int mode = 0;

PImage img1;
PImage img2;

int numWalls = 20; //change
void setup() {
  size(600, 600);
  background(255);
  stroke(1);
  textAlign(CENTER);
  font = loadFont("Impact-48.vlw");
  textFont(font, 48);
  determineWallPos(numWalls);

  img1 = loadImage("STARTSCREEN.png");
  img2 = loadImage("PAUSESCREEN.png");
}

void draw() {

  //checks for win/lose and displays appropriate screen
  checkScreen();
}


void winScreen() {
  noLoop();
  background(255);
  text("YOU WIN", width/2, height/2);
}

void loseScreen() {
  noLoop();
  background(255);
  text("GAME OVER", width/2, height/2);
}
void checkScreen() {
  if (player.getX() == enemy.getX() && player.getY() == enemy.getY())
    mode = 2;
  if (player.getX() == coin.getX() && player.getY() == coin.getY())
    mode = 3;

  switch (mode) {
  case 0:
    startScreen();
    break;
  case 1:
    playScreen();
    break;
  case 2:
    pauseScreen();
    break;
  case 3:
    winScreen();
    break;
  case 4:
    loseScreen();
    break;
  default: 
    startScreen();
    break;
  }
}

void startScreen() {
  image(img1, 0, 0);
}

void pauseScreen() {
  image(img2, 0, 0);
}

void playScreen() {
  background(255);
  grid();

  for (Wall wall : wallArr) {
    wall.display();
  }
  player.display();
  enemy.display();
  coin.display();
  player.checkSideCollision();
  enemy.checkSideCollision();
  enemyMove();
}

void determineWallPos(int wallNum) {
  ArrayList<Integer>X = new ArrayList<Integer>();
  ArrayList<Integer>Y = new ArrayList<Integer>();
  wallNum = numWalls;

  for (int i = 0; i < wallNum; i++) {
    int x = chooseNum("x");
    X.add(i, x);
    while (moreThanOnce(X, x)) {
      x = chooseNum("x");
      X.set(i, x);
    }
    int y = chooseNum("y");
    Y.add(i, y);

    while (moreThanOnce(Y, y)) {
      y = chooseNum("y");
      Y.set(i, y);
    }

    wallArr.add(new Wall(x, y));
    //println("(" + x + ", " + y + ")");
  }
}

int chooseNum(String xOrY) {
  if (xOrY.equals("x")) {
    int x = (int) (Math.random() * (width));
    while (x%20!=0) x = (int) (Math.random() * (width));
    return x;
  }
  if (xOrY.equals("y")) {
    int y = (int) (Math.random() * (height));
    while (y%20!=0) y = (int) (Math.random() * (height));
    return y;
  } else return 0;
}

boolean moreThanOnce(ArrayList<Integer> list, int searched) {
  int numCount = 0;

  for (int thisNum : list) {
    if (thisNum == searched) numCount++;
  }

  return numCount > 1;
}

void enemyMove() {
  //randomly-moving enemy, not AI
  int enemyMove = (int) (Math.random() * 4);
  if (frameCount%20==0) {
    switch (enemyMove) {
    case 0:
      enemy.move(-20, 0);
      break;
    case 1:
      enemy.move(20, 0);
      break;
    case 2:
      enemy.move(0, -20);
      break;
    case 3:
      enemy.move(0, 20);
      break;
    }
  }
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
  if (key == CODED) {
    switch (keyCode) {
    case UP:
      player.move(0, -20);
      break;
    case DOWN:
      player.move(0, 20);
      break;
    case LEFT:
      player.move(-20, 0);
      break;
    case RIGHT:
      player.move(20, 0);
      break;
    }
  }
  else if (key == 'p' && mode == 1) mode = 2; 
}


void mousePressed() {
  println(mouseX + ", " + mouseY);
  if (mode == 0) {
    if ((mouseX > 120 && mouseX < 480) && (mouseY > 220 && mouseY <330)) mode = 1;
  }
  else if (mode == 2) {
    if ((mouseX > 120 && mouseX < 480) && (mouseY > 220 && mouseY <330)) mode = 1;
  }
}
