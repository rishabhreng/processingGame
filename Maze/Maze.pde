//maze test
int squareSize=20;//pixels per square of traversible grid square
int wallThickness=3;//pixels per wall
int gridX=30;//grid dimensions
int gridY=30;
wall[] walls=new wall[gridY*(gridX-1)+gridX*(gridY-1)];
ArrayList<int[]> accessibleSquares=new ArrayList<int[]>();
int w=gridX*squareSize+wallThickness*(gridX-1);
int h=gridY*squareSize+wallThickness*(gridY-1);

//grid coordinates start with 0, 0 in upper left
//starting square is upper left

void settings(){
  size(w, h);
}

void setup(){
  //horizontal walls
  int index=0;
  for(int x=0;x<gridX;x++){
    for(int y=0;y<gridY-1;y++){
      walls[index]=new wall(x, y, true);
      index++;
    }
  }
  //vertical walls
  for(int x=0;x<gridX-1;x++){
   for(int y=0;y<gridY;y++){
    walls[index]=new wall(x, y, false);
    index++;
   }
  }
  for(wall wall:walls){
   wall.randomize(); 
  }
  rectMode(CENTER);
  accessibleSquares.add(new int[] {0, 0});
  println(equal(new int[] {0, 0}, new int[] {0, 0}));
  println(new int[] {0, 0}==new int[] {0, 0});
  generateMaze();
}

void draw(){
 graph();
}
