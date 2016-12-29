unit metodbf;

interface
uses crt,ustp,VibFn;
{----Процедуры методов оптимизации----}

{--Нахождение оптимума по методу  покоординатного спуска--}
procedure PkoordSp(ff:fun; p:mas; nom,n,m2:integer; d,d1,r:real;var fil:text);

implementation
  {$F+}

{--Нахождение оптимума по методу  покоординатного спуска--}
procedure PkoordSp(ff:fun; p:mas; nom,n,m2:integer; d,d1,r:real;var fil:text);
 var  i,k:integer;
      m1,s3:real;

   procedure dirsear(d,d1,r,m1:real; ff:fun;  m2,Nk:integer;
                      var p:mas; var s3:real; var k:integer);

   var i,j:integer;
       b1,b2,b3,b4:boolean;
       s2,s4,t:real;
       s1,h:mas;
    function ee:boolean;
      var i,j:integer;
      begin
         n:=2;
         ee:=False;
         for i:=1 to n do
          begin
             h[i]:=h[i]+s1[i];  s4:=ff(h,nom,fil);  k:=k+1;
             {--вывод промежуточных результатов в файл для анализа--}
        {begin}
        for j:=1 to n do
           write(fil,' p [',j,'] = ',h[j]:12:4,',  ');
        writeln(fil,' zf = ',s4:12:4);
        {end}

             if s4<s2 then s2:=s4
                else  begin
                      s1[i]:=-s1[i];  h[i]:=h[i]+2*s1[i];
                      if k<m2 then k:=k+1
                         else begin ee:=True; exit; end;
                      s4:=ff(h,nom,fil);
                      if s4<s2 then s2:=s4 else h[i]:=h[i]-s1[i];
                      end;
           {--вывод промежуточных результатов в файл для анализа--}
        begin
        for j:=1 to n do
           write(fil,' p [',j,'] = ',h[j]:12:4,',  ');
        writeln(fil,' zf = ',s4:12:4);
        end
          end;
      end;
    {начало процедуры dirsear}
    begin
      writeln(fil,'Текущие значения');
      for i:=1 to Nk do
      begin
        s1[i]:=d*abs(p[i]);
        if s1[i]<m1 then s1[i]:=d;
      end;
      s3:=ff(p,nom,fil);  k:=1;   b1:=True;
      while b1 do
       begin
        s2:=s3;   h:=p;   b3:=True;
        {--вывод промежуточных результатов в файл для анализа--}
        {begin}
        for i:=1 to Nk do
           write(fil,' p [',i,'] = ',p[i]:12:4,',  ');
        writeln(fil,' zf = ',s3:12:4);
        {end}

        if ee then exit;
        if s2<s3 then
         begin
          j:=1; b4:=false; b2:=true;
          while b2 do
           begin
           for i:=1 to n do
           begin
              if (h[i]>p[i])=(s1[i]<0) then s1[i]:=-s1[i];
              t:=p[i]; p[i]:=h[i]; h[i]:=2*h[i]-t
           end;

           s3:=s2;
           if k<m2 then k:=k+1 else exit;
           s4:=ff(h,nom,fil); s2:=s4;
           if ee then exit;
           if s2>=s3 then
              begin j:=n+1; b2:=false; b3:=false end;
           while j<=n do
            begin
              if abs(h[i]-p[i])>0.5*abs(s1[i]) then
                  begin j:=n; b4:=true end;
              j:=j+1;
              if b4 then b2:=true else b2:=false
             end
         end
    end;
     if(d>=d1) and b3 then
       begin
           if k>m2 then exit;
           d:=r*d;
           for i:=1 to n do s1[i]:=r*s1[i];
           end
           else
           if d<d1 then b1:=false
        end
   end;

begin {начало процедуры покоординатного спуска}
n:=2;
writeln(fil,'Нахождение оптимума по методу  покоординатного спуска');
writeln;
writeln('Нахождение оптимума по методу  покоординатного спуска');
{--Вычисление оптимума--}
dirsear(d,d1,r,m1, ff, m2,n, p, s3, k);
writeln;
if k>=m2 then
   begin writeln('Минимум не найден по методу покоординатного спуска!');
         writeln(fil,'Минимум не найден по методу покоординатного спуска!');
         writeln('Пересмотрите вводимые параметры!');
         writeln(fil,'Пересмотрите вводимые параметры!');
    end
else
   begin
       writeln('Минимум найден по методу покоординатного спуска');
       writeln(fil,'Минимум найден по методу покоординатного спуска');
       write('Точка минимума р(');
       write(fil,'Точка минимума р(');
       n:=2;
       for i:=1 to n do
         if i=n then begin write(p[i]:12:4);
                           write(fil,p[i]:12:4);end
               else begin write(p[i]:12:4,',');
                          write(fil,p[i]:12:4,',');end;

       writeln(').');writeln(fil,').');
       writeln('Значение функции F =',s3:12:4);
       writeln(fil,'Значение функции F = ',s3:12:4);
    end;
writeln('Количество вычислений k = ',k);
writeln(fil,'Количество вычислений k = ',k);writeln(fil);
end;
end.
