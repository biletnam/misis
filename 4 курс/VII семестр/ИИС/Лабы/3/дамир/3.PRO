DOMAINS
 i=integer
 listi=i*
 listii=listi*
 s=string
 lists=s*
PREDICATES
 replace(i,i,listi,listi)
 rndlist(i,i,listi)
 rndlist2(i,i,listi,i)
 listitos(listi,lists)
 itos(i,s)
 dividelist(listi,i,listi,listi)
 insert(listi,i,listi,listi) 
 inlist(i,listi,i,i)
 listinlist(listi,listi,listii)
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
 
 rndlist(M,K,L) if
   RANGE=K-M,
   random(RANGE,RND),
   N=RND+M,
   rndlist2(M,K,L,N).
 rndlist2(_,_,[],0) if
   !.
 rndlist2(M,K,[H|T],N) if
   RANGE=K-M,
   random(RANGE,RND),
   H=RND+M,
   N2=N-1,
   rndlist2(M,K,T,N2).
    
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
 dividelist(L,0,[],L) if
   !.  
 dividelist([H|T],N,[H|T1],T2) if
   N2=N-1,
   dividelist(T,N2,T1,T2).

 inlist(_,[],K,K) if
   !.  
 inlist(X,[H|T],K,N) if
   X<>H,
   inlist(X,T,K,N).
 inlist(X,[H|T],K,N) if
   X=H,
   K2=K+1,
   inlist(X,T,K2,N).   

 listinlist([A],L,L2) if
   inlist(A,L,0,B),
   L2=[[A,B]],
   !.
 listinlist([H|T],L,[H2|T2]) if
   inlist(H,L,0,B),
   H2=[H,B],
   listinlist(T,L,T2).
  
 insert(L,N,[H|T],[H|T2]) if
   N>1,
   N2=N-1,
   insert(L,N2,T,T2).
 insert([],_,L,L) if
   !.
 insert([H|T],1,L2,[H|T2]) if
   insert(T,1,L2,T2).
     
       