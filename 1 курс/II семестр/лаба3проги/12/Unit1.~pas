unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   r1,r2: real; // велечины сопротивлений
   r: real; // сопротивление цепи
begin
   // получить исходные данные
   r1 := StrToFloat(Edit1.Text);
   r2 := StrToFloat(Edit2.Text);

   If (r1 = 0) and (r2 = 0) then
   begin
      ShowMessage('Надо задать величину хотя бы одного сопротивления');
      exit;
   end;

   If RadioButton1.Checked
       then // выбран перекючатель Последовательно
           r := r1 + r2
       else // выбран перекючатель Параллельно
           r := (r1*r2)/(r1+r2);
   Label4.Caption := 'Сопротивление цепи: ';
   If r < 1000 then
      Label4.Caption := Label4.Caption + FloatToStrF(r,ffGeneral,3,2) + ' Ом'
   else
     begin
        r := r/1000;
        Label4.Caption := Label4.Caption + FloatToStrF(r,ffGeneral,3,2) + ' кОм';
     end
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
   Label4.Caption := '';
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
   Label4.Caption := '';
end;

end.
