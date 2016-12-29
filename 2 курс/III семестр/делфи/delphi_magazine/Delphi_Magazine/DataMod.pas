unit DataMod;
interface
uses
  SysUtils, Classes, DB, DBClient;

type
  TDataModule1 = class(TDataModule)
    cdsMagazine: TClientDataSet;
    cdsIssue: TClientDataSet;
    cdsArticle: TClientDataSet;
    cdsArticleAuthor: TClientDataSet;
    cdsAuthor: TClientDataSet;
    cdsMagazineMagazineID: TIntegerField;
    cdsMagazineTitle: TStringField;
    cdsMagazineEditorID: TIntegerField;
    cdsIssueIssueID: TIntegerField;
    cdsIssueMagazineID: TIntegerField;
    cdsIssueVolume: TIntegerField;
    cdsIssueNumber: TIntegerField;
    cdsIssueDate: TStringField;
    cdsArticleArticleID: TIntegerField;
    cdsArticleIssueID: TIntegerField;
    cdsArticleTitle: TStringField;
    cdsArticleAuthorArticleID: TIntegerField;
    cdsArticleAuthorAuthorID: TIntegerField;
    cdsAuthorAuthorID: TIntegerField;
    cdsAuthorName: TStringField;
    cdsAuthorEmail: TStringField;
    dsMagazine: TDataSource;
    dsEditor: TDataSource;
    cdsMagazineEditorName: TStringField;
    cdsMagazineEditorEmail: TStringField;
    cdsArticleIssueVolume: TIntegerField;
    cdsArticleIssueNumber: TIntegerField;
    cdsArticleIssueDate: TStringField;
    cdsArticleAuthorAuthorName: TStringField;
    cdsArticleAuthorAuthorEmail: TStringField;
    dsIssue: TDataSource;
    dsArticle: TDataSource;
    dsArticleAuthor: TDataSource;
    cdsArticleMagazineID: TIntegerField;
    procedure cdsIssueBeforeInsert(DataSet: TDataSet);
    procedure cdsIssueAfterInsert(DataSet: TDataSet);
    procedure cdsArticleBeforeInsert(DataSet: TDataSet);
    procedure cdsArticleAfterInsert(DataSet: TDataSet);
    procedure cdsArticleAuthorAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    LastIssueID: Integer;
    LastMagazineID: Integer;
    LastVolume: Integer;
    LastNumber: Integer;
    LastDate: String[7];
    LastArticleID: Integer;
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation
{$R *.dfm}

procedure TDataModule1.cdsIssueBeforeInsert(DataSet: TDataSet);
begin
  cdsIssue.Last;
  LastIssueID := cdsIssueIssueID.AsInteger;
  LastMagazineID := cdsIssueMagazineID.AsInteger;
  LastVolume := cdsIssueVolume.AsInteger;
  LastNumber := cdsIssueNumber.AsInteger;
  LastDate := cdsIssueDate.AsString;
end;

procedure TDataModule1.cdsIssueAfterInsert(DataSet: TDataSet);
begin
  cdsIssueIssueID.AsInteger := LastIssueID + 1;
  cdsIssueMagazineID.AsInteger := LastMagazineID;
  cdsIssueVolume.AsInteger := LastVolume;
  cdsIssueNumber.AsInteger := LastNumber + 1;
  cdsIssueDate.AsString := LastDate;
end;

procedure TDataModule1.cdsArticleBeforeInsert(DataSet: TDataSet);
begin
  cdsArticle.Last;
  LastArticleID := cdsArticleArticleID.AsInteger;
  LastIssueID := cdsArticleIssueID.AsInteger;
end;

procedure TDataModule1.cdsArticleAfterInsert(DataSet: TDataSet);
begin
  cdsArticleArticleID.AsInteger := LastArticleID + 1;
  cdsArticleIssueID.AsInteger := LastIssueID + 1;
end;

procedure TDataModule1.cdsArticleAuthorAfterInsert(DataSet: TDataSet);
begin
  cdsArticleAuthorAuthorID.AsInteger := 1; // by default, I'm the author
end;

end.

