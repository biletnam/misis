unit Tabl_Zarplat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TTabl_Zarplata = class(TForm)
    Zarplata_DataSource: TDataSource;
    Zarplata_DBGrid: TDBGrid;
    Zarplata_DBNavigator: TDBNavigator;
    Zarplata_Table: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tabl_Zarplata: TTabl_Zarplata;

implementation

{$R *.dfm}

end.
