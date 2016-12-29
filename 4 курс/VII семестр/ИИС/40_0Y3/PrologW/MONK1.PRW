monk(n):-begin(n,A,B,C),move(n,1,2,3,A,B,C,D,E,F).
move(1,x,y,z,A,B,C,D,E,F):-make(x,y,A,B,C,D,E,F).
move(n,x,y,z,A,B,C,D,E,F):-¡ŒÀ‹ÿ≈(n,1),move(#n-1#,x,z,y,A,B,C,a,b,c),make(x,y,a,b,c,d,e,f), move(#n-1#,z,y,x,d,e,f,D,E,F).
begin(n,A,[],[]):-¡ŒÀ‹ÿ≈(n,0),Ã≈Õ‹ÿ≈(n,15),list(n,B),rev(B,A),pyr(A).
list(1,[1]).
list(n,[n|m]):-¡ŒÀ‹ÿ≈(n,1),list(#n-1#,m).
rev([],[]).
rev([h|t],L):-rev(t,T),conc(T,[h],L).
conc([],L,L).
conc([h|A],B,[h|C]):-conc(A,B,C).
len([],0).
len([a|b],l):-len(b,m),—ÀŒ∆≈Õ»≈(m,1,l).
pyr([]).
pyr([n|t]):-len(t,h),disk(n,1,h,n),pyr(t).
make(1,2,[a|A],B,C,A,[a|B],C):-len(A,d),disk(a,1,d,15),len(B,e),disk(a,2,e,a).
make(1,3,[a|A],B,C,A,B,[a|C]):-len(A,d),disk(a,1,d,15),len(C,e),disk(a,3,e,a).
make(2,3,A,[b|B],C,A,B,[b|C]):-len(B,d),disk(b,2,d,15),len(C,e),disk(b,3,e,b).
make(2,1,A,[b|B],C,[b|A],B,C):-len(B,d),disk(b,2,d,15),len(A,e),disk(b,1,e,b).
make(3,2,A,B,[c|C],A,[c|B],C):-len(C,d),disk(c,3,d,15),len(B,e),disk(c,2,e,c).
make(3,1,A,B,[c|C],[c|A],B,C):-len(C,d),disk(c,3,d,15),len(A,e),disk(c,1,e,c).
disk(n,s,h,c):-box(#s*140-5*n#,#300-10*h-1#,#s*140+5*n#,#300-10*h-10#,c).
box(a,b,c,d,e):-À»Õ»ﬂ(a,b,a,d,e),À»Õ»ﬂ(a,d,c,d,e),À»Õ»ﬂ(c,d,c,b,e),À»Õ»ﬂ(c,b,a,b,e),«¿ –¿— ¿(#a+1#,#b-1#,e,e).
?«¿œ»—‹_¬("grp:"),monk(14).
