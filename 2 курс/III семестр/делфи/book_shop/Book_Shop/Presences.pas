unit Presences;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm_Presences = class(TForm)
    Table_Presences: TTable;
    DataSource_Presences: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button_Close: TButton;
    procedure Button_CloseClick(Sender: TObject);
    procedure Table_PresencesBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Presences: TForm_Presences;

implementation

{$R *.DFM}

procedure TForm_Presences.Button_CloseClick(Sender: TObject);
begin
     Close;
end;

procedure TForm_Presences.Table_PresencesBeforeDelete(DataSet: TDataSet);
begin
     if MessageDlg('Текущая запись и все связанные с ней записи будут удалены.'
        +#13+'Продолжить?',
        mtConfirmation,[mbOK,mbCancel],0)=mrCancel then begin
        Abort;
     end;
end;

end.
