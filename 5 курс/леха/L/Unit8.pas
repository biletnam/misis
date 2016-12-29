unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TForm8 = class(TForm)
    Button4: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Table1: TTable;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button4Click(Sender: TObject);
var count,i, year : integer;
res,oa,ddz,zup,ko,ta,z,to2,ds,kf: double;
str: string;
begin
  Table1.First;
  ListBox1.Clear;
  count := Table1.RecordCount;

  for i := 1 to count do
    begin
      year := Table1.FieldByName('god').Value;
      ta := Table1.FieldByName('ta').Value;
      z := Table1.FieldByName('z').Value;
      to2 := Table1.FieldByName('to').Value;


      res := (ta-z)/to2;

      str := 'Год: '+IntToStr(year)+'   Коэффициент срочной ликвидности: '+FloatToStr(res);

      ListBox1.AddItem(str, nil);
      Table1.Next;
    end;
end;

end.
