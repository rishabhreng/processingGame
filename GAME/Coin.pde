//reach it to win
public class Coin extends GamePiece {
  private color coinColor = #FFFFFF;
  
  public Coin(int xpos,int ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(coinColor);
    imageMode(CORNER);
    image(COIN, getX(), getY());
    imageMode(CENTER);
  } 
}
