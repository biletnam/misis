unit Tabl_skladII;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Mask, DBCtrls, ExtCtrls;

type
  TKod_sklad = class(TForm)
    Sklad_DataSource: TDataSource;
    Kod_Label: TLabel;
    Mesto_hran_Label: TLabel;
    Otv_lico_Label: TLabel;
    Tip_Label: TLabel;
    Mesto_hran_sklad: TDBEdit;
    Otv_lico_Sklad: TDBEdit;
    Tip_sklad: TDBEdit;
    Sklad_Table: TTable;
    fgdh: TDBEdit;
    Sklad_DBNavigator: TDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Kod_sklad: TKod_sklad;

implementation

{$R *.dfm}

end.
