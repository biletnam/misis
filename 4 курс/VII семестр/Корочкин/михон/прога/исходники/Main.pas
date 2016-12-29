unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, Logic, StdCtrls, Myclasses, XPMan, Input;

type
  TForm1 = class(TForm)
    TickTimer: TTimer;
    InfoTimer: TTimer;
    ListBox1: TListBox;
    StringGrid1: TStringGrid;
    XPManifest1: TXPManifest;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button4: TButton;
    Label5: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure InfoTimerTimer(Sender: TObject);
    procedure TickTimerTimer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Log:TLog;
  SceneMan:TSceneMan;
implementation

uses ComCtrls;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  TickTimer.Enabled := not(TickTimer.Enabled);
  if TickTimer.Enabled
  then Button1.Caption:='Стоп'
  else Button1.Caption:='Старт';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SceneMan.NewClient;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SceneMan.CarMan.RemoveCar;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  Log:=TLog.Create(ListBox1);
  SceneMan:=TSceneMan.Create(Log);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  SceneMan.SetMinMax(Form2.Edit1,Form2.Edit2);
end;

procedure TForm1.InfoTimerTimer(Sender: TObject);
var i,kpd:integer;
    buf:TCar;
begin

    while SceneMan.CarMan.Cars.Count <> Form2.TrackBar1.Position do
    begin
      if SceneMan.CarMan.Cars.Count>Form2.TrackBar1.Position
      then SceneMan.CarMan.RemoveCar
      else SceneMan.CarMan.AddCar;
    end;

   TickTimer.Interval := Round(1000/Form2.TrackBar2.Position);
   Label1.Caption := Log.MakeTimeString(Log.Time);

   StringGrid1.RowCount := SceneMan.CarMan.Cars.Count + 1;
   if StringGrid1.RowCount=1 then StringGrid1.RowCount:=2;

   StringGrid1.FixedRows := 1;
   StringGrid1.Cells[0,0] := 'Такси';
   StringGrid1.Cells[1,0] := 'Состояние';
   StringGrid1.Cells[2,0] := 'Время работы';
   StringGrid1.Cells[3,0] := 'К-т простоя';
   for i := 0 to SceneMan.CarMan.Cars.Count - 1 do
   begin
    buf := SceneMan.CarMan.Cars[i] as TCar;

   StringGrid1.Cells[0,i+1] := buf.Name;
   if buf.Active then StringGrid1.Cells[1,i+1] := buf.Client.Name
   else StringGrid1.Cells[1,i+1] := 'Ожидание';
   StringGrid1.Cells[2,i+1] := IntToStr(buf.WorkTime) + ' мин.';

   if (buf.WorkTime+buf.WaitTime)<>0
   then kpd:=Round(100*buf.WaitTime/(buf.WorkTime+buf.WaitTime))
   else kpd:=100;

   StringGrid1.Cells[3,i+1] := IntToStr(kpd)+'%';

   end;

   // Статистика
   BEGIN
     Label2.Caption := 'Заявки: '+IntToStr(SceneMan.Clients.Count);
     Label3.Caption := 'Обслужено клинтов: '+IntToStr(SceneMan.CarMan.ServedClients);
     Label4.Caption := 'Свободно машин: '+IntToStr(SceneMan.FreeCars.Count);
     Label5.Caption := 'В очереди: '+IntToStr(SceneMan.NeedToServe.Count);
   END;
end;

procedure TForm1.TickTimerTimer(Sender: TObject);
begin
  if Random<=(StrToInt(Form2.Edit3.Text)/StrToInt(Form2.Edit4.Text)) then SceneMan.NewClient;

  if Log.Time>= 22*3600 then Button1.Click
  else
  begin
    Log.Tick(60);
    SceneMan.Tick(1);
  end;
end;

end.
