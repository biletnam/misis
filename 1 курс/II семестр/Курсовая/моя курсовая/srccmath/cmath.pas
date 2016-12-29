unit cmath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,funclevel, StdCtrls, ComCtrls, NumberEdit,Menus, Series,
  dichotomy,dateutils, ToolWin, ImgList,Math,Gauss;

type
    THistoryItems=object
    	THistoryItem:array of TDoubleRect;
        procedure AddHistoryItem(Area:TDoubleRect);
        procedure Undo(histID:integer);
        procedure SetHistorySize(size:integer);
    private
    	CurItems:integer;
        HistorySize:integer;
    end;
  TfrmMain = class(TForm)
    pbOut: TPaintBox;
    bvlBevel: TBevel;
    gbControls: TGroupBox;
    sbStatus: TStatusBar;
    lstOut: TListView;
    splSplitter: TSplitter;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    mnuReport: TMenuItem;
    mnuSave: TMenuItem;
    mnuSavePicture: TMenuItem;
    mnuMethod: TMenuItem;
    mnuCrackingStep: TMenuItem;
    mnuQuickestDescent: TMenuItem;
    mnuConj: TMenuItem;
    mnuQuasi: TMenuItem;
    mnuCycle: TMenuItem;
    mnuHookJeavse: TMenuItem;
    mnuRosenbrooks: TMenuItem;
    mnuPawell: TMenuItem;
    mnuNelderMid: TMenuItem;
    tlbButtons: TToolBar;
    btnLevels: TToolButton;
    btnMin: TToolButton;
    Separator: TToolButton;
    btnScale: TToolButton;
    btnMethod: TToolButton;
    ToolButton2: TToolButton;
    Separator1: TToolButton;
    btnSaveRep: TToolButton;
    btnSavePicture: TToolButton;
    gbLines: TGroupBox;
    lblPrec: TLabel;
    lblCount: TLabel;
    neCount: TNumberEdit;
    nePrec: TNumberEdit;
    gbMin: TGroupBox;
    lbfPrec: TLabel;
    nefPrec: TNumberEdit;
    gbWorldCoord: TGroupBox;
    lblLx: TLabel;
    lblLy: TLabel;
    lblRx: TLabel;
    lblRy: TLabel;
    neLx: TNumberEdit;
    neLy: TNumberEdit;
    neRx: TNumberEdit;
    neRy: TNumberEdit;
    gbBeginPoint: TGroupBox;
    lblY: TLabel;
    lblX: TLabel;
    neY: TNumberEdit;
    neX: TNumberEdit;
    lblRadius: TLabel;
    lblRestart: TLabel;
    neRestart: TNumberEdit;
    neRadius: TNumberEdit;
    lblPx: TLabel;
    lblIter: TLabel;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    mnuCondGrad: TMenuItem;
    mnuAntigradPrj: TMenuItem;
    cboHistory: TComboBox;
    procedure InvScanLevels(Area:TDoubleRect;N:integer);
    procedure pbOutPaint(Sender: TObject);
    procedure pbOutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FastFallWithCrackingStep(eps:double;fp:TWorldPoint);
    procedure QuickestDescent(eps:double;fp:TWorldPoint);
    procedure ConjDirection(eps:double;fp:TWorldPoint);
    procedure DFPMethod(eps:double;fp:TWorldPoint);
    procedure HookJeavse(eps:double;fp:TWorldPoint);
    procedure Rosenbrouke(eps:double;fp:TWorldPoint);
    procedure Pawell(eps:double;fp:TWorldPoint);
    procedure NelderMid(eps:double;fp:TworldPoint);
    procedure CycledDescent(eps:double;fp:TworldPoint);
    {nonlinear programming}
    procedure CondGrad(eps:double;fp:TworldPoint);
    procedure DrawCondition;
    procedure AntiGradPrj(eps:double;fp:TworldPoint);

    {---------------------}
    procedure BuiltReport(x,grad:TWorldPoint;k:double;cappa:double);
    procedure SetPoint(x:TWorldPoint);
    procedure mnuSaveClick(Sender: TObject);
    procedure mnuSavePictureClick(Sender: TObject);
    procedure mnuCrackingStepClick(Sender: TObject);
    procedure mnuQuickestDescentClick(Sender: TObject);
    procedure mnuConjClick(Sender: TObject);
    procedure btnMinClick(Sender: TObject);
    procedure btnLevelsClick(Sender: TObject);
    procedure btnMethodClick(Sender: TObject);
    procedure btnSaveRepClick(Sender: TObject);
    procedure btnSavePictureClick(Sender: TObject);
    procedure mnuQuasiClick(Sender: TObject);
    procedure mnuHookJeavseClick(Sender: TObject);
    procedure mnuRosenbrooksClick(Sender: TObject);
    procedure mnuPawellClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   procedure ServeMenuClick(Menu:TMenuItem);
    procedure mnuNelderMidClick(Sender: TObject);
    procedure mnuCycleClick(Sender: TObject);
    procedure mnuCondGradClick(Sender: TObject);
    procedure pbOutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbOutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuAntigradPrjClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboHistoryClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;
   TNumbers=array[1..4] of integer;
   function InCondition(A,B:TMatrix;x:TWorldPoint):boolean;
   function GetActiveCond(A,B:TMatrix;point:TWorldPoint;var numbers:TNumbers;eps:double):integer;
var
  frmMain: TfrmMain;
  CopyScr:TBitMap;
  Area:TDoubleRect;
  dig,blocksize,RefreshRate:integer;
  LeftBound,RightBound:TScreenPoint;
  CanZoom:boolean;
  A_all,Bi:Tmatrix;
  Undo:THistoryItems;

implementation

{$R *.dfm}


procedure TfrmMain.InvScanLevels(Area:TDoubleRect;N:integer);
var i,j:integer;
    world:TWorldPoint;
    screen:TScreenPoint;
    mins,s,f:double;
    //cs:array of double;
    function GetMidColor(cPoint:TScreenPoint):LongInt;
    var ii,jj:integer;
        r,g,b:LongInt;
    const size=1;
    begin
        r:=0;g:=0;b:=0;
 	for ii:=max(cpoint.x-size,0) to min(cPoint.x+size,copyscr.Width) do
          for jj:=max(cpoint.y-size,0) to min(cpoint.y+size,copyscr.Height) do
           begin
             r:=r+GetRValue(copyscr.Canvas.Pixels[ii,jj]);
             g:=g+GetGValue(copyscr.Canvas.Pixels[ii,jj]);
             b:=b+GetBValue(copyscr.Canvas.Pixels[ii,jj]);
           end;
    r:=r div sqr(2*size);
    b:=b div sqr(2*size);
    g:=g div sqr(2*size);
    Result:=rgb(r,g,b);
    end;
begin
mins:=getMin(Area);
s:=(GetMax(Area)-mins)/N;
//Setlength(cs,N);
CopyScr.Free;
CopyScr:=TBitMap.Create;
CopyScr.Height:=pbOut.Height;
CopyScr.Width:=pbOut.Width;
//for i:=0 to N-1 do
//   cs[i]:=min+i*s;
for i:=0 to frmMain.pbOut.Width do
    for j:=0 to frmMain.pbOut.Height do
       begin
            screen.x:=i;screen.y:=j;
            Screen2World(Area,frmMain.pbOut.ClientRect,screen,world);
            {for k:=0 to N-1 do
              if abs(func(world.x,world.y)-cs[k])<10*GetPrecision then
               begin}
               f:=(func(world.x,world.y)-mins)/(s+1);
               if frac(f)<GetPrecision Then
                begin
                 frmMain.pbOut.Canvas.Pixels[i,j]:=0;//rgb(trunc(255*f/N),trunc(255*f/N),trunc(255*f/N));
                 {cl:=GetMidColor(screen);
                 frmMain.pbOut.Canvas.Pixels[i,j]:=cl;}
                 CopyScr.Canvas.Pixels[i,j]:=0;{cl;}
                end;
               //end;
       end;{for}
