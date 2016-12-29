unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit2;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function Perevod(Symbols:String;Number:Integer) : String;

var g,f,s:Integer;  DF,GH,ML:string;
begin
  ML:=Symbols;
  f:=Number mod Length(ML);
  if Number<Length(ML) then
   Result:=ML[f+1]
   else
   while Number>=Length(ML) do begin
 Number:=Number div Length(ML);
 g:=Number mod Length(ML);
 DF:=DF+ML[g+1];
 GH:=ML[f+1]+DF;
  end;
for s:=Length(GH) downto  1 do
  Result:=Result+GH[s];
 end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var //цифровая маска
  vrPos, vrLength, vrSelStart: byte;
const
  I: byte = 1;
    //I+1 = количество знаков после запятой (в данном случае - 2 знака)
begin

  with Sender as TEdit do
  begin
    vrLength := Length(Text); //определяем длину текста
    vrPos := Pos(',', Text); //проверяем наличие запятой
    vrSelStart := SelStart; //определяем положение курсора
  end;

  case Key of

    '0'..'9':
      begin
        //проверяем положение курсора и количество знаков после запятой
        if (vrPos > 0) and (vrLength - vrPos > I) and (vrSelStart >= vrPos) then
          Key := #0; //"погасить" клавишу
      end;

    #8: ; //позволить удаление знаков клавишей 'Back Space'
  else
    Key := #0; //"погасить" все остальные клавиши
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var symb: string;
begin
 case ComboBox1.ItemIndex of
 0 : symb:='01';
 1 : symb:='01234567';
 2 : symb:='0123456789ABCDEF';
 end;
If Length(Edit1.Text)<=9  then
begin
if Length(Edit1.Text)=0 then ShowMessage('Введите число') else Edit2.Text:=Perevod(symb,StrToInt(Edit1.Text))
end
else ShowMessage('Ваше число слишком большое, попробуйте ввести что-нибудь поменьше');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Form2.Show;
end;

end.
