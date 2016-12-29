DOMAINS
 int=integer
 listI=int*
 tree=null;tr(int,tree,tree)
PREDICATES
 tree_insert(int,tree,tree)  
 tree_sum(tree,int)
 write_tree(tree)
 write_tree1(tree,tree,int,int)
 tab(int)
 diapason(tree,int,int,int)
 isbinary(tree)
CLAUSES
 tree_insert(X,null,tr(X,null,null)).
 tree_insert(X,tr(X,L,R),tr(X,L,R)) if
   !.
 tree_insert(X,tr(K,L,R),tr(K,L1,R)) if
   X<K,
   !,
   tree_insert(X,L,L1).
 tree_insert(X,tr(K,L,R),tr(K,L,R1)) if
   tree_insert(X,R,R1).
    
 tree_sum(null,0).
 tree_sum(tr(X,L,R),N) if
   X>=0,
   tree_sum(L,N1),
   tree_sum(R,N2),
   N=N1+N2+X.
 tree_sum(tr(X,L,R),N) if
   X<0,
   tree_sum(L,N1),
   tree_sum(R,N2),
   N=N1+N2.
   
 tab(0).
 tab(X) if
   write(" "),
   X1=X-1,
   tab(X1).
 
 write_tree(T) if
   write_tree1(T,T,0,0).
 write_tree1(null,_,_,1) if
   !.
 write_tree1(null,_,_,0) if
   write("Tree is empty!"),nl.
 write_tree1(tr(X,L,R),T,S,_) if
   B=S+2,
   write_tree1(R,T,B,1),
   tab(B),
   write(X),nl,
   write_tree1(L,T,B,1).
  
 diapason(null,_,_,0).
 diapason(tr(K,L,R),A,B,N) if
   K>=A,
   K<=B,
   !,
   diapason(L,A,B,N1),
   diapason(R,A,B,N2),
   N=N1+N2+1.
 diapason(tr(_,L,R),A,B,N) if
   diapason(L,A,B,N1),
   diapason(R,A,B,N2),
   N=N1+N2.  
 
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
  
   
   
   
   
                 