pbOutPaint(pbOut);
end;


procedure TfrmMain.pbOutPaint(Sender: TObject);
begin
     pbOut.Canvas.Draw(0,0,CopyScr);
end;


procedure TfrmMain.pbOutMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var world:TWorldPoint;
    screen:TScreenPoint;
    rect:TRect;
    s1,s2:string;
begin
screen.x:=x;screen.y:=y;
str(screen.x,s1);str(screen.y,s2);
sbStatus.Panels[0].Text:='Позиция-> Экранная :'+s1+','+s2+'; ';
if (Area.lx<>0) and (Area.rx<>0) then
begin
     Screen2World(Area,copyscr.Canvas.ClipRect,screen,world);
     str(world.x:4,s1);str(world.y:4,s2);
     sbStatus.Panels[0].Text:=sbStatus.Panels[0].Text+' Мировые :'+s1+','+s2;
end;
if CanZoom then
	begin
           pbOut.Repaint;
           Rect.Left:=min(x,LeftBound.x);
           if [ssShift]<=Shift then Rect.Right:=Rect.Left+abs(x-Rect.Left)
           else Rect.Right:=max(x,LeftBound.x);
           Rect.Top:=min(y,leftbound.y);
           if Shift>=[ssShift] then Rect.Bottom:=Rect.Top+abs(x-rect.Left)
           else Rect.Bottom:=max(y,leftBound.y);
           pbOut.Canvas.DrawFocusRect(Rect);
        end;
end;

procedure TfrmMain.FastFallWithCrackingStep(eps:double;fp:TWorldPoint);
var k:integer;
    gamma,cappa:double;
    lastx,x,grad:TWorldPoint;
    Screen2:TScreenPoint;
const cappa0=1;
begin
k:=1;gamma:=0.5;
x:=fp;
lastx:=fp;
GradientFunc(fp.x,fp.y,grad);
while sqrt(sqr(grad.x)+sqr(grad.y))>eps do
begin

     cappa:=cappa0;
     GradientFunc(lastx.x,lastx.y,grad);
     x.x:=lastx.x+cappa*grad.x;
     x.y:=lastx.y+cappa*grad.y;
     while Func(lastx.x,lastx.y)-Func(x.x,x.y)<0.5*cappa*(sqr(grad.x)+sqr(grad.y)) do
     begin
        cappa:=cappa*gamma;
        x.x:=lastx.x+cappa*grad.x;
        x.y:=lastx.y+cappa*grad.y;
     end;
     BuiltReport(x,grad,k,cappa);
     World2Screen(Area, copyscr.Canvas.ClipRect,x,screen2);
     SetPoint(x);
    lastx:=x;
    copyscr.Canvas.LineTo(screen2.x,screen2.y);
    inc(k);
end;{while}
end;

procedure TfrmMain.QuickestDescent(eps:double;fp:TWorldPoint);
var grad:TWorldPoint;
    curx:TWorldPoint;
    func:T1DFunction;
    screen1:TScreenPoint;
    cappa:double;
    k:integer;
begin
//(pmBlack, pmWhite, pmNop, pmNot, pmCopy, pmNotCopy, pmMergePenNot,
//pmMaskPenNot, pmMergeNotPen, pmMaskNotPen, pmMerge, pmNotMerge, pmMask,
//pmNotMask, pmXor, pmNotXor)
curx:=fp;
GradientFunc(fp.x,fp.y,grad);
func:=@Pseudo1D;
k:=1;
while sqrt(sqr(grad.x)+sqr(grad.y))>eps do
begin
     GradientFunc(curx.x,curx.y,grad);
     xk:=curx;
     uk:=grad;
     cappa:=MakeDichotomy(0,1,1e-5,eps/100,func);
     curx.x:=curx.x+cappa*grad.x;
     curx.y:=curx.y+cappa*grad.y;
     BuiltReport(curx,grad,k,cappa);
     World2Screen(Area, copyscr.Canvas.ClipRect,curx,screen1);
     SetPoint(curx);
     copyscr.Canvas.LineTo(screen1.x,screen1.y);
     inc(k);
end;
//BuiltReport(curx,grad,k,cappa);
end;


procedure TfrmMain.ConjDirection(eps:double;fp:TWorldPoint);
var k:integer;
    grad,lastgrad,curx,lastx,pk:TWorldPoint;
    cappa,gamma:double;
    screen1:TScreenPoint;
//Сопряженных направлений
begin
curx:=fp;
GradientFunc(fp.x,fp.y,grad);
pk:=grad;
k:=1;
while sqrt(sqr(grad.x)+sqr(grad.y))>eps do
begin
     xk:=curx;
     uk:=pk;
     cappa:=MakeDichotomy(0,10,1e-5,eps/100,Pseudo1D);
     lastx:=curx;
     curx.x:=curx.x+cappa*pk.x;
     curx.y:=curx.y+cappa*pk.y;
     Lastgrad:=grad;
     GradientFunc(curx.x,curx.y,grad);
     BuiltReport(curx,grad,k,cappa);
     SetPoint(curx);
     World2Screen(Area, copyscr.Canvas.ClipRect,curx,screen1);
     copyscr.Canvas.LineTo(screen1.x,screen1.y);
     if (k mod RefreshRate)=0 then
        pk:=grad
     else
         begin
            gamma:=(sqr(grad.x)+sqr(grad.y))/(sqr(lastgrad.x)+sqr(lastgrad.y));
            pk.x:=gamma*pk.x+grad.x;
            pk.y:=gamma*pk.y+grad.y;
         end;
     inc(k);
end;{while}
end;

procedure TfrmMain.DFPMethod(eps:double;fp:TWorldPoint);
type
    TDoubleMatrix=array[0..1] of array [0..1] of double;
var k:integer;
    grad,lastgrad,curx,lastx,pk,
    Deltax,DeltaW:TWorldPoint;
    cappa,alpha,beta:double;
    screen1:TScreenPoint;
    Ak,A:TDoubleMatrix;
