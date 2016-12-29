unit MedCommis;

interface
uses classes, Sysutils, Contnrs, logicclasses,myclasses,Forms, StdCtrls, ComCtrls, ExtCtrls, XPMan, Controls;

Type TDoctor=Class(TLogicNode)
private
  mDuration: TMinMaxSelect;
public
  Constructor Create(cName: string; cForm: TForm);
  procedure Reset();
end;

Type TMedCom=Class(TObject)
private
  mReg: TDoctor;
  mTer: TDoctor;
  mHir: TDoctor;
  mPsi: TDoctor;
  mStat: TStatControls;
  mForm: TForm;
  mInputForm: TForm;
  mLog: TLog;
  mTime: integer;
  mClientsNow: integer;
  mClientsDone: integer;
  mClock: TLabel;
  mSpeedSelect: TTrackBar;
  mTotalTime, mTotalWait: integer;
  mAvgTotalTime, mAvgWait: Real;
  mIntensity: TIntegerSelect;
  mIntensityLabel: TLabel;
  mSpeedLabel: TLabel;
  mTickTimer: TTimer;
  mInfoTimer: TTimer;
  mXPMan: TXPManifest;
  mStartStopButton: TButton;
  mInputFormButton: TButton;
  mRestartButton: TButton;
public
  Constructor Create(cForm: TForm);
  Destructor Destroy; override;
  procedure UpdateInfo;
  procedure Tick(dt: integer);
  procedure SpawnTick(dt: integer);
  procedure LogicTick(dt: integer);
  function FindMinQueue(Client: TClient):TLogicNode;
  procedure ClientGoNext(Client: TClient; From:TLogicNode);
  procedure SetMDs(Client: TClient);
  procedure GetClientStat(dt: integer);
  procedure GetClientStatForNode(Node: TLogicNode; dt: integer);
  procedure AddClient;
  procedure CreateAdvacedCtrls(cForm: TForm);
  procedure UpdateStatInfo;
  procedure TickTimerTimer(Sender: TObject);
  procedure InfoTimerTimer(Sender: TObject);
  procedure StartStopClick(Sender: TObject);
  procedure InputFormShow(Sender: TObject);
  procedure RestartClick(Sender: TObject);
end;

implementation
const
  N1_I = 'Регистратура';
  N1_R = 'Регистратуры';
  N1_V = 'Регистратуру';

  N2_I = 'Терапевт';
  N2_R = 'Терапевта';
  N2_V = 'Терапевта';

  N3_I = 'Хирург';
  N3_R = 'Хирурга';
  N3_V = 'Хирурга';

  N4_I = 'Психолог';
  N4_R = 'Психолога';
  N4_V = 'Психолога';
 
Constructor TDoctor.Create(cName: string; cForm: TForm);
begin
  inherited;                                                                                     
  {mDuration := TMinMaxSelect.Create('Время прохождения', InfoControls.GroupBox);
  mDuration.ChangeCoord(InfoControls.QueueInfo.InfoLabel.Left, InfoControls.WaitPercent.InfoLabel.Top + 40);}
  InfoControls.GroupBox.Height := 200;
end;

procedure TDoctor.Reset();
begin
  ClientList.Clear;
  Client := nil;
  Active := false;
  WaitTime := 0;
  WorkTime := 0;
  UpdateInfo;
end;

