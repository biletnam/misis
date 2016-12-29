unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  very_long = longint; 

  { Тип матрицы - ключа } 
  tkey    = array[1 .. 2, 1 .. 2] of integer; 
  { Матрица - столбец } 
  tcolumn = array[1 .. 2] of integer; 

  pmatrix = ^matrix; 
  matrix  = array [1 .. maxint div sizeof(tcolumn)] of tcolumn; 



const
  k_2: Tkey = ((1, 7), (3, 6));

var
  Form2: TForm2;

implementation

{$R *.dfm}

function _inc(var x: integer): integer;
begin
  inc(x);
  _inc := x;
end;

{
  Реализация расширенного алгоритма Евклида
  (используется для нахождения числа, обратного данному по модулю
   при вычислении определителя матрицы)
}
procedure extended_euclid(a, b: very_long;
          var x, y, d: very_long);
var q, r, x1, x2, y1, y2: very_long;
begin

  if b = 0 then begin

    d := a; x := 1; y := 0;
    exit

  end;

  x2 := 1; x1 := 0; y2 := 0; y1 := 1; 
  while b > 0 do begin

    q := a div b; r := a - q * b; 
    x := x2 - q * x1; y := y2 - q * y1; 
    a := b; b := r; 
    x2 := x1; x1 := x; y2 := y1; y1 := y; 

  end; 

  d := a; x := x2; y := y2; 

end; 

(* Вычисление числа, обратного A по модулю N *) 
function inverse(a, n: very_long): very_long;
var d, x, y: very_long; 
begin 

  extended_euclid(a, n, x, y, d); 
  if d = 1 then inverse := x 
  else inverse := 0; 

end;

{ Алфавит криптосистемы } 
const 
  alpha: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 

{ Преобразование массива столбцов длины Count в строку символов } 
function make_str(const arr: array of tcolumn; 
         const count: integer): string;
var
  res: string;
  i, j: integer;
begin
  res := '';

  for i := 0 to pred(count) do
    for j := 1 to 2 do res := res + alpha[succ(arr[i][j])];

  make_str := res;
end;
{ Преобразование строки символов S в массив столбцов (возвращается длина массива) }
function make_columns(var arr: array of tcolumn;
         const s: string): integer;
var
  i, count: integer;
  col: tcolumn; 
begin 
  count := -1; 
  for i := 1 to length(s) do begin 

    col[2 - (i mod 2)] := pred(pos(s[i], alpha)); 
    if not odd(i) then
      arr[_inc(count)] := col; 

  end; 
  make_columns := count + 1; 
end; 

{ Функция шифрования сообщения S ключом K }
function EncodeHill(const k: Tkey; const s: string): string; 
var 
  i, j, count: integer; 
  mx, Y: pmatrix; 
  len: integer; 

begin
  len := sizeof(tcolumn) * ( (length(s) div 2) + byte(odd(length(s))) );
  getmem(mx, len);
  getmem( Y, len);

  count := make_columns(mx^, s);
  for i := 1 to count do
    for j := 1 to 2 do
      Y^[i][j] := (K[j, 1] * mx^[i][1] + K[j, 2] * mx^[i][2]) mod length(alpha);

  EncodeHill := make_str(Y^, count);

  freemem( Y, len);
  freemem(mx, len); 
end; 

{ Функция расшифровки шифротекста S известным ключом K } 
function DecodeHill(const k: Tkey; const s: string): string; 

  function positive(X: integer): integer; 
  begin
    repeat 
      inc(X, length(alpha)); 
    until X >= 0; 
    positive := X; 
  end; 

var 
  inv_k: Tkey;
  det, i, j, count: integer; 
  mx, Y: pmatrix; 
  len: integer; 

begin 
  det := k[1, 1] * k[2, 2] - k[1, 2] * k[2, 1]; 
  if det < 0 then det := positive(det);

  det := inverse(det, length(alpha));
  for i := 1 to 2 do
    for j := 1 to 2 do begin

      if i = j then
        inv_k[i, j] := det * k[3 - i, 3 - j]
      else
        inv_k[i, j] := - det * k[i, j];

      if inv_k[i, j] < 0 then
        inv_k[i, j] := positive(inv_k[i, j])
      else inv_k[i, j] := inv_k[i, j] mod 26;
    end;

  len := sizeof(tcolumn) * ( (length(s) div 2) + byte(odd(length(s))) ); 
  getmem(mx, len); 
  getmem( Y, len); 

  count := make_columns(Y^, s);

  for i := 1 to count do 
    for j := 1 to 2 do 
      mx^[i][j] := (inv_k[j, 1] * Y^[i][1] + inv_k[j, 2] * Y^[i][2]) mod length(alpha); 

  DecodeHill := make_str(mx^, count); 

  freemem( Y, len);
  freemem(mx, len);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Memo2.Text := EncodeHill(k_2, Memo1.Text);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Memo2.Text := DecodeHill(k_2, Memo1.Text);
end;

end.
