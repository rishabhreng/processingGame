public class Player extends GamePiece {
  private color playerColor = #0000FF;
  
  public Player(int xpos,int ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(playerColor);
  }
  
  //keeps player from moving in wall by comparing coordinates with wall coordinates
  
}

//takes in arrow keys and moves player accordingly
void playerMove() {
  moveSound.play();
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
