unit Input;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form2.close;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
const Digit: Set of Char=['0' .. '9'];
begin
  if not (Key in Digit) then Key:=#0;
end;

end.
