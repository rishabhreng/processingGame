/*
Main Tab
  What did you expect?
  
Face
  A face is what is actually graphed and is always a triangle because a triangle determines a plane.
  
  Each face has a variable which contains its "parent" object of which it is a part.
  
  The faces also have arrays which contain three numbers which refer to the vertices of the object being graphed through the array of points in the graphed object. 
  These numbers are used to access the points after transformed versions have been made.
  
ReadMe
  This is the file you are reading.

dictionary
  This file contains the Dictionary class which is used to streamline the process of sorting the Face objects for graphing. A dictionary has arrays for faces, the
  depths (floats) of each face, and a sorted version of that array. In graphing, the dictionary is loaded with all of the faces necessary, then their depths are found
  and stored in the depths array, then the sorted array is set to be the reverse of the sorted version of the depths array. The faces are graphed by depth in the order
  of the sorted array with the help of the value(...) method which returns the face corresponding to the depth given. A boolean array labelled "graphed" is used to
  track which faces have been graphed already to prevent them from being graphed twice, which ensures that all faces are graphed exactly once.

functions
  This is a collection of functions used throughout the program. New functions meant for the entire program should be placed here.

object
  This file contains the awkwardly named Object class, the instances of which are the virtual analogues of real-world objects. Once constructed, these instances are
  not meant to be edited except in the setup of the Point objects and Face objects. When an Object object is created, it begins with an empty array for Point objects
  for its vertices, an empty array for transformed versions of its vertices, and an array for its faces, all of which are set to the correct sizes by the constructor.
  Before use, the vertex points and the faces must be specified manually or through custom functions such as the "defauls_cube(...)" function. Faces and vertex points
  are specified by setting the elemeng of the corresponging array to an instance of the Face or Point class.The vertices of an Object object are specified in relation 
  to the center of the object around which it will rotate: in its default rotation, the Object object's center is treated as the origin of a coordinate system and the 
  vertices are specified accordingly. Face elements are specified by giving three numbers which refer to the indices of Point objects in the Object object's points
  array, as well as a color and the Object object itself. The Object object's display() method is only used when the Scene is not being used. In graphing, the Object 
  object's vertex points are rotated around the object's center, then translated to the object's location in 3d space, translated again to put the camera at the 
  origin, rotated around the origin according to the camera's orientation, and those results are saved in the array "transformed." Then the dictionary of the object's
  faces and their depths (distances from the camera/origin) is made so that the faces can be graphed back-to-front.

point
  This file contains the Point class, which specifies how points work. The rules for points in this program are the same as in geometry and linear algebra, though
  the distinction between points and vectors is ignored. There are functions and methods which serve the same purposes except that the methods set the current instance
  to what would be returned by the corresponding function. If you need to add some point to one you are working with, use the method on the point you are working with.
  Similarly, do so with the other operations. If you want to keep the identities of the points you are working with while performing the calculation and using the 
  result, then use the functions.

scene
  The Scene class is meant to only have one instance which contains all of the Object objects being graphed. The scene contains an array for all of the objects and a 
  dictionary for graphing in the exact same manner as specified in the section labelled "object" above except that the dictionary is filled with all of the faces from
  all of the objects before graphing begins to allow all of the Object objects to be graphed properly (no object further away will be able to be graphed on top of an 
  object closer to the camera).

test_code
  Simply a collection of legacy code in case it is needed later.
  
Other useful information
  In this program, the x-axis is horizontal and points to the right, the y-axis is vertical and points upward, and the z-axis points directly into the screen.
  There are a few notes in the Engine_3d_3.PDE file
  Cumulative rotation mode allows Object objects to accumulate rotation over several frames and is a boolean tied to the specific objects, not a global.
  The textured mode is currently a globel boolean.
  The textures of the faces are stored in one image file to reduce the number of images which have to be loaded at the start of the program.

*/
