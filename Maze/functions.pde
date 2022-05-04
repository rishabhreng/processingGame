boolean equal(int[] a, int[] b){
 for(int i=0;i<a.length;i++){
  if(a[i]!=b[i]){
   return false; 
  }
 }
 return true;
}

boolean contains(int[] a, int b){
 for(int i=0;i<a.length;i++){
   if(a[i]==b){
    return true; 
   }
 }
 return false;
}
