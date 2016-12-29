unit Main;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Stomatolog;
type
  TForm1 = class(TForm)
  procedure FormCreate(Sender: TObject);
 end;
var
  Form1: TForm1;
  MedCom: TMedCom;
implementation
{$R *.dfm}
procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  Form1.Width := 775;
  Form1.Height := 520;
  MedCom := TMedCom.Create(Form1);
end;
end.
