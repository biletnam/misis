DOMAINS
 number=integer
 float = real
PREDICATES
 max4(number,number,number,number,number)
 inCircle(number,number,number,number,number)
 myABS(number,number)
 gipoten(number,number,float)
 step1(number,number,number)
 step2(number,number,number)
 step3(number,number,number,number,number)
 step3M(number,number,number)
 sum(number,number)
 sumN(number,number)
 nod(number,number,number)
 nok(number,number,number)
 repeat
 loop(number,number)
 for(number,number)
 downfor(number,number)
CLAUSES

 max4(A,B,C,D,A) if
   A>=B,
   A>=C,
   A>=D,
   !.
 max4(_,B,C,D,B) if
   B>=C,
   B>=D,
   !.
 max4(_,_,C,D,C) if
   C>=D,
   !.
 max4(_,_,_,D,D).       
 
 inCircle(X,Y,Xc,Yc,R) if
   ((X-Xc)*(X-Xc) + (Y-Yc)*(Y-Yc)) <= R*R.
   
 myABS(X,X) if
   X>=0,
   !.
 myABS(X,A) if
   A = -X.
   
 gipoten(A,B,C) if
   C = sqrt(A*A + B*B).
 
 step1(_,0,1).
 step1(X,1,X).
 step1(A,N,AN) if
   N>1,
   N2=N-1,
   step1(A,N2,AN2),
   AN = AN2*A.
 
 step2(_,0,1) if
   !.
 step2(X,1,X) if
   !.
 step2(A,N,AN) if
   N2=N-1,
   step2(A,N2,AN2),
   AN=AN2*A.    
   
 step3(_,N,AN,N,AN) if
   !.
 step3(A,N,AN,N1,AN1) if
   N2=N1+1,
   AN2=AN1*A,
   step3(A,N,AN,N2,AN2).
 step3M(A,N,AN) if
   step3(A,N,AN,1,A).  
 
 sum(1,1) if
   !.
 sum(N,X) if
   N2=N-1,
   sum2(N2,X2),
   X=X2+N.
  
 sumN(1,1) if
   !.
 sumN(N,X) if
   N mod 2 = 0,
   N2=N-1,
   sumN(N2,X).  
 sumN(N,X) if  
   N mod 2 = 1,
   N2=N-2,
   sumN(N2,X2),
   X=X2+N. 
 
 nod(A,A,A) if
   !.
 nod(A,B,X) if
   A>B,
   A2=A-B,
   nod(A2,B,X).
 nod(A,B,X) if
   B>A,
   B2=B-A,
   nod(A,B2,X).
 
 nok(A,B,X) if
   nod(A,B,X2),
   X = (A*B)/X2.
   
 repeat.
 repeat if 
   repeat.
 loop(N,N) if
   !.
 loop(N1,N2) if
   repeat,
   N=N1+1,
   write(N),nl,
   loop(N,N2).
    
 for(X,Y) if
   X>Y,
   !.
 for(X1,X2) if
   write(X1),nl,
   X = X1 + 1,
   for(X,X2).
   
 downfor(X,Y) if
   X<Y,
   !.
 downfor(X1,X2) if
   write(X1),nl,
   X=X1-1,
   downfor(X,X2).         