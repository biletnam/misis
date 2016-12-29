unit metodgf;

interface
uses crt,ustp;
{----Процедуры методов оптимизации----}

{--Методы с использованием свойств градиента--}

{--Нахождение оптимума по методу наискорейшего спуска--}
procedure NSpusk(zf:fun; pr:fpr; x:mas; n1,n:integer; h,eps:real; var fil:text);

implementation
  {$F+}
{--Процедуры методов оптимизации--}

{--Методы с использованием свойств градиента--}

{--Нахождение оптимума по методу наискорейшего спуска--}
procedure NSpusk(zf:fun; pr:fpr; x:mas; n1,n:integer; h,eps:real; var fil:text);
var
    y,g,d:mas;
    l,ff:array[1..4] of real;
    f,g2,f0,ll:real;
    dn,z,zz,g0:real;
    s1,s2,s3:real;
    k,i,j,fe:integer;
    prizn,m:byte;

begin
     fe:=0;prizn:=0;
     writeln('Вычисление по методу наискорейшего спуска');
     writeln;
     writeln(fil,'Вычисление по методу наискорейшего спуска');
          {Промежуточный вывод}
     writeln(fil,'--***----- ТЕКУЩИЕ ЗНАЧЕНИЯ-----***--');
     n:=2;
    for i:=1 to n do y[i]:=x[i];
    z:=zf(x,n1,fil);      fe:=fe+1; g0:=pr(x,n1,n,g,fil);
 repeat
       for i:=1 to n do d[i]:=-g[i]/g0;
          {Задать направление наискорейшего спуска из
          точки y[i] равной в начале x[i]}
       l[1]:=0; ff[1]:=z; zz:=z;
       repeat
          m:=1;
          l[3]:=h;
          for i:=1 to n do x[i]:=y[i]+l[3]*d[i];
          z:= zf(x,n1,fil);  fe:=fe+1; ff[3]:=z; g0:=pr(x,n1,n,g,fil);
          g2:=0;
          for i:=1 to n do g2:=g2+g[i]*d[i];
          if  (ff[3]<ff[1]) or (g2<0) then
             begin
                    h:=h*2; m:=1;
                end
                else m:=0;
    if h>=100000 then
              begin m:=0;
                    writeln;writeln(fil);
                    writeln('Внимание! Шаг увеличиваеться, а минимум не найден!');
                    writeln(fil,'Внимание! Шаг увеличиваеться, а минимум не найден!');
                    writeln('Шаг = ',h:8:3);
                    writeln(fil,'Шаг = ',h:8:3);
                    writeln;writeln(fil);
              end;
       until m=0;

    if h>=100000 then
     begin m:=0;
       end
     else
     begin
        l[2]:=h/2;
        for i:=1 to n do x[i]:=y[i]+l[2]*d[i];
        z:=zf(x,n1,fil);      fe:=fe+1;  ff[2]:=z;
        {Выполнить первую квадратичную интерполяцию}
        if (2*ff[2]-ff[1]-ff[3]=0) then
             if (ff[2]=ff[1]) and (ff[2]=ff[3]) then  prizn:=prizn+1
                else
                 begin
                   writeln('Ошибка! Деление на ноль!');prizn:=10;
                   writeln(fil,'Ошибка! Деление на ноль!');
                   delay(2500);exit;
                 end
         else l[4]:=h*(ff[2]-0.75*ff[1]-0.25*ff[3])/(2*ff[2]-ff[1]-ff[3]);

        if l[4]<0 then
          begin
                 writeln('Внимание');
              end;
         for i:=1 to n do x[i]:=y[i]+l[4]*d[i];
         z:=zf(x,n1,fil);      fe:=fe+1; ff[4]:=z;
       {Имеем 4 значения и 4 значения функции,
         упорядочить их в порядке убывания}
       repeat
         m:=1;
         for j:=1 to 3 do
           for k:=j+1 to 4 do
            if ff[j]>ff[k] then
              begin
                     ll:=l[j];l[j]:=l[k];l[k]:=ll;
                     f0:=ff[j];ff[j]:=ff[k];ff[k]:=f0;
                    end;
     {Закончить поиск в данном направлении
     если точность достигнута}
    if (abs(l[1]-l[2]))<(eps*50) then   m:=0
     else {запомнить 3 лучшие точки}
       begin
            s1:=sgn(l[2],l[1]);
            s2:=sgn(l[3],l[1]);
            s3:=sgn(l[4],l[1]);
        if (s1=s2)and(s1=-s3) then
            begin
               l[3]:=l[4]; ff[3]:=ff[4];
            end;

            begin
             dn:=(l[2]-l[3])*ff[1]+(l[3]-l[1])*ff[2]+(l[1]-l[2])*ff[3];
             if dn<>0 then
             f:=(ff[1]-ff[2])/(2*dn)
             else
              begin
                 writeln('dn=0');
                 writeln('Ошибка! Деление на ноль!');
                 writeln(fil,'Ошибка! Деление на ноль!');
                 delay(2500);exit;
                 end;

             f:=f*(l[2]-l[3])*(l[3]-l[1]);
             l[4]:=(l[1]+l[2])/2+f;
             for i:=1 to n do
                 x[i]:=y[i]+l[4]*d[i];
             z:=zf(x,n1,fil);      fe:=fe+1; ff[4]:=z; m:=1;
            end;
       end;
     until (m=0);
     { or (prizn=0);}
     for i:=1 to n do
       begin
            x[i]:=y[i]+l[1]*d[i];
            y[i]:=x[i];
            write(fil,'  x[',i,']=',x[i]:10:8);
         end;
     z:=zf(x,n1,fil);      fe:=fe+1; g0:=pr(x,n1,n,g,fil);
     writeln(fil,'     zf =',z:12:8);
     h:=h/2;

    end;
until (g0<eps) or (fe>1500) or (h>100000) or (prizn>=5);
if (fe>1500) or (h>10000) then
   begin
     writeln('Минимум не найден по методу наискорейшего спуска!');
     writeln(fil,'Минимум не найден по методу наискорейшего спуска!');
     writeln(fil,'Проверьте начальные параметры!');
     writeln('Проверьте начальные параметры!');
   end
 else
  begin
     writeln('Минимум найден по методу наискорейшего спуска в точке');
     writeln(fil,'Минимум найден по методу наискорейшего спуска в точке');
   for i:=1 to n do
     begin
          write(' x[',i,']=',x[i]:15:12);
          write(fil,' x[',i,']=',x[i]:15:12);
         end;
   writeln;writeln(fil);
   writeln('Значение функции = ',z:15:12);
   writeln(fil,'Значение функции  = ',z:15:12);
  end;
   writeln('Количество вычислений = ',fe);
   writeln(fil,'Количество вычислений = ',fe);
   writeln(fil);

end;

end.
