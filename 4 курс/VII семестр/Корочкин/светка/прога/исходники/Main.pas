unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPMan, StdCtrls, Logic, myclasses, InputForm;

type
  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    LogListBox: TListBox;
    Button1: TButton;
    InfoTimer: TTimer;
    TickTimer: TTimer;
    TimeLabel: TLabel;
    Button2: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure InfoTimerTimer(Sender: TObject);
    procedure TickTimerTimer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure UpdateStat;

var
  Form1: TForm1;
  Log: TLog;
  SceneMan:TSceneMan;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TickTimer.Enabled := not(TickTimer.Enabled);
  if TickTimer.Enabled then Button2.Caption := 'Стоп'
  else Button2.Caption := 'Старт';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SceneMan.Reset;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SceneMan.ClientMan.NewClient;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  Log := TLog.Create(LogListBox);
  SceneMan := TSceneMan.Create(Log);
  SceneMan.CreateCarMan(GroupBox2);
end;

procedure TForm1.FormShow(Sender: TObject);
var i: integer;
    buf:TClient;
    buf2:TCar;
begin
   for i := 0 to SceneMan.CarMan.Cars.Count - 1 do
   begin
      buf2 := SceneMan.CarMan.Cars[i] as TCar;
      buf2.CreateSettings(Form2.GroupBox2);
      if i=0 then buf2.Settings.ChangeCoord(10,20)
      else buf2.Settings.NextTo((SceneMan.CarMan.Cars[i-1] as TCar).Settings);
   end;
   SceneMan.ClientMan.SetInt(Form2.Edit1,Form2.Edit2);
   with SceneMan.CarMan do
   begin
    (Cars[0] as TCar).SetServeTime(10,15);
    (Cars[1] as TCar).SetServeTime(8,20);
    (Cars[2] as TCar).SetServeTime(10,18);
    (Cars[3] as TCar).SetServeTime(15,18);
    (Cars[4] as TCar).SetServeTime(20,30);
   end;
end;

procedure TForm1.InfoTimerTimer(Sender: TObject);
begin
  SceneMan.UpdateInfo;
  TimeLabel.Caption := Log.MakeTimeString(Log.Time);
  TickTimer.Interval := Round(1000/Form2.TrackBar1.Position);
  UpdateStat;
end;

procedure TForm1.TickTimerTimer(Sender: TObject);
begin
  if SceneMan.Log.Time<22*3600 then
  SceneMan.Tick(1) // шаг времени 1 мин
  else
  begin
    Button2.Click;
    SceneMan.Log.Add('Эксперимент закончен.');
    //Form3.Show;
  end;
end;

procedure UpdateStat();
var avg:integer;
begin
  if SceneMan.ClientMan.TotalServed<>0 then avg:=Round(SceneMan.CarMan.TotalServeTime/SceneMan.ClientMan.TotalServed) else avg:=0;
  Form1.Label1.Caption := 'Клиентов в ресторане: ' + IntToStr(SceneMan.ClientMan.Clients.Count);
  Form1.Label2.Caption := 'Свободно мест: ' + IntToStr(SceneMan.ClientMan.TotalPlaces - SceneMan.ClientMan.Clients.Count);
  Form1.Label10.Caption := 'Общий доход: ' + IntToStr(SceneMan.CarMan.TotalMoney) + ' $';
  Form1.Label11.Caption := 'Всего обслужено: ' + IntToStr(SceneMan.ClientMan.TotalServed) + ' чел.';
  Form1.Label3.Caption := 'Среднее время обслуживания: ' + IntToStr(avg) + ' мин.';
  Form1.Label6.Caption := 'Больше всего заработал: ' + SceneMan.CarMan.FindMaxMoney.Name;
  Form1.Label5.Caption := 'Меньше всего заработал: ' + SceneMan.CarMan.FindMinMoney.Name;
  Form1.Label4.Caption := 'Наибольшая занятость у: ' + SceneMan.CarMan.FindMaxWork.Name;
  Form1.Label12.Caption := 'Наименьшая занятость у: ' + SceneMan.CarMan.FindMinWork.Name;
end;

end.
