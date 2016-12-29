unit KontrAgent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, DB, DBTables, StdCtrls, Mask;

type
  TKontrAgenti = class(TForm)
    Kontragenti_DataSource: TDataSource;
    Kontragenti_Table: TTable;
    Kontragenti_DBNavigator: TDBNavigator;
    Kontragenti_Kod: TDBEdit;
    Kontragenti_Name: TDBEdit;
    Kontragenti_FullName: TDBEdit;
    Kontragenti_INN: TDBEdit;
    Kontragenti_YrAdres: TDBEdit;
    Kontragenti_PochtAdres: TDBEdit;
    Kontragenti_Telefon: TDBEdit;
    Kontragenti_Chet: TDBEdit;
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
  KontrAgenti: TKontrAgenti;

implementation

{$R *.dfm}

end.