const E:TDoubleMatrix=((1,0),(0,1));
begin
Ak:=E;
GradientFunc(fp.x,fp.y,grad);
//pk:=grad;
curx:=fp;
lastgrad:=grad;
k:=1;
while sqrt(sqr(grad.x)+sqr(grad.y))>eps do
begin
    pk.x:=Ak[0][0]*grad.x+Ak[0][1]*grad.y; //Ak*(-grad(curx))
    pk.y:=Ak[1][0]*grad.x+Ak[1][1]*grad.y;
    xk:=curx;
    uk:=pk;
    cappa:=MakeDichotomy(0,100,1e-5,eps/100,Pseudo1D);
    LastX:=curx;
    curx.x:=curx.x+cappa*pk.x;
    curx.y:=curx.y+cappa*pk.y;
    Lastgrad:=grad;
    GradientFunc(curx.x,curx.y,grad);
    BuiltReport(curx,grad,k,cappa);
    SetPoint(curx);
    World2Screen(Area, copyscr.Canvas.ClipRect,curx,screen1);
    copyscr.Canvas.LineTo(screen1.x,screen1.y);
    if (k mod RefreshRate)=0 then
       Ak:=E
    else
      begin
          DeltaX.x:=curx.x-lastx.x;
          DeltaX.y:=curx.y-lastx.y;
          DeltaW.x:=grad.x-lastgrad.x;
          DeltaW.y:=grad.y-lastgrad.y;
          A:=Ak;
          alpha:=1/(deltaw.x*deltax.x+deltaw.y*deltax.y);
          beta:=1/((A[0][0]*deltaw.x+A[0][1]*deltaw.y)*deltaw.x+(A[1][0]*deltaw.x+A[1][1]*deltaw.y)*deltaw.y);
          Ak[0][0]:=A[0][0]-alpha*sqr(deltax.x)-beta*(
                             sqr(A[0][0]*deltaw.x)+
                             2*A[0][0]*deltaw.x*A[0][1]*deltaw.y+
                             sqr(A[0][1]*deltaw.y));
          Ak[0][1]:=A[0][1]-alpha*deltax.x*deltax.y-beta*(
                    A[0][0]*sqr(deltaw.x)*A[1][0]+
                    A[0][0]*deltaw.x*A[1][1]*deltaw.y+
                    A[0][1]*deltaw.y*A[1][0]*deltaw.x+
                    A[0][1]*sqr(Deltaw.y)*A[1][1]);
          Ak[1][0]:=A[1][0]-alpha*deltax.x*deltax.y-beta*(
                    A[0][0]*sqr(deltaw.x)*A[1][0]+
                    A[0][0]*deltaw.x*A[1][1]*deltaw.y+
                    A[0][1]*deltaw.y*A[1][0]*deltaw.x+
                    A[0][1]*sqr(Deltaw.y)*A[1][1]);
          Ak[1][1]:=A[1][1]-alpha*sqr(deltax.y)-beta*(
                    sqr(A[1][0]*deltaw.x)+
                    2*A[1][0]*deltaw.x*A[1][1]*deltaw.y+
                    sqr(A[1][1]*deltaw.y));
      end;
    inc(k);
end; {while}
end;



procedure TFrmMain.BuiltReport(x,grad:TWorldPoint;k:double;cappa:double);
var ListItem:TListItem;
    OutS,s:string;
begin
      ListItem:=lstOut.Items.Add;
      str(k:0:dig,outs);
      ListItem.Caption:=OutS;
      OutS:='(';
      str(x.x:0:dig,s);
      OutS:=OutS+s+',';
      str(x.y:0:dig,s);
      OutS:=OutS+s+')';
     ListItem.SubItems.Add(Outs);
     str(func(x.x,x.y):0:dig,outs);
     ListItem.SubItems.Add(Outs);
     str(cappa:0:dig,outs);
     ListItem.SubItems.Add(Outs);
//     str(sqrt(sqr(grad.x)+sqr(grad.y)):0:dig,outs);
//     OutS:='(';
     str(grad.x:0:dig,s);
     OutS:='('+s;
     str(grad.y:0:dig,s);
     OutS:=OutS+','+s+')';
     ListItem.SubItems.Add(Outs);
end;

procedure TFrmMain.SetPoint(x:TWorldPoint);
var i,k:integer;
    screen1:TScreenPoint;
begin
World2Screen(area,copyscr.Canvas.ClipRect,x,screen1);
for i:=screen1.x-blocksize to screen1.x+blocksize do
   for k:=screen1.y-blocksize to screen1.y+blocksize do
       CopyScr.Canvas.Pixels[i,k]:=rgb(255,255,0);
end;

procedure TfrmMain.mnuSaveClick(Sender: TObject);
var i,j:integer;
    t:textfile;
    ListItem:TListItem;
begin
assignfile(t,'table.txt');
rewrite(t);
for i:=0 to lstOut.Items.count-1 do
begin
   ListItem:=lstOut.Items.Item[i];
   Write(t,ListItem.Caption);
    for j:=0 to ListItem.SubItems.Count-1 do
      write(t,chr(9),ListItem.SubItems.Strings[j]);
    writeln(t);
end;
closefile(t);
end;

procedure TfrmMain.mnuSavePictureClick(Sender: TObject);
begin
    CopyScr.SaveToFile('levels.bmp');
end;


procedure TfrmMain.mnuCrackingStepClick(Sender: TObject);
begin
	ServeMenuClick(mnuCrackingStep);
end;

procedure TfrmMain.mnuQuickestDescentClick(Sender: TObject);
begin
	ServeMenuClick(mnuQuickestDescent);
end;

procedure TfrmMain.mnuConjClick(Sender: TObject);
begin
	ServeMenuClick(mnuConj);
end;

procedure TfrmMain.btnMinClick(Sender: TObject);
var x:TWorldPoint;
    screen1:TScreenPoint;
    eps:double;
    c:integer;
    frst:TDateTime;
    s:string;
begin
//my point
     x.x:=0;
     x.y:=2*sqrt(5);
//lena's point
     x.x:=x.x;
     x.y:=x.y;//same point
//sonya's point
//     x.x:=-x.y;
//     x.y:=1;
//для функции розенброка
      x.x:=-2;x.y:=-1;
//для Жэковской функции
 //     x.x:=sqrt(10);x.y:=0;
//для фукнции Химмельблау
//	x.x:=-5;x.y:=5;
//      x.x:=-2;x.y:=1;
     val(neX.Text,x.x,c);
     val(ney.text,x.y,c);
     val(nefPrec.Text,eps,c);
     val(neRestart.Text,RefreshRate,c);
     if eps=0 then eps:=0.01;
     dig:=round(abs(ln(eps)/ln(10)));
     frst:=Time;
     btnLevelsClick(nil);
     Undo.AddHistoryItem(Area);
     sbStatus.Panels.Items[1].Text:='Статус: ' +' Минимизация';
     sbStatus.Refresh;
     //(pmBlack, pmWhite, pmNop, pmNot, pmCopy, pmNotCopy, pmMergePenNot,
//pmMaskPenNot, pmMergeNotPen, pmMaskNotPen, pmMerge, pmNotMerge, pmMask,
//pmNotMask, pmXor, pmNotXor)
     copyscr.Canvas.Pen.Mode:=pmNot;
     lstOut.Clear;
     World2Screen(Area, frmMain.pbOut.ClientRect,x,screen1);
     copyscr.Canvas.MoveTo(screen1.x,screen1.y);
     SetPoint(x);
     if mnuCrackingStep.Checked then FastFallWithCrackingStep(eps,x);
     if mnuQuickestDescent.Checked then QuickestDescent(eps,x);
     if mnuConj.Checked then ConjDirection(eps,x);
     if mnuQuasi.Checked then DFPMethod(eps,x);
     if mnuHookJeavse.Checked then HookJeavse(eps,x);
     if mnuRosenbrooks.Checked then Rosenbrouke(eps,x);
     if mnuPawell.Checked then Pawell(eps,x);
     if mnuNelderMid.Checked then NelderMid(eps,x);
     if mnuCycle.Checked then CycledDescent(eps,x);
     if mnuCondGrad.Checked then CondGrad(eps,x);
     if mnuAntiGradPrj.Checked then
         AntiGradPrj(eps,x);
     str(MilliSecondsBetween(frst,time),s);
     sbStatus.Panels.Items[1].Text:='Статус: ' +s+' мсек';
     pbOut.Refresh;
end;

procedure TfrmMain.btnLevelsClick(Sender: TObject);
var scrr: TRect;
    lcnt,code:integer;
    s:string;
    p:double;
begin
sbStatus.Panels.Items[1].text:='Статус:Построение линий уровня...';
sbStatus.Refresh;
scrr.Left:=0;scrr.Right:=pbOut.width;scrr.Top:=pbOut.Height;scrr.Bottom:=0;
with Area do
begin
     val(neLx.Text,lx,code);
     val(nely.Text,ly,code);
     val(nerx.Text,rx,code);
     val(nery.Text,ry,code);
     if lx>=rx then lx:=rx-1;
     if ly>=ry then ly:=ry-1;
