DOMAINS
 int=integer
 listI= integer*
PREDICATES
 member3(int,listI)
 intersection(listI,listI,listI)
 intersection2(listI,listI,listI)
 minus(listI,listI,listI)
 union(listI,listI,listI)
 subset(listI,listI)
 subsetU(listI,listI)

 sublist(listI,listI)
 conc(listI,listI,listI)
 permutation(listI,listI)
 del(int,listI,listI)
CLAUSES

 member3(X,[X|_]) if
   !.
 member3(X,[_|T]) if
   member3(X,T).
 
 intersection([],_,[]).
 intersection([H|T1],S2,[H|T]) if
   member3(H,S2),
   !,
   intersection(T1,S2,T).
 intersection([_|T],S2,S) if
   intersection(T,S2,S).
   
 minus([],_,[]).
 minus([H|T],S2,S) if
   member3(H,S2),
   !,
   minus(T,S2,S).
 minus([H|T],S2,[H|S]) if
   minus(T,S2,S).
   
 intersection2(A,B,S) if
   minus(A,B,A_B),
   minus(A,A_B,S).    
 
 subset([],_).
 subset([H|T],S) if
   member3(H,S),
   subset(T,S).
   
 union([],S2,S2).
 union([H|T],S2,S) if
   member3(H,S2),
   !,
   union(T,S2,S).
 union([H|T],S2,[H|S]) if
   union(T,S2,S).
   
 subsetU(A,B) if
   union(A,B,B).

sublist(L0,L) if
    conc(L1,L2,L),
    conc(L3,L0,L1).

 conc([],L,L).
 conc([H|T],L,[H|T1]) if 
   conc(T,L,T1).

 permutation([],[]).
 permutation(L,[X|P]) if
    del(X,L,L1),
    permutation(L1,P).

 del(X,[X|T],T).
 del(X,[Y|T],[Y|T1]) if 
    del(X,T,T1).