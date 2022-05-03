public class Enemy extends GamePiece {
  private color enemyColor = #FF0000;
  
  public Enemy(float xpos,float ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(enemyColor);
  }
  
}
