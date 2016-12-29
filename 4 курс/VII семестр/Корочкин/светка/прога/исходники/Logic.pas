unit Logic;

interface
uses classes, Sysutils, Contnrs, myclasses,Forms, StdCtrls, ComCtrls, ExtCtrls, Controls, Math, Graphics;

Type TClientControls=class(Tobject)
  Name:string;
  GroupBox: TGroupBox;
  NeedMassInfo: TInfoRecord;
  TotalWaitTimeInfo: TInfoRecord;
  Constructor Create(cName: string; cParent: TWinControl);
  procedure ChangeCoord(X,Y: integer);
  procedure NextTo(CC: TClientControls; delta: integer);
end;

Type TClientSettings=class(TObject)
  Panel: TPanel;
  NameEdit: TEdit;
  MinRequest: TIntegerInput;
  MaxRequest: TIntegerInput;
  TimeRange: TIntegerInput;
  MinGoingTime: TIntegerInput;
  MaxGoingTime: TIntegerInput;
  Constructor Create(cName: string; cParent: TWinControl);
  procedure ChangeCoord(X,Y:integer);
  procedure RightTo(S: TClientSettings; delta:integer);
end;

Type TClient=class(TObject)
  Name:string;
  Log:TLog;
  TotalWaitTime:integer;
  Serving: Boolean;
  Delete:Boolean;
  Constructor Create(cName: string; cLog:TLog);
end;

Type TClientMan=class(TObject)
  Log:TLog;
  Clients: TObjectList;
  TotalPlaces: integer;
  TotalClients: integer;
  TotalServed:integer;
  IntNum,IntTime:TEdit;
  Constructor Create(cLog:TLog);
  procedure AddClient(Name: string);
  procedure NewClient;
  procedure Tick(dt: integer);
  procedure SetInt(cIntNum,cIntTime:TEdit);
end;

Type TCarSettings=class(TObject)
  Panel: TPanel;
  MinTime: TIntegerInput;
  MaxTime: TIntegerInput;
  Constructor Create(cName: string; cParent: TWinControl);
  procedure ChangeCoord(X,Y:integer);
  procedure NextTo(S: TCarSettings);
end;

Type TCar=Class(TObject)
  Name: string;
  Log:TLog;
  Controls: TInfoControls;
  Settings: TCarSettings;
  Client:TClient;
  Active: Boolean;
  TimeRemain: integer;
  WaitTime: integer;
  WorkTime: integer;
  Money: integer;
  Constructor Create(cName: string; cParent: TWinControl; cLog:TLog);
  procedure UpdateInfo;
  procedure Tick(dt: integer);
  procedure SetRequest(cClient:TClient);
  procedure SetServeTime(Min,Max:integer);
  procedure CreateSettings(cParent: TWinControl);
  procedure Reset;
end;

Type TCarMan=class(TObject)
  Control: TWinControl;
  Log:TLog;
  Cars: TObjectList;
  TotalMoney:integer;
  TotalServeTime:integer;
  Constructor Create(cParent: TWinControl; cLog:TLog);
  procedure AddCar(Name: string);
  procedure UpdateCarsInfo;
  procedure Tick(dt: integer);
  function FindMaxMoney:TCar;
  function FindMinMoney:TCar;
  function FindMaxWork:TCar;
  function FindMinWork:TCar;
end;

Type TSceneMan=class(TObject)
  Log:TLog;
  CarMan: TCarMan;
  ClientMan: TClientMan;
  Constructor Create(cLog:TLog);
  procedure CreateCarMan(cParent: TWinControl);
  procedure UpdateInfo;
  procedure Tick(dt: integer);
  procedure LogicTick;
  function SelectRandomCar(Clients: TObjectList):TCar;
  function NeedToServe():TObjectList;
  function FreeCars():TObjectList;
  procedure Reset;
end;

implementation

Constructor TCar.Create(cName: string; cParent: TWinControl; cLog:TLog);
begin
  Controls := TInfoControls.Create(cName,cParent);
  Name:= cName;
  Client := nil;
  Active := true;
  TimeRemain := -1;
  WaitTime:=0;
  WorkTime:=0;
  Money :=0;
  Log := cLog;
end;

