class Dictionary {
  float[] depths;
  Face[] faces;
  float[] sorted;
  boolean[] graphed;
  Dictionary(int size) {//dictionary element
    depths=new float[size];
    faces=new Face[size];
    sorted=new float[size];
    graphed=new boolean[size];
  }

  void setdepths() {
    for (int i=0; i<depths.length; i++) {//sets the depths list based on the depths of the centers of the faces in the face list
      if(!perspective){
      depths[i]=faces[i].center().z;
      }else{
        if(faces[i].numVerticesBehindCamera()<3){
        depths[i]=faces[i].center().distance();
        }else{
         depths[i]=-faces[i].center().distance(); 
        }
      }
    }
    for(int i=0;i<graphed.length;i++){
     graphed[i]=false; 
    }
  }
  
  Face value(float k){//returns the face which has the specified depth
    for(int i=0;i<depths.length;i++){
     if (depths[i]==k && graphed[i]==false){
      graphed[i]=true;
      return faces[i]; 
     }
    }
    return null;
  }
  
  void sortDepths(){//makes a sorted version of the depths list while keeping the depths list intact
    this.sorted=reverse(sort(depths));
  }
}
