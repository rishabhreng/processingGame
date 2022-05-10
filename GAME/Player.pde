public class Player extends GamePiece {
  private color playerColor = #0000FF;
  
  public Player(float xpos,float ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(playerColor);
  }
}

void playerMove() {
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
