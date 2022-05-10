public class Enemy extends GamePiece {
  private color enemyColor = #FF0000;
  
  public Enemy(float xpos,float ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(enemyColor);
  }
  
}

void enemyMove() {
  //randomly-moving enemy, not AI
  int enemyMove = (int) (Math.random() * 4);
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
