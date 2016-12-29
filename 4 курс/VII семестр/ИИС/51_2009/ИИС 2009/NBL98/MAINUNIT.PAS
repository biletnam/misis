unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus,nshape;

type
  Tmain = class(TForm)
    MainMenu1: TMainMenu;
    Create1: TMenuItem;
    IN1: TMenuItem;
    OUT1: TMenuItem;
    NEURON1: TMenuItem;
    ColorDialog1: TColorDialog;
    Parameters1: TMenuItem;
    LineColor1: TMenuItem;
    Run1: TMenuItem;
    STP: TMenuItem;
    Reset1: TMenuItem;
    Initialize: TMenuItem;
    ReserAll1: TMenuItem;
    RTE: TMenuItem;
    N1: TMenuItem;
    InitLoop: TMenuItem;
    LoopStep: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    INColor1: TMenuItem;
    OUTColor1: TMenuItem;
    NEURONColor1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Load1: TMenuItem;
    Save1: TMenuItem;
    N2: TMenuItem;
    Clearworkspace1: TMenuItem;
    SaveDialog2: TSaveDialog;
    GenerateWeight1: TMenuItem;
    ShowGrid: TMenuItem;
    Templates1: TMenuItem;
    N5x51: TMenuItem;
    N4x41: TMenuItem;
    N6x61: TMenuItem;
    N3: TMenuItem;
    N6x11: TMenuItem;
    N6x21: TMenuItem;
    N6x31: TMenuItem;
    N4: TMenuItem;
    N1x61: TMenuItem;
    N2x61: TMenuItem;
    N3x61: TMenuItem;
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure IN1Click(Sender: TObject);
    procedure NEURON1Click(Sender: TObject);
    procedure OUT1Click(Sender: TObject);
    procedure LineColor1Click(Sender: TObject);
    procedure InitializeClick(Sender: TObject);
    procedure STPClick(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure ReserAll1Click(Sender: TObject);
    procedure RTEClick(Sender: TObject);
    procedure InitLoopClick(Sender: TObject);
    procedure LoopStepClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure INColor1Click(Sender: TObject);
    procedure OUTColor1Click(Sender: TObject);
    procedure NEURONColor1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Clearworkspace1Click(Sender: TObject);
    procedure GenerateWeight1Click(Sender: TObject);
    procedure ShowGridClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N5x51Click(Sender: TObject);
    procedure N4x41Click(Sender: TObject);
    procedure N6x61Click(Sender: TObject);
    procedure N6x11Click(Sender: TObject);
    procedure N6x21Click(Sender: TObject);
    procedure N6x31Click(Sender: TObject);
    procedure N1x61Click(Sender: TObject);
    procedure N2x61Click(Sender: TObject);
    procedure N3x61Click(Sender: TObject);
  protected
    procedure Paint; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  main: Tmain;
  tX,tY:integer;
implementation

uses aboutunit,filework;

{$R *.DFM}

procedure Tmain.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure Tmain.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TslShape(Source).Move(X,Y);
end;

procedure Tmain.IN1Click(Sender: TObject);
begin
  TslShape.Create(self,1);
end;

procedure Tmain.OUT1Click(Sender: TObject);
begin
  TslShape.Create(self,2);
end;

procedure Tmain.NEURON1Click(Sender: TObject);
begin
  TslShape.Create(self,3);
end;

procedure Tmain.Paint;
var i:integer;
    r:TRect;
begin
  inherited Paint;
  if dlin then
  for i:=0 to scon.Count-1 do begin
    r:=scon.GetCoord(i);
    Canvas.MoveTo(r.Left,r.Top);
    Canvas.Pen.Color:=scon.GetColor(i);
    Canvas.LineTo(r.Right,r.Bottom);
  end;
end;


procedure Tmain.LineColor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then scon.DefC:=Colordialog1.Color;
end;

procedure ShutOFF;
begin
    scon.Reset;
    main.STP.enabled:=false;
    main.RTE.enabled:=false;
    main.LoopStep.enabled:=false;
    main.Initialize.Enabled:=true;
    main.InitLoop.Enabled:=true;
    main.Caption:='Neuron Builder - building';
end;

procedure Tmain.InitLoopClick(Sender: TObject);
begin
  Loop:=true;
  scon.Reset;
  Debug:=true;
  Initing:=true;
  LoopStep.Enabled:=true;
  Initialize.Enabled:=false;
  Caption:='Neuron Builder - running with loop control';
end;

procedure Tmain.InitializeClick(Sender: TObject);
begin
  Loop:=false;
  scon.Reset;
  Debug:=true;
  Initing:=true;
  STP.enabled:=true;
  RTE.enabled:=true;
  InitLoop.Enabled:=false;
  Caption:='Neuron Builder - running linear';
end;

procedure Tmain.STPClick(Sender: TObject);
begin
  if scon.Step then ShutOff;
end;

procedure Tmain.Reset1Click(Sender: TObject);
begin
  ShutOff;
end;

procedure Tmain.ReserAll1Click(Sender: TObject);
begin
  scon.ResetAll;
  ShutOff;
end;

procedure Tmain.RTEClick(Sender: TObject);
begin
  if scon.Step then ShutOff;
  repeat until scon.Step;
end;

procedure Tmain.LoopStepClick(Sender: TObject);
begin
  scon.LoopStep;
end;

procedure Tmain.About1Click(Sender: TObject);
begin
  Aboutf.ShowModal;
end;

procedure Tmain.INColor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then C1:=Colordialog1.Color;
end;

procedure Tmain.OUTColor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then C2:=Colordialog1.Color;
end;

procedure Tmain.NEURONColor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then C3:=Colordialog1.Color;
end;

procedure Tmain.Save1Click(Sender: TObject);
begin
  Save;
end;

procedure Tmain.Load1Click(Sender: TObject);
begin
  Load;
end;

procedure Tmain.Clearworkspace1Click(Sender: TObject);
begin
  ClearW;
  main.RePaint;
end;

procedure Tmain.GenerateWeight1Click(Sender: TObject);
begin
  GenReport;
end;

procedure Tmain.ShowGridClick(Sender: TObject);
begin
  if ShowGrid.Checked then begin
    Brush.style:=bsSolid;
    Color:=clWhite;
    ShowGrid.Checked:=false;
  end else begin
    Brush.style:=bsCross;
    Color:=clBTNFace;
    ShowGrid.Checked:=true;
  end;

end;

procedure Tmain.FormResize(Sender: TObject);
begin
RePaint;
end;

procedure Tmain.N5x51Click(Sender: TObject);
begin
  GenerateTemplate(5,5);
end;

procedure Tmain.N4x41Click(Sender: TObject);
begin
  GenerateTemplate(4,4);
end;

procedure Tmain.N6x61Click(Sender: TObject);
begin
  GenerateTemplate(6,6);
end;

procedure Tmain.N6x11Click(Sender: TObject);
begin
  GenerateTemplate(6,1);
end;

procedure Tmain.N6x21Click(Sender: TObject);
begin
  GenerateTemplate(6,2);
end;

procedure Tmain.N6x31Click(Sender: TObject);
begin
  GenerateTemplate(6,3);
end;

procedure Tmain.N1x61Click(Sender: TObject);
begin
  GenerateTemplate(1,6);
end;

procedure Tmain.N2x61Click(Sender: TObject);
begin
  GenerateTemplate(2,6);
end;

procedure Tmain.N3x61Click(Sender: TObject);
begin
  GenerateTemplate(3,6);
end;

end.
