unit spline3;
interface
uses Math, Ap, Sysutils;

procedure Spline3BuildTable(N : Integer;
     const DiffN : Integer;
     x : TReal1DArray;
     y : TReal1DArray;
     const BoundL : Double;
     const BoundR : Double;
     var ctbl : TReal2DArray);
function Spline3Interpolate(N : Integer;
     const c : TReal2DArray;
     const X : Double):Double;

implementation

(*************************************************************************
Процедура Spline3BuildTable служит  для  построения таблицы  коэффициентов
кубического сплайна по заданным точкам и граничным условиям, накладываемым
на производные.

В дальнейшем постренная таблица используется функцией Spline3Interpolate.

Параметры:
    N       - число точек
    DiffN   - тип граничного условия. "1" соответствует граничным условиям
              накладываемым на первые производные, "2" - на вторые.
    xs      - массив абсцисс опорных точек с номерами от 0 до N-1
    ys      - массив ординат опорных точек с номерами от 0 до N-1
    BoundL  - левое граничное условие. Если DiffN равно 1, то первая произ-
              водная  на  левой  границе  равна BoundL, иначе BoundL равна
              вторая.
    BoundR  - аналогично BoundL
    

Выходные значения:
    ctbl    - в этот массив помещается таблица коэффициентов сплайна.
              Эта таблица используется функцией Spline3Interpolate.
*************************************************************************)
procedure Spline3BuildTable(N : Integer;
     const DiffN : Integer;
     x : TReal1DArray;
     y : TReal1DArray;
     const BoundL : Double;
     const BoundR : Double;
     var ctbl : TReal2DArray);
var
    C : Boolean;
    E : Integer;
    G : Integer;
    Tmp : Double;
    nxm1 : Integer;
    I : Integer;
    J : Integer;
    DX : Double;
    DXJ : Double;
    DYJ : Double;
    DXJP1 : Double;
    DYJP1 : Double;
    DXP : Double;
    DYP : Double;
    YPPA : Double;
    YPPB : Double;
    PJ : Double;
    b1 : Double;
    b2 : Double;
    b3 : Double;
    b4 : Double;
begin
    x := DynamicArrayCopy(x);
    y := DynamicArrayCopy(y);
    N := N-1;
    g := (n+1) div 2;
    repeat
        i := g;
        repeat
            j := i-g;
            c := True;
            repeat
                if x[j]<=x[j+g] then
                begin
                    c := False;
                end
                else
                begin
                    Tmp := x[j];
                    x[j] := x[j+g];
                    x[j+g] := Tmp;
                    Tmp := y[j];
                    y[j] := y[j+g];
                    y[j+g] := Tmp;
                end;
                j := j-1;
            until  not ((j>=0) and C);
            i := i+1;
        until  not (i<=n);
        g := g div 2;
    until  not (g>0);
    SetLength(ctbl, 4+1, N+1);
    N := N+1;
    if DiffN=1 then
    begin
        b1 := 1;
        b2 := 6/(x[1]-x[0])*((y[1]-y[0])/(x[1]-x[0])-BoundL);
        b3 := 1;
        b4 := 6/(x[n-1]-x[n-2])*(BoundR-(y[n-1]-y[n-2])/(x[n-1]-x[n-2]));
    end
    else
    begin
        b1 := 0;
        b2 := 2*BoundL;
        b3 := 0;
        b4 := 2*BoundR;
    end;
    nxm1 := n-1;
    if n>=2 then
    begin
        if n>2 then
        begin
            dxj := x[1]-x[0];
            dyj := y[1]-y[0];
            j := 2;
            while j<=nxm1 do
            begin
                dxjp1 := x[j]-x[j-1];
                dyjp1 := y[j]-y[j-1];
                dxp := dxj+dxjp1;
                ctbl[1,j-1] := dxjp1/dxp;
                ctbl[2,j-1] := 1-ctbl[1,j-1];
                ctbl[3,j-1] := 6*(dyjp1/dxjp1-dyj/dxj)/dxp;
                dxj := dxjp1;
                dyj := dyjp1;
                j := j+1;
            end;
        end;
        ctbl[1,0] := -b1/2;
        ctbl[2,0] := b2/2;
        if n<>2 then
        begin
            j := 2;
            while j<=nxm1 do
            begin
                pj := ctbl[2,j-1]*ctbl[1,j-2]+2;
                ctbl[1,j-1] := -ctbl[1,j-1]/pj;
                ctbl[2,j-1] := (ctbl[3,j-1]-ctbl[2,j-1]*ctbl[2,J-2])/pj;
                j := j+1;
            end;
        end;
        yppb := (b4-b3*ctbl[2,nxm1-1])/(b3*ctbl[1,nxm1-1]+2);
        i := 1;
        while i<=nxm1 do
        begin
            j := n-i;
            yppa := ctbl[1,j-1]*yppb+ctbl[2,j-1];
            dx := x[j]-x[j-1];
            ctbl[3,j-1] := (yppb-yppa)/dx/6;
            ctbl[2,j-1] := yppa/2;
            ctbl[1,j-1] := (y[j]-y[j-1])/dx-(ctbl[2,j-1]+ctbl[3,j-1]*dx)*dx;
            yppb := yppa;
            i := i+1;
        end;
        i:=1;
        while i<=n do
        begin
            ctbl[0,i-1] := y[i-1];
            ctbl[4,i-1] := x[i-1];
            Inc(i);
        end;
    end;
end;


(*************************************************************************
Вычисление значения сплайна в точке по таблице коэффициентов

Функция Spline3Interpolate по построенной процедурой Spline3BuildTable
таблице коэффициентов вычисляет значение интерполируемой функции в
заданной точке.

Параметры:
    N       - число точек, переданных в процедуру Spline3BuildTable
    C       - таблица коэффициентов, построенная процедурой
              Spline3BuildTable
    X       - точка, в которой ведем расчет
    
Результат:
    значение кубического сплайна, заданного таблицей C, в точке X
*************************************************************************)
function Spline3Interpolate(N : Integer;
     const c : TReal2DArray;
     const X : Double):Double;
var
    I : Integer;
    L : Integer;
    Half : Integer;
    First : Integer;
    Middle : Integer;
begin
    N := N-1;
    L := N;
    First := 0;
    while L>0 do
    begin
        Half := L div 2;
        Middle := First+Half;
        if C[4,Middle]<X then
        begin
            First := Middle+1;
            L := L-Half-1;
        end
        else
        begin
            L := Half;
        end;
    end;
    I := First-1;
    if I<0 then
    begin
        I := 0;
    end;
    Result := c[0,I]+(X-c[4,i])*(C[1,I]+(X-c[4,i])*(C[2,I]+C[3,i]*(X-c[4,i])));
end;


end.