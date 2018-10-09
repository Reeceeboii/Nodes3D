# Nodes3D
A 3D 'network' effect using 3D libraries in Processing.
This is a sketch that, in essence, creates nodes (3D spheres) within a defined volume of space (a cube).
These nodes move around the cube randomly, and bounce off the edges when they hit them. When a node of one of
the two colours comes within a certain vicinity of another node of the same color, a visible connection
is formed as long as the distance between them remains below the threshold defined in the code.

It contains some interactivity, the instructions for which are shown on-screen during runtime.

There are 2 separate classes of Node objects, one for the nodes forming the red connections (the superclass), and a subclass for the nodes forming the blue connections. They essentially behave in exactly the same way, but as stated above, they can only form connections with other nodes of the same color.

![alt text](https://raw.githubusercontent.com/Reeceeboii/Nodes3D/master/img/image1.PNG)
![alt text](https://raw.githubusercontent.com/Reeceeboii/Nodes3D/master/img/image2.PNG)
