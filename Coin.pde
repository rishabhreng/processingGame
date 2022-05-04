public class Coin extends GamePiece {
  private color coinColor = #FFFF00;
  
  public Coin(float xpos,float ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(coinColor);
  } 
}
