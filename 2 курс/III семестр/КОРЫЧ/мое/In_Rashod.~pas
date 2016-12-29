unit In_Rashod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabl_Rashod, StdCtrls, Mask, DBCtrls, ComCtrls;

type
  TIn_Rashodi = class(TForm)
    Rashod_Data: TDateTimePicker;
    Rashod_Vid: TDBEdit;
    Rashod_KontrAgent: TDBEdit;
    Rashod_Summa: TDBEdit;
    Label_Rashod_Data: TLabel;
    Label_Rashod_Vid: TLabel;
    Label_Rashod_KontrAgent: TLabel;
    Label_Rashod_Summa: TLabel;
    Button_Add_Rashod: TButton;
    procedure Button_Add_RashodClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  In_Rashodi: TIn_Rashodi;

implementation

{$R *.dfm}

procedure TIn_Rashodi.Button_Add_RashodClick(Sender: TObject);
begin
   If (Rashod_Vid.Text='') OR (Rashod_KontrAgent.Text='') OR (Rashod_Summa.Text='') then
   ShowMessage('Заполнены не все поля')
   else begin
     with Tabl_Rashodi.Rashodi_Table do
       begin
         FieldByName('Data').Value :=  In_Rashodi.Rashod_Data.Date;
         Post;
         Append;
         Post;
       end;
   end;
end;



end.
