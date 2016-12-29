unit Tabl_postuplenie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TTabl_postup = class(TForm)
    Postup_DataSource: TDataSource;
    Postup_DBGrid: TDBGrid;
    Postup_DBNavigator: TDBNavigator;
    Postup_Table: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tabl_postup: TTabl_postup;

implementation

{$R *.dfm}

end.
