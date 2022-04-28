//player vs enemy (blue vs red) in which enemy follows you every step you make, as u move toward a goal spot (like a coin)
Player player = new Player(100, 100);
Enemy enemy = new Enemy(300, 300);

void setup() {
  size(400, 400);
  background(255);
  stroke(1);
}

void draw() {
  println(frameRate);
  //essential game pieces, conceptual
  background(255);
  grid();
  player.display();
  enemy.display();


//randomly-moving enemy
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

  //walls
  //fill(128);
  //square(100,100,20);
  //square(100,120,20);
  //square(100,140,20);
  //square(100,160,20);
  //square(100,180,20);
  //square(100,200,20);
  endScreen();
}


void endScreen() {
  if (player.getX() == enemy.getX() && player.getY() == enemy.getY()) {
  noLoop();
  background(255);
  text("GAME OVER", width/2, height/2);
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

void grid () {
  int grid=20;
  for (int i = 0; i < width; i+=grid) {
    line (i, 0, i, height);
  }
  for (int i = 0; i < height; i+=grid) {
    line (0, i, width, i);
  }
}
