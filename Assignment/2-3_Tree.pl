/* This program is for a non-self balancing 2-3 tree */

/* tree(4, tree(3, nil, nil), tree(8, nil, nil)). */
test(tree(3, nil, nil, nil, nil)).

/* Base case, if the element is the root */
in(X, tree(X, _, _)).

/* Check if the node or leaf is in the left subtree */
in(X, tree(Y, L, _)) :- X =< Y, in(X, L).

/* Check if the node or leaf is in the right subtree */
in(X, tree(_, _, R)) :- in(X, R).

/* Adding a node or leaf to the tree */
addnode(X, nil, tree(X, nil, nil)).

addnode(X, tree(L, Y, R), tree(L1, Y, R)) :- X =< Y, addnode(X, L, L1).

addnode(X, tree(L, Y, R), tree(L, Y, R1)) :- addnode(X, R, R1).

/* True if adding X to the 2-3 tree T1 generates the 2-3 tree T2 */
/* add(X, T1, T2). */

add(X, T1, T2) :- addnode(X, nill, nil), T1 == T2.

/* If the tree is a 2 node tree */

present(Key, tree(Key, _, _)).

present(Key, tree(_, LeftSubTree, _)) :-
    present(Key, LeftSubTree).

present(Key, tree(_, _, RightSubTree)) :-
    present(Key, RightSubTree).

/* If the tree is a 3 node tree */

present(LeftKey, tree(LeftKey, _, _, _, _)). % base case
present(RightKey, tree(_, RightKey, _, _, _)). % base case

present(Key, tree(_, _, LeftSubTree, _, _)) :-
    present(Key, LeftSubTree).

present(Key, tree(_, _, _, MidSubTree, _)) :-
    present(Key, MidSubTree).

present(Key, tree(_, _, _, _, RightSubTree)) :-
    present(Key, RightSubTree).

/* Inserting */

inserting(Key, nil, tree(Key, nil, nil)).

inserting(Key, tree(Root, LeftSubTree, RightSubTree), tree(Root, NewLeftSubTree, RightSubTree)) :-
    Key < Root,
    inserting(Key, LeftSubTree, NewLeftSubTree).

inserting(Key, tree(Root, LeftSubTree, RightSubTree), tree(Root, LeftSubTree, NewRightSubTree)) :-
    Key > Root,
    inserting(Key, RightSubTree, NewRightSubTree).

/* Height of a tree */

height(nil, 0).

height(tree(_, L, R), H) :-
    height(L, LH), height(R, RH), H is max(LH, RH) + 1.

height(tree(_, _, L, M, R), H) :-
    height(L, LH), height(M, MH), height(R, RH), OneMax is max(LH, MH), H is max(OneMax, RH) + 1.

/* Printing a tree */

prettyPrint(nil, _).
prettyPrint(tree(Key, LST, RST), D) :- D1 is D + 1, prettyPrint(LST, D1), printKey(Key, D), prettyPrint(RST, D1).

printKey(Key, D) :- D > 0, !, D1 is D - 1, write('\t'), printKey(Key, D1).
printKey(Key, _) :- write(Key), nl.