DOMAINS
 num=integer
 rnum=real
 listI=num*
 listII = listI*
 
PREDICATES
 n_element(listI,num,num)
 length(listI,num)
 replace2(listI,num,num,ListI,num)
 replace(listI,num,num,listI)
 abslist(listI,listI)
 deleteall2(listI,listI)
 inlist(num,listI,num,num)
 checkmembers(listI,listI)
 poslistinlistM(listI,listI,num,num)
 poslistinlist(listI,listI,num)
 listinlist(listI,listI,listII)
CLAUSES
 
 length([],0).
 length([_|T], L) if
   length(T, L_T),
   L=L_T+1.
      
 n_element([X|_],1,X).
 n_element([_|L],N,Y) if
   N1=N-1,
   n_element(L,N1,Y).
  
 
 replace2(L,_,_,[],K) if
   length(L,K2),
   K2=K-1, 
   !.
 replace2(L,A,B,[H|T],K) if
   K<>A,
   K<>B,
   n_element(L,K,H),
   K2=K+1,
   replace2(L,A,B,T,K2). 
 replace2(L,A,B,[H|T],K) if 
   K=A,
   n_element(L,B,H),
   K2=K+1,
   replace2(L,A,B,T,K2).
 replace2(L,A,B,[H|T],K) if
   K=B,
   n_element(L,A,H),
   K2=K+1,
   replace2(L,A,B,T,K2).
 replace(L,A,B,L2) if
   replace2(L,A,B,L2,1).        
 
 abslist([],[]) if
   !. 
 abslist([H|T],[H2|T2]) if
   H2=ABS(H),
   abslist(T,T2).
   
 deleteall2([A],[A]) if
   !.
 deleteall2([A,_],[A]) if
   !.
 deleteall2([A,_|T],[A|T2]) if
   deleteall2(T,T2).
   

 inlist(_,[],K,K) if
   !.  
 inlist(X,[H|T],K,N) if
   X<>H,
   inlist(X,T,K,N).
 inlist(X,[H|T],K,N) if
   X=H,
   K2=K+1,
   inlist(X,T,K2,N).  
  
 
 checkmembers([],_) if
   !.
 checkmembers([H|T],[H2|T2]) if
   H=H2,
   checkmembers(T,T2).
 
 listinlist([A],L,L2) if
   inlist(A,L,0,B),
   L2=[[A,B]],
   !.
 listinlist([H|T],L,[H2|T2]) if
   inlist(H,L,0,B),
   H2=[H,B],
   listinlist(T,L,T2).
   
 poslistinlistM(L,L2,K,K) if
   checkmembers(L,L2),
   !.
 poslistinlistM(_,[],0,0) if
   !.  
 poslistinlistM(L,[_|T],K,N) if
   K2=K+1,
   poslistinlistM(L,T,K2,N).  
 
 poslistinlist(L,L2,N) if
   poslistinlistM(L,L2,1,N).                    