DOMAINS
 s=symbol
 int=integer
 listI=integer*
 listS=s*
PREDICATES
 deletelastel(listI,listI)
 deletelast(listI,int,listI)
 rndlist(int,listI)
 rimnum(int,s).
 rimnumlist(listI,listS)
 delduo(listI,listI)
 listMN(listI,int,int,listI)
CLAUSES 
 deletelastel([_],[]) if
   !.
 deletelastel([H|T],[H|L]) if
   deletelastel(T,L).
   
 deletelast(L,0,L) if
   !.
 deletelast(L,N,L3) if
   deletelastel(L,L2),
   N2=N-1,
   deletelast(L2,N2,L3).
   
 rndlist(0,[]) if
   !.
 rndlist(K,[H|T]) if
   random(100,H),
   K2=K-1,
   rndlist(K2,T).
   
 rimnum(1,"I").
 rimnum(2,"II").
 rimnum(3,"III").
 rimnum(4,"IV").
 rimnum(5,"V").
 rimnum(6,"VI").
 rimnum(7,"VII").
 rimnum(8,"VIII").
 rimnum(9,"IX").
 rimnum(10,"X").
 
 rimnumlist([],[]) if
   !.
 rimnumlist([H|T],[H2|T2]) if
   rimnum(H,H2),
   rimnumlist(T,T2).
   
 delduo([],[]) if
   !.
 delduo([H,H|T],[H|T2]) if
   delduo(T,T2),
   !.
 delduo([H|T],[H|T2]) if
   delduo(T,T2).  
   
 listMN([_|T],M,N,L2) if
   M>1,
   M2=M-1,
   N2=N-1,
   listMN(T,M2,N2,L2).
 listMN([H|T],1,N,[H|T2]) if
   N2=N-1,
   listMN(T,1,N2,T2).
 listMN(_,1,0,[]) if
   !. 