class Face {
  int[] points;
  Object parent;
  color q;
  color stroke;
  float weight;
  float[] direction;
  float[] img;
  int adjustment;
  Face(int a, int b, int c, Object parent, color q) {
    this.points=new int[]{a, b, c};
    this.parent=parent;
    this.points=sort(this.points);
    this.q=q;
    this.stroke=q;
    this.weight=0;
    this.direction=new float[3];
    float[]k={0, 0, 0, 16, 16, 0};//pixel coordinates
    this.img=k;
    this.adjustment=0;//0, 1, or 2 to indicate how to rotate texture of face to match texture mapping code
  }

  Point center() {
    float x=0;
    float y=0;
    float z=0;
    for (int point : this.points) {//get transformed points
      x+=parent.transformed[point].x;
      y+=parent.transformed[point].y;
      z+=parent.transformed[point].z;
    }
    x/=3;
    y/=3;//average the vertices
    z/=3;
    return new Point(x, y, z);
  }

  void display() {
    if (!textured) {
      //get the projected points
      Point[] vertices={parent.transformed[this.points[0]], parent.transformed[this.points[1]], parent.transformed[this.points[2]]};
      Point[] projections={vertices[0].project(), vertices[1].project(), vertices[2].project()};
      //graph face's projection
      stroke(stroke);
      strokeWeight(weight);
      fill(q);
      triangle(projections[0].x, projections[0].y, projections[1].x, projections[1].y, projections[2].x, projections[2].y);
    } else {
      Point[] vertices={parent.transformed[this.points[0]], parent.transformed[this.points[1]], parent.transformed[this.points[2]]};
      vertices=shift(vertices, this.adjustment);
      Point[] projections={vertices[0].project(), vertices[1].project(), vertices[2].project()};
      //iterate through x and y over bounding box of triangle on screen, find the corresponding part of the face in 3d, map the face to the unit triangle, map that to the image
      float c1=vertices[2].x-vertices[0].x;
      float c2=vertices[2].y-vertices[0].y;
      float c3=vertices[1].x-vertices[0].x;//constants to save time in computing
      float c4=vertices[1].y-vertices[0].y;
      float c5=vertices[2].z-vertices[0].z;
      float c6=vertices[1].z-vertices[0].z;
      for (int x=int(max(-width/2, min(projections[0].x, projections[1].x, projections[2].x))); x<min(max(projections[0].x, projections[1].x, projections[2].x), width/2); x++) {
        for (int y=int(max(-height/2, min(projections[0].y, projections[1].y, projections[2].y))); y<min(max(projections[0].y, projections[1].y, projections[2].y), height/2); y++) {
          float[][] system=new float[2][3];
          //solve system of equations to find the components of the corresponding point of the triange in the vector space
          float z=plane_distance;
          if (x!=0) {//x=0 causes a strange issue, so test an x value close to but not quite 0
            system[0][0]=y*(c1)-x*(c2);
            system[0][1]=y*(c3)-x*(c4);
            system[0][2]=x*vertices[0].y-y*vertices[0].x;
            system[1][0]=z*(c1)-x*(c5);
            system[1][1]=z*(c3)-x*(c6);
            system[1][2]=x*vertices[0].z-z*vertices[0].x;
          } else {
            system[0][0]=y*(c1)-.1*(c2);
            system[0][1]=y*(c3)-.1*(c4);
            system[0][2]=.1*vertices[0].y-y*vertices[0].x;
            system[1][0]=z*(c1)-.1*(c5);
            system[1][1]=z*(c3)-.1*(c6);
            system[1][2]=.1*vertices[0].z-z*vertices[0].x;
          }
          //explicitly solve system instead of using solve() function
          float[] components=new float[2];//solve for the components of the point
          components[1]=(system[0][0]*system[1][2]-system[0][2]*system[1][0])/(system[0][0]*system[1][1]-system[0][1]*system[1][0]);
          components[0]=(system[0][2]-system[0][1]*components[1])/system[0][0];
          if (components[0]==constrain(components[0], 0, 1)&&components[1]==constrain(components[1], 0, 1-components[0])) {//when the point satisfies the boundary conditions, find the color from the texture
            float[] coordinate=new float[2];
            coordinate[0]=img[0];//get the second vertex
            coordinate[1]=img[1];
            float[] p1={img[0], img[1]};//express the points in the image as vectors to find the coordinate of the pixel in the image
            float[] p2={img[2], img[3]};
            float[] p3={img[4], img[5]};
            p1=vsprod(p1, -1);
            p2=vadd(p1, p2);
            p3=vadd(p1, p3);
            coordinate=vadd(coordinate, vsprod(p2, components[0]));
            coordinate=vadd(coordinate, vsprod(p3, components[1]));
            coordinate[0]=int(coordinate[0]);
            coordinate[1]=int(coordinate[1]);
            color c=texture.pixels[min(int(coordinate[0]+texture.width*(coordinate[1])), texture.pixels.length-1)];
            if(int(coordinate[0]+texture.width*(coordinate[1]))>texture.pixels.length-1){
             println(coordinate[0], coordinate[1]); 
            }
            color d=pixels[(x+width/2)+width*(height/2-y)];
            if (alpha(c)==255) {
              pixels[(x+width/2)+width*(height/2-y)]=c;//if fully opaque, then simply overlap color onto screen
            } else {
              pixels[(x+width/2)+width*(height/2-y)]=color((red(c)*alpha(c)+red(d)*(255-alpha(c)))/(alpha(c)+(255-alpha(c))), (green(c)*alpha(c)+green(d)*(255-alpha(c)))/(alpha(c)+(255-alpha(c))), (blue(c)*alpha(c)+blue(d)*(255-alpha(c)))/(alpha(c)+(255-alpha(c))));//if not fully opaque, then set the color to be a function of the previous and texture colors
            }
          }
        }
      }
    }
  }
}

Point[] shift(Point[] k, int shift) {
  Point a;
  switch(shift) {
  case 0:
    return k;
  case 1:
    a=k[0];
    k[0]=k[1];
    k[1]=k[2];
    k[2]=a;
    return k;
  case 2:
    a=k[0];
    k[0]=k[2];
    k[2]=k[1];
    k[1]=a;
    return k;
  case 3:
    a=k[2];
    k[2]=k[1];
    k[1]=a;
    return k;
  case 4:
    a=k[2];
    k[2]=k[1];
    k[1]=a;
    a=k[0];
    k[0]=k[1];
    k[1]=k[2];
    k[2]=a;
    return k;
  case 5:
    a=k[2];
    k[2]=k[1];
    k[1]=a;
    a=k[0];
    k[0]=k[2];
    k[2]=k[1];
    k[1]=a;
    return k;
  }
  return new Point[3];
}
