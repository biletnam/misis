program neuron;

uses
  Forms,
  mainunit in 'mainunit.pas' {main},
  nshape in 'nshape.pas',
  rmform in 'rmform.pas' {renamer},
  weigunit in 'weigunit.pas' {Weigf},
  aboutunit in 'aboutunit.pas' {AboutF},
  filework in 'filework.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Neuron Builder 98';
  Application.CreateForm(Tmain, main);
  Application.CreateForm(TAboutF, AboutF);
  Application.Run;
end.
