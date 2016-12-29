unit In_Zarplat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabl_Zarplat, Sotrudnik, StdCtrls, Mask, DBCtrls, ComCtrls;

type
  TIn_Zarplata = class(TForm)
    Zarplat_Data: TDateTimePicker;
    Zarplat_Summa: TDBEdit;
    Zarplat_ButtonAdd: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Zarplat_FIO: TDBLookupComboBox;
    procedure Zarplat_ButtonAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  In_Zarplata: TIn_Zarplata;

implementation

{$R *.dfm}

procedure TIn_Zarplata.Zarplat_ButtonAddClick(Sender: TObject);
begin
  with Tabl_Zarplata.Zarplata_Table do
     begin
       FieldByName('Data').Value :=  In_Zarplata.Zarplat_Data.Date;
       Post;
       Append;
       Post;
     end;
end;

end.
