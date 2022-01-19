north(p, k).
east(p, q).

north(k, f).
east(k, l).

north(f, a).
east(f, g).

east(a, b).

north(q, l).
east(q, r).

north(l, g).
east(l, m).

north(g, b).
east(g, h).

east(b, c).

north(r, m).
east(r, s).

north(m, h).
east(m, n).

north(h, c).
east(h, i).

east(c, d).

north(s, n).
east(s, t).

north(n, i).
east(n, o).

north(i, d).
east(i, j).

east(d, e).

north(t, o).

north(o, j).

north(j, e).

south(X, Y) :- north(Y, X).
west(X, Y) :- east(Y, X).