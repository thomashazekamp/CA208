/* FACTS */

parents(david, george, noreen).
parents(jennifer, george, noreen).
parents(georgejr, george, noreen).
parents(scott, george, noreen).
parents(joanne, george, noreen).
parents(jessica, david, edel).
parents(clara, david, edel).
parents(michael, david, edel).
parents(laura, georgejr, susan).
parents(anna, scott, siobhan).


/* Relationships */

father(X, Y) :- parents(Y, X, _).
male(X) :- father(X, _).

mother(X, Y) :- parents(Y, _, X).
female(X) :- mother(X, _).

grandfather(X, Y) :- father(X, Z), father(Z, Y).
grandfather(X, Y) :- father(X, Z), mother(Z, Y).

grandmother(X, Y) :- mother(X, Z), mother(Z, Y).
grandmother(X, Y) :- mother(X, Z), father(Z, Y).

brother(X, Y) :- male(X), father(Z, X), father(Z, Y).

sister(X, Y) :- female(X), father(Z, X), father(Z, Y).

/* X is the uncle of Y, X has to be male, we then get the father (F) of Y and check if F and Y are brothers. Same thing if the parent is a female */

uncle(X, Y) :- male(X), parents(Y, F, _), brother(F, X).
uncle(X, Y) :- male(X), parents(Y, _, M), sister(M, X).

/* Note: if person does not have any children we cannot tell if they are male or female. X is the aunt of Y, we then get the father (F) of Y anch check if F is the brother of X (the possible aunt), similar thing to check if they are sisters.*/

aunt(X, Y) :- parents(Y, F, _), brother(F, X).
aunt(X, Y) :- parents(Y, _, M), sister(M, X).

/* To find if X and Y are cousins we need to get the parents and check if any of the parents are sibligs */

cousin(X, Y) :- parents(X, F, M), parents(Y, F2, M2), (brother(F, F2); brother(F, M2); sister(M, F2); sister(M, M2)).
