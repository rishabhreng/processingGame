public class Player extends GamePiece {
  private color playerColor = #0000FF;
  private int prevX, prevY;
  
  public Player(int xpos,int ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(playerColor);
  }
  
  public void checkWallCollision(){
    //find the wall the player is on if possible
    if (getWall((player.getX()-40)/60, player.getY()/60, true) == null) return;
    if(getWall(player.getX()/60, (player.getY()-40)/60, false) == null)  return;
    
    if((player.getX()/20+1)%3==0){//vertical wall collision
      if(getWall((player.getX()-40)/60, player.getY()/60, true).isGraphed()){
        super.setX(prevX);
        super.setY(prevY);
      }
    }
    
    else if((player.getY()/20+1)%3==0){//horizontal wall collision
      if(getWall(player.getX()/60, (player.getY()-40)/60, false).isGraphed()){
        super.setX(prevX);
        super.setY(prevY);
      }
    }
  }
  
  public void updatePrevPos() {
   prevX=super.getX();
   prevY=super.getY();
   println(prevX + ", " + prevY);
  }
}

//takes in wasd
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
