public class Mover {
  private float xpos, ypos;

  public Mover(float m_xpos, float m_ypos) {
    xpos = m_xpos;
    ypos = m_ypos;
  }

  public void display(color colour) {
    fill(colour);
    square(xpos, ypos, 20);
    fill(0);
  }

  //should be a factor of 20
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
}
