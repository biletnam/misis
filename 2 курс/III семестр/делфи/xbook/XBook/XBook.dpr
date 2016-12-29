program XBook;

uses
  Forms,
  uBook in 'uBook.pas' {Form1Tree},
  about in 'about.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'XBook';
  Application.CreateForm(TForm1Tree, Form1Tree);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