procedure TCar.SetServeTime(Min,Max:integer);
begin
  Settings.MinTime.Edit.Text := IntToStr(Min);
  Settings.MinTime.Value := Min;
  Settings.MaxTime.Edit.Text := IntToStr(Max);
  Settings.MaxTime.Value := Max;
end;

procedure TCar.Reset;
begin
  Client:=nil;
  TimeRemain:=-1;
  WorkTime:=0;
  WaitTime:=0;
  Money :=0;
  Active:=False;
end;

procedure TCar.UpdateInfo();
var kpd:integer;
begin
  with Controls do
  begin

    If Client<>nil then
    begin
      StateInfo.Edit.Text := 'Работа';
      StateInfo.Edit.Font.Color := clGreen;
    end
    else
    begin
      StateInfo.Edit.Text := 'Ожидание';
      StateInfo.Edit.Font.Color := clRed;
    end;

    WorkInfo.Edit.Text := IntToStr(WorkTime) + ' мин.';
    if (WaitTime+WorkTime)<>0 then kpd:=Round(100*WorkTime/(WaitTime+WorkTime))
    else kpd:=0;
    WaitPercent.Edit.Text := IntToStr(kpd) + ' %';
    MoneyInfo.Edit.Text := IntToStr(Money)+' $';
  end;
end;

procedure TCar.SetRequest(cClient:TClient);
begin
  Client := cClient;
  Client.Serving:=true;
  TimeRemain := RandomRange(Settings.MinTime.Value,Settings.MaxTime.Value);
  Log.Add(Name + ' начал обслуживать ' + Client.Name+'.');
end;

procedure TCar.Tick(dt: integer);
var m:integer;
begin
  if Client<>nil then WorkTime:=WorkTime+dt
  else WaitTime:=WaitTime+dt;

  if Client<>nil then TimeRemain := TimeRemain - 1;

  if TimeRemain = 0 then
  begin
    m := RandomRange(20,50);
    Log.Add(Name + ' закончил обслуживать ' + Client.Name + '. Заработано: '+IntToStr(m)+'$.');
    Money := Money + m;
    TimeRemain := -1;
    Client.Delete := true;
    Client := nil;
  end;
end;

Constructor TClientControls.Create(cName: string; cParent: TWinControl);
var mDelta,mLeft:integer;
    Last:TInfoRecord;
begin
  Name := cName;
  mDelta := 20;
  mLeft := 10;
  GroupBox := TGroupBox.Create(cParent);
  GroupBox.Parent := cParent;
  GroupBox.Caption := cName;

  NeedMassInfo := TInfoRecord.Create('Заказ:',GroupBox,150);
  NeedMassInfo.ChangeCoord(mLeft,25);

  TotalWaitTimeInfo := TInfoRecord.Create('Общее время ожидания:',GroupBox,150);
  TotalWaitTimeInfo.NextTo(NeedMassInfo, mDelta);

  Last:=TotalWaitTimeInfo;
  GroupBox.Height := Last.InfoLabel.Top + 30;
  GroupBox.Width := Last.Edit.Left + Last.Edit.Width + 10;
end;

procedure TClientControls.ChangeCoord(X,Y: integer);
begin
  GroupBox.Left := X;
  GroupBox.Top := Y;
end;

procedure TClientControls.NextTo(CC: TClientControls; delta: integer);
begin
  GroupBox.Top := CC.GroupBox.Top + CC.GroupBox.Height + delta;
  GroupBox.Left := CC.GroupBox.Left;
end;

Constructor TClient.Create(cName: string; cLog:TLog);
begin
  Name := cName;
  TotalWaitTime:=0;
  Log:=cLog;
  Serving := false;
  Delete:=false;
end;

procedure TClientMan.AddClient(Name: string);
var buf: TClient;
begin
  buf:=TClient.Create(Name,Log);
  Clients.Add(buf);
  Log.Add(buf.Name + ' пришел в ресторан.');
end;

procedure TClientMan.NewClient;
begin
  if Clients.Count<TotalPlaces then
  begin
    TotalClients := TotalClients + 1;
    AddClient('Клиент'+IntToStr(TotalClients));
  end;
end;

Constructor TClientMan.Create(cLog:TLog);
begin
  Log:=cLog;
  TotalClients := 0;
  TotalPlaces := 20;
  TotalServed:=0;
  Clients := TObjectList.Create;
end;

