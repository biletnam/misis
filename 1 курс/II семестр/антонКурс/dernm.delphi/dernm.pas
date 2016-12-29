unit dernm;
interface
uses Math, Ap, Sysutils;

(*
This routines must be defined by you:
function F(X : Double):Double;
*)

function DerivativeNM(X : Double; H : Double; M : Integer; N : Integer):Double;

implementation

(*************************************************************************
Вычисление M-ой производной путем построения интерполяционного полинома
по N точкам, размещенным в корнях полинома Чебышева N-ой степени.

Входные параметры:
    X   -   точка, в которой считаем производную
    H   -   шаг дифференцирования. Точки вычисления функции будут размещены
            на области (X-H, X+H)
    M   -   порядок производной. M>=0
    N   -   число используемых точек, N>=1

Результат - M-ая производная функции F в точке X
*************************************************************************)
function DerivativeNM(X : Double; H : Double; M : Integer; N : Integer):Double;
var
    FK : TReal1DArray;
    C : TReal1DArray;
    P : TReal1DArray;
    I : Integer;
    J : Integer;
    K : Integer;
    B1 : Double;
    B2 : Double;
    E : Double;
    D : Double;
begin
    if N=0 then
    begin
        Result := 0;
        Exit;
    end;
    if N=1 then
    begin
        if M=0 then
        begin
            Result := F(X);
        end
        else
        begin
            Result := 0;
        end;
        Exit;
    end;
    SetLength(FK, N+1);
    K:=1;
    while K<=N do
    begin
        FK[K] := F(x+h*Cos(Pi*(K-0.5)/N));
        Inc(K);
    end;
    SetLength(C, N-1+1);
    J:=0;
    while J<=N-1 do
    begin
        C[J] := 0;
        K:=1;
        while K<=N do
        begin
            C[J] := C[J]+FK[K]*Cos(Pi*J*(K-0.5)/N);
            Inc(K);
        end;
        if J=0 then
        begin
            C[J] := C[J]/N;
        end
        else
        begin
            C[J] := 2*C[J]/N;
        end;
        Inc(J);
    end;
    SetLength(P, N-1+1);
    I:=0;
    while I<=N-1 do
    begin
        P[i] := 0;
        Inc(I);
    end;
    d := 0;
    i := 0;
    repeat
        k := i;
        repeat
            e := P[k];
            P[k] := 0;
            if (i<=1) and (k=i) then
            begin
                P[k] := 1;
            end
            else
            begin
                if i<>0 then
                begin
                    P[k] := 2*d;
                end;
                if k>i+1 then
                begin
                    P[k] := P[k]-P[k-2];
                end;
            end;
            d := e;
            k := k+1;
        until  not (k<=N-1);
        d := P[i];
        e := 0;
        k := i;
        while k<=N-1 do
        begin
            e := e+P[k]*C[k];
            k := k+2;
        end;
        P[i] := e;
        i := i+1;
    until  not (i<=N-1);
    if M>N-1 then
    begin
        Result := 0;
        Exit;
    end;
    Result := P[M];
    I:=1;
    while I<=M do
    begin
        Result := Result*I/h;
        Inc(I);
    end;
end;


end.