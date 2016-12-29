DOMAINS
 num=integer
 rnum = real
PREDICATES
 max2(num,num,num)
 max3(num,num,num,num)
 max4(num,num,num,num,num)
 inCircle(num,num,num,num,num)
 myABS(num,num)
 gipot(num,num,rnum)
 step1(num,num,num)
 step2(num,num,num)
 step3(num,num,num,num,num)
 step3M(num,num,num)
 sum1(num,num)
 sum2(num,num)
 sum3(num,num,num,num)
 sum3M(num,num)
 sumN(num,num)
 nod(num,num,num)
 nok(num,num,num)
 repeat
 loop(num,num)
 for(num,num)
 downfor(num,num)
CLAUSES
 
 max2(X,Y,X) if
   X>Y,
   !.	
 max2(_,Y,Y).
 
 max3(X,Y,Z,M) if
   max2(X,Y,XY),
   max2(XY,Z,M).
 
 max4(A,B,C,D,M) if
   max3(A,B,C,ABC),
   max2(ABC,D,M). 
 
 inCircle(X,Y,Xc,Yc,R) if
   ((X-Xc)*(X-Xc) + (Y-Yc)*(Y-Yc)) <= R*R.
   
 myABS(X,X) if
   X>=0,
   !.
 myABS(X,A) if
   A = -X.
   
 gipot(A,B,C) if
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
 
 sum1(1,1).
 sum1(N,X) if
   N>1,
   N2=N-1,
   sum1(N2,X2),
   X=X2+N. 
 
 sum2(1,1) if
   !.
 sum2(N,X) if
   N2=N-1,
   sum2(N2,X2),
   X=X2+N.
 
 sum3(N,X,N,X) if
   !.
 sum3(N,X,N1,X1) if 
   N2=N1+1,
   X2=X1+N2,
   sum3(N,X,N2,X2).
 sum3M(N,X) if
   sum3(N,X,1,1).

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