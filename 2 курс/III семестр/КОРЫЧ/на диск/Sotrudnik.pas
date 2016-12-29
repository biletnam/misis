unit Sotrudnik;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, StdCtrls, Mask;

type
  TSotrudniki = class(TForm)
    Sotrudniki_DBNavigator: TDBNavigator;
    Sotrudniki_DataSource: TDataSource;
    Sotrudniki_Table: TTable;
    Sotrudniki_Num: TDBEdit;
    Sotrudniki_Nomer: TDBEdit;
    Sotrudniki_FIO: TDBEdit;
    Sotrudniki_INN: TDBEdit;
    Sotrudniki_NumStrah: TDBEdit;
    Sotrudniki_Dolgnost: TDBEdit;
    Sotrudniki_RegAdres: TDBEdit;
    Sotrudniki_FakAdres: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Sotrudniki: TSotrudniki;

implementation

{$R *.dfm}

end.
