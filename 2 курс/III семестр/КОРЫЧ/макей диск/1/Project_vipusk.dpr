program Project_vipusk;

uses
  Forms,
  Tabl_vipuskII in 'Tabl_vipuskII.pas' {Tabl_vipusk};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabl_vipusk, Tabl_vipusk);
  Application.Run;
end.
