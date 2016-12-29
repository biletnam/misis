program prjcMath;

uses
  Forms,
  cmath in 'cmath.pas' {frmMain},
  funclevel in 'funclevel.pas',
  dichotomy in 'dichotomy.pas',
  Gauss in 'Gauss.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
