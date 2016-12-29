unit Tabl_Dohod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TTabl_Dohodi = class(TForm)
    Dohodi_DBGrid: TDBGrid;
    Dohodi_DBNavigator: TDBNavigator;
    Dohodi_DataSource: TDataSource;
    Dohodi_Table: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tabl_Dohodi: TTabl_Dohodi;

implementation

{$R *.dfm}

end.
