unit aboutunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TAboutF = class(TForm)
    OK: TButton;
    Label1: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutF: TAboutF;

implementation

{$R *.DFM}


procedure TAboutF.FormCreate(Sender: TObject);
begin
  image1.Picture.Icon:=Application.Icon;
end;

end.






