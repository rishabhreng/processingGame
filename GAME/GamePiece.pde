//general class for enemies, player, and coin
public class GamePiece {
  private int xpos, ypos, prevX, prevY;

  public GamePiece(int m_xpos, int m_ypos) {
    xpos = m_xpos;
    ypos = m_ypos;
    prevX=xpos;
    prevY=ypos;
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

  public int getPrevX() {
    return prevX;
  }

  public int getPrevY() {
    return prevY;
  }

  public void setX(int x) {
    xpos=x;
  }

  public void setY(int y) {
    ypos=y;
  }

  //if a gamepiece moves past any of the sides of the screen, move it to opposite side
  public void checkSideCollision() {
    if (xpos >= width) move(-width, 0);
    if (xpos < 0) move(width, 0);
    if (ypos >= height) move(0, -height);
    if (ypos < 0) move(0, height);
  }

  public int checkWallCollision() {
    if ((float(getX())-40)/60%1==0&&(float(getY())-40)/60%1==0) {
      setX(prevX);
      setY(prevY);
      return 1;
    }
    if ((float(getX())-40)/60%1==0) {
      var testWall=getWall((getX()-40)/60, getY()/60, false);
      if (testWall!=null&&testWall.isGraphed()) {
        setX(prevX);
        setY(prevY);
        return 1;
      }
    } 
    else if ((float(getY())-40)/60%1==0) {
      var testWall=getWall(getX()/60, (getY()-40)/60, true);
      if (testWall!=null&&testWall.isGraphed()) {
        setX(prevX);
        setY(prevY);
        return 1;
      }
    }
    return 0;
  }

  //if player attempts to move into wall, keeps the player in the same place
  public void updatePrevPos() {
    prevX=getX();
    prevY=getY();
  }
}

public int RandPos() {
  int column=-1;
  while ((column-2)%3==0) {
    column=(int) (Math.random()*30);
  }
  return 20*column;
}

public void randomizePositions() {
  player.setX(RandPos());
  player.setY(RandPos());
  for (Enemy enemy : enemies) {
    enemy.setX(RandPos());
    enemy.setY(RandPos());
    while (enemy.getX()==player.getX()&&enemy.getY()==player.getY()) {
      enemy.setX(RandPos());
      enemy.setY(RandPos());
    }
  }
  coin.setX(RandPos());
  coin.setY(RandPos());
}
