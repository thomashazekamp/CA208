/* if X is an element of A (list) */
myElem(X, [X | A]). /* checking if X is the head of the list */
myElem(X, [_ | A]) :- myElem(X, A). /* checking if X is part of the tail of the list*/

/* if X is the first element of A (list) */
myHead(X, [X | A]). /* checking if X is the head of the list */

/* if X is the last element of A (list) */
myLast(X, [X]). /* checking if X is the last element */
myLast(X, [_, Y]) :- myLast(X, Y). /* checking until Y is the last element */

/* if A (list) is the tail of B (list) */
myTail(A, [_ | A]).


