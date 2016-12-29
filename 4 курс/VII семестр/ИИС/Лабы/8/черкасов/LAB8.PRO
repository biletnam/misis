DOMAINS
 s=string
 symb=char
 file=in;out
 int=integer
 listI=int*
 listS=string*
PREDICATES
 MyOpenWrite(file,s) 		% #1
 MyOpenModify(file,s)		% #2
 MyOpenAppend(file,s)		% #3
 RewriteChet(s,s)		% #4
 RewriteChetLoop
 WriteIfChet(int)
 OtrNum(s,int)			% #5
 OtrNumInList(listI,int)
 FileToListI(file,listI) 
 IntNumInList(listI,int)
 IntNum(s,int)			% #6
 Lenght(ListI,int)
 AvgList(listI,real)
 NumLessInList(listI,real,int)
 NumLessThenAvgInList(listI,int)
 NumLessThenAvg(s,int)		% #7
 FileToListS(file,listS)
 RepeatText(s,listS)		% #8
 FindMaxLen(listS,int)
 ContinueStr(s,int,s)
 ContinueStrList(listS,listS)
 ContinueStrListLoop(listS,int,listS)
 WriteListSToFile(listS,file)
 ContinuesFile(s)		% #9
CLAUSES
 MyOpenWrite(F,N) if
   existfile(N),
   !,
   openwrite(F,N).
 MyOpenWrite(_,_) if
   write("File not found!"),nl.
 
 MyOpenModify(F,N) if
   existfile(N),
   !,
   openmodify(F,N).
 MyOpenModify(_,_) if
   write("File not found!"),nl.  
   
 MyOpenAppend(F,N) if
   existfile(N),
   !,
   openappend(F,N).
 MyOpenAppend(_,_) if
   write("File not found!"),nl.
   
 RewriteChet(F1,F2) if
   openread(in,F1),
   openwrite(out,F2),
   readdevice(in),
   writedevice(out),  
   RewriteChetLoop.
 RewriteChetLoop if
   not(eof(in)),
   !,
   readint(I),
   WriteIfChet(I),
   RewriteChetLoop.
 RewriteChetLoop if
   closefile(in),
   closefile(out),
   readdevice(keyboard),
   writedevice(screen).    
 WriteIfChet(I) if
   I mod 2 = 0,
   !,
   write(I),nl.   
 WriteIfChet(_).
 
 FileToListI(F,[H|T]) if
   not(eof(F)),
   !,
   readint(H),
   FileToListI(F,T).
 FileToListI(F,[]) if
   closefile(F).  
 
 OtrNumInList([],0) if
   !.
 OtrNumInList([H|T],N) if
   H<0,
   !,
   OtrNumInList(T,N2),
   N=N2+1.
 OtrNumInList([_|T],N) if
   OtrNumInList(T,N).  
    
 OtrNum(F,N) if
   openread(in,F),
   readdevice(in),
   FileToListI(in,L),
   OtrNumInList(L,N).
   
 IntNumInList([],0) if
   !.
 IntNumInList([H|T],N) if
   IntNumInList(T,N2),
   N=N2+H.
   
 IntNum(F,N) if
   openread(in,F),
   readdevice(in),
   FileToListI(in,L),
   IntNumInList(L,N).    
 
 Lenght([],0) if
   !.
 Lenght([_|T],N) if
   Lenght(T,N2),
   N=N2+1.
   
 AvgList(L,A) if
   IntNumInList(L,S),
   Lenght(L,N),
   A=S/N.  
 
 NumLessInList([],_,0) if
   !.
 NumLessInList([H|T],K,N) if
   H<K,
   !,
   NumLessInList(T,K,N2),
   N=N2+1.
 NumLessInList([_|T],K,N) if
   NumLessInList(T,K,N).
   
 NumLessThenAvgInList(L,N) if
   AvgList(L,A),
   NumLessInList(L,A,N).
   
 NumLessThenAvg(F,N) if
   openread(in,F),
   readdevice(in),
   FileToListI(in,L),
   NumLessThenAvgInList(L,N).
   
 FileToListS(F,[H|T]) if
   not(eof(F)),
   !,
   readln(H),
   FileToListS(F,T).
 FileToListS(F,[]) if
   closefile(F).
    
 RepeatText(F,L) if
   openread(in,F),
   readdevice(in),
   FileToListS(in,L).
   
 FindMaxLen([A],L) if
   str_len(A,L),
   !.
 FindMaxLen([H|T],L) if
   str_len(H,L),
   FindMaxLen(T,M),
   L>M.
 FindMaxLen([H|T],M) if
   str_len(H,L),
   FindMaxLen(T,M),
   L<=M.
   
 ContinueStr(S,0,S) if
   !.
 ContinueStr(S,N,S2) if
   N2=N-1,
   ContinueStr(S,N2,S3),
   concat(S3,"*",S2).
   
 ContinueStrList(L1,L2) if
   FindMaxLen(L1,M),
   ContinueStrListLoop(L1,M,L2).
 
 ContinueStrListLoop([],_,[]) if
   !.
 ContinueStrListLoop([H|T],M,[H2|T2]) if
   str_len(H,LEN),
   M2=M-LEN,
   ContinueStr(H,M2,H2),
   ContinueStrListLoop(T,M,T2).
 
 WriteListSToFile([],_) if
   !.
 WriteListSToFile([H|T],F) if
   writedevice(F),
   write(H),nl,
   WriteListSToFile(T,F).
   
   
 ContinueSFile(F) if
   openread(in,F),
   readdevice(in),
   FileToListS(in,L1),
   ContinueStrList(L1,L2),
   closefile(in),
   openwrite(in,F),
   WriteListSToFile(L2,in),
   closefile(in).
   
   
           