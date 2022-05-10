public class GamePiece {
  private int xpos, ypos;

  public GamePiece(int m_xpos, int m_ypos) {
    xpos = m_xpos;
    ypos = m_ypos;
  }

  public void display(color colour) {
    fill(colour);
    square(xpos, ypos, 20);
    fill(0);
  }

  //should be a factor of 20, or in general, grid "pixel" size
  public void move(int x, int y) {
    xpos+=x;
    ypos+=y;
    display(0);
  }

  public int getX() {
    return xpos;
  }
  
  public int getY() {
    return ypos;
  }
  
   public void setX(int x){
   xpos=x; 
  }
  
  public void setY(int y){
   ypos=y; 
  }
  
  public void checkSideCollision() {
    if (xpos >= width) move(-width, 0);
    if (xpos < 0) move(width, 0);
    if (ypos >= height) move(0,-height);
    if (ypos < 0) move(0, height);
  }
  
  
}
