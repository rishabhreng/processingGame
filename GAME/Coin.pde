//reach it to win
public class Coin extends GamePiece {
  private color coinColor = #FFFF00;
  
  public Coin(int xpos,int ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(coinColor);
  } 
}