Constructor TMedCom.Create(cForm: TForm);
begin
  mForm := cForm;

  /// ВВОД ДАННЫХ
  mInputForm := TForm.Create(cForm);
  mInputForm.Caption := 'Ввод данных';
  mInputForm.Height := 530;
  mInputForm.Width := 220;
  mInputForm.Position := poDesktopCenter;

  mIntensityLabel := TLabel.Create(mInputForm);
  mIntensityLabel.Parent := mInputForm;
  mIntensityLabel.Top := 20;
  mIntensityLabel.Left := 12;
  mIntensityLabel.Caption := 'Интенсивность:';

  mIntensity := TIntegerSelect.Create('', mInputForm);
  mIntensity.Text := ' чел./час';
  mIntensity.Edit.Width := 70;
  mIntensity.UpDown.Position := 20;
  mIntensity.Edit.Text := '20 чел./час';
  mIntensity.ChangeCoord(mIntensityLabel.Left + mIntensityLabel.Width - 60,18);

  mSpeedLabel := TLabel.Create(mInputForm);
  mSpeedLabel.Parent := mInputForm;
  mSpeedLabel.Top := mIntensityLabel.Top + 50;
  mSpeedLabel.Left := 12;
  mSpeedLabel.Caption := 'Скорость:';

  mSpeedSelect := TTrackBar.Create(mInputForm);
  mSpeedSelect.Parent := mInputForm;
  mSpeedSelect.Top := mSpeedLabel.Top - 8;
  mSpeedSelect.Left := mSpeedLabel.Left + mSpeedLabel.Width + 5;
  mSpeedSelect.Min := 1;
  mSpeedSelect.Max := 500;
  mSpeedSelect.Frequency := 50;
  mSpeedSelect.Width := 135;

  /// РЕГИСТРАТУРА
  mReg := TDoctor.Create(N1_I,cForm);
  mReg.Ctrl.ChangeCoord(10,50);

  mReg.mDuration := TMinMaxSelect.Create('Время прохождения '+N1_R+': ', mInputForm);
  mReg.mDuration.ChangeCoord(10,mSpeedLabel.Top + 40);
  mReg.mDuration.Min.SetBorders(50,100,50);
  mReg.mDuration.Max.SetBorders(50,250,100);

  /// ТЕРАПЕВТ
  mTer := TDoctor.Create(N2_I,cForm);
  mTer.Ctrl.RightTo(mReg.Ctrl,50);

  mTer.mDuration := TMinMaxSelect.Create('Время прохождения '+N2_R+': ', mInputForm);
  mTer.mDuration.ChangeCoord(10,mSpeedLabel.Top + 140);
  mTer.mDuration.Min.SetBorders(50,250,50);
  mTer.mDuration.Max.SetBorders(50,250,250);

  /// ХИРУРГ
  mHir := TDoctor.Create(N3_I,cForm);
  mHir.Ctrl.RightTo(mTer.Ctrl,50);

  mHir.mDuration := TMinMaxSelect.Create('Время прохождения '+N3_R+': ', mInputForm);
  mHir.mDuration.ChangeCoord(10,mSpeedLabel.Top + 240);
  mHir.mDuration.Min.SetBorders(50,250,50);
  mHir.mDuration.Max.SetBorders(50,250,250);

  /// ПСИХОЛОГ
  mPsi := TDoctor.Create(N4_I,cForm);
  mPsi.Ctrl.RightTo(mHir.Ctrl,50);

  mPsi.mDuration := TMinMaxSelect.Create('Время прохождения '+N4_R+': ', mInputForm);
  mPsi.mDuration.ChangeCoord(10,mSpeedLabel.Top + 340);
  mPsi.mDuration.Min.SetBorders(50,250,50);
  mPsi.mDuration.Max.SetBorders(50,250,250);

  //// КОНТРОЛЫ
  mLog:= TLog.Create(cForm);
  mLog.ListBox.Left := mReg.InfoControls.GroupBox.Left;
  mLog.ListBox.Top := mReg.InfoControls.GroupBox.Top + mReg.InfoControls.GroupBox.Height + 20;

  mTime := 32400;
  mClientsNow := 0;
  mClientsDone := 0;
  mTotalTime :=0;
  mTotalWait:=0;

  CreateAdvacedCtrls(cForm);

  mClock := TLabel.Create(cForm);
  mClock.Parent := cForm;
  mClock.Top := 5;
  mClock.Font.Size := 20;
  mClock.Left := 650;

  mTickTimer := TTimer.Create(cForm);
  mTickTimer.Enabled := False;
  mTickTimer.OnTimer := TickTimerTimer;

  mInfoTimer := TTimer.Create(cForm);
  mInfoTimer.Enabled:=True;
  mInfoTimer.OnTimer := InfoTimerTimer;
  mInfoTimer.Interval := 300;

  mStartStopButton := TButton.Create(cForm);
  mStartStopButton.Parent := cForm;
  mStartStopButton.Caption := 'Старт';
  mStartStopButton.OnClick := StartStopClick;
  mStartStopButton.Top := 10;
  mStartStopButton.Left := mClock.Left - mStartStopButton.Width - 25;

  mRestartButton := TButton.Create(cForm);
  mRestartButton.Parent := cForm;
  mRestartButton.Caption := 'Сначала';
  mRestartButton.OnClick := RestartClick;
  mRestartButton.Top := 10;
  mRestartButton.Left := mStartStopButton.Left - mStartStopButton.Width - 25;


  mInputFormButton := TButton.Create(cForm);
  mInputFormButton.Parent := cForm;
  mInputFormButton.Caption := 'Ввод данных';
  mInputFormButton.OnClick := InputFormShow;
  mInputFormButton.Top := 10;
  mInputFormButton.Left := 10;

  mXPMan := TXPManifest.Create(cForm);
end;

procedure TMedCom.CreateAdvacedCtrls(cForm: TForm);
begin
  mStat := TStatControls.Create(cForm);
  mStat.GroupBox.Left := mLog.ListBox.Left + mLog.ListBox.Width + 20;
  mStat.GroupBox.Top := mLog.ListBox.Top - 5;
end;

Destructor TMedCom.Destroy;
begin
  inherited;
end;

