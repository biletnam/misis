DOMAINS
 s=string
 file=out
DATABASE
 capital(s,s)
PREDICATES
 menu
 m(char)
 start
 cap_cou(s,s)
 cou_cap(s,s)
CLAUSES
 cap_cou(CAP,COU) if
  capital(CAP,COU),
  !.
 cap_cou(_,"No solution").
 
 cou_cap(CAP,COU) if
  capital(COU,CAP),
  !.
 cou_cap(_,"No solution").
 
 start if
   existfile("Capital.ddb"),
   !,
   consult("Capital.ddb"),
   menu.
 start if
   openwrite(out,"Capital.ddb"),
   closefile(out),
   menu.  
 
 menu if
   clearwindow,
   write("1 - CAP to COU"),nl,
   write("2 - COU to CAP"),nl,
   write("3 - New COU-CAP"),nl,
   write("4 - Change COU-CAP"),nl,
   write("0 - Exit"),nl,
   readchar(C),
   m(C).
 
 m('0') if
   save("Capital.ddb"),
   retractall(_).
 m('1') if
   clearwindow,
   write("Capital - "),nl,
   readln(CAP),
   cou_cap(CAP,COU),
   write("Country -"),nl,
   write(COU),
   readchar(_),
   menu.
 m('2') if
   clearwindow,
   write("Country - "),nl,
   readln(COU),
   cap_cou(COU,CAP),
   write("Capital - "),nl,
   write(CAP),
   readchar(_),
   menu.
 m('3') if
   clearwindow,
   write("Country - "),nl,
   readln(COU),
   write("Capital - "),nl,
   readln(CAP),
   assert(capital(COU,CAP)),
   menu.
 m('4') if
   clearwindow,
   write("Country - "),nl,
   readln(COU),
   write("Capital - "),nl,
   readln(CAP),
   retract(capital(COU,_)),
   assert(capital(COU,CAP)),
   menu.  
   
GOAL start   
     
   
   
   
           