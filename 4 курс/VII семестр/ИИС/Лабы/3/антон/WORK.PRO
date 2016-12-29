DOMAINS
 i=integer
 listi=i*
 s=string
 lists=s*
PREDICATES
 replace(i,i,listi,listi)
 del(listi,listi)
 listitos(listi,lists)
 itos(i,s)
 sublist(listi,i,listi)
 conc(listi,listi,listi)
 slideleft(listi,listi)
 lastel(listi,i)
 dellastel(listi,listi)
 slideright(listi,listi)
 insert(listi,i,listi,listi) 
CLAUSES
 replace(A,A,X,X) if
   !.
 replace(A,B,[A|T],[B|T2]) if
   replace(A,B,T,T2).
 replace(A,B,[X|T],[X|T2]) if
   X<>A,
   replace(A,B,T,T2).  
 replace(_,_,[],[]) if
   !.    
 
 del([A],[A]) if
   !.
 del([_,A],[A]) if
   !.
 del([H|T],[H|T2]) if
   del(T,T2).   
   
 itos(0,"zero").
 itos(1,"one").
 itos(2,"two").
 itos(3,"three").
 itos(4,"four").
 itos(5,"five").
 itos(6,"six").
 itos(7,"seven").
 itos(8,"eight").
 itos(9,"nine").
 
 listitos([],[]) if
   !.
 listitos([H|T],[H2|T2]) if
   itos(H,H2),
   listitos(T,T2).   
 
 sublist(L,1,L) if
   !.
 sublist([_|T],K,T2) if
   K>1,
   K2=K-1,
   sublist(T,K2,T2).
 
 conc([],L,L).
 conc([H|T],L,[H|T1]) if
   conc(T,L,T1).  
 
 slideleft([H|T],L) if
   L1=[H],
   conc(T,L1,L).
   
 lastel([A],A) if
   !.
 lastel([_|T],X) if
   lastel(T,X).
   
 dellastel([_],[]) if
   !.
 dellastel([H|T],[H|T2]) if
   dellastel(T,T2).
   
 slideright(L1,L2) if
   lastel(L1,A),
   L=[A],
   dellastel(L1,B),
   conc(L,B,L2).

 insert(L,N,[H|T],[H|T2]) if
   N>1,
   N2=N-1,
   insert(L,N2,T,T2).
 insert([],_,L,L) if
   !.
 insert([H|T],1,L2,[H|T2]) if
   insert(T,1,L2,T2).                  