DOMAINS
 str=string
 listS=str*
 symb=char
 int=integer
PREDICATES
 symbnum(str,symb,int)
 scob(str)
 strtolist(str,listS)
 firstpos(symb,str,int)
 glnum(str,int)
 findmaxlist(listS,str)
 findmax(str,str)
CLAUSES
 symbnum(S,C,N) if
  frontchar(S,C,S2),
  !,
  symbnum(S2,C,N2),
  N=N2+1.
 symbnum(S,C,N) if
  frontchar(S,_,S2),
  symbnum(S2,C,N).
 symbnum("",_,0). 
 
 scob(S) if
  symbnum(S,'(',N1),
  symbnum(S,')',N2),
  N1=N2.
   
 firstpos(_,"",0).
 firstpos(C,S,1) if
   frontchar(S,C,_).
 firstpos(C,S,N) if
   frontchar(S,X,S2),
   X<>C,
   firstpos(C,S2,N2),
   N=N2+1.   
 
 strtolist("",[]) if
  !.
 strtolist(S,[H|T]) if
  firstpos(' ',S,N),
  frontstr(N,S,H,S2),
  strtolist(S2,T).
 
 glnum(S,N) if
   symbnum(S,'a',N1),
   symbnum(S,'o',N2),
   symbnum(S,'e',N3),
   symbnum(S,'y',N4),
   symbnum(S,'u',N5),
   symbnum(S,'i',N6),
   N=N1+N2+N3+N4+N5+N6. 
 
 findmaxlist([],"").
 findmaxlist([A],A).
 findmaxlist([H|T],H) if
   findmaxlist(T,M),
   glnum(H,N),
   glnum(M,N2),
   N>=N2,
   !.
 findmaxlist([_|T],M) if
   findmaxlist(T,M).  
 
 findmax(S,S2) if
   strtolist(S,L),
   findmaxlist(L,S2).  