////obsolete
////ArrayList<Wall> wallArr = new ArrayList<Wall>();

//public class Wall extends GamePiece {
//  private color wallColor = #808080;
  
//  public Wall(float xpos,float ypos) {
//    super(xpos, ypos);
//  }
  
//  public void display() {
//    super.display(wallColor);
//  }
//}

//int chooseNum(String xOrY) {
//  if (xOrY.equals("x")) {
//    int x = (int) (Math.random() * (width));
//    while (x%20!=0) x = (int) (Math.random() * (width));
//    return x;
//  }
//  if (xOrY.equals("y")) {
//    int y = (int) (Math.random() * (height));
//    while (y%20!=0) y = (int) (Math.random() * (height));
//    return y;
//  } else return 0;
//}

//boolean moreThanOnce(ArrayList<Integer> list, int searched) {
//  int numCount = 0;

//  for (int thisNum : list) {
//    if (thisNum == searched) numCount++;
//  }

//  return numCount > 1;
//}

//void determineWallPos(int wallNum) {
//  ArrayList<Integer>X = new ArrayList<Integer>();
//  ArrayList<Integer>Y = new ArrayList<Integer>();
//  wallNum = numWalls;

//  for (int i = 0; i < wallNum; i++) {
//    int x = chooseNum("x");
//    X.add(i, x);
//    while (moreThanOnce(X, x)) {
//      x = chooseNum("x");
//      X.set(i, x);
//    }
//    int y = chooseNum("y");
//    Y.add(i, y);

//    while (moreThanOnce(Y, y)) {
//      y = chooseNum("y");
//      Y.set(i, y);
//    }

//    wallArr.add(new Wall(x, y));
//    //println("(" + x + ", " + y + ")");
//  }
//}
