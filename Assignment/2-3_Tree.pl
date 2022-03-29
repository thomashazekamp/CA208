/* This program is for a non-self balancing 2-3 tree */

/* If the tree is a 2 node tree */

present(Node, tree(Node, _, _)).

present(Node, tree(_, LeftSubTree, _)) :-
    present(Node, LeftSubTree).

present(Node, tree(_, _, RightSubTree)) :-
    present(Node, RightSubTree).

/* If the tree is a 3 node tree */

present(LeftNode, tree(LeftNode, _, _, _, _)). % base case
present(RightNode, tree(_, RightNode, _, _, _)). % base case

present(Node, tree(_, _, LeftSubTree, _, _)) :-
    present(Node, LeftSubTree).

present(Node, tree(_, _, _, MidSubTree, _)) :-
    present(Node, MidSubTree).

present(Node, tree(_, _, _, _, RightSubTree)) :-
    present(Node, RightSubTree).

/* Add(X, T1, T2) is true if adding X to the 2-3 Tree T1 generates the 2-3 Tree T2 */

inserting(NewNode, tree(ParentNode, LeftChild, RightChild), tree(ParentNode, NewNode, LeftChild, nil, RightChild)) :- % The 2 node will turn into a 3 node if the node looking to be added is larger than the current only parent node
    NewNode > ParentNode, !.

inserting(NewNode, nil, tree(NewNode, nil, nil)). % Base case for 2 or 3 node tree

% For a node with 3 elements

inserting(NewNode, tree(LeftParent, RightParent, LeftChildTree, MidChildTree, RightChildTree), tree(LeftParent, RightParent, NewLeftChildTree, MidChildTree, RightChildTree)) :- % If the new node needs to be added to the left child side
    NewNode =< LeftParent,
    inserting(NewNode, LeftChildTree, NewLeftChildTree).

inserting(NewNode, tree(LeftParent, RightParent, LeftChildTree, MidChildTree, RightChildTree), tree(LeftParent, RightParent, LeftChildTree, NewMidChildTree, RightChildTree)) :- % If the new node needs to be added to the middle child side
    NewNode > LeftParent,
    NewNode =< RightParent,
    inserting(NewNode, MidChildTree, NewMidChildTree).

inserting(NewNode, tree(LeftParent, RightParent, LeftChildTree, MidChildTree, RightChildTree), tree(LeftParent, RightParent, LeftChildTree, MidChildTree, NewRightChildTree)) :- % If the new node needs to be added to the right child side
    NewNode > RightParent,
    inserting(NewNode, RightChildTree, NewRightChildTree).

% For a node with 2 elements

inserting(NewNode, tree(ParentNode, LeftChildTree, RightChildTree), tree(ParentNode, NewLeftChildTree, RightChildTree)) :- % If the new node needs to be added to the left child side
    NewNode =< ParentNode,
    inserting(NewNode, LeftChildTree, NewLeftChildTree).

inserting(NewNode, tree(ParentNode, LeftChildTree, RightChildTree), tree(ParentNode, LeftChildTree, NewRightChildTree)) :- % If the new node needs to be added to the right child side
    NewNode > ParentNode,
    inserting(NewNode, RightChildTree, NewRightChildTree).


/* Height of a tree, height(T, N) is true if the height of T is N */

height(nil, 0). % Base case, If the node is nil, then the current height is 0

height(tree(_, LeftChild, RightChild), HeightNum) :- % Calculating the height of a 2 node tree
    height(LeftChild, LeftChildHeight), height(RightChild, RightChildHeight),
    HeightNum is max(LeftChildHeight, RightChildHeight) + 1.

height(tree(_, _, LeftChild, MidChild, RightChild), HeightNum) :- % Calculating the height of a 3 node tree
    height(LeftChild, LeftChildHeight), height(MidChild, MidChildHeight), height(RightChild, RightChildHeight),
    OneMax is max(LeftChildHeight, MidChildHeight), HeightNum is max(OneMax, RightChildHeight) + 1.

/* Printing a 2-3 Tree, prettyPrint(T) is always true and displays the 2-3 Tree T */

prettyPrint(tree(Node, LeftChildTree, RightChildTree)) :-
    printingFullTree(tree(Node, LeftChildTree, RightChildTree), 0). % Start of printing for a 2 node parent
prettyPrint(tree(LeftNode, RightNode, LeftChildTree, MST, RightChildTree)) :-
    printingFullTree(tree(LeftNode, RightNode, LeftChildTree, MST, RightChildTree), 0). % Start of printing for a 3 node parent

printingFullTree(nil, _).

printingFullTree(tree(Node, LeftChildTree, RightChildTree), Pos) :-
    NewPos is Pos + 1,
    printingFullTree(LeftChildTree, NewPos),
    printNode(Node, Pos),
    printingFullTree(RightChildTree, NewPos).

printingFullTree(tree(LeftNode, RightNode, LeftChildTree, MST, RightChildTree), Pos) :-
    NewPos is Pos + 1,
    printingFullTree(LeftChildTree, NewPos),
    printNode(LeftNode, RightNode, Pos),
    printingFullTree(MST, NewPos),
    printingFullTree(RightChildTree, NewPos).

printNode(Node, Pos) :-
    Pos > 0, !, NewPos is Pos - 1, write('\t'), printNode(Node, NewPos).

printNode(Node, _) :- write(Node), nl.

printNode(LeftNode, RightNode, Pos) :- Pos > 0, !, NewPos is Pos - 1, write('\t'), printNode(LeftNode, RightNode, NewPos).

printNode(LeftNode, RightNode, _) :- write(LeftNode), write(','), write(RightNode), nl.