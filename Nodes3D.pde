/*
Nodes3D
Reece Mercer 2018
City, University of London
*/


int nodeCount = 55; // number of nodes to be rendered
int bgNodeCount = 25; // number of secondary nodes to be rendered

Node[] nodeArr = new Node[nodeCount];  // array of node objects
bgNode[] bgNodeArr = new bgNode[bgNodeCount]; // array of secondary node objects

int cubeAreaSize = 500; // initial size of cube
int totalConnections = 0; // keeps track of total connections between nodes

int zoom = 650; // level of zoom
boolean paused = false; // tracks whether the sketch has been paused or not


void setup(){
  size(displayWidth, displayHeight, P3D);
  frameRate(60);
  
  // creates new node objects for the amount of nodes specified
  for(int node = 0; node < nodeCount; node++){
    nodeArr[node] = new Node();
  }
  // creates new secondary node objects for the amount of secondary nodes specified
  for(int i = 0; i < bgNodeCount; i++){
  	bgNodeArr[i] = new bgNode();
  }
}


void draw(){
  background(100);
  infoDisplay(); // displays live info
  camera(mouseX, mouseY, zoom, width/2, height/2, 0, 0, 1, 0); // camera linked to mouse X and Y
  translate(width/2, height/2, -100); // moves the center of the cube
  strokeWeight(2);
  stroke(255);
  noFill();
  box(cubeAreaSize); // 3D cube size of cubeAreaSize

  // primary nodes
  if(nodeCount != 0){
    renderPrimary();
  }
  // secondary nodes
  if(bgNodeCount != 0){
    renderSecondary();
  }
}


void renderPrimary(){ 
  /*
  method to render and move the white nodes. A nested loop goes through every node object
  in the object array and compares it to every other node in the object array (aside from itself).
  It then calculates a distance between itself and the other node and if this distance is less than 150,
  a line is drawn between them for as long as the distance remains so.
  */

  for(int i = 0; i < nodeCount; i++){
    for(int j = 0; j < nodeCount; j++){
      if(i != j){
        float distance = dist(nodeArr[i].nodeX, nodeArr[i].nodeY, nodeArr[i].nodeZ, nodeArr[j].nodeX, nodeArr[j].nodeY, nodeArr[j].nodeZ);
          if(distance < 150){
            totalConnections ++;
            stroke(255-distance, 0, 0);
            line(nodeArr[i].nodeX, nodeArr[i].nodeY, nodeArr[i].nodeZ, nodeArr[j].nodeX, nodeArr[j].nodeY, nodeArr[j].nodeZ);
            stroke(255);
          }
      }
    }
    totalConnections --;
  }
  if(paused != true){ // if not paused, render & move
    for(Node node : nodeArr){
      node.render3D();
      node.move();      
    }
  }else{ // if paused, just render w/o moving nodes
    for(Node node : nodeArr){
      node.render3D();
    }
  }
}


void renderSecondary(){
  // exactly the same loop structure, but for the secondary nodes
  for(int i = 0; i < bgNodeCount; i++){
    for(int j = 0; j < bgNodeCount; j++){
      if(i != j){
        float distance = dist(bgNodeArr[i].nodeX, bgNodeArr[i].nodeY, bgNodeArr[i].nodeZ, bgNodeArr[j].nodeX, bgNodeArr[j].nodeY, bgNodeArr[j].nodeZ);
        if(distance < 150){
          totalConnections ++;
          stroke(0, 0 , 255-distance);
          line(bgNodeArr[i].nodeX, bgNodeArr[i].nodeY, bgNodeArr[i].nodeZ, bgNodeArr[j].nodeX, bgNodeArr[j].nodeY, bgNodeArr[j].nodeZ);
          stroke(0);
        }
      }
    }
    totalConnections --;      
  }
  if(paused != true){ // if not paused, render & move
    for (bgNode secondaryNode : bgNodeArr){
      stroke(0);
      secondaryNode.render3D();
      secondaryNode.move();
    }
  }else{ // if paused, just render w/o moving nodes
    for(bgNode secondaryNode : bgNodeArr){
      secondaryNode.render3D();
    }
  }
}


void infoDisplay(){
  translate(width/2, height/2, -100);

  totalConnections = totalConnections/2;

  String message = ("Connections: " + str(totalConnections));
  textSize(30);
  text(message, 0 - (textWidth(message)/2), -(cubeAreaSize/2) - 10, (cubeAreaSize/2));
  totalConnections = 0;

  textSize(20);
  text("W: Increase cube area", (cubeAreaSize/2)+10, 0, cubeAreaSize/2);
  text("S: Decrease cube area", (cubeAreaSize/2)+10, 20, cubeAreaSize/2);
  text("Right or left click: Pause", (cubeAreaSize/2)+10, 40, cubeAreaSize/2);
  text("Scroll wheel: Zoom", (cubeAreaSize/2)+10, 60, cubeAreaSize/2);
}


void mouseWheel(MouseEvent event){ // adjusts zoom via the scroll wheel
  float e = event.getCount();
  zoom += e * 30;
}


void keyPressed(){
  if(key == 's' && cubeAreaSize > 100){ // shrinks cube volume
    cubeAreaSize -= 20;
    for(Node node : nodeArr){
      node.adjustPosForResize(); // keeps nodes within the boundaries
    }
    for(bgNode secondaryNode : bgNodeArr){
      secondaryNode.adjustPosForResize();
    }
  }else if(key == 'w' && cubeAreaSize < 800){ // increases cube volume
    cubeAreaSize += 20;
  }
}


void mousePressed(){ // pauses or unpauses on a mouse click
  paused = !paused; // reverses pause state. Paused becomes unpaused and unpaused becomes paused
}
