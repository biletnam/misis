DOMAINS
 str=string
 listS=str*
 symb=char
 int=integer
PREDICATES
 symbnum(str,symb,int)
 scob(str)
 islat(symb)
 latsum(str,int)
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
 
 islat('a').
 islat('b').
 islat('c').
 islat('z').
   
 latsum("",0) if 
   !.
 latsum(S,N) if
   frontchar(S,C,S2),
   islat(C),
   !,
   latsum(S2,K),
   N=K+1.
 latsum(S,N) if
   frontchar(S,_,S2),
   latsum(S2,N).    