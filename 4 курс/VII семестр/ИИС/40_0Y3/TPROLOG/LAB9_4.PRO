DOMAINS
 s=string
 file=out
DATABASE
 book(s,s)
PREDICATES
 menu
 m(char)
 start
 book_autor(s,s)
 autor_book(s,s)
CLAUSES
 book_autor(BOOK,AUTOR) if
  book(BOOK,AUTOR),
  !.
 book_autor(_,"No solution").
 
 autor_book(AUTOR,BOOK) if
  book(BOOK,AUTOR),
  !.
 autor_book(_,"No solution").
 
 start if
   existfile("Book.ddb"),
   !,
   consult("Book.ddb"),
   menu.
 start if
   openwrite(out,"Book.ddb"),
   closefile(out),
   menu.  
 
 menu if
   clearwindow,
   write("1 - AUTOR to BOOK"),nl,
   write("2 - BOOK to AUTOR"),nl,
   write("3 - New BOOK-AUTOR"),nl,
   write("4 - Change BOOK-AUTOR"),nl,
   write("0 - Exit"),nl,
   readchar(C),
   m(C).
 
 m('0') if
   save("Book.ddb"),
   retractall(_).
 m('1') if
   clearwindow,
   write("AUTOR - "),nl,
   readln(AUTOR),
   autor_book(AUTOR,BOOK),
   write("BOOK -"),nl,
   write(BOOK),
   readchar(_),
   menu.
 m('2') if
   clearwindow,
   write("BOOK - "),nl,
   readln(BOOK),
   book_autor(BOOK,AUTOR),
   write("AUTOR - "),nl,
   write(AUTOR),
   readchar(_),
   menu.
 m('3') if
   clearwindow,
   write("BOOK - "),nl,
   readln(BOOK),
   write("AUTOR - "),nl,
   readln(AUTOR),
   assert(book(BOOK,AUTOR)),
   menu.
 m('4') if
   clearwindow,
   write("BOOK - "),nl,
   readln(BOOK),
   write("AUTOR - "),nl,
   readln(AUTOR),
   retract(book(BOOK,_)),
   assert(book(BOOK,AUTOR)),
   menu.  
   
GOAL start   
     
   
   
   
           