end;
//для Функции Розенброка вводим параметр alpha
val(NeX.Text,alpha,code);
val(neRadius.Text,blocksize,code);
if blocksize=0 then blocksize:=1;
val(nePrec.Text,p,code);
SetPrecision(p);
val(neCount.Text,lcnt,code);
if btnScale.Down then
begin
     if pbOut.height>pbOut.Width then
        frmMain.Width:=frmMain.Width+PbOut.Height-pbOut.Width
     else
        frmMain.Height:=frmMain.Height-PbOut.Height+pbOut.Width;
     str(pbOut.Height,s);
     Caption:=s;
     str(pbout.Width,s);
     caption:=caption+'-'+s;
end;
pbout.Refresh;
InvScanLevels(Area,lCnt);
sbStatus.Panels.Items[1].text:='Статус:Готов.';
end;

procedure TfrmMain.HookJeavse(eps:double;fp:TWorldPoint);
const n=2;
var wavex,xkwave,lastxkwave,curx,b:TWorldPoint;
    basis:array [1..n] of TWorldPoint;
    screen:TScreenPoint;
    fmj,fpj,fjk,gamma,a:double;//f_{-j},f_{+j},...
    k,j:integer;
begin
basis[1].x:=1;basis[1].y:=0;
basis[2].x:=0;basis[2].y:=1;
b.x:=0.5;b.y:=0.5;
gamma:=2;
curx:=fp;{нормальные к-ые точки (используются после исчерпывающего спуска)}
wavex:=fp;{x с волной и с нижним индексом-промежуточные точки}
xkwave:=fp;{x с волной без нижнего индекса}
k:=1;
while true do
begin
  while (xkwave.x=wavex.x) and (xkwave.y=wavex.y) do
   begin
       for j:=1 to n do   {двигаемся по базисным векторам}
       begin
             fjk:=func(wavex.x,wavex.y);
	     fpj:=func(wavex.x+b.x*basis[j].x,wavex.y+b.y*basis[j].y);
	     fmj:=func(wavex.x-b.x*basis[j].x,wavex.y-b.y*basis[j].y);
	     if (fjk>fpj) and (fmj>=fpj) then
	     begin
	        wavex.x:=wavex.x+b.x*basis[j].x;
        	wavex.y:=wavex.y+b.y*basis[j].y;
	     end
	     else if (fjk>fmj) and (fpj>fmj) then
	     begin
	        wavex.x:=wavex.x-b.x*basis[j].x;
	        wavex.y:=wavex.y-b.y*basis[j].y;
	     end;
             World2Screen(Area,CopyScr.Canvas.ClipRect,wavex,Screen);
             CopyScr.Canvas.LineTo(Screen.x,Screen.y);
             SetPoint(wavex);
//             pbOut.Refresh;
       end;{for j}
       if (xkwave.x=wavex.x) and (xkwave.y=wavex.y) then
       begin
             b.x:=b.x/gamma;
	     b.y:=b.y/gamma;
       end;
       if sqrt(sqr(b.x)+sqr(b.y))<eps then
         begin
           BuiltReport(xkwave,wavex,k,0);//минимум найден
           exit;
         end;
//      curx:=wavex;
   end;{while xkwave=wavex}
  if sqrt(sqr(xkwave.x-wavex.x)+sqr(xkwave.y-wavex.y))<eps then break;
  lastxkwave:=xkwave;
  xkwave:=wavex;
  xk:=curx;     {для исчерпывающего спуска}
  uk.x:=xkwave.x-lastxkwave.x;  uk.y:=xkwave.y-lastxkwave.y;
  a:=MakeDichotomy(0,10,1e-5,eps/100,Pseudo1D);{реализуем исчерпывающий спуск}
  curx.x:=lastxkwave.x+a*(xkwave.x-lastxkwave.x);  //todo : replace to uk
  curx.y:=lastxkwave.y+a*(xkwave.y-lastxkwave.y);
  World2Screen(Area,CopyScr.Canvas.ClipRect,curx,Screen);
  CopyScr.Canvas.LineTo(Screen.x,Screen.y);
  SetPoint(curx);
  //pbOut.Refresh;
  BuiltReport(curx,xkwave,k,0);
  wavex:=curx;
  xkwave:=curx;
  inc(k);
end;{while}
BuiltReport(xkwave,wavex,k,1677216);
end;

procedure TFrmMain.Rosenbrouke(eps:double;fp:TWorldPoint);
const n=2;
var wavex,curx:TWorldPoint;
    basis,a,b:array [1..n] of TWorldPoint;
    screen:TScreenPoint;
    gamma:double;
    cappa:array[1..n] of double;
    k,j,i:integer;
begin
basis[1].x:=1;basis[1].y:=0;
basis[2].x:=0;basis[2].y:=1;
curx:=fp;{нормальные к-ые точки (используются после исчерпывающего спуска)}
wavex:=fp;{x с волной и с нижним индексом-промежуточные точки}
k:=1;
while true do
begin
  for j:=1 to n do
  begin
  	xk:=wavex;
	uk:=basis[j];
        cappa[j]:=MakeDichotomy(-1e2,1e2,1e-5,eps/100,Pseudo1D);
        wavex.x:=wavex.x+cappa[j]*basis[j].x;
        wavex.y:=wavex.y+cappa[j]*basis[j].y;
          World2Screen(Area,CopyScr.Canvas.ClipRect,wavex,Screen);
	  Copyscr.Canvas.LineTo(Screen.x,Screen.y);
	//  SetPoint(wavex);
//	  BuiltReport(wavex,wavex,-k,cappa[j]);
//          pbout.Refresh;
  end; {for j}
  if sqrt(sqr(wavex.x-curx.x)+sqr(wavex.y-curx.y))<eps then break
  else curx:=wavex;
            World2Screen(Area,CopyScr.Canvas.ClipRect,curx,Screen);
	  Copyscr.Canvas.LineTo(Screen.x,Screen.y);
	  SetPoint(curx);
	  BuiltReport(curx,curx,k,0);
  //        pbout.Refresh;
  for j:=1 to n do
  begin
  	if abs(cappa[j])<eps*0.01 then
           a[j]:=basis[j]
        else
         begin
            a[j].x:=0;a[j].y:=0;
            for i:=j to n do
            begin
                a[j].x:=a[j].x+cappa[i]*basis[i].x;
                a[j].y:=a[j].y+cappa[i]*basis[i].y;
            end;
         end;
  end;{for j}
  b[1]:=a[1];
       gamma:=sqrt(sqr(b[1].x)+sqr(b[1].y));
       basis[1].x:=b[1].x/gamma;
       basis[1].y:=b[1].y/gamma;
  for j:=2 to n do
  begin
      b[j]:=a[j];
      for i:=1 to j-1 do
      begin
      	gamma:=(a[j].x*basis[i].x+a[j].y*basis[i].y);
        b[j].x:=b[j].x-gamma*basis[i].x;
        b[j].y:=b[j].y-gamma*basis[i].y;
      end;
      gamma:=sqrt(sqr(b[j].x)+sqr(b[j].y));
      basis[j].x:=b[j].x/gamma;
      basis[j].y:=b[j].y/gamma;
  end; {for j}
  for j:=1 to n do
  begin
  end;
  inc(k);
  wavex:=curx;
end; {while}
end;

procedure TFrmMain.Pawell(eps:double;fp:TWorldPoint);
const n=2;
var cappa:Double;
    p_i:array [1..n] of TWorldPoint;
    z,p,curx,lastx,lastxx,wavex:TWorldPoint;
    k,l,i:integer;
    screen:TScreenPoint;
