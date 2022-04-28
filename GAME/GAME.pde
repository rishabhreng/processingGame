//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (like a coin)
Player player = new Player(100, 100);
Enemy enemy = new Enemy(300, 300);
Coin coin = new Coin(200,200);
PFont font;

void setup() {
  size(400, 400);
  background(255);
  stroke(1);
  textAlign(CENTER);
  font = loadFont("Impact-48.vlw");
  textFont(font, 48);
}

void draw() {
  background(255);
  grid();
  player.display();
  enemy.display();
  coin.display();
  player.checkSideCollision();
  enemy.checkSideCollision();

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
  
  //checks for win/lose and displays appropriate screen
  checkScreen();
}

void checkScreen() {
  if (player.getX() == enemy.getX() && player.getY() == enemy.getY())
    loseScreen();
  if (player.getX() == coin.getX() && player.getY() == coin.getY())
    winScreen();
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
}
