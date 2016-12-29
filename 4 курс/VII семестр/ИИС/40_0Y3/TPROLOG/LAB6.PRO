DOMAINS
 int=integer
 listI=int*
 tree=null;tr(int,tree,tree)
PREDICATES
 isbinary(tree)
 tree_sum(tree,int)
 tree_length(tree,int)
 tree_avg(tree,real)
 write_len(tree,int)
 subtree(tree,tree)
CLAUSES
 
 isbinary(tr(A,tr(L,L1,L2),tr(R,R1,R2))) if
   L<=A,
   R>=A,
   isbinary(L1),
   isbinary(L2),
   isbinary(R1),
   isbinary(R2).
 isbinary(tr(A,tr(L,_,_),tr(R,_,_))) if
   L<=A,
   R>=A.
 isbinary(tr(_,null,null)).    
  
 tree_sum (null,0).              
 tree_sum(tr(X,L,R),N):-
   tree_sum (L,N1),       
   tree_sum (R,N2),       
   N=N1+N2+X.
   
 tree_length(null,0).
 tree_length(tr(_,L,R),N) if
   tree_length(L,N1),
   tree_length(R,N2),
   N=N1+N2+1.  
 
 tree_avg(T,A) if
   tree_sum(T,S),
   tree_length(T,N),
   A=S/N.   
 
 write_len(tr(A,_,_),1) if
   write(A),nl.
 write_len(null,_) if
   !.
 write_len(tr(_,L,R),K) if
   K2=K-1,
   write_len(L,K2),
   write_len(R,K2).    
     
 subtree(tr(A,null,null),tr(A,null,null)).
 subtree(null,null) if
   !.
 subtree(tr(X,L,R),tr(X,L2,R2)) if
   subtree(L,L2),
   subtree(R,R2).
 subtree(tr(A,L,R),tr(B,L2,_)) if
   A<>B,
   subtree(tr(A,L,R),L2),
   !.
 subtree(tr(A,L,R),tr(_,_,R2)) if
   subtree(tr(A,L,R),R2).      
   
                 