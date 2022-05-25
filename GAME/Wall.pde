int gridX=10;//grid dimensions
int gridY=10;
Wall[] walls=new Wall[gridY*(gridX-1)+gridX*(gridY-1)];
ArrayList<int[]> accessibleSquares=new ArrayList<int[]>();
float loopConstant=.9;

public class Wall {
  private color wallColor = #808080;
  int x;//take grid coordinates of the square either above or to the left
  int y;
  boolean horizontal;
  float weight;
  boolean graphed;

  public Wall(int x, int y, boolean horizontal) {
    this.x=x;
    this.y=y;
    this.horizontal=horizontal;
    this.graphed=true;
  }

  void randomize() {
    this.weight=random(1);
  }

  public boolean isGraphed() {
    return graphed;
  }

  public void display() {
    if (isGraphed()) {
      fill(wallColor);
      if (horizontal) {
        rect(60*x, 60*y+40, 40, 20);
      } else {
        rect(60*x+40, 60*y, 20, 40);
      }
    }
  }
}

void generateMaze() {
  accessibleSquares.clear();
  accessibleSquares.add(new int[] {0, 0});
  ArrayList<Wall> accessibleWalls=new ArrayList<Wall>();
  FloatList wallWeights=new FloatList();
  Wall weakestWall;
  while (accessibleSquares.size()<gridX*gridY) {
    //empty accesible wall array and wall weight array
    wallWeights.clear();
    accessibleWalls.clear();
    //get all of the accesible walls, finding the ones which are not blocking loops
    for (Wall wall : walls) {
      int neighbors=0;
      //add the walls if they are not between two accesible squares
      if (wall.horizontal==true) {//make sure the wall is adjacent to only one accesible square
        for (int[] square : accessibleSquares) {
          if (square[0]==wall.x&&(square[1]==wall.y||square[1]==wall.y+1)) {
            neighbors++;
          }
        }
        if (neighbors==1) {
          accessibleWalls.add(wall);
        }
      } else {
        for (int[] square : accessibleSquares) {
          if (square[1]==wall.y&&(square[0]==wall.x||square[0]==wall.x+1)) {
            neighbors++;
          }
        }
        if (neighbors==1) {
          accessibleWalls.add(wall);
        }
      }
    }
    //get a floatlist of the weights
    for (int i=0; i<accessibleWalls.size(); i++) {
      wallWeights.append(accessibleWalls.get(i).weight);
    }
    //find the wall with minimum weight
    int index=0;
    for (int i=0; i<wallWeights.size(); i++) {
      if (wallWeights.get(i)==wallWeights.min()) {
        index=i;
      }
    }
    weakestWall=accessibleWalls.get(index);
    //set this wall to not be graphed, add the grid square opposite it to the accessible squares
    weakestWall.graphed=false;
    if (weakestWall.horizontal==true) {
      boolean contained=false;
      for (int[] square : accessibleSquares) {
        if (square[0]==weakestWall.x&&square[1]==weakestWall.y) {
          contained=true;
        }
      }
      if (contained) {
        accessibleSquares.add(new int[] {weakestWall.x, weakestWall.y+1});
      } else {
        accessibleSquares.add(new int[] {weakestWall.x, weakestWall.y});
      }
    } else {
      boolean contained=false;
      for (int[] square : accessibleSquares) {
        if (square[0]==weakestWall.x&&square[1]==weakestWall.y) {
          contained=true;
        }
      }
      if (contained) {
        accessibleSquares.add(new int[] {weakestWall.x+1, weakestWall.y});
      } else {
        accessibleSquares.add(new int[] {weakestWall.x, weakestWall.y});
      }
    }
  }
  for (Wall wall : walls) {
    if (random(1)>loopConstant&&wall.isGraphed()) {
      wall.graphed=false;
    }
  }
}

Wall getWall(int x, int y, boolean horizontal) {
  for (Wall wall : walls) {
    if (wall.x==x&&wall.y==y&&wall.horizontal==horizontal) {
      return wall;
    }
  }
  return null;
}

void graph() {
  for (Wall wall : walls) {//walls
    wall.display();
  }
  for (int a=0; a<gridX-1; a++) {//grid
    for (int b=0; b<gridY-1; b++) {
      fill(#808080);
      square(60*a+40, 60*b+40, 20);
      fill(0);
    }
  }
}

void wallsCreate() {
  //horizontal walls
  int index=0;
  for (int x=0; x<gridX; x++) {
    for (int y=0; y<gridY-1; y++) {
      walls[index]=new Wall(x, y, true);
      index++;
    }
  }
  //vertical walls
  for (int x=0; x<gridX-1; x++) {
    for (int y=0; y<gridY; y++) {
      walls[index]=new Wall(x, y, false);
      index++;
    }
  }
  for (Wall wall : walls) {
    wall.randomize();
  }
  accessibleSquares.add(new int[] {0, 0});
  generateMaze();
}
