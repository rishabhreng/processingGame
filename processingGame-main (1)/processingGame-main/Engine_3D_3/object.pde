class Object {
  Point[] points;
  Point[] transformed;
  Face[] faces;
  Point center;
  int npoints, nfaces;
  float theta, phi, rho;
  boolean cumulativeRotation;
  float[][] rotation;
  Dictionary dict;
  //initialize an empty object with no points nor faces saved but space allocated for them
  Object(int npoints, int nfaces, Point center) {
    this.npoints=npoints;//lists and numbers
    this.nfaces=nfaces;
    this.points=new Point[npoints];
    this.faces=new Face[nfaces];
    this.center=center;//center point
    this.theta=0;//rotation variables
    this.phi=0;
    this.rho=0;
    this.transformed=new Point[npoints];
    this.cumulativeRotation=false;//cumulative rotation mode allows for rotations to be accumulated over frames
    this.rotation=xyrotation(0);//matrix to store cumulative rotations
    this.dict=new Dictionary(nfaces);//dictionary for the faces for graphing purposes
  }

  void display() {
    //generate transformed set of points, then display
    transform();
    dict.setdepths();
    dict.sortDepths();
    for (float depth : dict.sorted) {
      if (depth>0) {
        dict.value(depth).display();
      }
    }
  }

  void transform() {//make a transformed copy of the points
    float[][] rtheta=xzrotation(theta);
    float[][] rphi=yzrotation(phi);
    float[][] rrho=xyrotation(rho);
    for (int i=0; i<npoints; i++) {
      if (!cumulativeRotation) {//cumulative rotation mode only needs to use one matrix, noncumulative rotations require all three in a specific order
        transformed[i]=mproduct(mproduct(mproduct(points[i], rrho), rphi), rtheta);//rotate the object, reposition it based off its center, reposition it based off the camera position, rotate based off camera orientation.
      } else {
        transformed[i]=mproduct(points[i], rotation);
      }
      transformed[i].add(center);//after rotating, the points are translated and then rotated according to the camera's orientation
      transformed[i].add(new Point(-camposition[0], -camposition[1], -camposition[2]));
      transformed[i].mproduct(xzrotation(-camera_theta));//rotate entire scene by the negative of camera rotation to undo the camera's rotation
      transformed[i].mproduct(yzrotation(-camera_phi));
    }
  }

  //stretching functions
  void stretchx(float factor) {
    for (Point point : this.points) {
      point.x*=factor;
    }
  }

  void stretchy(float factor) {
    for (Point point : this.points) {
      point.y*=factor;
    }
  }

  void stretchz(float factor) {
    for (Point point : this.points) {
      point.z*=factor;
    }
  }

  //sets the dictionary's face list
  void setDict() {
    for (int i=0; i<nfaces; i++) {
      dict.faces[i]=this.faces[i];
    }
  }
}


//default cube creator
Object default_cube(int size, Point center, color a) {
  //textureMapping is a list of 8 values for the four points of a square, which is broken into two triangles for the cube's two triangles per face
  //UL, LL, LR, UR
  Object entity;
  entity=new Object(8, 12, new Point(0, 0, 0));
  entity.center=center;
  entity.points[0]=new Point(-size, -size, -size);
  entity.points[1]=new Point(-size, -size, size);
  entity.points[2]=new Point(-size, size, -size);
  entity.points[3]=new Point(-size, size, size);
  entity.points[4]=new Point(size, -size, -size);
  entity.points[5]=new Point(size, -size, size);
  entity.points[6]=new Point(size, size, -size);
  entity.points[7]=new Point(size, size, size);
  entity.faces[0]=new Face(0, 1, 3, entity, a);
  entity.faces[1]=new Face(0, 2, 3, entity, a);
  entity.faces[2]=new Face(0, 1, 5, entity, a);
  entity.faces[3]=new Face(0, 4, 5, entity, a);
  entity.faces[4]=new Face(0, 2, 6, entity, a);
  entity.faces[5]=new Face(0, 4, 6, entity, a);
  entity.faces[6]=new Face(2, 3, 6, entity, a);
  entity.faces[7]=new Face(7, 3, 6, entity, a);
  entity.faces[8]=new Face(7, 6, 5, entity, a);
  entity.faces[9]=new Face(4, 6, 5, entity, a);
  entity.faces[10]=new Face(5, 1, 3, entity, a);
  entity.faces[11]=new Face(7, 5, 3, entity, a);
  entity.setDict();
  return entity;
}

//sets the texture of the cube and ensures that each face object is properly mapped
void setDefaultCubeTexture(Object entity, float[] tM){
  int[] k={0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2};
  for (int i=0; i<12; i++) {
    switch(k[i]) {
    case 0:
      float[] t={tM[0], tM[1], tM[2], tM[3], tM[4], tM[5]};
      entity.faces[i].img=t;
      break;
    case 1:
      float[] t1={tM[2], tM[3], tM[4], tM[5], tM[6], tM[7]};
      entity.faces[i].img=t1;
      break;
    case 2:
      float[] t2={tM[4], tM[5], tM[6], tM[7], tM[0], tM[1]};
      entity.faces[i].img=t2;
      break;
    case 3:
      float[] t3={tM[6], tM[7], tM[0], tM[1], tM[2], tM[3]};
      entity.faces[i].img=t3;
      break;
    }
  }
  int[] n={2, 3, 2, 3, 2, 3, 1, 5, 0, 4, 1, 5};
  for (int i=0; i<12; i++) {
    entity.faces[i].adjustment=n[i];
  }
}
