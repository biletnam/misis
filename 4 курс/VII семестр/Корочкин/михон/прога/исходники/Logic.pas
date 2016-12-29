unit Logic;

interface
uses classes, Sysutils, Contnrs, myclasses,Forms, StdCtrls, ComCtrls, ExtCtrls, Controls, Math, Graphics;

Type TClient=class(TObject)
  Name:string;
  Log:TLog;
  TotalWaitTime:integer;
  TotalServeTime:integer;
  Serving: Boolean;
  Delete:Boolean;
  Constructor Create(cName: string; cLog:TLog);
end;

Type TCar=Class(TObject)
  Name: string;
  Log:TLog;
  Client:TClient;
  Active: Boolean;
  TimeRemain: integer;
  WaitTime: integer;
  WorkTime: integer;
  ServedClients:integer;
  Constructor Create(cName: string; cLog:TLog);

  procedure Tick(dt: integer);
  procedure SetRequest(cClient:TClient);


  //procedure Reset;
end;

Type TCarMan=class(TObject)
  Log:TLog;
  Cars: TObjectList;
  TotalServeTime:integer;
  ServedClients:integer;
  Constructor Create(cLog:TLog);
  procedure AddCar;
  procedure RemoveCar;
  //procedure UpdateCarsInfo;
  procedure Tick(dt: integer);
end;


Type TSceneMan=class(TObject)
  Log:TLog;
  CarMan: TCarMan;
  Clients: TObjectList;
  TotalClients: integer;
  MinTime,MaxTime: TEdit;
  Constructor Create(cLog:TLog);
  procedure NewClient;
  //procedure UpdateInfo;
  procedure Tick(dt: integer);
  //procedure LogicTick;
  function SelectRandomCar(Cars: TObjectList):TCar;
  function NeedToServe():TObjectList;
  function FreeCars():TObjectList;
  procedure DelClients;
  procedure SetMinMax(Min,Max:TEdit);
  //procedure Reset;
end;

implementation

Constructor TClient.Create(cName: string; cLog:TLog);
begin
  Name:=cName;
  Log := cLog;
  TotalWaitTime:=0;
  TotalServeTime:=0;
  Serving:=false;
  Delete:=false;
end;

Constructor TCar.Create(cName: string; cLog:TLog);
begin
  Name:=cName;
  Log:=cLog;
  Client:=nil;
  Active:=false;
  TimeRemain:=-1;
  WaitTime:=0;
  WorkTime:=0;
  ServedClients:=0;
end;

procedure TCar.SetRequest(cClient:TClient);
begin
  Log.Add(Name + ' отправилось обслуживать '+cClient.Name+'.');
  cClient.Serving:=true;
  Client:=cClient;
  Active:=true;
  TimeRemain:=cClient.TotalServeTime;
end;

procedure TCar.Tick(dt: integer);
begin

  if Client<>nil then Active:=true else Active:=false;
  if Active then WorkTime:=WorkTime+dt else WaitTime:=WaitTime+dt;

  if TimeRemain=0 then
  begin
    Log.Add(Name + ' обслужило '+Client.Name+'.');
    Client.Serving := false;
    Client.Delete := true;
    TimeRemain:=-1;
    Client:=nil;
    Active:=false;
    ServedClients := ServedClients+1;
  end;

  if TimeRemain>0 then
  begin
    TimeRemain:=TimeRemain-1;
  end;

end;

Constructor TCarMan.Create(cLog:TLog);
begin
  Log:=cLog;
  Cars := TObjectList.Create;
  TotalServeTime:=0;
  ServedClients :=0;
end;

procedure TCarMan.AddCar;
var buf:TCar;
begin
   buf := TCar.Create('Такси '+IntToStr(Cars.Count+1),Log);
   Cars.Add(buf);
end;

procedure TCarMan.RemoveCar;
var buf:TCar;
begin
   if Cars.Count>0 then
   begin
      buf := Cars.Last as TCar;
      if buf.Client<>nil then buf.Client.Serving := false;
      Cars.Remove(Cars.Last);
   end;
end;

procedure TCarMan.Tick(dt: integer);
var i:integer;
begin
  ServedClients:=0;
  for i := 0 to Cars.Count - 1 do
    begin
      (Cars[i] as TCar).Tick(dt);
      ServedClients := ServedClients + (Cars[i] as TCar).ServedClients;
    end;
end;

Constructor TSceneMan.Create(cLog:TLog);
begin
  Log:=cLog;
  CarMan:=TCarMan.Create(Log);
  Clients:=TObjectList.Create;
  TotalClients:=0;
end;

procedure TSceneMan.NewClient;
var buf:TClient;
begin
   buf:=TClient.Create('Клиент'+IntToStr(TotalClients+1),Log);
   buf.TotalServeTime := RandomRange(StrToInt(MinTime.Text),StrToInt(MaxTime.Text));
   Clients.Add(buf);
   Log.Add('Поступила заявка от '+buf.Name+'.');
   TotalClients:=TotalClients+1;
end;

function TSceneMan.NeedToServe():TObjectList;
var i:integer;
    Res:TObjectList;
    buf:TClient;
begin
  Res:=TObjectList.Create;
  for i := 0 to Clients.Count - 1 do
  begin
    buf := Clients[i] as TClient;
    if (buf.Serving=false)and(buf.Delete=false) then Res.Add(buf);
  end;
  Result:=Res;
end;

function TSceneMan.FreeCars():TObjectList;
var i:integer;
    Res:TObjectList;
    buf:Tcar;
begin
  Res:=TObjectList.Create;
  for i := 0 to CarMan.Cars.Count - 1 do
  begin
    buf := CarMan.Cars[i] as TCar;
    if (buf.Active=false) then Res.Add(buf);
  end;
  Result:=Res;
end;

function TSceneMan.SelectRandomCar(Cars: TObjectList):TCar;
var Res: TCar;
begin
   Res:=nil;
   if Cars.Count>0 then Res:=Cars[Random(Cars.Count)] as TCar;
   Result:=Res;
end;

procedure TSceneMan.DelClients;
var i:integer;
    buf:TClient;
begin
   i:=0;
   while i< Clients.Count do
   begin
      buf := (Clients[i] as TClient);
      if buf.Delete then
      begin
        Clients.Remove(buf);
        i:=i-1;
      end;
      i:=i+1;
   end;
end;

procedure TSceneMan.Tick(dt: integer);
begin
  while (NeedToServe.Count>0)and(FreeCars.Count>0) do
  begin
     (SelectRandomCar(FreeCars) as TCar).SetRequest(NeedToServe.First as TClient);
  end;
  DelClients;
  CarMan.Tick(dt);
end;

procedure TSceneMan.SetMinMax(Min,Max:TEdit);
begin
  MinTime := Min;
  MaxTime := Max;
end;

end.
