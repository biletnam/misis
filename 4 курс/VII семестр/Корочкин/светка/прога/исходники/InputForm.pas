unit InputForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, myclasses, ComCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    TrackBar1: TTrackBar;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
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
  Form2.Close;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
const Digit: Set of Char=['0' .. '9'];
begin
  if not (Key in Digit) then Key:=#0;
end;

end.