begin
p_i[1].x:=1;p_i[1].y:=0;
p_i[2].x:=0;p_i[2].y:=1;
curx:=fp;
lastx:=fp;
wavex:=fp;
lastxx:=fp;
k:=1;
while true do
begin
  for i:=1 to n do
  begin
    for l:=1 to n do
    begin
       xk:=wavex;
       uk:=p_i[l];
       cappa:=MakeDichotomy(-1000,1000,1e-5,eps/100,Pseudo1D);
       if abs(cappa)<1e-8 then cappa:=0;
       wavex.x:=wavex.x+cappa*p_i[l].x;
       wavex.y:=wavex.y+cappa*p_i[l].y;
       World2Screen(Area,CopyScr.Canvas.ClipRect,wavex,Screen);
       Copyscr.Canvas.LineTo(Screen.x,Screen.y);
     //  pbOut.Refresh;
    end;
    p.x:=wavex.x-lastx.x;
    p.y:=wavex.y-lastx.y;
    xk:=wavex;
    uk:=p;
    cappa:=MakeDichotomy(-10000,10000,1e-5,eps/100,Pseudo1D);
    if abs(cappa)<1e-8 then cappa:=0;
    z.x:=wavex.x+cappa*p.x;
    z.y:=wavex.y+cappa*p.y;
    World2Screen(Area,CopyScr.Canvas.ClipRect,z,Screen);
    Copyscr.Canvas.LineTo(Screen.x,Screen.y);
    SetPoint(z);
//    pbOut.Refresh;
    for l:=1 to n-1 do
     begin
        p_i[l]:=p_i[l+1];
     end;
    p_i[n]:=p;
    if i<>n then begin wavex:=z;lastx:=z; end;
  end;{for i}
  BuiltReport(wavex,p,k,cappa);
  lastxx:=curx;
  curx:=z;
  if sqrt(sqr(curx.x-lastxx.x)+sqr(curx.y-lastxx.y))<eps then
   begin
{      World2Screen(Area,CopyScr.Canvas.ClipRect,z,Screen);
      Copyscr.Canvas.LineTo(Screen.x,Screen.y);
      SetPoint(z);
      BuiltReport(z,wavex,k,0);}
      break;
   end;
  wavex:=curx;
  lastx:=curx;
  inc(k);
end;
end;

procedure TFrmMain.NelderMid(eps:double;fp:TWorldPoint);
const n=2;//размерность пространства
      l=1;//длина ребра симплекса
      alpha=1;//коэффициент отражения
      beta=2;//коэффициент растяжения
      gamma=0.5;//коэффициент сжатия
      delta=0.5;//коэффициент редукции
type
    TSimplexPoint=array [1..n] of double;
    TSimplex=array[1..n+1] of TSimplexPoint;
var i,j,k:integer;
    Simplex,NeoSimplex:TSimplex;
    sp:TSimplexPoint;
    p:TWorldPoint;
   procedure ReenumerateVertexes(var NewSimplex:TSimplex);
   //Делает правильную нумерацию вершин
    var i,j:integer;
    	min:TSimplexPoint;
   begin
    for i:=1 to n+1 do
      for j:=i+1 to n+1 do
      	if func(NewSimplex[j][1],NewSimplex[j][2])<func(NewSimplex[i][1],NewSimplex[i][2]) then
           begin
            min:=NewSimplex[i];
            NewSimplex[i]:=NewSimplex[j];
            NewSimplex[j]:=min;
           end;
   end;{ReenumerateVertexes}
   procedure DrawSimplex(NewSimplex:TSimplex);
   //Рисует Симплекс
   var i:integer;
   	screen:TScreenPoint;
        pnt:TWorldPoint;
   begin
   	CopyScr.Canvas.pen.Color:=rgb(0,0,255);
   	Copyscr.Canvas.Pen.Mode:=pmCopy;
   	pnt.x:=NewSimplex[1][1];
        pnt.y:=NewSimplex[1][2];
   	World2Screen(area,copyscr.Canvas.ClipRect,pnt,screen);
   	copyscr.Canvas.MoveTo(screen.x,screen.y);
        for i:=2 to n+1 do
        begin
           	pnt.x:=NewSimplex[i][1];
	        pnt.y:=NewSimplex[i][2];
        	World2Screen(area,copyscr.Canvas.ClipRect,pnt,screen);
  	   	copyscr.Canvas.LineTo(screen.x,screen.y);
        end;
      	pnt.x:=NewSimplex[1][1];
        pnt.y:=NewSimplex[1][2];
	World2Screen(area,copyscr.Canvas.ClipRect,pnt,screen);
	copyscr.Canvas.LineTo(screen.x,screen.y);
       //	pbOut.Refresh;
   end;
   procedure GetCenterPoint(gcpSimplex:TSimplex;var CenterPoint:TSimplexPoint);
   //возвращает центральную точку грани(ребра) симплекса
   var i,j:integer;
   begin
     for i:=1 to n do
     begin
       CenterPoint[i]:=0;
       for j:=1 to n do
          CenterPoint[i]:=CenterPoint[i]+gcpSimplex[j][i];//центр
       CenterPoint[i]:=CenterPoint[i]/n;
     end;{for i}
   end;{GetCenterPoint}
   function StopCond(NewSimplex:TSimplex):double;
   {вычисляет функцию в условии останова}
   var i:integer;
       CenterPoint:TSimplexPoint;
   begin
   	GetCenterPoint(NewSimplex,CenterPoint);
	Result:=0;
        for i:=1 to n+1 do
           Result:=Result+sqr(func(Simplex[i][1],Simplex[i][2])-func(CenterPoint[1],CenterPoint[2]));
	Result:=sqrt(Result/(n+1));
   end;

begin
k:=1;
//строим начальный симплекс
{строим по центральной точке}
sp[1]:=fp.x;sp[2]:=fp.y;
{for i:=1 to n+1 do
  for j:=1 to n do
    begin
      if j<i-1 then Simplex[i][j]:=sp[j];
      if j=i-1 then Simplex[i][j]:=sp[j]+l*sqrt(j/(2*(j+1)));
      if j>i-1 then Simplex[i][j]:=sp[j]-l/sqrt(2*j*(j+1));
    end;}
{построение симплекса по базисным векторам}
Simplex[1]:=sp;
Simplex[2][1]:=sp[1]+l;
simplex[2][2]:=sp[2];
simplex[3][1]:=sp[1];
simplex[3][2]:=sp[2]+l;
ReenumerateVertexes(Simplex);
DrawSimplex(Simplex);

While StopCond(Simplex)>eps do
begin
//отражение
   GetCenterPoint(Simplex,sp);
   if (k mod RefreshRate)=0 then
     begin
       //fp.x нам уже не нужна  - затираем, чтобы не вводить новых переменных
       fp.x:=sin(60)*sqrt(sqr(Simplex[1][1]-Simplex[2][1])+sqr(Simplex[1][2]-Simplex[2][2]));
       p.x:=Simplex[1][2]-Simplex[2][2];
       p.y:=-Simplex[1][1]+Simplex[2][1];//перпендик к вектору Simplex[1]-Simplex[2]
       Simplex[3][1]:=sp[1]+fp.x*p.x;
       Simplex[3][2]:=sp[2]+fp.x*p.y;
//       fp.x:=sp[1];fp.y:=sp[2];
//       SetPoint(fp);
  //     DrawSimplex(Simplex);
     end;
