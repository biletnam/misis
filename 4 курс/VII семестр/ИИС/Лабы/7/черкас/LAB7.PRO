DOMAINS
 str=string
 symb=char
PREDICATES
 del(str,symb,str)
 firstch(str,str)
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
   
 firstch("","") if
   !.
 firstch(S,S3) if
   fronttoken(S,H,T),
   frontchar(H,C,_),
   firstch(T,S2),
   frontchar(S3,C,S2).
  
   
   
