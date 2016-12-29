unit MainForm;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, FrmAuthor, FrmMagazine, ComCtrls, FrmArticle,
  FrmIssue, Grids, DBGrids, StdCtrls, FrmArticleAuthor, AppEvnts;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FrameMagazine1: TFrameMagazine;
    FrameAuthor1: TFrameAuthor;
    Bevel1: TBevel;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    FrameIssue1: TFrameIssue;
    Bevel2: TBevel;
    FrameArticle1: TFrameArticle;
    DBNavigator3: TDBNavigator;
    DBNavigator4: TDBNavigator;
    Bevel3: TBevel;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    FrameArticleAuthor1: TFrameArticleAuthor;
    DBNavigator5: TDBNavigator;
    DBLookupComboBox1: TDBLookupComboBox;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DataMod, DBClient;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
// Note: This could also have been done in the Data Module itself
begin
  with DataModule1 do
  begin
    cdsMagazine.Active := True;
    cdsAuthor.Active := True;
    cdsIssue.Active := True;
    cdsArticle.Active := True;
    cdsArticleAuthor.Active := True
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
// Note: This could also have been done in the Data Module itself

  procedure MergeAndClose(var CDS: TClientDataSet);
  begin
    if CDS.ChangeCount > 0 then
    begin
      CDS.MergeChangeLog;
      CDS.SaveToFile // needed since...
    end;
    CDS.Active := False // this will not save anymore, since ChangeCount = 0!!
  end;

begin
  with DataModule1 do
  begin
    MergeAndClose(cdsMagazine);
    MergeAndClose(cdsAuthor);
    MergeAndClose(cdsIssue);
    MergeAndClose(cdsArticle);
    MergeAndClose(cdsArticleAuthor)
  end
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  ShowMessage((Sender AS TComponent).Name + E.Message);
end;

end.

