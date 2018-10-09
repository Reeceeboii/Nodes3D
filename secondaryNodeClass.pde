class bgNode extends Node{
}

/*
This class is inheriting from the Node superclass,
it allows the creation of identical nodes.
These nodes are a different color and can only form
connections with other nodes from this class.
Therefore the superclass and child class create 2 
seperate kinds of nodes.

No polymorphism of methods used as the only difference these nodes have
is a different color, and this can be easily achieved by one 
fill() command during the draw method.

This seems very empty but is required for the sketch to function.
*/
