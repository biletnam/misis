DOMAINS
 person=string
PREDICATES
 male(person)
 female(person)
 married(person,person)
 husband(person,person)
 wife(person,person)
 parents(person,person,person)
 brother(person,person)
 sister(person,person)
 mother(person,person)
 father(person,person)
 grandfather(person,person)
 grandmother(person,person)
 aunt(person,person)
 uncle(person,person)
 ancestor(person,person)
CLAUSES
 male("Alex").
 male("David").
 male("Eric").
 male("Jack").
 female("Mary").
 female("Anna").
 female("Diana").
 female("Julia").
 female("Molly").
 married("Alex","Mary").
 married("David","Anna").
 married("Eric","Julia").
 parents("Diana","Alex","Mary").
 parents("Julia","Alex","Mary").
 parents("Eric","David","Anna").
 parents("Molly","David","Anna").
 parents("Jack","Eric","Julia").
 
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
 
   