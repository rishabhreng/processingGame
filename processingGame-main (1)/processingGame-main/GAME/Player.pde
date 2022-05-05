public class Player extends GamePiece {
  private color playerColor = #0000FF;
  
  public Player(float xpos,float ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(playerColor);
  }
}
