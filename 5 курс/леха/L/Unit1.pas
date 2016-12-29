unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TForm1 = class(TForm)
    Table1: TTable;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure CalcNom(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.close;
end;

procedure TForm1.CalcNom(Sender: TObject);
var count,k, year : integer;
i,r,n: double;
str: string;
begin
  Table1.First;
  ListBox1.Clear;
  count := Table1.RecordCount;

  for k := 1 to count do
    begin
      year := Table1.FieldByName('god').Value;
      i := Table1.FieldByName('i').Value;
      r := Table1.FieldByName('r').Value;
      n := r+i+r*i;

      str := 'Год: '+IntToStr(year)+'   Номинальная ставка доходности: '+FloatToStr(n);

      ListBox1.AddItem(str, nil);
      Table1.Next;
    end;
end;


end.
