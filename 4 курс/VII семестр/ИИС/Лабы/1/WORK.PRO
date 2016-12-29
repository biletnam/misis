DOMAINS
 s=string
PREDICATES
 male(s)
 female(s)
 married(s,s)
 husband(s,s)
 wife(s,s)
 parents(s,s,s)
 brother(s,s)
 sister(s,s)
 mother(s,s)
 father(s,s)
 grandfather(s,s)
 grandmother(s,s)
 aunt(s,s)
 uncle(s,s)
 ancestor(s,s)
CLAUSES
 male("Anton").
 male("James").
 male("Andrey").
 male("Alex").
 male("Tom").
 female("Nicole").
 female("Maria").
 female("Kate").
 female("Elena").
 married("Anton","Nicole").
 married("James","Maria").
 married("Alex","Kate").
 parents("Andrey","Anton","Nicole").
 parents("Kate","Anton","Nicole").
 parents("Alex","James","Maria").
 parents("Elena","Alex","Kate").
 parents("Tom","Alex","Kate").
 
 husband(X,Y):-
  married(X,Y),
  male(X).
  
 wife(X,Y):-
  married(Y,X),
  female(X). 
  
 brother(X,Y):-
  parents(X,Father,Mother),
  parents(Y,Father,Mother),
  male(X).
  
 sister(X,Y):-
  parents(X,Father,Mother),
  parents(Y,Father,Mother),
  female(X).
 
 mother(X,Y):-
  parents(Y,Father,X),
  female(X).
 
 father(X,Y):-
  parents(Y,X,Mother),
  male(X).
  
 grandfather(X,Y):-
  father(Z,Y),
  father(X,Z).  
  
 grandmother(X,Y):-
  mother(Z,Y),
  mother(X,Z).
  
 aunt(X,Y):-
  sister(X,Z),
  father(Z,Y).
 aunt(X,Y):-
  sister(X,Z),
  mother(Z,Y).
  
 uncle(X,Y):-
  brother(X,Z),
  father(Z,Y).
 uncle(X,Y):-
  brother(X,Z),
  mother(Z,Y).     
  
 ancestor(X,Y):-
  father(X,Y).
 ancestor(X,Y):-
  mother(X,Y).
 ancestor(X,Y):-
  father(X,Z),
  ancestor(Z,Y).
 ancestor(X,Y):-
  mother(X,Z),
  ancestor(Z,Y).   
 
   