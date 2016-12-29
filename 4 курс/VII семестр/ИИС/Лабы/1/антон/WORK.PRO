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
 male("Max").
 male("Alex").
 male("Anton").
 male("Roma").
 female("Anna").
 female("Kate").
 female("Mary").
 female("Vika").
 female("Nika").
 female("Lida").
 married("Max","Anna").
 married("Alex","Kate").
 married("Roma","Vika").
 parents("Anton","Max","Anna").
 parents("Mary","Max","Anna").
 parents("Vika","Max","Anna").
 parents("Roma","Alex","Kate").
 parents("Nika","Alex","Kate").
 parents("Lida","Roma","Vika").
 
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
 
   