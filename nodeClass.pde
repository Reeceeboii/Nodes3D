int[] directions = {-2,-1,1,2}; // possible directions for the nodes
int nodeSize = 5; // size of each node object of type Node 

/*
Each node has its own instance variables for speed, direction and position
This allows them to move independently of each other
*/

class Node{
  float nodeX;
  float nodeY;
  float nodeZ;

  int xDirection;
  int yDirection;
  int zDirection;
 
  float xSpeed;
  float ySpeed;
  float zSpeed;

  Node(){ // node object construtor
    nodeX = random(-(cubeAreaSize/2), (cubeAreaSize/2));
    nodeY = random(-(cubeAreaSize/2), (cubeAreaSize/2));
    nodeZ = random(-(cubeAreaSize/2), (cubeAreaSize/2));

    xDirection = directions[int(random(4))];
    yDirection = directions[int(random(4))];
    zDirection = directions[int(random(4))];

    xSpeed = random(.3, .6);
    ySpeed = random(.3, .6);
    zSpeed = random(.3, .6);
  }
  
  void render3D(){ // rendering the nodes in 3D space
    textSize(40);
    String message = str(cubeAreaSize);
    text(message, 0-(textWidth(message)/2), 0); // cube volume message in center of cube
    
    pushMatrix(); // push the current transformation matrix onto the matrix stack
    translate(nodeX, nodeY, nodeZ); // 3D translation to X, Y and Z
    sphere(nodeSize); // renders the invking node object at its instance variable's X, Y and Z
    popMatrix(); // pop the previously pushed matrix from the stack
  }
  
  void move(){ // method to move a node around the cube
    // the three following if statements keep the nodes inside the cube

    if(nodeX > (cubeAreaSize/2) || nodeX < -(cubeAreaSize/2)){ // X axis constraint
      xDirection *= -1;
    }
    if(nodeY > (cubeAreaSize/2) || nodeY < -(cubeAreaSize/2)){ // Y axis constraint
      yDirection *= -1;
    }
    if(nodeZ > (cubeAreaSize/2) || nodeZ < -(cubeAreaSize/2)){ // Z axis constraint
      zDirection *= -1; 
    }
    nodeX += (xSpeed * xDirection); // moves node in X direction
    nodeY += (ySpeed * yDirection); // moves node in Y direction
    nodeZ += (zSpeed * zDirection); // moves node in Z direction
  }

  void adjustPosForResize(){ 
    // keeps nodes within cube when W or S used to change volume
    // these are calculated on the basis that origin [0,0,0] is the center of the cube

    // keeps nodes inside the cube if they exceed the maximum X (half of cube width)
    if(nodeX > (cubeAreaSize/2)){
      while(nodeX > (cubeAreaSize/2)){
        nodeX --;
      }
    }
    // keeps nodes inside the cube if they exceed the minimum X (negative half of cube width)
    if(nodeX < -(cubeAreaSize/2)){
      while(nodeX < -(cubeAreaSize/2)){
        nodeX ++;
      }
    }
    // keeps nodes inside the cube if they exceed the maximum Y (half of cube height)
    if(nodeY > (cubeAreaSize/2)){
      while(nodeY > (cubeAreaSize/2)){
        nodeY --;
      }
    }
    // keeps nodes inside the cube if they exceed the minimum Y (negative half of cube height)
    if(nodeY < -(cubeAreaSize/2)){
      while(nodeY < -(cubeAreaSize/2)){
        nodeY ++;
      }
    }
    // keeps nodes inside the cube if they exceed the maximum Z (half of cube depth)
    if(nodeZ > (cubeAreaSize/2)){
      while(nodeZ > (cubeAreaSize/2)){
        nodeZ --;
      }
    }
    // keeps nodes inside the cube if they exceed the minimum Z (negative half of cube depth)
    if(nodeZ < -(cubeAreaSize/2)){
      while(nodeZ < -(cubeAreaSize/2)){
        nodeZ ++;
      }
    }
  }
}