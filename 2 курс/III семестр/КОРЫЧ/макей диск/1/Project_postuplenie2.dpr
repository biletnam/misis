program Project_postuplenie2;

uses
  Forms,
  In_postuplenie2 in 'In_postuplenie2.pas' {In_postup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TIn_postup, In_postup);
  Application.Run;
end.
