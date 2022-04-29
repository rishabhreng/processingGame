class Scene {
  Dictionary dict;
  Object[] objects;
  int numObjects;
  int numFaces;
  //a scene is a collection of all of the faces of all of the objects being graphed
  Scene(int numObjects) {
    this.numFaces=0;
    this.numObjects=numObjects;
    this.dict=new Dictionary(0);
    this.objects=new Object[numObjects];
  }

  //sets the dictionary of the scene much like that of an individual object
  void getdict() {
    this.numFaces=0;
    for (Object object : this.objects) {
      this.numFaces+=object.nfaces;
    }
    this.dict=new Dictionary(this.numFaces);
    int index=0;
    for (Object object : this.objects) {
      for (Face face : object.faces) {
        this.dict.faces[index]=face;
        index++;
      }
    }
    this.dict.setdepths();
    this.dict.sortDepths();
  }
  
  //places an object at a specified index in the scene, though the specific index has no influence on graphing
  void setObject(int index, Object a){
   this.objects[index]=a; 
  }

  //displays all of the faces in the scene as one would expect
  void display() {
    //generate transformed set of points
    for (Object object : this.objects) {
      object.transform();
    }
    getdict();
    for(int i=0;i<this.dict.faces.length;i++){
     if(dict.sorted[i]>0){
      dict.value(dict.sorted[i]).display(); 
     }
    }
  }
}
