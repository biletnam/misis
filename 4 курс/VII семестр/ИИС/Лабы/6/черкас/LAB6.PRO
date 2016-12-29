DOMAINS
 int=integer
 listI=int*
 tree=null;tr(int,tree,tree)
PREDICATES
 tree_insert(int,tree,tree)  
 tree_list(tree,listI)
 list_tree(listI,tree)
 conc(listI,listI,listI)
 tobinary(tree,tree)
 tree_sum(tree,int)
 tree_length(tree,int)
 tree_avg(tree,real)
 tree_gen(int,tree)
 write_tree(tree)
 write_tree1(tree,tree,int,int)
 tab(int)
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

 conc([],L,L).
 conc([H|T],L,[H|T1]) if
   conc(T,L,T1).
   
 tree_list(null,[]).
 tree_list(tr(K,L,R),S) if
   tree_list(L,T_L),
   tree_list(R,T_R),
   conc(T_L,[K|T_R],S).
   
 list_tree([],null).
 list_tree([H|T],Tr) if
   list_tree(T,Tr1),
   tree_insert(H,Tr1,Tr).  
 
 tobinary(T1,T2) if
   tree_list(T1,L),
   list_tree(L,T2).

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

 tree_gen(0,null) if
   !.
 tree_gen(N,T) if
   random(5,X),
   N1=N-1,
   tree_gen(N1,T1),
   tree_insert(X,T1,T).        

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
 
   
   
                 