class Point {
  float x, y, z;
  //create a point
  Point(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }

  Point project_orthographic() {//interchangeable with other projection methods
    return new Point(this.x, this.y, 0);
  }
  
  Point project_perspective(){//perspective projection method
    float t=plane_distance/this.z;
    return new Point(this.x*t, this.y*t, 0);
  }

  float depth() {//uselesss
    return this.z;
  }

  void scale(float scale) {//scales the vector representation of the point
    this.x*=scale;
    this.y*=scale;
    this.z*=scale;
  }

  void add(Point a) {//adds another point's vector to current point
    this.x+=a.x;
    this.y+=a.y;
    this.z+=a.z;
  }

  void mproduct(float[][] R) {//transforms current point with a matrix
    float X, Y, Z;
    X=this.x*R[0][0]+this.y*R[0][1]+this.z*R[0][2];
    Y=this.x*R[1][0]+this.y*R[1][1]+this.z*R[1][2];
    Z=this.x*R[2][0]+this.y*R[2][1]+this.z*R[2][2];
    this.x=X;
    this.y=Y;
    this.z=Z;
  }

  Point project() {//change the function here to change overall projection
    if (perspective) {
      return this.project_perspective();
    } else {
      return this.project_orthographic();
    }
  }
  
  float distance(){
    return sqrt(this.x*this.x+this.y*this.y+this.z*this.z);
  }
}

Point add(Point a, Point b) {//create new point object which is the sum of two points
  return new Point(a.x+b.x, a.y+b.y, a.z+b.z);
}

Point scale(Point a, float scale) {//create a scaled version of a point
  return new Point(a.x*scale, a.y*scale, a.z*scale);
}

Point mproduct(Point a, float[][] R) {//create a transformed version of a point.
  float X, Y, Z;
  X=a.x*R[0][0]+a.y*R[0][1]+a.z*R[0][2];
  Y=a.x*R[1][0]+a.y*R[1][1]+a.z*R[1][2];
  Z=a.x*R[2][0]+a.y*R[2][1]+a.z*R[2][2];
  return new Point(X, Y, Z);
}

float dotProduct(Point a, Point b){
 return a.x*b.x+a.y*b.y+a.z*b.z; 
}

Point interpolatedPoint(Point a, Point b, float t){//t=0 returns a, t=1 returns b, values between return linearly interpolated points between a and b
 return new Point(a.x+t*(b.x-a.x), a.y+t*(b.y-a.y), a.z+t*(b.z-a.z));
}
