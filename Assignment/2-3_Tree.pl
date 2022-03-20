/* This program is for a non-self balancing 2-3 tree */

/* tree(4, tree(3, nil, nil), tree(8, nil, nil)). */
tree(3, nil, nil).

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

present(LeftKey, tree(LeftKey, _, _, _, _)). % base case
present(RightKey, tree(_, RightKey, _, _, _)). % base case

present(Key, tree(_, _, LeftSubTree, _, _)) :-
    present(Key, LeftSubTree).

present(Key, tree(_, _, _, MidSubTree, _)) :-
    present(Key, MidSubTree).

present(Key, tree(_, _, _, _, RightSubTree)) :-
    present(Key, RightSubTree).

% Inserting

inserting(Key, nil, tree(Key, nil, nil)).

inserting(Key, tree(Root, LeftSubTree, RightSubTree), tree(Root, NewLeftSubTree, RightSubTree)) :-
    Key < Root,
    inserting(Key, LeftSubTree, NewLeftSubTree).

inserting(Key, tree(Root, LeftSubTree, RightSubTree), tree(Root, LeftSubTree, NewRightSubTree)) :-
    Key > Root,
    inserting(Key, RightSubTree, NewRightSubTree).