procedure TMedCom.UpdateStatInfo;
begin
  mClock.Caption := mLog.MakeTimeString(mTime);
  mStat.ClientsNow.Edit.Text := IntToStr(mClientsNow) + ' чел.';
  mStat.ClientsDone.Edit.Text := IntToStr(mClientsDone) + ' чел.';
  mStat.AvgTotalTime.Edit.Text := FloatToStrF(mAvgTotalTime/60,ffFixed,3,1) + ' мин.';
  mStat.AvgWaitTime.Edit.Text := FloatToStrF(mAvgWait/60,ffFixed,3,1) + ' мин.';
end;

procedure TMedCom.UpdateInfo;
begin
  mReg.UpdateInfo;
  mTer.UpdateInfo;
  mHir.UpdateInfo;
  mPsi.UpdateInfo;
  UpdateStatInfo;
end;

procedure TMedCom.SpawnTick(dt: integer);
var i,a:integer;
begin
   a:=Round(3600/dt);
   i:=Random(3600);
   if i<mIntensity.UpDown.Position then AddClient;   
end;

procedure TMedCom.Tick(dt: integer);
begin
  if mTime >= 64800 then
  begin
    mTime := 64800;
    StartStopClick(nil);
  end;
  SpawnTick(dt);
  mReg.Tick(dt);
  mTer.Tick(dt);
  mHir.Tick(dt);
  mPsi.Tick(dt);
  LogicTick(dt);
  GetClientStat(dt);
  mTime := mTime + dt;
end;

procedure TMedCom.GetClientStatForNode(Node: TLogicNode; dt: integer);
var i: integer;
begin
   for i:= 0 to Node.ClientList.Count - 1 do
   begin
      (Node.ClientList[i] as TClient).TotalTime := (Node.ClientList[i] as TClient).TotalTime + dt;
      (Node.ClientList[i] as TClient).WaitTime := (Node.ClientList[i] as TClient).WaitTime + dt;
   end;
   if Node.Client<>nil then Node.Client.TotalTime := Node.Client.TotalTime + dt;
end;

procedure TMedCom.GetClientStat(dt: integer);
begin
  GetClientStatForNode(mReg,dt);
  GetClientStatForNode(mHir,dt);
  GetClientStatForNode(mTer,dt);
  GetClientStatForNode(mPsi,dt);
end;

procedure TMedCom.AddClient;
var Client: TClient;
begin
  mClientsNow := mClientsNow + 1;
  Client := TClient.Create(mClientsNow + mClientsDone);
  mReg.ClientList.Add(Client);
  mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' пришел проходить медкомиссию.');
end;

procedure TMedCom.SetMDs(Client: TClient);
begin
  if Random(100) < 70 then
  begin
    Client.NeedTer := true;
    mLog.Add(mTime, '   Клиент' + IntToStr(Client.Number)+ ' должен пройти '+N2_R+'.');
  end;
  if Random(100) < 70 then
  begin
    Client.NeedHir := true;
    mLog.Add(mTime, '   Клиент' + IntToStr(Client.Number)+ ' должен пройти '+N3_R+'.');
  end;
  if Random(100) < 70 then
  begin
    Client.NeedPsi := true;
    mLog.Add(mTime, '   Клиент' + IntToStr(Client.Number)+ ' должен пройти '+N4_R+'.');
  end;
end;

function TMedCom.FindMinQueue(Client: TClient):TLogicNode;
var Min: TLogicNode;
    Res: TLogicNode;
begin
   Min := nil;
   if Client.NeedTer = true then Min := mTer;
   if Client.NeedHir = true then
   begin
      if Min<>nil then
      begin
        if Min.ClientList.Count > mHir.ClientList.Count then Min := mHir;
      end
      else Min := mHir;
   end;
   if Client.NeedPsi = true then
   begin
      if Min<>nil then
      begin
        if Min.ClientList.Count > mPsi.ClientList.Count then Min := mPsi;
      end
      else Min := mPsi;
   end;
   Res := Min;

   if ((Client.NeedTer) and (mTer.Active=False) and (mTer.ClientList.Count = 0)) then Res:= mTer;
   if ((Client.NeedHir) and (mHir.Active=False) and (mHir.ClientList.Count = 0)) then Res:= mHir;
   if ((Client.NeedPsi) and (mPsi.Active=False) and (mPsi.ClientList.Count = 0)) then Res:= mPsi;

   Result:=Res;
end;

