public class GamePiece {
  private float xpos, ypos;

  public GamePiece(float m_xpos, float m_ypos) {
    xpos = m_xpos;
    ypos = m_ypos;
  }

  public void display(color colour) {
    fill(colour);
    square(xpos, ypos, 20);
    fill(0);
  }

  //should be a factor of 20, or in general, grid "pixel" size
  public void move(float x, float y) {
    xpos+=x;
    ypos+=y;
    display(0);
  }

  public float getX() {
    return xpos;
  }
  
  public float getY() {
    return ypos;
  }
  
  public void checkSideCollision() {
    if (xpos >= width) move(-width, 0);
    if (xpos < 0) move(width, 0);
    if (ypos >= height) move(0,-height);
    if (ypos < 0) move(0, height);
  }
  
  
}
