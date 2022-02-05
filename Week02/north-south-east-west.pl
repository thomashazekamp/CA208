/* FACTS */

north(p, k).
north(k, f).
north(f, a).
north(q, l).
north(l, g).
north(g, b).
north(r, m).
north(m, h).
north(h, c).
north(s, n).
north(n, i).
north(i, d).
north(t, o).
north(o, j).
north(j, e).

east(p, q).
east(k, l).
east(f, g).
east(a, b).
east(q, r).
east(l, m).
east(g, h).
east(b, c).
east(r, s).
east(m, n).
east(h, i).
east(c, d).
east(s, t).
east(n, o).
east(i, j).
east(d, e).

south(X, Y) :- north(Y, X).
west(X, Y) :- east(Y, X).

due_north(X, Y):- north(X, Y).
due_north(X, Y):- north(X, Z), due_north(Z, Y).

due_south(X, Y):- south(X, Y).
due_south(X, Y):- south(X, Z), due_south(Z, Y).

due_west(X, Y):- west(X, Y).
due_west(X, Y):- west(X, Z), due_west(Z, Y).

due_east(X, Y):- east(X, Y).
due_east(X, Y):- east(X, Z), due_east(Z, Y).

due_north_west(X, Y):- due_north(X, Z), due_west(Z, Y).
due_north_east(X, Y):- due_north(X, Z), due_east(Z, Y).

due_south_west(X, Y):- due_south(X, Z), due_west(Z, Y).
due_south_east(X, Y):- due_south(X, Z), due_east(Z, Y).
