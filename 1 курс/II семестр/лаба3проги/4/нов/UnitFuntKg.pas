unit UnitFuntKg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFunt_Kg = class(TForm)
    ButtonPerechet: TButton;
    EditFunt: TEdit;
    LabelText: TLabel;
    LabelKg: TLabel;
    procedure ButtonPerechetClick(Sender: TObject);
    procedure EditFuntKeyPress(Sender: TObject; var Key: Char);
    procedure EditFuntChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Funt_Kg: TFunt_Kg;

implementation

{$R *.dfm}

procedure TFunt_Kg.ButtonPerechetClick(Sender: TObject);
var
   funt: real; // масса в фунтах
   kg: real;   // масса в килограммах
begin
   funt := StrToFloat(EditFunt.Text);
   kg := funt * 0.4095;
   LabelKg.Caption := FloatToStrF(funt,ffGeneral,5,2) + ' ф - это ' + FloatToStrF(kg,ffGeneral,5,2) + ' кг';
end;

procedure TFunt_Kg.EditFuntKeyPress(Sender: TObject; var Key: Char);
begin
   case Key of
            '0'..'9', #8: ; // цифры и клавиша <Backspace>
            '.' , ',':
                     begin
                        Key := DecimalSeparator;
                        If pos(DecimalSeparator,EditFunt.Text) <> 0 then Key := Char(0);
                     end;
            else Key := Char(0); // остальные символы запрещены
   end;
end;

procedure TFunt_Kg.EditFuntChange(Sender: TObject);
begin
   // проверим есть ли в поле Edit1 исходные данные
   If Length(EditFunt.Text) = 0
   then ButtonPerechet.Enabled := False // кнопка Пересчет недоступна
   else ButtonPerechet.Enabled := True; // кнопка Пересчет доступна
end;

procedure TFunt_Kg.FormCreate(Sender: TObject);
begin
   ButtonPerechet.Enabled := false;
end;



end.

