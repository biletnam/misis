DOMAINS
 s=string
 file=out
DATABASE
 enru(s,s)
PREDICATES
 menu
 m(char)
 start
 EN_RU(s,s)
 RU_EN(s,s)
CLAUSES
 EN_RU(EN,RU) if
  enru(EN,RU),
  !.
 EN_RU(_,"No solution").
 
 RU_EN(RU,EN) if
  enru(EN,RU),
  !.
 RU_EN(_,"No solution").
 
 start if
   existfile("Dic.ddb"),
   !,
   consult("Dic.ddb"),
   menu.
 start if
   openwrite(out,"Dic.ddb"),
   closefile(out),
   menu.  
 
 menu if
   clearwindow,
   write("1 - RU to EN"),nl,
   write("2 - EN to RU"),nl,
   write("3 - New EN-RU"),nl,
   write("4 - Change EN-RU"),nl,
   write("0 - Exit"),nl,
   readchar(C),
   m(C).
 
 m('0') if
   save("Dic.ddb"),
   retractall(_).
 m('1') if
   clearwindow,
   write("RU - "),nl,
   readln(RU),
   RU_EN(RU,EN),
   write("EN -"),nl,
   write(EN),
   readchar(_),
   menu.
 m('2') if
   clearwindow,
   write("EN - "),nl,
   readln(EN),
   EN_RU(EN,RU),
   write("RU - "),nl,
   write(RU),
   readchar(_),
   menu.
 m('3') if
   clearwindow,
   write("EN - "),nl,
   readln(EN),
   write("RU - "),nl,
   readln(RU),
   assert(enru(EN,RU)),
   menu.
 m('4') if
   clearwindow,
   write("EN - "),nl,
   readln(EN),
   write("RU - "),nl,
   readln(RU),
   retract(enru(EN,_)),
   assert(enru(EN,RU)),
   menu.  
   
GOAL start   
     
   
   
   
           