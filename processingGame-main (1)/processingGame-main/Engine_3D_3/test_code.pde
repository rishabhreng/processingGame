void one() {//test for matrix inverter
  float[][] m={{5, 1, 2}, {0, 1, 0}, {1, 0, 1}};
  float[][] inverse=inverseMatrix(m);
  println(inverse[0][0], inverse[0][1], inverse[0][2]);
  println(inverse[1][0], inverse[1][1], inverse[1][2]);
  println(inverse[2][0], inverse[2][1], inverse[2][2]);
  float[][] product=matrixProduct(m, inverse);
  println(product[0][0], product[0][1], product[0][2]);
  println(product[1][0], product[1][1], product[1][2]);
  println(product[2][0], product[2][1], product[2][2]);
  float[] vector={1, 2, 3};
  vector=mvprod(m, vector);
  vector=mvprod(inverse, vector);
  println(vector[0], vector[1], vector[2]);
}

void two() {//test for system of equation solver
  float[][] system={{1, 17, 1, 5}, {1, 1, 3, 2}, {1, 4, 1, 3}};
  system=simplify(system, 3);
  println(system[0][0], system[0][1], system[0][2], system[0][3]);
  println(system[1][0], system[1][1], system[1][2], system[1][3]);
  println(system[2][0], system[2][1], system[2][2], system[2][3]);
  float[] solution=solve(system, 3);
  println(solution[0], solution[1], solution[2]);
}

void old_face_display() {//old display method
  //float[] screen={projections[0].x, projections[0].y, projections[1].x, projections[1].y, projections[2].x, projections[2].y};//x and y coordinates of the points in custom frame
  //float[][] matrix=new float[2][2];//from orthonormal to screen
  //float[][] inverse=new float[2][2];
  //matrix[0][0]=screen[2]-screen[0];
  //matrix[0][1]=screen[4]-screen[0];
  //matrix[1][0]=screen[3]-screen[1];
  //matrix[1][1]=screen[5]-screen[1];
  //float k=det(matrix);
  ////find its inverse
  //inverse[0][0]=matrix[1][1]/k;//x of i
  //inverse[0][1]=-matrix[0][1]/k;//y of i
  //inverse[1][0]=-matrix[1][0]/k;//x of j
  //inverse[1][1]=matrix[0][0]/k;//y of j
  ////use x and y of custom frame and turn them into pixel coordinates later
  //for (int y=int(max(min(screen[1], screen[3], screen[5]), -height/2)); y<min(max(screen[1], screen[3], screen[5]), height/2); y++) {
  //  //check all points inside bounding box
  //  //test if each pixel is inside the triangle
  //  //if inside, move on with calculation
  //  for (int x=int(max(min(screen[0], screen[2], screen[4]), -width/2)); x<min(max(screen[0], screen[2], screen[4]), width/2); x++) {
  //    //calculate the components of the point of the pixel
  //    //if the components are within the proper ranges, then proceed
  //    float[] vector={x-screen[0], y-screen[1]};//for each x value, take the pixel and translate the vector to have the first vertex at the origin
  //    float[] components=mvprod(inverse, vector);//take the vector and multiply it by the inverse matrix to get the components
  //    if (components[0]==constrain(components[0], 0, 1)&&components[1]==constrain(components[1], 0, 1-constrain(components[0], 0, 1))) {
  //      //take these components to find the relevant pixel in the image by multiplying vectors in the image by the components
  //      //and taking the vector of these components as the relevant pixel
  //      float[] coordinate=new float[2];
  //      coordinate[0]=img[0];//get the second vertex
  //      coordinate[1]=img[1];
  //      float[] p1={img[0], img[1]};//express the points in the image as vectors to find the coordinate of the pixel in the image
  //      float[] p2={img[2], img[3]};
  //      float[] p3={img[4], img[5]};
  //      p1=vsprod(p1, -1);
  //      p2=vadd(p1, p2);
  //      p3=vadd(p1, p3);
  //      coordinate=vadd(coordinate, vsprod(p2, components[0]));
  //      coordinate=vadd(coordinate, vsprod(p3, components[1]));
  //      coordinate[0]=int(coordinate[0]);
  //      coordinate[1]=int(coordinate[1]);
  //      pixels[x+width/2+(height/2-y)*width]=texture.pixels[int(coordinate[0]+texture.width*(coordinate[1]))];//coordinates are always in pixel coordinates, x and y are converted to pixel coordinates
  //    }
  //  }
  //}
}
