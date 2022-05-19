public class Enemy extends GamePiece {
  private color enemyColor = #FF0000;

  public Enemy(int xpos, int ypos) {
    super(xpos, ypos);
  }

  public void display() {
    super.display(enemyColor);
  }
}

void enemyMove(Enemy enemy) {
  int deltaX, deltaY;
  int enemyMove;
  switch(aiLevel) {
  case 0:
    //AI 1
    deltaX=enemy.getX()-player.getX();
    deltaY=enemy.getY()-player.getY();
    if (abs(deltaX)>abs(deltaY)) {
      if (deltaX<0) {
        enemyMove=1;
      } else {
        enemyMove=0;
      }
    } else {
      if (deltaY<0) {
        enemyMove=3;
      } else {
        enemyMove=2;
      }
    }
    enemyMotions(enemyMove, enemy);
    break;
  case 1:
    enemyMove=(int) (Math.random()*4);
    enemyMotions(enemyMove, enemy);
    // AI 2
    //rank each move and do the best one, retracing steps until a move works
    break;
  }
}

void enemyMotions(int motion, Enemy enemy) {
  switch (motion) {
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
