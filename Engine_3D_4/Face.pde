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

  int numVerticesBehindCamera() {
    int k=0;
    for (int i=0; i<3; i++) {
      if (parent.transformed[points[i]].z<0) k++;
    }
    return k;
  }

  void display() {
    if (!textured) {
      int k;
      float t;
      int counter;
      Point a=new Point(0, 0, 0);
      Point b=new Point(0, 0, 0);
      //get the projected points
      Point[] vertices={parent.transformed[this.points[0]], parent.transformed[this.points[1]], parent.transformed[this.points[2]]};//transformed vertices
      Point[] projections={vertices[0].project(), vertices[1].project(), vertices[2].project()};//projected versions
      //graph face's projection
      stroke(stroke);
      strokeWeight(weight);
      fill(q);
      switch(numVerticesBehindCamera()) {//graphing for each case of clipping with near plane
      case 0:
        triangle(projections[0].x, projections[0].y, projections[1].x, projections[1].y, projections[2].x, projections[2].y);//no clipping means normal graphing
        break;
      case 1://one vertex clipped means making a quadrilateral
        //find the vertex behind the camera and cut it off, making a quadrilateral which can be plotted as usual
        k=0;
        for (int p : points) {
          if (parent.transformed[p].z<0) k=p;
        }
        //with the vertex known, find where the segments between it and the other vertices cross the near clip plane
        t=0;//parametric variable between 0 at the corresponding front vertex and 1 at the rear vertex
        counter=0;
        for (int p : points) {//going in order, calculate the t values, then use those to calculate the two intersection points via linear interpolation
          if (p!=k) {
            t=parent.transformed[p].z/(parent.transformed[p].z-parent.transformed[k].z);
            t-=.01;//adjust t to avoid cast ray being parallel to graph plane
            if (counter==0) {
              a=interpolatedPoint(parent.transformed[p], parent.transformed[k], t);
            } else {
              b=interpolatedPoint(parent.transformed[p], parent.transformed[k], t);
            }
            counter++;
          }
        }
        //find which vertex in the sequence is behind the camera and then graph the quadrilateral
        for (int i=0; i<3; i++) {
          if (points[i]==k) {
            k=i;
            break;
          }
        }
        a=a.project();//a is adjacent to the first non-cut point, b to the second
        b=b.project();
        switch(k) {
        case 0:
          quad(b.x, b.y, a.x, a.y, projections[1].x, projections[1].y, projections[2].x, projections[2].y);
          break;
        case 1:
          quad(projections[0].x, projections[0].y, a.x, a.y, b.x, b.y, projections[2].x, projections[2].y);
          break;
        case 2:
          quad(projections[0].x, projections[0].y, projections[1].x, projections[1].y, b.x, b.y, a.x, a.y);
          break;
        }
        break;
      case 2:
        //find the vertex in front of the camera and cut the others off, making a new triangle to graph
        k=0;//k stores the front vertex
        for (int p : points) {
          if (parent.transformed[p].z>0) k=p;
        }
        counter=0;
        for (int p : points) {
          if (p!=k) {//for all other vertices, linearly interpolate a new vertex
            t=parent.transformed[k].z/(parent.transformed[k].z-parent.transformed[p].z);
            t-=.01;
            if (counter==0) {
              a=interpolatedPoint(parent.transformed[k], parent.transformed[p], t);
            } else {
              b=interpolatedPoint(parent.transformed[k], parent.transformed[p], t);
            }
            counter++;
          }
        }
        a=a.project();//find the projected vertices
        b=b.project();
        //find which vertex is in front, then graph accordingly
        for (int i=0; i<3; i++) {
          if (k==points[i]) {
            k=i;
            break;
          }
        }
        triangle(a.x, a.y, b.x, b.y, projections[k].x, projections[k].y);
        break;
      }
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
            if (int(coordinate[0]+texture.width*(coordinate[1]))>texture.pixels.length-1) {
              println(coordinate[0], coordinate[1]);
            }
            color d=pixels[min((x+width/2)+width*(height/2-y), 639999)];
            if (alpha(c)==255) {
              pixels[min((x+width/2)+width*(height/2-y), 639999)]=c;//if fully opaque, then simply overlap color onto screen
            } else {
              pixels[min((x+width/2)+width*(height/2-y), 639999)]=color((red(c)*alpha(c)+red(d)*(255-alpha(c)))/(alpha(c)+(255-alpha(c))), (green(c)*alpha(c)+green(d)*(255-alpha(c)))/(alpha(c)+(255-alpha(c))), (blue(c)*alpha(c)+blue(d)*(255-alpha(c)))/(alpha(c)+(255-alpha(c))));//if not fully opaque, then set the color to be a function of the previous and texture colors
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
