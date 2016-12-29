unit In_postuplenie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ComCtrls, Mask,Tabl_postuplenie;

type
  TIn_postup = class(TForm)
    Label_data: TLabel;
    Label_naimen: TLabel;
    Label_sklad: TLabel;
    Label_cena: TLabel;
    Label_kolvo: TLabel;
    Postup_naimen: TDBEdit;
    Postup_kolvo: TDBEdit;
    Postup_cena: TDBEdit;
    Postup_data: TDateTimePicker;
    Button_add_postup: TButton;
    Postup_sklad: TDBComboBox;
    procedure Button_add_postupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  In_postup: TIn_postup;

implementation

{$R *.dfm}

procedure TIn_postup.Button_add_postupClick(Sender: TObject);
begin
IF (Postup_naimen.Text='') OR (Postup_sklad.Text='') OR (Postup_cena.Text='') OR (Postup_kolvo.Text='') then
     ShowMessage('Заполнены не все поля')
     else begin
       with Tabl_postuplenie.Tabl_postup do
       begin
         FieldByName('Data').Value :=  In_postup.Postup_data.Date;
         FieldByName('Summa').Value := StrToInt(In_postup.Postup_Kolvo.Text);
         Post;
         Append;
         Post;
       end;
     end;
end;

end.
