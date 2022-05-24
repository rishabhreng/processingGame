public class Enemy extends GamePiece {
  private color enemyColor1 = #FF0000;
  private color enemyColor2 = #00FF00;
  private color enemyColor3 = #FF00FF;
  private int aiMode;

  public Enemy(int xpos, int ypos) {
    super(xpos, ypos);
    aiMode=(int) (Math.random()*3);
  }

  public void display() {
    if(aiMode==0) super.display(enemyColor1);
    if(aiMode==1) super.display(enemyColor2);
    if(aiMode==2) super.display(enemyColor3);
  }
  
  public int getMode(){
   return aiMode; 
  }
}

void enemyMove(Enemy enemy) {
  int deltaX, deltaY;
  int enemyMove;
  switch(enemy.getMode()) {
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
    case 2:
    enemyMove=1;
    switch(keyCode){
     case UP:
     enemyMove=2;
     break;
     case DOWN:
     enemyMove=3;
     break;
     case LEFT:
     enemyMove=0;
     break;
     case RIGHT:
     enemyMove=1;
     break;
    }
    enemyMotions(enemyMove, enemy);
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
