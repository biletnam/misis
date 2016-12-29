DOMAINS
 str=string
 symb=char
PREDICATES
 del(str,symb,str)
 lastch(str,str)
CLAUSES
 del("",_,"") if
   !.
 del(S,C,S3) if
   frontchar(S,C,S2),
   del(S2,C,S3),
   !.
 del(S,C,S4) if
   frontchar(S,X,S2),
   del(S2,C,S3),
   frontchar(S4,X,S3).
   
 lastch(X,X) if
   str_len(X,1),
   !.
 lastch(S,S3) if
   frontchar(S,H,T),
   frontchar(T,' ',_),
   lastch(T,S2),
   frontchar(S3,H,S2),
   !.
 lastch(S,S2) if
   frontchar(S,_,T),
   lastch(T,S2).      
   
   
