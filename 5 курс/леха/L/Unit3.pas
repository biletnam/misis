unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Table1: TTable;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var t,d,s:integer;
o:double;
begin
  t := StrToInt(Edit1.Text);
  d := StrToInt(Edit2.Text);
  s := StrToInt(Edit3.Text);

  o := (s*d)/t;
  Edit4.Text := FloatToStr(o);
end;

procedure TForm3.Button4Click(Sender: TObject);
var count,k, year : integer;
i,r,n,t,d,s,o: double;
str: string;
begin
  Table1.First;
  ListBox1.Clear;
  count := Table1.RecordCount;

  for k := 1 to count do
    begin
      year := Table1.FieldByName('god').Value;
      t := Table1.FieldByName('t').Value;
      d := Table1.FieldByName('d').Value;
      s := Table1.FieldByName('c').Value;
      o := (s*d)/t;

      str := 'Год: '+IntToStr(year)+'   Длительность одного оборота: '+FloatToStr(o);

      ListBox1.AddItem(str, nil);
      Table1.Next;
    end;
end;

end.
