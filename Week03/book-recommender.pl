book(illiad, homer, study, 500).
book(c, richie, study, 150).
book(nt_bible, sams, reference, 480).
book(monty_python, cleese, comedy, 300).

buildLibrary(Lib) :- findall(book(T, A, G, S) , book(T, A, G, S), Lib). /* Title, author, genre, size */

revision_book(B):- B = book(_, _, G, S), (G == study; G == reference), S > 300.

revision(B, [B | _]):- revision_book(B).
revision(B, [_ | T]):- revision(B, T).

holiday_book(B):- B = book(_, _, G, S), G \== reference, G \== study, S < 400.

holiday(B, [B | _]):- holiday_book(B).
holiday(B, [_ | T]):- holiday(B, T).


literacy_book(B):- B = book(_, _, G, _), G == drama.

literacy(B, [B | _]):- literacy_book(B).
literacy(B, [_ | T]):- literacy(B, T).


leisure_book(B):- B = book(_, _, G, _), (G == comedy; G == fiction).

leisure(B, [B | _]):- leisure_book(B).
leisure(B, [_ | T]):- leisure(B, T).

