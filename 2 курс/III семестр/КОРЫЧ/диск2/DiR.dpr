program DiR;

uses
  Forms,
  Main in 'Main.pas' {Form_Main},
  In_Dohod in 'In_Dohod.pas' {In_Dohodi},
  Tabl_Dohod in 'Tabl_Dohod.pas' {Tabl_Dohodi},
  Tabl_Rashod in 'Tabl_Rashod.pas' {Tabl_Rashodi},
  In_Rashod in 'In_Rashod.pas' {In_Rashodi},
  Tabl_Zarplat in 'Tabl_Zarplat.pas' {Tabl_Zarplata},
  In_Zarplat in 'In_Zarplat.pas' {In_Zarplata},
  KontrAgent in 'KontrAgent.pas' {KontrAgenti},
  Sotrudnik in 'Sotrudnik.pas' {Sotrudniki},
  QDohod in 'QDohod.pas' {QDohodi},
  About in 'About.pas' {FormAbout},
  QRashod in 'QRashod.pas' {QRashodi},
  Password in 'Password.pas' {PasswordForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPasswordForm, PasswordForm);
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TIn_Dohodi, In_Dohodi);
  Application.CreateForm(TTabl_Dohodi, Tabl_Dohodi);
  Application.CreateForm(TTabl_Rashodi, Tabl_Rashodi);
  Application.CreateForm(TIn_Rashodi, In_Rashodi);
  Application.CreateForm(TTabl_Zarplata, Tabl_Zarplata);
  Application.CreateForm(TIn_Zarplata, In_Zarplata);
  Application.CreateForm(TKontrAgenti, KontrAgenti);
  Application.CreateForm(TSotrudniki, Sotrudniki);
  Application.CreateForm(TQDohodi, QDohodi);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TQRashodi, QRashodi);
  Application.Run;
end.
