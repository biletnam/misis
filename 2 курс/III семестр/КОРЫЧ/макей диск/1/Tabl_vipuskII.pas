unit Tabl_vipuskII;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TTabl_vipusk = class(TForm)
    Vipusk_DataSource: TDataSource;
    Vipusk_DBGrid: TDBGrid;
    Vipusk_DBNavigator: TDBNavigator;
    Vipusk_Table: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tabl_vipusk: TTabl_vipusk;

implementation

{$R *.dfm}

end.
