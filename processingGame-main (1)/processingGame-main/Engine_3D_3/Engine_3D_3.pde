//z is into screen, x to right, y up
//theta is angle around y, 0 at z+ axis, increases turning left
//phi increases looking up
//rho increases counterclockwise
//matrix indeces are row-column
//points in an object are defined with respect to the center and in default position and orientation
//each time the points are graphed, their actual positions are calculated by rotating and translating the object, then the standard algorithm is applied
//standard algorithm translates all of the objects and the camera to put the camera at the origin, then rotating to put the camera on the z+ axis, then projecting the points
//the object holds the original points with respect to its center and original orientation as well as a set of transformed versions of the points
//The faces refer to the parent object to get the points
//When the faces need the points, they must be transformed beforehand.
//rotation application order is xy-yz-xz or rho-phi-theta

float[] camposition={0, 0, 0};
float camera_phi=0;//horizontal rotation. 0 at z+, increases going counterclockwise as seen from y+(above)
float camera_theta=0;//vertical rotation. half pi at y+, -half pi at y-
float plane_distance=10;
float[] cubeMap1={16, 32, 16, 48, 32, 48, 16, 48};
float[] cubeMap2={48, 32, 48, 48, 64, 48, 64, 32};
float[] cubeMap3={32, 32, 32, 48, 48, 48, 48, 32};
Object cube=default_cube(63, new Point(0, 0, 200), color(255));
Object cube2=default_cube(21, new Point(0, 0, 200), color(255));
Object cube3=default_cube(7, new Point(0, 0, 200), color(255));
boolean perspective=true;
float fov=radians(120);//use fov to determine graphing plane distance
float camspeed=0;
boolean textured=true;
PImage texture;
float light_phi=0;
float light_theta=0;
Scene scene=new Scene(3);

void setup() {
  setDefaultCubeTexture(cube, cubeMap1);
  setDefaultCubeTexture(cube2, cubeMap2);
  setDefaultCubeTexture(cube3, cubeMap3);
  size(800, 800);
  background(0);
  plane_distance=-width/(2*tan(fov));//set plane distance and face colors
  cube.faces[0].q=color(255, 0, 0, 128);
  cube.faces[1].q=color(255, 0, 0, 128);
  cube.faces[2].q=color(0, 255, 0, 128);
  cube.faces[3].q=color(0, 255, 0, 128);
  cube.faces[4].q=color(0, 0, 255, 128);
  cube.faces[5].q=color(0, 0, 255, 128);
  cube.faces[6].q=color(0, 255, 255, 128);
  cube.faces[7].q=color(0, 255, 255, 128);
  cube.faces[8].q=color(255, 0, 255, 128);
  cube.faces[9].q=color(255, 0, 255, 128);
  cube.faces[10].q=color(255, 255, 0, 128);
  cube.faces[11].q=color(255, 255, 0, 128);
  for (Face face : cube.faces) {
    face.stroke=face.q;
  }
  cube.cumulativeRotation=true;
  cube2.cumulativeRotation=true;
  cube3.cumulativeRotation=true;
  texture=loadImage("Master_Texture2.png");
  scene.setObject(0, cube);
  scene.setObject(1, cube2);
  scene.setObject(2, cube3);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);
  cube.rotation=matrixProduct(yzrotation(-.01), matrixProduct(xzrotation(.05), cube.rotation));
  cube2.rotation=matrixProduct(yzrotation(.05), matrixProduct(xzrotation(-.01), cube2.rotation));
  cube3.rotation=matrixProduct(yzrotation(.05), matrixProduct(xzrotation(.01), cube3.rotation));
  if (!textured) {
    background(0);
  } else {
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      pixels[i]=color(0);
    }
  }
  scene.display();
  if (textured) {
    updatePixels();
  }
}