procedure TClientMan.SetInt(cIntNum,cIntTime:TEdit);
begin
  IntNum:=cIntNum;
  IntTime:=cIntTime;
end;

procedure TClientMan.Tick(dt: integer);
var i:integer;
    buf:tclient;
begin
  if Random <= StrToInt(IntNum.Text)/StrToInt(IntTime.Text) then NewClient; 

  i:=0;
  while i<Clients.Count do
  begin
    buf:=Clients[i] as TClient;
    if buf.Delete then
    begin
       Log.Add(buf.Name + ' ушел из ресторана.');
       TotalServed := TotalServed + 1;
       Clients.Remove(buf);
       i:=i-1;
    end;
    i:=i+1;
  end;
end;

procedure TCarMan.AddCar(Name: string);
var buf: TCar;
begin
  buf:=TCar.Create(Name,Control,Log);
  if Cars.Count=0 then buf.Controls.ChangeCoord(10,15)
  else if Cars.Count=3 then buf.Controls.DowntTo((Cars.First as TCar).Controls,25)
  else buf.Controls.RightTo((Cars.Last as TCar).Controls,25);
  Cars.Add(buf);
end;

Constructor TCarMan.Create(cParent: TWinControl; cLog:TLog);
begin
  Control := cParent;
  Log:=cLog;
  TotalMoney:=0;
  TotalServeTime:=0;

  Cars := TObjectList.Create;

  AddCar('Официант 1');
  AddCar('Официант 2');
  AddCar('Официант 3');
  AddCar('Официант 4');
  AddCar('Официант 5');
end;

procedure TCarMan.UpdateCarsInfo;
var i:integer;
begin
   for i := 0 to Cars.Count - 1 do
   begin
     (Cars[i] as TCar).UpdateInfo;
   end;
end;

procedure TCarMan.Tick(dt: integer);
var i:integer;
    buf:TCar;
begin
   TotalMoney:=0;
   TotalServeTime:=0;
   for i := 0 to Cars.Count - 1 do
   begin
     buf:= Cars[i] as TCar;
     buf.Tick(dt);
     TotalMoney:=TotalMoney+buf.Money;
     TotalServeTime := TotalServeTime + buf.WorkTime;
   end;
end;

function TCarMan.FindMaxMoney:TCar;
var i:integer;
    buf,res:TCar;
begin
     res:=nil;
     for i := 0 to Cars.Count - 1 do
     begin
        buf:= Cars[i] as TCar;
        if i=0 then res:=buf else
        if buf.Money>res.Money then res:=buf;
     end;
     Result:=res;
end;

function TCarMan.FindMinMoney:TCar;
var i:integer;
    buf,res:TCar;
begin
     res:=nil;
     for i := 0 to Cars.Count - 1 do
     begin
        buf:= Cars[i] as TCar;
        if i=0 then res:=buf else
        if buf.Money<res.Money then res:=buf;
     end;
     Result:=res;
end;

function TCarMan.FindMaxWork:TCar;
var i:integer;
    buf,res:TCar;
begin
     res:=nil;
     for i := 0 to Cars.Count - 1 do
     begin
        buf:= Cars[i] as TCar;
        if i=0 then res:=buf else
        if buf.WorkTime>res.WorkTime then res:=buf;
     end;
     Result:=res;
end;

function TCarMan.FindMinWork:TCar;
var i:integer;
    buf,res:TCar;
begin
     res:=nil;
     for i := 0 to Cars.Count - 1 do
     begin
        buf:= Cars[i] as TCar;
        if i=0 then res:=buf else
        if buf.WorkTime<res.WorkTime then res:=buf;
     end;
     Result:=res;
end;
Constructor TSceneMan.Create(cLog:TLog);
begin
  Log:=cLog;
  ClientMan := TClientMan.Create(Log);
end;

procedure TSceneMan.CreateCarMan(cParent: TWinControl);
begin
  CarMan := TCarMan.Create(cParent, Log);
end;

procedure TSceneMan.UpdateInfo;
begin
  CarMan.UpdateCarsInfo;
end;

procedure TSceneMan.Tick(dt: integer);
begin
  LogicTick;
  Log.Tick(dt * 60);
  ClientMan.Tick(dt);
  CarMan.Tick(dt);
end;

