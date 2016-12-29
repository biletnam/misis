program TDM97;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  DataMod in 'DataMod.pas' {DataModule1: TDataModule},
  FrmMagazine in 'FrmMagazine.pas' {FrameMagazine: TFrame},
  FrmAuthor in 'FrmAuthor.pas' {FrameAuthor: TFrame},
  FrmIssue in 'FrmIssue.pas' {FrameIssue: TFrame},
  FrmArticle in 'FrmArticle.pas' {FrameArticle: TFrame},
  FrmArticleAuthor in 'FrmArticleAuthor.pas' {FrameArticleAuthor: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
