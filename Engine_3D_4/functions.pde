float[][] xzrotation(float angle) {//rotation matrices
  float[][] k=new float[3][3];
  k[1][1]=1;
  k[0][0]=cos(angle);//x column
  k[2][0]=sin(angle);
  k[0][2]=-sin(angle);//z column
  k[2][2]=cos(angle);
  return k;
}

float[][] yzrotation(float angle) {
  float[][] k=new float[3][3];
  k[0][0]=1;
  k[1][1]=cos(angle);//y column
  k[2][1]=sin(angle);
  k[1][2]=-sin(angle);//z column
  k[2][2]=cos(angle);
  return k;
}

float[][] xyrotation(float angle) {
  float[][] k=new float[3][3];
  k[2][2]=1;
  k[0][0]=cos(angle);//x column
  k[1][0]=sin(angle);
  k[0][1]=-sin(angle);//y column
  k[1][1]=cos(angle);
  return k;
}

float[][] matrixProduct(float[][] A, float[][] B) {//3x3 matrix product
  float[][] K=new float[3][3];
  for (int r=0; r<3; r++) {
    for (int c=0; c<3; c++) {
      float counter=0;
      for (int i=0; i<3; i++) {
        counter+=A[r][i]*B[i][c];
      }
      K[r][c]=counter;
    }
  }
  return K;
}

void keyPressed() {
  println(keyCode);
  switch(keyCode) {
  case 87:
    camposition[0]-=camspeed*sin(camera_theta);
    camposition[2]+=camspeed*cos(camera_theta);
    println(87);
    break;
  case 65:
    camposition[0]+=camspeed*cos(camera_theta);
    camposition[2]+=camspeed*sin(camera_theta);
    println(65);
    cube.center.x-=1;
    break;
  case 83:
    camposition[0]+=camspeed*sin(camera_theta);
    camposition[2]-=camspeed*cos(camera_theta);
    println(83);
    break;
  case 68:
    camposition[0]-=camspeed*cos(camera_theta);
    camposition[2]-=camspeed*sin(camera_theta);
    println(68);
    cube.center.x+=1;
    break;
  case 77:
    mouseMoving=!mouseMoving;
    break;
  case 78:
    mouse0[0]=mouseX;
    mouse0[1]=mouseY;
    break;
  }
}

void mouseClicked() {
  cube.rotation=xyrotation(0);
}

float dotproduct(float[] a, float[] b) {//dot product between vectors of any size
  float k=0;
  for (int i=0; i<a.length; i++) {
    k+=a[i]*b[i];
  }
  return k;
}

float[] camOrientation() {//returns vector pointing in the direction of the camera
  float z=cos(camera_phi)*cos(camera_theta);
  float x=sin(camera_phi)*cos(camera_theta);
  float y=sin(camera_theta);
  float[] k={x, y, z};
  return k;
}

float[] normalize(float[] a) {//returns a vector of unit length in the direction of the input vector
  float k=0;
  for (float b : a) {
    k+=b*b;
  }
  k=sqrt(k);
  for (int i=0; i<a.length; i++) {
    a[i]/=k;
  }
  return a;
}

float det(float[][] m) {//returns the determinant of a 2x2 matrix
  return m[0][0]*m[1][1]-m[0][1]*m[1][0];
}

float[] mvprod(float[][] m, float[] v) {//multiplies a vector by a matrix on its left side (matrix-vector products are non-commutative)
  float[] k=new float[v.length];
  for(int i=0;i<v.length;i++){
   for(int j=0;j<v.length;j++){
    k[i]+=m[i][j]*v[j]; 
   }
  }
  return k;
}

float[] vadd(float[] a, float[] b) {//adds two vectors of length 2
  float[] k=new float[2];
  k[0]=a[0]+b[0];
  k[1]=a[1]+b[1];
  return k;
}

float[] vsprod(float[] v, float k) {//multiplies a vector by a scalar
  float[] a=v;
  a[0]*=k;
  a[1]*=k;
  return a;
}

float[] solve(float[][] system, int rows) {//supposedly solves a system of linear equations EXTREMELY UNSTABLE
  int columns=rows+1;
  float[] solution=new float[rows];
  float constant;
  for(int r=rows-1;r>-1;r--){
    constant=system[r][columns-1];
    for(int c=r+1;c<columns-1;c++){
     constant-=system[r][c]*solution[c]; 
    }
    solution[r]=constant/system[r][r];
  }
  return solution;
}

float[][] simplify(float[][] system, int rows) {//supposedly simplifies a system of linear equations
  //if inputed system is of more than two rows, sort system to have the first equation have a non-zero leading coefficient, eliminate and solve for subsystem
  int columns=rows+1;
  if (rows>1) {
    //prepare system's rows after first for elimination of first variable
    system=sortSystem(system, rows);
    for (int r=1; r<rows; r++) {
      for (int c=0; c<columns; c++) {
        system[r][c]*=system[0][0];
      }
    }
    //eliminate first variable from all lines except first
    for (int r=1; r<rows; r++) {
      float tvar=system[r][0];
      for (int c=0; c<columns; c++) {
        system[r][c]-=system[0][c]*tvar/system[0][0];
      }
    }
    //replace all but first line with simplified subsystem, unless the current system is too small in which case resolve explicitly

    float[][]subsystem=new float[rows-1][columns-1];
    for (int r=0; r<rows-1; r++) {
      for (int c=0; c<columns-1; c++) {
        subsystem[r][c]=system[r+1][c+1];
      }
    }
    subsystem=simplify(subsystem, rows-1);
    for (int r=0; r<rows-1; r++) {
      for (int c=0; c<columns-1; c++) {
        system[r+1][c+1]=subsystem[r][c];
      }
    }
    return system;
  } else {
    return system;
  }
}
float[][] sortSystem(float[][] system, int rows){//supposedly sorts a system of linear equations
  if(system[0][0]==0){
    float[] line=system[0];//assume a proper line can be found later in the system
    for(int r=1;r<rows;r++){
      if(system[r][0]!=0){
       system[0]=system[r];
       system[r]=line;
       break;
      }
    }
  }
 return system; 
}

float[][] inverseMatrix(float[][] m){//supposedly calculates an inverse matrix
 //only square matrices of size 3
 //solve for inverse one column at a time
 float[][] inverse=new float[3][3];
 for(int c=0;c<3;c++){
   float[][] system=new float[3][4];//set up system to solve for column of inverse
   for(int nr=0;nr<3;nr++){
    for(int nc=0;nc<3;nc++){
     system[nr][nc]=m[nr][nc];//put matrix in system 
    }
   }
   system[c][3]=1;
   system=simplify(system, 3);
   float[] column=solve(system, 3);
   for(int r=0;r<3;r++){
    inverse[r][c]=column[r];
   }
 }
 return inverse;
}

float[][] transpose(float[][] m){//returns a transpose matrix
 float[][] t=new float[3][3];
 for(int c=0;c<3;c++){
  for(int r=0;r<3;r++){
   t[r][c]=m[c][r];
  }
 }
 return t;
}

float[] lvector(){//returns the vector pointing in the direction that the global light is pointing
 float[] k=new float[3];
 k[0]=cos(light_phi)*sin(light_theta);
 k[1]=sin(light_phi);
 k[2]=cos(light_phi)*cos(light_theta);
 return k;
}