// fp.x:=sp[1];fp.y:=sp[2];
   NeoSimplex:=Simplex;
   for i:=1 to n do
      NeoSimplex[n+1][i]:=sp[i]+alpha*(sp[i]-Simplex[n+1][i]);
   if func(NeoSimplex[n+1][1],NeoSimplex[n+1][2])<func(Simplex[1][1],Simplex[1][2]) then
      begin
      //этап 2 - растяжение
      	 Simplex:=NeoSimplex;
         GetCenterPoint(Simplex,sp);
         NeoSimplex:=Simplex;
         for i:=1 to n do
            NeoSimplex[n+1][i]:=sp[i]+beta*(Simplex[n+1][i]-sp[i]);
         if func(NeoSimplex[n+1][1],NeoSimplex[n+1][2])<func(Simplex[1][1],Simplex[1][2]) then
             Simplex:=NeoSimplex;
         DrawSimplex(Simplex);
         ReenumerateVertexes(Simplex);
         inc(k);
         continue;
      end;
   if (func(NeoSimplex[n][1],NeoSimplex[n][2])>=func(NeoSimplex[n+1][1],NeoSimplex[n+1][2]))
      and (func(NeoSimplex[n+1][1],NeoSimplex[n+1][2])>=func(NeoSimplex[1][1],NeoSimplex[1][2])) then
         begin
	    DrawSimplex(NeoSimplex);
            Simplex:=NeoSimplex;
            ReenumerateVertexes(Simplex);
            inc(k);
            continue;
         end;
   if (func(NeoSimplex[n+1][1],NeoSimplex[n+1][2])>func(NeoSimplex[n][1],NeoSimplex[n][2]))
      and (func(NeoSimplex[n][1],NeoSimplex[n][2])>=func(NeoSimplex[1][1],NeoSimplex[1][2])) then
	//сжатие нового симплекса
        begin
         GetCenterPoint(NeoSimplex,sp);
//          NeoSimplex:=Simplex;
          if func(NeoSimplex[n+1][1],NeoSimplex[n+1][2])<=func(Simplex[n+1][1],Simplex[n+1][2]) then
              //Проверить возможность прсчета центральной точки в неосимплексе -
              //должно ли быть безразлично где считать? Да
              for i:=1 to n do
                NeoSimplex[n+1][i]:=sp[i]+gamma*(NeoSimplex[n+1][i]-sp[i])
          else
             for i:=1 to n do
             	NeoSimplex[n+1][i]:=sp[i]+gamma*(Simplex[n+1][i]-sp[i]);
          if func(NeoSimplex[n+1][1],NeoSimplex[n+1][2])<func(Simplex[n+1][1],Simplex[n+1][2]) then
          	begin
                  Simplex:=NeoSimplex;
                  ReenumerateVertexes(Simplex);
                  DrawSimplex(Simplex);
                  inc(k);
                  continue;
                end
          else
            begin
              //редукция симплекса
              for i:=2 to n+1 do
                for j:=1 to n do
                   NeoSimplex[i][j]:=Simplex[1][j]+delta*(Simplex[i][j]-Simplex[1][j]);
              Simplex:=NeoSimplex;
              ReenumerateVertexes(Simplex);
              DrawSimplex(Simplex);
              inc(k);
              continue;
            end;
        end;
end;{while}
ReenumerateVertexes(Simplex);
fp.x:=Simplex[1][1];
fp.y:=Simplex[1][2];
BuiltReport(fp,fp,k,0);
end;

procedure TFrmMain.CycledDescent(eps:double;fp:TWorldPoint);
const n=2;
type TNDimensionalVector=array[1..n] of double;
var j,k:integer;
    basis:array[1..n] of TNDimensionalVector;
    curx,lastcoordx,tmpx,lastx:TNDimensionalVector;
    screen:TScreenPoint;
    alpha:double;
begin
basis[1][1]:=1;basis[1][2]:=0;
basis[2][1]:=0;basis[2][2]:=1;
curx[1]:=fp.x;curx[2]:=fp.y;
k:=1;
while true do
begin
      lastcoordx:=curx;
      tmpx:=curx;
      for j:=1 to n do
        begin
          xk.x:=lastcoordx[1];xk.y:=lastcoordx[2];
          uk.x:=basis[j][1];uk.y:=basis[j][2];
          alpha:=MakeDichotomy(-10,10,1e-5,eps/100,Pseudo1D);
          tmpx[1]:=tmpx[1]+alpha*basis[j][1];
          tmpx[2]:=tmpx[2]+alpha*basis[j][2];
          fp.x:=tmpx[1];fp.y:=tmpx[2];
          World2Screen(area,copyscr.Canvas.ClipRect,fp,screen);
          copyscr.Canvas.LineTo(screen.x,screen.y);
          setpoint(fp);
          pbout.Refresh;
          lastcoordx:=tmpx;
        end;
      lastx:=curx;
      curx[1]:=tmpx[1]+alpha*basis[n][1];
      curx[2]:=tmpx[2]+alpha*basis[n][1];
      BuiltReport(fp,fp,k,alpha);
     fp.x:=curx[1];fp.y:=curx[2];
      World2Screen(area,copyscr.Canvas.ClipRect,fp,screen);
      copyscr.Canvas.LineTo(screen.x,screen.y);
       setpoint(fp);
      pbout.Refresh;
      if sqrt(sqr(curx[1]-lastx[1])+sqr(curx[2]-lastx[2]))<eps then break;
     inc(k);
end;
end;

procedure TfrmMain.btnMethodClick(Sender: TObject);
begin
btnMinClick(nil);
end;

procedure TfrmMain.btnSaveRepClick(Sender: TObject);
begin
     MnuSaveClick(nil);
end;

procedure TfrmMain.btnSavePictureClick(Sender: TObject);
begin
     mnuSavePictureClick(nil);
end;

procedure TfrmMain.mnuQuasiClick(Sender: TObject);
begin
	ServeMenuClick(mnuQuasi);
end;

procedure TfrmMain.mnuHookJeavseClick(Sender: TObject);
begin
	ServeMenuClick(mnuHookJeavse);
end;

procedure TfrmMain.mnuRosenbrooksClick(Sender: TObject);
begin
	ServeMenuClick(mnuRosenbrooks);
end;

procedure TfrmMain.mnuPawellClick(Sender: TObject);
begin
  ServeMenuClick(mnuPawell);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ord(Key)=vk_f9 then
	btnMinCLick(nil);
end;

procedure TfrmMain.mnuNelderMidClick(Sender: TObject);
begin
  ServeMenuClick(mnuNelderMid);
end;

procedure TFrmMain.ServeMenuClick(Menu:TMenuItem);
begin
   mnuCrackingStep.Checked:=false;
   mnuQuickestDescent.Checked:=false;
   mnuConj.Checked:=false ;
   mnuQuasi.Checked:=false;
   mnuCycle.Checked:=false;
   mnuHookJeavse.Checked:=false;
   mnuRosenbrooks.Checked:=false;
   mnuPawell.Checked:=false;
   mnuNelderMid.Checked:=false;
   Menu.Checked:=true;
   sbStatus.Panels.Items[2].Text:='Метод:'+Menu.Caption;
   btnMethod.Caption:=Menu.Caption;
end;

procedure TfrmMain.mnuCycleClick(Sender: TObject);
begin
	ServeMenuClick(mnuCycle);
end;

procedure TfrmMain.mnuCondGradClick(Sender: TObject);
begin
   ServeMenuClick(mnuCondGrad);
end;

function InCondition(A,B:TMatrix;x:TWorldPoint):boolean;
var i:integer;
begin
//-4,-1,-4,5
//if ((x.x>=-4) and (x.x<=-1)) and ((x.y>=-4) and (x.y<=5)) then
Result:=true;
for i:=0 to Length(A)-1 do      //в случае линейных ограниченийы
 Result:=Result and ((x.x*A[i][0]+x.y*A[i][1]-B[i][0])<0);
end;

