unit In_postuplenie2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ComCtrls,ExtCtrls, Mask,Tabl_postuplenie;

type
  TIn_postup = class(TForm)
    Postup_kolvo: TDBEdit;
    Postup_cena: TDBEdit;
    Postup_sklad: TDBEdit;
    Postup_data: TDateTimePicker;
    Postup_naimen: TDBComboBox;
    Label_data: TLabel;
    Label_naimen: TLabel;
    Label_sklad: TLabel;
    Label_cena: TLabel;
    Label_kolvo: TLabel;
    Button_add_postup: TButton;
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
         FieldByName('Data_P').Value :=  In_postup.Postup_data.Date;
         FieldByName('Kolvo').Value := StrToInt(In_postup.Postup_Kolvo.Text);
         Post;
         Append;
         Post;
       end;
     end;
end;

end.
