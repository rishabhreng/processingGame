public class Wall extends GamePiece {
  private color wallColor = #808080;
  
  public Wall(float xpos,float ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(wallColor);
  }
}