function GetActiveCond(A,B:TMatrix;point:TWorldPoint;var numbers:TNumbers;eps:double):integer;
var i,size:integer;
begin
size:=1;
for i:=1 to 4 do Numbers[i]:=0;
for i:=0 to Length(A)-1 do
   if abs(point.x*A[i][0]+Point.y*A[i][1]-B[i][0])<=eps then
      begin
         Numbers[size]:=i+1;
         inc(size);
      end;
{if abs(point.x+4)<=eps then
//if abs(point.x+point.y-2)<=eps then
  begin
   Numbers[size]:=1;
   inc(size);
  end;
if abs(point.x+1)<=eps then
//if abs(point.x+5*point.y-5)<=eps then
  begin
   Numbers[size]:=2;
   inc(size);
  end;
if abs(point.y+4)<=eps then
//if abs(-point.x)<=eps then
  begin
   Numbers[size]:=3;
   inc(size);
  end;
if abs(point.y-5)<=eps then
//if abs(point.y)<=eps then
  begin
   Numbers[size]:=4;
   inc(size);
  end;       }
Result:=size-1;
end;

procedure TFrmMain.CondGrad(eps:double;fp:TworldPoint);
var lastx,wavex,curx,grad:TWorldPoint;
    cappa,l2nrm:Double;
    screen:TScreenPoint;
    rect:TRect;
    k:integer;
begin
//-2,4
InitMatrix(A_All,4,2);
InitMatrix(bi,4,1);

//bi[0][0]:=-1;bi[1][0]:=5;bi[2][0]:=4;bi[3][0]:=4;
bi[0][0]:=1;bi[1][0]:=3;bi[2][0]:=3;bi[3][0]:=5;
a_all[0][0]:=-1{1};a_all[0][1]:=0;//x
a_all[1][0]:=0;a_all[1][1]:=-1;      //y
a_all[2][0]:=1;a_all[2][1]:=0;   //x
a_all[3][0]:=0;a_all[3][1]:=1; 
//fp.x:=-1;fp.y:=4;
fp.x:=0;fp.y:=0;
lastx:=fp;
curx:=fp;
rect:=copyscr.Canvas.ClipRect;
SetPoint(fp);
World2Screen(Area,rect,fp,screen);
copyscr.Canvas.MoveTo(screen.x,screen.y);
GradientFunc(fp.x,fp.y,grad);      //это антиградиент
k:=0;
while true do
begin
      	lastx:=curx;
	if grad.x<0 then wavex.x:=-bi[0][0]{-4} else wavex.x:=bi[2][0]{-1};
	if grad.y<0 then wavex.y:=-bi[1][0]{-4} else wavex.y:=bi[3][0]{5};
	xk:=lastx;
	uk.x:=wavex.x-lastx.x;uk.y:=wavex.y-lastx.y;
	cappa:=MakeDichotomy(0,1,1e-7,1e-7,@Pseudo1D);
	curx.x:=lastx.x+cappa*uk.x;
	curx.y:=lastx.y+cappa*uk.y;
        World2Screen(Area,rect,curx,screen);
        copyscr.Canvas.LineTo(screen.x,screen.y);
        //pbout.Refresh;
	SetPoint(curx);
      	GradientFunc(Curx.x,curx.y,grad);      //это антиградиент
        l2nrm:=sqrt(sqr(lastx.x-curx.x)+sqr(lastx.y-curx.y));
	if l2nrm{abs(func(curx.x,curx.y)-func(lastx.x,lastx.y))}<eps then break;
        inc(k);
        BuiltReport(curx,wavex,l2nrm,cappa);
end;
DrawCondition;
end;

procedure TFrmMain.DrawCondition;
var i,j:integer;
    scr1,scr2,scr3:TScreenPoint;
    w1,w2:TWorldPoint;
    rect:TRect;
begin
rect:=copyscr.Canvas.ClipRect;
w1.x:=Area.lx;w1.y:=Area.ly;
w2.x:=Area.rx;w2.y:=Area.ry;
World2Screen(Area,Rect,w1,scr1);
World2Screen(Area,Rect,w2,scr2);
copyscr.Canvas.Pen.Mode:=pmXor;
for i:=min(scr1.x,scr2.x) to max(scr2.x,scr1.x) do
   for j:=min(scr1.y ,scr2.y) to max(scr1.y ,scr2.y) do
      begin
         scr3.x:=i;scr3.y:=j;
         Screen2World(Area,Rect,scr3,w1);
         if InCondition(A_all,bi,w1) then
            copyScr.Canvas.Pixels[i,j]:=rgb(48,48,48);
      end;
end;

procedure TfrmMain.pbOutMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   LeftBound.x:=x;leftBound.y:=y;
   CanZoom:=true;
end;

procedure TfrmMain.pbOutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var world1,world2:TWorldPoint;
    s:string;
begin
 if CanZoom then
   begin
      RightBound.x:=x;RightBound.y:=y;
      Screen2World(Area,copyscr.Canvas.ClipRect,LeftBound,world1);
      Screen2World(Area,copyscr.Canvas.ClipRect,RightBound,world2);
      str(min(world1.x,world2.x),s);
      neLx.Text:=s;
      str(max(world1.x,world2.x),s);
      neRx.Text:=s;
      str(min(world1.y,world2.y),s);
      neLy.Text:=s;
      str(max(world1.y,world2.y),s);
      neRy.Text:=s;
   end;
  CanZoom:=false;
end;

procedure TfrmMain.mnuAntigradPrjClick(Sender: TObject);
begin
  ServeMenuClick(mnuAntiGradPrj);
end;


procedure TFrmMain.AntiGradPrj(eps:double;fp:TworldPoint);
var cappa,curx:double;
    grad:TWorldPoint;
    A,{B,D,c,P,p_s,E,}p_i,{A_all,}lambda{,bi}:TMatrix;
    num:TNumbers;
    i,j,k:integer;
    screen:TScreenPoint;

    function IsIInNum(n:TNumbers;iii:integer):boolean;
    var iiii:integer;
    begin
	for iiii:=1 to 4 do
          if n[iiii]=iii then
             begin
                Result:=true;
                exit;
             end;
       result:=false;
    end;

    function GetMinCappa:double;
      var ii:integer;
      	  tmp,znam:double;
	  n:TNumbers;
      begin
        Result:=(bi[1][0]-(a_all[1][0]*fp.x+a_all[1][1]*fp.y));//MaxDouble;
        GetActiveCond(A_all,Bi,fp,n,eps);
    	for ii:=0 to 3 do
          begin
            { if Not IsIInNum(n,ii+1) then}
//                begin
                   znam:=(a_all[ii][0]*p_i[0][0]+a_all[ii][1]*p_i[1][0]);
                   if znam>0 then
                   begin
                     tmp:=(bi[ii][0]-(a_all[ii][0]*fp.x+a_all[ii][1]*fp.y))/znam;
                     if (tmp<Result) and (tmp>0) then Result:=tmp;
                   end;
  //              end;
          end;{for}
      end;

    procedure GetDescentVectorAndLambda(var desv,lam:TMatrix);
    Var BB,CC,DD,EE,PP,Pp_ss:TMatrix;
        jj,s:integer;
    begin
          s:=0;
          for jj:=1 to 4 do
             inc(s,num[jj]);
          if s<>0 then
          begin
		  AAT(A,BB);                  //B=A*A^T
		  GetInverseMatrix(BB,CC,eps); //C=inverse (A*A^T)
		  Transpose(A,DD);	     //D=A^T - больше не нужно
		  MultMatrix(DD,CC,EE);	     //E=A^T*(A*A^T)
		  MultMatrix(EE,A,PP);
		  MakeUnitMatrix(Pp_ss,length(PP));
		  MatrixSubtraction(PP_Ss,PP);
		  InitMatrix(DD,2,1);
		  DD[0][0]:=grad.x;DD[1][0]:=grad.y;
		  MultMatrix(Pp_ss,DD,desv);//p_i=(P*)*w1
	          //вычисляем lambda
	          MultMatrix(CC,A,BB);
		  MultMatrix(BB,DD,lam);//имеет количество строк, равное
        			      //количеству активных ограничений
          end
          else
            begin
              InitMatrix(DD,2,1);
              InitMatrix(lam,0,0);
              DD[0][0]:=grad.x;DD[1][0]:=grad.y;
              CopyMatrix(DD,desv);
            end;
