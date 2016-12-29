DOMAINS
 s=string
 file=out
DATABASE
 race(s,s)
PREDICATES
 menu
 m(char)
 start
 race_place(s,s)
 place_race(s,s)
CLAUSES
 race_place(RACE,PLACE) if
  race(RACE,PLACE),
  !.
 race_place(_,"No solution").
 
 place_race(RACE,PLACE) if
  race(PLACE,RACE),
  !.
 place_race(_,"No solution").
 
 start if
   existfile("race.ddb"),
   !,
   consult("race.ddb"),
   menu.
 start if
   openwrite(out,"race.ddb"),
   closefile(out),
   menu.  
 
 menu if
   clearwindow,
   write("1 - RACE to PLACE"),nl,
   write("2 - PLACE to RACE"),nl,
   write("3 - New PLACE-RACE"),nl,
   write("4 - Change PLACE-RACE"),nl,
   write("0 - Exit"),nl,
   readchar(C),
   m(C).
 
 m('0') if
   save("race.ddb"),
   retractall(_).
 m('1') if
   clearwindow,
   write("Race - "),nl,
   readln(RACE),
   place_race(RACE,PLACE),
   write("Place -"),nl,
   write(PLACE),
   readchar(_),
   menu.
 m('2') if
   clearwindow,
   write("Place - "),nl,
   readln(PLACE),
   race_place(PLACE,RACE),
   write("Race - "),nl,
   write(RACE),
   readchar(_),
   menu.
 m('3') if
   clearwindow,
   write("Place - "),nl,
   readln(PLACE),
   write("Race - "),nl,
   readln(RACE),
   assert(race(PLACE,RACE)),
   menu.
 m('4') if
   clearwindow,
   write("Place - "),nl,
   readln(PLACE),
   write("Race - "),nl,
   readln(RACE),
   retract(race(PLACE,_)),
   assert(race(PLACE,RACE)),
   menu.  
   
GOAL start   
     
   
   
   
           