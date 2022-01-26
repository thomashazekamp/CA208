book(illiad, homer, study, 500).
book(c, Richie, study, 150).
book(nt_bible, sams, reference, 480).
book(monty_python, cleese, comedy, 300).

buildLibrary(Lib) :- findall(book(T, A, G, S) , book(T, A, G, S), Lib). /* Title, author, genre, size */

comedy(B, L) :- book(T, A, comedy, S).