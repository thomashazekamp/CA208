/************************************************************
This program is for a non-self balancing 2-3 tree, the predicates that can be used are add(X, T1, T2), member(X, T), height(T, N) and prettyPrint(T)
Author: Thomas Hazekamp
Module: CA208 - Logic
************************************************************
References:
Lemnaru, C. & Potolea, R. (2018). Logic Programming: A Hands-on Approach. Cluj-Napoca. U.T. PRESS
--> The book above helped me understand how certain predicates work on binary trees, understanding their methods helped me create these predicates which work for 2-3 trees.
    add(_, _, _) & prettyPrint(_) are predicates based on subsections in chapter 7 of the detailed book above.
    Much of the mentioned code above has been heavely changed/adapted to facilitate the workings of a 2-3 tree. 
************************************************************/

/* 
Example of a 2-node: tree(3, nil, nil)
Example of a 3-node: tree(3, 4, nil, nil, nil)
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% add(X, T1, T2) is true if adding X to the 2-3 Tree T1 generates the 2-3 Tree T2

add(NewNode, tree(ParentNode, LeftChild, RightChild), tree(ParentNode, NewNode, LeftChild, nil, RightChild)) :- % The 2 node will turn into a 3 node if the node looking to be added is larger than the current only parent node
    NewNode > ParentNode, !.

add(NewNode, nil, tree(NewNode, nil, nil)). % Base case for 2 or 3 node

% For a node with 3 elements/children
add(NewNode, tree(LeftParent, RightParent, LeftChildTree, MidChildTree, RightChildTree), tree(LeftParent, RightParent, NewLeftChildTree, MidChildTree, RightChildTree)) :- % If the new node needs to be added to the left child side
    NewNode =< LeftParent,
    add(NewNode, LeftChildTree, NewLeftChildTree).

add(NewNode, tree(LeftParent, RightParent, LeftChildTree, MidChildTree, RightChildTree), tree(LeftParent, RightParent, LeftChildTree, NewMidChildTree, RightChildTree)) :- % If the new node needs to be added to the middle child side
    NewNode > LeftParent,
    NewNode =< RightParent,
    add(NewNode, MidChildTree, NewMidChildTree).

add(NewNode, tree(LeftParent, RightParent, LeftChildTree, MidChildTree, RightChildTree), tree(LeftParent, RightParent, LeftChildTree, MidChildTree, NewRightChildTree)) :- % If the new node needs to be added to the right child side
    NewNode > RightParent,
    add(NewNode, RightChildTree, NewRightChildTree).

% For a node with 2 elements/children
add(NewNode, tree(ParentNode, LeftChildTree, RightChildTree), tree(ParentNode, NewLeftChildTree, RightChildTree)) :- % If the new node needs to be added to the left child side
    NewNode =< ParentNode,
    add(NewNode, LeftChildTree, NewLeftChildTree).

add(NewNode, tree(ParentNode, LeftChildTree, RightChildTree), tree(ParentNode, LeftChildTree, NewRightChildTree)) :- % If the new node needs to be added to the right child side
    NewNode > ParentNode,
    add(NewNode, RightChildTree, NewRightChildTree).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% member(X, T) is true if X is in the 2-3 Tree T

% If the tree is a 2 node tree
member(Node, tree(Node, _, _)). % Base case to check if the node is the parent node

member(Node, tree(_, LeftChildTree, _)) :- % Using recursion to keep calling the left side of the parent (left child)
    member(Node, LeftChildTree).

member(Node, tree(_, _, RightChildTree)) :- % Using recursion to keep calling the right side of the parent (right child)
    member(Node, RightChildTree).

% If the tree is a 3 node tree
member(LeftNode, tree(LeftNode, _, _, _, _)). % Base case for the left parent
member(RightNode, tree(_, RightNode, _, _, _)). % Base case for the right parent

member(Node, tree(_, _, LeftChildTree, _, _)) :- % Using recursion to check if the node is in the left side of the parent
    member(Node, LeftChildTree).

member(Node, tree(_, _, _, MidChildTree, _)) :- % Using recursion to check if the node is in the middle side of the parent
    member(Node, MidChildTree).

member(Node, tree(_, _, _, _, RightChildTree)) :- % Using recursion to check if the node is in the right side of the parent
    member(Node, RightChildTree).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Height of a tree, height(T, N) is true if the height of T is N

height(nil, 0). % Base case, If the node is nil, then the current height is 0

height(tree(_, LeftChild, RightChild), HeightNum) :- % Calculating the height of a 2 node tree
    height(LeftChild, LeftChildHeight), height(RightChild, RightChildHeight),
    HeightNum is max(LeftChildHeight, RightChildHeight) + 1.

height(tree(_, _, LeftChild, MidChild, RightChild), HeightNum) :- % Calculating the height of a 3 node tree
    height(LeftChild, LeftChildHeight), height(MidChild, MidChildHeight), height(RightChild, RightChildHeight),
    OneMax is max(LeftChildHeight, MidChildHeight), HeightNum is max(OneMax, RightChildHeight) + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Printing a 2-3 Tree, prettyPrint(T) is always true and displays the 2-3 Tree T

prettyPrint(tree(Node, LeftChildTree, RightChildTree)) :-
    printingFullTree(tree(Node, LeftChildTree, RightChildTree), 0). % Start of printing for a 2 node parent, 0 is used to know position

prettyPrint(tree(LeftNode, RightNode, LeftChildTree, MidChildTree, RightChildTree)) :-
    printingFullTree(tree(LeftNode, RightNode, LeftChildTree, MidChildTree, RightChildTree), 0). % Start of printing for a 3 node parent, 0 is used to know position

printingFullTree(nil, _). % Base case, once it reaches 'nil'

% Recursion for a 2 node
printingFullTree(tree(Node, LeftChildTree, RightChildTree), Pos) :- % Incrementing NewPos and using Pos to know current position, used to print the nodes in correct order
    NewPos is Pos + 1,
    printingFullTree(LeftChildTree, NewPos),
    printNode(Node, Pos),
    printingFullTree(RightChildTree, NewPos).

% Recursion for a 3 node
printingFullTree(tree(LeftNode, RightNode, LeftChildTree, MidChildTree, RightChildTree), Pos) :- % Incrementing NewPos and using Pos to know current position, used to print the nodes in correct order
    NewPos is Pos + 1,
    printingFullTree(LeftChildTree, NewPos),
    printNode(LeftNode, RightNode, Pos),
    printingFullTree(MidChildTree, NewPos),
    printingFullTree(RightChildTree, NewPos).

% Printing the single parent node
printNode(Node, Pos) :-
    Pos > 0, !, NewPos is Pos - 1, write('        '), printNode(Node, NewPos).

printNode(Node, _) :- % Printing the single node followed by a new line
    write(Node), nl.

% Printing both parent nodes
printNode(LeftNode, RightNode, Pos) :- 
    Pos > 0, !, NewPos is Pos - 1, write('        '), printNode(LeftNode, RightNode, NewPos).

printNode(LeftNode, RightNode, _) :- % Printing the left and right nodes side by side followed by a new line
    write(LeftNode),
    write(','),
    write(RightNode), nl.