function TSceneMan.SelectRandomCar(Clients: TObjectList):TCar;
var Res: TCar;
begin
   Res:=nil;
   if Clients.Count>0 then Res:=Clients[Random(Clients.Count)] as TCar;
   Result:=Res;
end;

function TSceneMan.NeedToServe():TObjectList;
var List: TObjectList;
    i:integer;
    Clbuf: TClient;
begin
  List := TObjectList.Create;
  for i := 0 to ClientMan.Clients.Count - 1 do
    begin
       Clbuf := (ClientMan.Clients[i] as TClient);
       if Clbuf.Serving=False then List.Add(Clbuf);
    end;
  Result:=List;
end;

function TSceneMan.FreeCars():TObjectList;
var List: TObjectList;
    i:integer;
    Carbuf: TCar;
begin
  List := TObjectList.Create;
  for i := 0 to CarMan.Cars.Count - 1 do
    begin
       Carbuf := (CarMan.Cars[i] as TCar);
       if Carbuf.Client=nil then List.Add(Carbuf);
    end;
  Result:=List;
end;

procedure TSceneMan.LogicTick;
begin
  while (NeedToServe.Count>0)and(FreeCars.Count>0) do
  begin
    SelectRandomCar(FreeCars).SetRequest(NeedToServe.First as TClient);
  end;
end;

procedure TCar.CreateSettings(cParent: TWinControl);
begin
  Settings:=TCarSettings.Create(Name, cParent);
end;

Constructor TClientSettings.Create(cName: string; cParent: TWinControl);
var lbl1,lbl2,lbl3, lbl4, lbl5, lbl6, lbl7,lbl8:TLabel;
begin
   Panel := TPanel.Create(cParent);
   Panel.Parent := cParent;
   Panel.BevelKind := bkTile;
   Panel.BevelOuter := bvNone;
   Panel.Height := 150;
   Panel.Width := 150;

   NameEdit := TEdit.Create(Panel);
   NameEdit.Parent := Panel;
   NameEdit.Text := cName;
   NameEdit.Left := 5;
   NameEdit.Top := 5;

   lbl1 := TLabel.Create(Panel);
   lbl1.Parent := Panel;
   lbl1.AutoSize := true;
   lbl1.Caption := 'Интенсивность заявок:';
   lbl1.Top := NameEdit.Top + NameEdit.Height + 5;
   lbl1.Left := NameEdit.Left;

   MinRequest := TIntegerInput.Create(5000,Panel);
   MinRequest.Edit.Top := lbl1.Top + lbl1.Height + 5;
   MinRequest.Edit.Left := NameEdit.Left;

   lbl2 := TLabel.Create(Panel);
   lbl2.Parent := Panel;
   lbl2.AutoSize := true;
   lbl2.Caption := '-';
   lbl2.Top := MinRequest.Edit.Top + 2;
   lbl2.Left := MinRequest.Edit.Left + MinRequest.Edit.Width +5;

   MaxRequest := TIntegerInput.Create(10000,Panel);
   MaxRequest.Edit.Top := MinRequest.Edit.Top;
   MaxRequest.Edit.Left := lbl2.Left + lbl2.Width + 5;

   lbl3 := TLabel.Create(Panel);
   lbl3.Parent := Panel;
   lbl3.AutoSize := true;
   lbl3.Caption := 'л.';
   lbl3.Top := MinRequest.Edit.Top + 7;
   lbl3.Left := MaxRequest.Edit.Left + MaxRequest.Edit.Width +5;

   lbl4 := TLabel.Create(Panel);
   lbl4.Parent := Panel;
   lbl4.AutoSize := true;
   lbl4.Caption := 'каждые';
   lbl4.Top := MaxRequest.Edit.Top + MaxRequest.Edit.Height + 12;
   lbl4.Left := NameEdit.Left;

   TimeRange := TIntegerInput.Create(60,Panel);
   TimeRange.Edit.Top := MaxRequest.Edit.Top + MaxRequest.Edit.Height + 5;
   TimeRange.Edit.Left := lbl4.Left + lbl4.Width + 5;

   lbl5 := TLabel.Create(Panel);
   lbl5.Parent := Panel;
   lbl5.AutoSize := true;
   lbl5.Caption := 'мин.';
   lbl5.Top := lbl4.Top;
   lbl5.Left := TimeRange.Edit.Left + TimeRange.Edit.Width + 5;

   lbl6 := TLabel.Create(Panel);
   lbl6.Parent := Panel;
   lbl6.AutoSize := true;
   lbl6.Caption := 'Время выполнения заявки:';
   lbl6.Top := TimeRange.Edit.Top + TimeRange.Edit.Height + 5;
   lbl6.Left := NameEdit.Left;

   MinGoingTime := TIntegerInput.Create(20,Panel);
   MinGoingTime.Edit.Top := lbl6.Top + lbl6.Height + 5;
   MinGoingTime.Edit.Left := NameEdit.Left;

   lbl7 := TLabel.Create(Panel);
   lbl7.Parent := Panel;
   lbl7.AutoSize := true;
   lbl7.Caption := '-';
   lbl7.Top := MinGoingTime.Edit.Top + 2;
   lbl7.Left := MinGoingTime.Edit.Left + MinGoingTime.Edit.Width +5;

   MaxGoingTime := TIntegerInput.Create(30,Panel);
   MaxGoingTime.Edit.Top := MinGoingTime.Edit.Top;
   MaxGoingTime.Edit.Left := lbl7.Left + lbl7.Width + 5;

   lbl8 := TLabel.Create(Panel);
   lbl8.Parent := Panel;
   lbl8.AutoSize := true;
   lbl8.Caption := 'мин.';
   lbl8.Top := lbl7.Top + 5;
   lbl8.Left := MaxGoingTime.Edit.Left + MaxGoingTime.Edit.Width + 5;
