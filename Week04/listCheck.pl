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

/* if list C is list B appended to thend of list A, myAppend(A, B, C) */
myAppend([ ], B, B). /* Appending to an empty list */
myAppend([H | T], B, [H | C]) :- myAppend(T, B, C).

/* if list A is the reverse of list B, Note: solution from Dr. David Sinclair DCU School of Computing*/
myReverse([ ], [ ]). /* Checking empty lists */
myReverse([H | T], B) :- myReverse(T, T1), myAppend(T1, [H], B)

/* if list B is list A with the first occurrence of X removed, myDelete(X, A, B)*/
myDelete(X, [X | B], B).
myDelete(X, [Y | T], [Y | L]) :- myDelete(X, T, L).