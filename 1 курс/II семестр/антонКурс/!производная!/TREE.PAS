program p;
uses crt;
type
  one_leaf_pointer=^one_leaf;
  one_leaf=record
    ct:integer;
    bl:integer;
    left:one_leaf_pointer;
    right:one_leaf_pointer;
  end;
var
  start:one_leaf_pointer;
  c:char;
  nl:integer;

procedure output(p:one_leaf_pointer;oc,vd,str:integer);
begin
  if (str<23) then begin
    gotoxy(oc,str*2-1);
    write(p^.ct,' ',p^.bl);
    if (p^.left<>NIL) then output(p^.left,oc-vd div 2,vd div 2,str+1);
    if (p^.right<>NIL) then output(p^.right,oc+vd div 2,vd div 2,str+1);
  end;
end;

procedure add(a:integer;p:one_leaf_pointer);
var
  np:one_leaf_pointer;
  fl:boolean;
begin
  new(np);
  with np^ do begin
    ct:=a;
    bl:=0;
    left:=NIL;
    right:=NIL;
  end;
  fl:=false;
  repeat
    if (p^.ct=a) then begin
      dispose(np);
      fl:=true;
    end else begin
      if (p^.ct>a) then begin
        if (p^.left=NIL) then begin
          p^.left:=np;
          fl:=true;
        end else p:=p^.left;
      end else begin
        if (p^.right=NIL) then begin
          p^.right:=np;
          fl:=true;
        end else p:=p^.right;
      end;
    end;
  until fl;
end;

procedure del(a:integer;var p:one_leaf_pointer);
var
  np:one_leaf_pointer;
  sp:one_leaf_pointer;
  fl:boolean;
  f:boolean;
begin
  np:=p;
  sp:=NIL;
  f:=true;
{ Поиск элемента }
  while ((np^.ct<>a)and(np<>NIL)) do
    if (np^.ct<a) then begin
      sp:=np;
      np:=np^.right;
    end else begin
      sp:=np;
      np:=np^.left;
  end;
  if (np<>NIL) then begin
    if (sp=NIL) then begin
    { Если удаляется корень дерева }
      sp:=np;
      if (np^.right=NIL) then begin
        p:=np^.left;
        dispose (np);
        f:=false;
      end else begin
        if (np^.left=NIL) then begin
          p:=np^.right;
          dispose (np);
          f:=false;
        end else begin
          p:=np^.left;
          sp:=np^.right;
          dispose (np);
        end;
      end;
    end else begin
    { Удалиние некорневой вершины }
      if (np^.right=NIL) then begin
        if (sp^.right=np) then sp^.right:=np^.left else sp^.left:=np^.left;
        dispose (np);
        f:=false;
      end else begin
        if (sp^.right=np) then sp^.right:=np^.right else sp^.left:=np^.right;
        sp:=np^.left;
        dispose (np);
        if (sp=NIL) then f:=false;
      end;
    end;
    if (f) then begin
      np:=sp;
      fl:=false;
      repeat
        if (p^.ct>a) then begin
          if (p^.left=NIL) then begin
            p^.left:=np;
            fl:=true;
          end else p:=p^.left;
        end else begin
          if (p^.right=NIL) then begin
            p^.right:=np;
            fl:=true;
          end else p:=p^.right;
        end;
      until fl;
    end;
  end;
end;

function comp(p:one_leaf_pointer):integer;
var cl,cr:integer;
begin
  if (p^.left=NIL) then cl:=0 else cl:=comp(p^.left);
  if (p^.right=NIL) then cr:=0 else cr:=comp(p^.right);
  p^.bl:=cr-cl;
  comp:=cl+cr+1;
end;

procedure balance(p:one_leaf_pointer);
var n:integer;
    pp,ppp:one_leaf_pointer;
begin
  n:=comp(p);
  pp:=p;
  ppp:=NIL;
  while (abs(pp^.bl)>1) do begin
    ppp:=pp;
    if (pp^.bl>0) then pp:=pp^.right else pp:=pp^.left;
  end;
{ ppp- последний несбалансированный }

end;

begin
  clrscr;
  new(start);
  write(' Введите значение первого элемента: ');
  with start^ do begin
    readln(ct);
    bl:=0;
    left:=NIL;
    right:=NIL;
  end;
  repeat
    clrscr;
    output(start,40,40,1);
    c:=readkey;
    if (c='+') then begin
      gotoxy(1,24);
      write(' Введите новый элемент: ');
      readln(nl);
      add(nl,start);
      balance(start);
    end;
    if (c='-') then begin
      gotoxy(1,24);
      write(' Введите удаляемый элемент: ');
      readln(nl);
      del(nl,start);
      balance(start);
    end;
  until (c=#27);
  clrscr;
end.
