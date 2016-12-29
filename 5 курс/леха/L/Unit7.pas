unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TForm7 = class(TForm)
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
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button4Click(Sender: TObject);
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
      oa := Table1.FieldByName('oa').Value;
      ddz := Table1.FieldByName('ddz').Value;
      zup := Table1.FieldByName('zup').Value;
      ko := Table1.FieldByName('ko').Value;

      res := (oa-ddz-zup)/ko;

      str := 'Год: '+IntToStr(year)+'   Коэффициент текущей ликвидности: '+FloatToStr(res);

      ListBox1.AddItem(str, nil);
      Table1.Next;
    end;
end;

end.