procedure TMedCom.ClientGoNext(Client: TClient; From:TLogicNode);
begin
   Client.WaitTimer := -1;
   if FindMinQueue(Client)<>nil then
   begin
      mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' пошел к ' + FindMinQueue(Client).Ctrl.Name+'у.');
      ClientFromNodeToQueue(From,FindMinQueue(Client));
   end
   else
   begin
      mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' прошел медкомиссию.');
      mLog.Add(mTime, '   Потрачено времени: ' + IntToStr(Client.TotalTime) + ' сек.');
      mLog.Add(mTime, '   Из них Ожидание: ' + IntToStr(Client.WaitTime) + ' сек.');
      From.Client := nil;
      From.Active := false;
      mClientsDone := mClientsDone + 1;
      mClientsNow := mClientsNow - 1;
      mTotalTime := mTotalTime + Client.TotalTime;
      mTotalWait := mTotalWait + Client.WaitTime;
      mAvgTotalTime := mTotalTime/mClientsDone;
      mAvgWait := mTotalWait/mClientsDone;
      Client.Destroy;
   end;
end;

procedure TMedCom.LogicTick(dt: integer);
begin
   // Работа регистратуры
   if mReg.Active then
   begin
   with mReg do
   begin
     if Client.WaitTimer = -1 then
     begin
       // Определяем время прохождения регистратуры
       Client.WaitTimer := Random(100) + 60;
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' начал проходить '+N1_V+'.');
     end;
     Client.WaitTimer:= Client.WaitTimer-1;
     if Client.WaitTimer = 0 then
     begin
       // Регистрация пройдена
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' прошел '+N1_V+'.');
       SetMDs(Client);
       ClientGoNext(Client,mReg);
     end;
   end;
   end;


   // Работа терапевта
   if mTer.Active then
   begin
   with mTer do
   begin
     if Client.WaitTimer = -1 then
     begin
       // Определяем время прохождения терапевта
       Client.WaitTimer := Random(mTer.mDuration.Max.UpDown.Position - mPsi.mDuration.Min.UpDown.Position) + mPsi.mDuration.Min.UpDown.Position;
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' начал проходить '+N2_V+'.');
     end;
     Client.WaitTimer:= Client.WaitTimer-1;
     if Client.WaitTimer = 0 then
     begin
       // Терапевт пройден
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' прошел '+N2_V+'.');
       Client.NeedTer := false;
       ClientGoNext(Client,mTer);
     end;
   end;
   end;


   // Работа хирурга
   if mHir.Active then
   begin
   with mHir do
   begin
     if Client.WaitTimer = -1 then
     begin
       // Определяем время прохождения хирурга
       Client.WaitTimer := Random(mHir.mDuration.Max.UpDown.Position - mHir.mDuration.Min.UpDown.Position) + mHir.mDuration.Min.UpDown.Position;
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' начал проходить '+N3_V+'.');
     end;
     Client.WaitTimer:= Client.WaitTimer-1;
     if Client.WaitTimer = 0 then
     begin
       // Хирург пройден
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' прошел '+N3_V+'.');
       Client.NeedHir := false;
       ClientGoNext(Client,mHir);
     end;
   end;
   end;

   // Работа психолога
   if mPsi.Active then
   begin
   with mPsi do
   begin
     if Client.WaitTimer = -1 then
     begin
       // Определяем время прохождения психолога
       Client.WaitTimer := Random(mPsi.mDuration.Max.UpDown.Position - mPsi.mDuration.Min.UpDown.Position) + mPsi.mDuration.Min.UpDown.Position;
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' начал проходить '+N4_V+'.');
     end;
     Client.WaitTimer:= Client.WaitTimer-1;
     if Client.WaitTimer = 0 then
     begin
       // Психолог пройден
       mLog.Add(mTime, 'Клиент' + IntToStr(Client.Number)+ ' прошел '+N4_V+'.');
       Client.NeedPsi := false;
       ClientGoNext(Client,mPsi);
     end;
   end;
   end;

end;

procedure TMedCom.TickTimerTimer(Sender: TObject);
var i:Integer;
begin
  for i:= 1 to mSpeedSelect.Position do Tick(1);
end;

procedure TMedCom.InfoTimerTimer(Sender: TObject);
begin
  UpdateInfo;
end;

procedure TMedCom.StartStopClick(Sender: TObject);
begin
  mTickTimer.Enabled := not(mTickTimer.Enabled);
  if mTickTimer.Enabled then mStartStopButton.Caption := 'Стоп'
  else mStartStopButton.Caption := 'Старт';
end;

procedure TMedCom.InputFormShow(Sender: TObject);
begin
  if mInputForm.Showing = true then mInputForm.Close else mInputForm.Show;
end;

procedure TMedCom.RestartClick(Sender: TObject);
begin
  mTime := 32400;
  mClientsNow := 0;
  mClientsDone := 0;
  mTotalTime :=0;
  mTotalWait:=0;
  mAvgTotalTime := 0;
  mAvgWait := 0;

  mReg.Reset;
  mTer.Reset;
  mHir.Reset;
  mPsi.Reset;

  mLog.ListBox.Clear;
end;

end.