//            MessageBox(Handle,'Все таки этот участок кода надо писать...','ЧП',0);
    end;

    function GetFirstNegativeIndex(lam:TMatrix):integer;
    var ii:integer;
    begin
	for ii:=length(Lam)-1 downto 0 do
           if lam[ii][0]<0 then
             begin
                Result:=ii;
                exit;
             end;
        Result:=-1;
    end;

begin
k:=1;
InitMatrix(A_All,4,2);
InitMatrix(bi,4,1);
//bi[0][0]:=-4;bi[1][0]:=-1;bi[2][0]:=-4;bi[3][0]:=5;
bi[0][0]:=-1;bi[1][0]:=5;bi[2][0]:=4;bi[3][0]:=4;
fp.x:=-2;fp.y:=4;
{a_all[0][0]:=1;a_all[0][1]:=0;
a_all[1][0]:=1;a_all[1][1]:=0;
a_all[2][0]:=0;a_all[2][1]:=-1;
a_all[3][0]:=0;a_all[3][1]:=1;}
a_all[0][0]:=1;a_all[0][1]:=0;
a_all[1][0]:=0;a_all[1][1]:=1;
a_all[2][0]:=-1;a_all[2][1]:=0;
a_all[3][0]:=0;a_all[3][1]:=-1;

(*JONNY://bi[0][0]:=-1;bi[1][0]:=5;bi[2][0]:=4;bi[3][0]:=4;
bi[0][0]:=1;bi[1][0]:=5;bi[2][0]:=1;bi[3][0]:=5;
a_all[0][0]:=-1{1};a_all[0][1]:=0;//x
a_all[1][0]:=0;a_all[1][1]:=-1;      //y
a_all[2][0]:=1;a_all[2][1]:=0;   //x
a_all[3][0]:=0;a_all[3][1]:=1;      //y
//fp.x:=-1;fp.y:=4;
fp.x:=-1;fp.y:=4;          *)

DrawCondition;
World2Screen(area,copyscr.Canvas.ClipRect,fp,screen);
copyscr.Canvas.MoveTo(screen.x,screen.y);
copyscr.Canvas.Pen.Mode:=pmCopy;
while true do
begin
  GradientFunc(fp.x,fp.y,grad);
  InitMatrix(A,GetActiveCond(A_all,Bi,fp,num,eps),2);
  ZeroMatrix(A);
  for i:=0 to Length(A)-1 do
     for j:=0 to 1 do
        A[i][j]:=a_all[num[i+1]-1][j];
  GetDescentVectorAndLambda(p_i,lambda);
  if EuclidNorma(p_i)>eps then
    begin
	xk:=fp;
        uk.x:=p_i[0][0];uk.y:=p_i[1][0];
        cappa:=MakeDichotomy(0,GetMinCappa,eps*1e-2,eps*1e-2,@Pseudo1D);
        fp.x:=fp.x+cappa*uk.x;
        fp.y:=fp.y+cappa*uk.y;
  //      if Not incondition(fp) then
//         MessageBox(Handle,'not sat','',0);
        World2Screen(area,copyscr.Canvas.ClipRect,fp,screen);
        copyscr.Canvas.lineto(screen.x,screen.y);
        setpoint(fp);
        BuiltReport(fp,grad,k,0);
       // pbOut.Refresh;
        inc(k);
        continue;
    end
  else
    begin
      j:=0;
      for i:=1 to 4 do
          inc(j,num[i]);
      i:=GetFirstNegativeIndex(lambda);

      if (i=-1) then
       begin
         BuiltReport(fp,grad,0,0);//все.
         exit;
       end;
    {  while i<>-1 do}
      if i<>-1 then
       begin
         num[i+1]:=0;
         if Length(A)-1 >0 then
         begin
	   InitMatrix(A,Length(A)-1,2);//это точно
           ZeroMatrix(A);
           //если множество индексов ограничений пусто, то проверяем
           //положительность lambda
            for k:=0 to Length(num)-1 do
              if num[k+1]<>0 then
               begin
                 for i:=0 to Length(A)-1  do
                    for j:=0 to 1 do
                       A[i][j]:=a_all[num[k+1]-1][j];
               end;
            end;
            GetDescentVectorAndLambda(p_i,lambda);
           //i:=GetFirstNegativeIndex(lambda);
       end;{while}
       xk:=fp;
       uk.x:=p_i[0][0];uk.y:=p_i[1][0];
       cappa:=MakeDichotomy(0,GetMinCappa,eps*1e-2,eps*1e-2,@Pseudo1D);
       fp.x:=fp.x+cappa*uk.x;
       fp.y:=fp.y+cappa*uk.y;
       setpoint(fp);
    //   if Not incondition(fp) then
      //   MessageBox(Handle,'not sat','',0);
       World2Screen(area,copyscr.Canvas.ClipRect,fp,screen);
       BuiltReport(fp,grad,k,0);
       copyscr.Canvas.lineto(screen.x,screen.y);
      // pbOut.Refresh
{    else}
    {pk<epsilon}
    end;{if}
    inc(k);
end;
{InitMatrix(B,3,2);
A[0][0]:=1;A[0][1]:=2;A[0][2]:=3;
A[1][0]:=4;A[1][1]:=5;A[1][2]:=6;
B[0][0]:=-1;B[0][1]:=-4;
B[1][0]:=-2;B[1][1]:=-5;
B[2][0]:=-3;B[2][1]:=-6;
//MultMatrix(A,B,C);
//GetInverseMatrix(C,B,1e-5);
AAT(A,C);}
cappa:=-1;
end;

procedure THistoryItems.AddHistoryItem(Area:TDoubleRect);
var  s,c:string;
begin
 if CurItems+1<=HistorySize then
   begin
    c:='';
    THistoryItem[CurItems]:=Area;
    str(Area.lx:0:3,s);
    c:='('+s;
    str(Area.ly:0:3,s);
    c:=c+';'+s;
    str(Area.rx:0:3,s);
    c:=c+')x('+s;
    str(Area.ry:0:3,s);
    c:=c+';'+s+')';
    frmMain.cboHistory.Items.Add(c) ;
    inc(CurItems);
   end;
end;

procedure THistoryItems.Undo(histID:integer);
var s:string;
    i:integer;
begin
   With frmMain do
    begin
      str(THistoryItem[HistID].lx ,s);
      neLx.Text:=s;
      str(THistoryItem[HistId].rx,s);
      neRx.Text:=s;
      str(THistoryItem[HistId].ly,s);
      neLy.Text:=s;
      str(THistoryItem[HistId].ry,s);
      neRy.Text:=s;
      for i:=HistId to cboHistory.Items.Count-1 do
	  cboHistory.Items.Delete(i);
    end;
    CurItems:=HistId;
end;

procedure THistoryItems.SetHistorySize(size:integer);
begin
   CurItems:=0;
   SetLength(ThistoryItem,Size);
   HistorySize:=size;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   undo.SetHistorySize(20);
end;

procedure TfrmMain.cboHistoryClick(Sender: TObject);
begin
   Undo.Undo(cboHistory.ItemIndex);
end;

end.