end;

procedure TClientSettings.ChangeCoord(X,Y:integer);
begin
  Panel.Top := Y;
  Panel.Left := X;
end;

procedure TClientSettings.RightTo(S: TClientSettings; delta:integer);
begin
  Panel.Top := S.Panel.Top;
  Panel.Left := S.Panel.Left + S.Panel.Width + delta;
end;

Constructor TCarSettings.Create(cName: string; cParent: TWinControl);
var lbl1,lbl2,lbl3:TLabel;
begin
  Panel := TPanel.Create(cParent);
  Panel.Parent := cParent;
  Panel.BevelKind := bkNone;
  Panel.BevelOuter := bvNone;
  Panel.Height := 26;
  Panel.Width := cParent.Width;

  lbl1 := TLabel.Create(Panel);
  lbl1.Parent := Panel;
  lbl1.AutoSize := true;
  lbl1.Caption := cName+':    Время обслуживания: ';
  lbl1.Top := 5;
  lbl1.Left := 5;

  MinTime := TIntegerInput.Create(5,Panel);
  MinTime.Edit.Top := 0;
  MinTime.Edit.Left := lbl1.Left + lbl1.Width + 5;

  lbl3 := TLabel.Create(Panel);
  lbl3.Parent := Panel;
  lbl3.AutoSize := true;
  lbl3.Caption := '-';
  lbl3.Top := lbl1.Top - 2;
  lbl3.Left := MinTime.Edit.Left+MinTime.Edit.Width+5;

  MaxTime := TIntegerInput.Create(15,Panel);
  MaxTime.Edit.Top := 0;
  MaxTime.Edit.Left := lbl3.Left + lbl3.Width + 5;

  lbl2 := TLabel.Create(Panel);
  lbl2.Parent := Panel;
  lbl2.AutoSize := true;
  lbl2.Caption := 'мин.';
  lbl2.Top := lbl1.Top;
  lbl2.Left := MaxTime.Edit.Left+MaxTime.Edit.Width+5;

end;

procedure TCarSettings.ChangeCoord(X,Y:integer);
begin
  Panel.Top := Y;
  Panel.Left := X;
end;

procedure TCarSettings.NextTo(S: TCarSettings);
begin
  Panel.Left := S.Panel.Left;
  Panel.Top := S.Panel.Top + S.Panel.Height;
end;



procedure TSceneMan.Reset;
var i: integer;
    buf:TClient;
    buf2:TCar;
begin
   ClientMan.Clients.Clear;
   for i := 0 to CarMan.Cars.Count - 1 do
   begin
      buf2 := CarMan.Cars[i] as TCar;
      buf2.Reset;
   end;
   Log.Time:=8 * 3600;
   Log.ListBox.Clear;
end;

END.
