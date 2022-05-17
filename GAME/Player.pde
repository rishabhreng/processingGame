public class Player extends GamePiece {
  private color playerColor = #0000FF;
  private int prevX, prevY;
  
  public Player(int xpos,int ypos) {
    super(xpos, ypos);
  }
  
  public void display() {
    super.display(playerColor);
  }
  
  //keeps player from moving in wall by comparing coordinates with wall coordinates
  public void checkWallCollision(){
    if((float(player.getX())-40)/60%1==0&&(float(player.getY())-40)/60%1==0){
      println("Point collision");
      super.setX(prevX);
      super.setY(prevY);
    }if((float(player.getX())-40)/60%1==0){
      var testWall=getWall((player.getX()-40)/60, player.getY()/60, false);
      if(testWall!=null&&testWall.isGraphed()){
        println("wall Collision");
        super.setX(prevX);
        super.setY(prevY);
      }
    }else if((float(player.getY())-40)/60%1==0){
      var testWall=getWall(player.getX()/60, (player.getY()-40)/60, true);
      if(testWall!=null&&testWall.isGraphed()){
       println("wall Collision");
       super.setX(prevX);
       super.setY(prevY);
      }
    }
  }
  
  //if player attempts to move into wall, keeps the player in the same place
  public void updatePrevPos() {
   prevX=super.getX();
   prevY=super.getY();
   println(prevX + ", " + prevY);
  }
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
