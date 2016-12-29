unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus,nshape;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Create1: TMenuItem;
    IN1: TMenuItem;
    OUT1: TMenuItem;
    NEURON1: TMenuItem;
    Bevel1: TBevel;
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure IN1Click(Sender: TObject);
    procedure NEURON1Click(Sender: TObject);
    procedure OUT1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tX,tY:integer;
implementation

{$R *.DFM}

procedure TForm1.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TForm1.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TslShape(Source).Move(X,Y);
end;

procedure TForm1.IN1Click(Sender: TObject);
begin
  TslShape.Create(self,1);
end;

procedure TForm1.OUT1Click(Sender: TObject);
begin
  TslShape.Create(self,2);
end;

procedure TForm1.NEURON1Click(Sender: TObject);
begin
  TslShape.Create(self,3);
end;

end.
