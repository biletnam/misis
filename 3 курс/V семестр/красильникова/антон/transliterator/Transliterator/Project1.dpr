program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fmMain};

{$R *.RES}

begin
  Application.Title:='Transliterator v1.02 - by Loonies Software';
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
