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
 
 husband(X,Y)if
  married(X,Y),
  male(X).
  
 wife(X,Y)if
  married(Y,X),
  female(X). 
  
 brother(X,Y)if
  parents(X,Father,Mother),
  parents(Y,Father,Mother),
  male(X),
  X<>Y.
  
 sister(X,Y)if
  parents(X,Father,Mother),
  parents(Y,Father,Mother),
  female(X),
  X<>Y.
 
 mother(X,Y)if
  parents(Y,_,X),
  female(X).
 
 father(X,Y)if
  parents(Y,X,_),
  male(X).
  
 grandfather(X,Y)if
  father(Z,Y),
  father(X,Z).
 grandfather(X,Y)if
  mother(Z,Y),
  father(X,Z).  
  
 grandmother(X,Y)if
  mother(Z,Y),
  mother(X,Z).
grandmother(X,Y)if
  father(Z,Y),
  mother(X,Z).
  
 aunt(X,Y)if
  sister(X,Z),
  father(Z,Y).
 aunt(X,Y)if
  sister(X,Z),
  mother(Z,Y).
  
 uncle(X,Y)if
  brother(X,Z),
  father(Z,Y).
 uncle(X,Y)if
  brother(X,Z),
  mother(Z,Y).     
  
 ancestor(X,Y)if
  father(X,Y).
 ancestor(X,Y)if
  mother(X,Y).
 ancestor(X,Y)if
  father(X,Z),
  ancestor(Z,Y).
 ancestor(X,Y)if
  mother(X,Z),
  ancestor(Z,Y).   
 
   