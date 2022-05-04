class wall {
  int x;//take grid coordinates of the square either above or to the left
  int y;
  boolean horizontal;
  float weight;
  boolean graphed;
  wall(int x, int y, boolean horizontal) {
    this.x=x;
    this.y=y;
    this.horizontal=horizontal;
    graphed=true;
    weight=0;
  }
  void randomize() {
    this.weight=random(1);
  }
  void graph() {
    if (graphed) {
      if (horizontal) {
        fill(0);
        rect((squareSize+wallThickness)*x+squareSize/2, (squareSize+wallThickness)*y+squareSize+wallThickness/2, squareSize, wallThickness);
      } else {
        fill(0);
        rect(squareSize+wallThickness/2+x*(squareSize+wallThickness), (squareSize+wallThickness)*y+squareSize/2, wallThickness, squareSize);
      }
    }
  }
}

void generateMaze() {
  ArrayList<wall> accessibleWalls=new ArrayList<wall>();
  FloatList wallWeights=new FloatList();
  wall weakestWall;
  while (accessibleSquares.size()<gridX*gridY) {
    //empty accesible wall array and wall weight array
    wallWeights.clear();
    accessibleWalls.clear();
    //get all of the accesible walls, finding the ones which are not blocking loops
    for (wall wall : walls) {
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
        for(int[] square:accessibleSquares){
         if(square[1]==wall.y&&(square[0]==wall.x||square[0]==wall.x+1)){
          neighbors++; 
         }
        }
        if(neighbors==1){
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
      for(int[] square:accessibleSquares){
       if(square[0]==weakestWall.x&&square[1]==weakestWall.y){
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
      for(int[] square:accessibleSquares){
       if(square[0]==weakestWall.x&&square[1]==weakestWall.y) {
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
}

wall getwall(int x, int y, boolean horizontal) {
  for (wall wall : walls) {
    if (wall.x==x&&wall.y==y&&wall.horizontal==horizontal) {
      return wall;
    }
  }
  return null;
}

void graph() {
  for (wall wall : walls) {
    wall.graph();
  }
}
