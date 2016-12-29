unit nshape;

interface
uses
     sysutils,
     forms,
     windows,
     menus,
     controls,
     graphics, //константы цветов
     classes,  //tcomponent
     ExtCtrls; // тут определяется tshape

var Debug:boolean=false; //включается во время работы нейронной сети
    Initing:boolean=false;
    Loop:boolean;
    C1:TColor=clYellow;
    C2:TColor=clAqua;
    C3:TColor=clLime;


const AR=100; //динамические массивы тормозят программу
type
  Tdar=array[1..AR] of double;
  Tiar=array[1..AR] of integer;

  TslShape=class(TShape)
    constructor Create(AOwner: TWinControl; knd:integer);reintroduce;
    procedure Move(X,Y:integer);
    procedure ChangeName(Caption:string);
  private

    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton;
                             Shift: TShiftState; X, Y: Integer);
    procedure ShapeDragOver(Sender, Source: TObject; X, Y: Integer;
                            State: TDragState; var Accept: Boolean);
    procedure ShapeDragDrop(Sender, Source: TObject; X, Y: Integer);
  protected
    procedure Paint;override;// reintroduce;
  public
    knd:integer; //тип формы
                  // 1 - in
                  // 2 - out
                  // 3 - neuron
    en,skip,non:boolean;
    Caption:string;
    T:double; //пороговое значение, используется только нейронами
    tX,tY:integer;
  end;

  TslPopupMenu=class(Tpopupmenu)
    constructor Create(AOwner: TWinControl); reintroduce;
  private
    Conn: TMenuItem;
    Weig: TMenuItem;
    Disc: TMenuItem;
    Nmit: TMenuItem;
    Deli: TMenuItem;
    procedure miClick(Sender:TObject);
  end;


  TslCon=class
    constructor Create;
    procedure Add(ot,it:TslShape);
    function Remove(ot,it:TslShape):boolean; overload;
    procedure Remove(ind:integer); overload;
    function Find(ot,it:TslShape; var ind:integer):boolean;
  public
    DefC:TColor;
    function GetCoord(ind:integer):TRect;
    function GetColor(ind:integer):TColor;
    procedure GetEl(ind:integer;var ot:TslShape;var wei:double);
    procedure ChWeig(ind:integer;wei:double);
    function FillIn(it:TslShape;var otv:TiAR):integer;
    function Count:integer;

    procedure HackGetALL(var w,i,o,c:TStringList);
    procedure HackPutALL(var w,i,o,c:TStringList);

    {функции работы с нейронной сктью}
    procedure ResetAll;
    procedure Reset;
    function Step:boolean;
    procedure LoopStep;
  private
    o,i,c,w:TStringList;
  end;

procedure GenerateTemplate(n,k:integer);

var Scon:TslCon;
    dlin:boolean=true;

implementation
uses rmform,mainunit,weigunit;
var  mnu:Tslpopupmenu=nil;
     ts:TslShape;

     Connecting:boolean;
     DisConnecting:boolean;

//------------------------------------------------------------------------------------
//TslPopupMenu

  constructor TslPopupMenu.Create;
  begin
    inherited Create(AOwner);

    Conn:=TMenuItem.Create(self);
    Conn.Caption:='Connect To';
    Conn.Tag:=1;
    Conn.OnClick:=miClick;
    Items.Add(Conn);

    Weig:=TMenuItem.Create(self);
    Weig.OnClick:=miClick;
    Weig.Tag:=2;
    Weig.Caption:='Weight';
    Items.Add(Weig);

    Disc:=TMenuItem.Create(self);
    Disc.Caption:='Disconnect From';
    Disc.Tag:=3;
    Disc.OnClick:=miClick;
    Items.Add(Disc);

    Nmit:=TMenuItem.Create(self);
    Nmit.Caption:='Rename';
    Nmit.Tag:=4;
    Nmit.OnClick:=miClick;
    Items.Add(Nmit);

    Deli:=TMenuItem.Create(self);
    Deli.Caption:='Delete';
    Deli.Tag:=5;
    Deli.OnClick:=miClick;
    Items.Add(Deli);
  end;

  procedure TslPopupMenu.miClick(Sender:TObject);
  var rm:Trenamer;
      ind:integer;
      otv:Tiar;
      k:integer;
      tw:TWeigf;
  begin
    case TMenuItem(Sender).Tag of
    1:begin
        Connecting:=true;
        Screen.Cursor:=crCross;
      end;
    2:begin
        k:=scon.FillIn(ts,otv);
        tw:=TWeigf.Create(main,otv,k,ts);
        tw.ShowModal;
        tw.Free;
      end;
    3:begin
        DisConnecting:=true;
        Screen.Cursor:=crCross;
      end;
    4:begin
        rm:=Trenamer.Create(self,ts.Caption);
        if rm.ShowModal=mrOk then ts.Caption:=rm.Editor.Text;
        rm.Free;
        ts.Repaint;
      end;
    5:begin
        while scon.Find(ts,nil,ind) do scon.Remove(ind);
        while scon.Find(nil,ts,ind) do scon.Remove(ind);
        main.RePaint;
        ts.Free;
      end;
    end;
  end;

//------------------------------------------------------------------------------------
//TslShape
  constructor TslShape.Create;
  begin
    if not (knd in [1..3]) then exit; //если тип указан неправильно, то ничего не делаем
    inherited Create(Owner);          //родительский конструктор
    self.knd:=knd;                    //запомним кто мы
    en:=false;
    skip:=false;
    case knd of
    1:begin  //in
        Shape:=stSquare;
        Brush.Color:=C1;
        Height:=30;
        Width:=30;
      end;
    2:begin //out
        Shape:=stRoundRect;
        Brush.Color:=C2;
        Height:=30;
        Width:=40;
      end;
    3:begin
        Shape:=stRoundRect;
        Brush.Color:=C3;
        Height:=30;
        Width:=65;
        T:=0;
      end;
    end;
    Parent:=AOwner;
    if mnu=nil then mnu:=TslpopupMenu.Create(AOwner); //инициализировать контекстное меню, если этого ещё не сделано
    OnDragDrop:=ShapeDragDrop;
    OnDragOver:=ShapeDragOver;
    OnMouseDown:=ShapeMouseDown;
  end;


  procedure TslShape.ShapeMouseDown(Sender: TObject; Button: TMouseButton;
                           Shift: TShiftState; X, Y: Integer);
  begin
    if Connecting then begin
      Connecting:=false;
      Screen.Cursor:=crDefault;
      scon.Add(ts,self);
      main.Repaint;
    end else
    if DisConnecting then begin
      DisConnecting:=false;
      Screen.Cursor:=crDefault;
      scon.Remove(ts,self);
      main.Repaint;
    end else
    if Initing and (Button=mbLeft)then begin
      if (not Loop) and (TslShape(Sender).knd<>1) then exit;
         self.en:=not self.en;
         self.Paint;
    end else begin
      tX:=X;
      tY:=Y;
      if Button=mbLeft then (Sender as TShape).BeginDrag(false) else

      if Button=mbRight then begin
        ts:=self;
        if knd=3 then mnu.Weig.Enabled:=true else mnu.Weig.Enabled:=false;
        mnu.Popup(ClientToScreen(Point(X,Y)).X,ClientToScreen(Point(X,Y)).Y);
      end;
    end;
  end;

  procedure TslShape.ShapeDragOver(Sender, Source: TObject; X, Y: Integer;
                          State: TDragState; var Accept: Boolean);
  begin
    Accept:=true;
  end;

  procedure TslShape.ShapeDragDrop(Sender, Source: TObject; X, Y: Integer);
  begin
    TslShape(Source).Move(Tshape(Sender).Left+X,Tshape(Sender).Top+Y);
  end;

  procedure TslShape.Move(X,Y:integer);
  begin
    Left:=X-tX;
    Top:=Y-tY;
    main.Repaint;
  end;

  procedure TslShape.Paint;
  begin
    inherited Paint;
    Canvas.TextRect(Rect(Pen.Width+1,Pen.Width+1,Width-Pen.Width-3,Height-Pen.Width-3),2,Trunc(Height/3),Caption);
    Canvas.Brush.Color:=clBlack;
    if en then Canvas.FillRect(Rect(Pen.Width+2,Pen.Width+2,Pen.Width+10,Pen.Width+8));
  end;

  procedure TslShape.ChangeName;
  begin
    self.Caption:=Caption;
  end;


//------------------------------------------------------------------------------------
//TslCon
  constructor TslCon.Create;
  begin
   inherited Create;
   i:=TStringList.Create; //in->out = o->i !!! - то есть всё наоборот
   o:=TStringList.Create;
   c:=TStringList.Create;
   w:=TStringList.Create;
   DefC:=$000000;
  end;


  function TslCon.Find;
  var j:integer;
  begin
    result:=false;

    if ot=nil then begin
       for j:=0 to i.Count-1 do
       if i.Objects[j]=it then begin
         result:=true;
         ind:=j;
         exit;
       end;
    end else
    if it=nil then begin
       for j:=0 to o.Count-1 do
       if o.Objects[j]=ot then begin
         result:=true;
         ind:=j;
         exit;
       end;
    end else
    for j:=0 to o.Count-1 do
    if (o.Objects[j]=ot)and(i.Objects[j]=it) then
    begin
      result:=true;
      ind:=j;
      exit;
    end;
  end;

  procedure TslCon.Add;
  var ind:integer;
  begin
    if Find(ot,it,ind) or Find(it,ot,ind) or(ot.knd=2)or(it.knd=1) then exit;
    if (it.knd=2)and Find(nil,it,ind) then exit;
    if it=ot then exit;
    o.AddObject('',ot);
    i.AddObject('',it);
    c.AddObject('',pointer(DefC)); //запрещённый приём :-)
    w.Add(FloatToStr(0));
  end;

  function TslCon.Remove(ot,it:TslShape):boolean;
  var ind:integer;
  begin
    result:=true;
    if Find(ot,it,ind) then
    begin
      i.Delete(ind);
      o.Delete(ind);
      c.Delete(ind);
      w.Delete(ind);
    end else result:=false;
  end;

  procedure TslCon.Remove(ind:integer);
  begin
      i.Delete(ind);
      o.Delete(ind);
      c.Delete(ind);
      w.Delete(ind);
  end;

  function TslCon.Count:integer;
  begin
    result:=o.Count;
  end;

  function TslCon.GetCoord;
  var osh,ish:TslShape;

  begin
    osh:=TslShape(o.objects[ind]);
    ish:=TslShape(i.objects[ind]);
    result:=Rect(Trunc(osh.left+osh.width/2),
                 Trunc(osh.top+osh.height/2),
                 Trunc(ish.left+ish.width/2),
                 Trunc(ish.top+ish.height/2));
  end;


  function TslCon.GetColor;
  begin
    result:=TColor(c.Objects[ind]);
  end;

  function TslCon.GetEl;
  begin
    wei:=StrToFloat(w.Strings[ind]);
    ot:=TslShape(o.Objects[ind]);
  end;

  procedure TslCon.ChWeig;
  begin
    w.Strings[ind]:=FloatToStr(wei);
  end;

  function TslCon.FillIn;
  var j,k:integer;
  begin
    k:=0;
    for j:=0 to i.Count-1 do
    if TslShape(i.Objects[j])=it then begin
      inc(K);
      otv[k]:=j;
    end;
    result:=k;
  end;

  procedure TslCon.ResetAll;
  var j:integer;
  begin
    Debug:=false;
    Initing:=false;
    for j:=0 to main.ControlCount-1 do begin
      if main.Controls[j] is TslShape then TslShape(main.Controls[j]).en:=false;
      TslShape(main.Controls[j]).skip:=false;
    end;
    main.Repaint;
  end;

  procedure TslCon.Reset;
  var j:integer;
  begin
    if not Loop then
      for j:=0 to main.ControlCount-1 do begin
        if main.Controls[j] is TslShape then
        if TslShape(main.Controls[j]).knd<>1 then TslShape(main.Controls[j]).en:=false;
        TslShape(main.Controls[j]).skip:=false;
      end;
    Debug:=false;
    Initing:=false;
    main.Repaint;
  end;

  function TslCon.Step;
  var j,k:integer;
      tsh,tshf:TslShape;
      wei:double;
      we:TdAR;
      fr:TiAr;
      sz:integer;
      rt,       //сумма весов включённых
      t:double; //порог как сумма всех весов
  label notready;

  begin
    if not Debug then begin
      result:=true;
      Exit;
    end;
    if Initing then begin
      Reset;
      Debug:=true;
      Initing:=false;
      for j:=0 to o.Count-1 do begin
        if TslShape(o.Objects[j]).knd=1 then TslShape(o.Objects[j]).skip:=true;
      end;
    end;

    if i.Count=0 then begin
      result:=true;
      exit;
    end;

    k:=0;
    repeat
      tsh:=TslShape(i.Objects[k]);
      if tsh.skip=false then begin
        if tsh.knd=2 then begin //out
          GetEl(k,tshf,wei);
          if tshf.en then tsh.en:=true;
          tsh.skip:=true;
        end else begin          //neuron
          sz:=FillIn(tsh,fr);
          t:=0;
          rt:=0;
          for j:=1 to sz do begin
            GetEl(fr[j],tshf,we[j]);
            if not tshf.skip then goto notready;
            t:=t+abs(we[j]);
            if not tshf.en then we[j]:=0;
            rt:=rt+we[j];
          end;
          tsh.skip:=true;
          if t=0 then t:=1; //так как rt всё равно равно 0, и rt/t=0
          if rt/t>=tsh.T then tsh.en:=true else tsh.en:=false;
        end;
        result:=false;
        main.Repaint;
        exit;
      end;
   notready:
      inc(k);
    until k>i.Count-1;
    result:=true;
  end;

  procedure TslCon.LoopStep;
  var j,k:integer;
      tsh,tshf:TslShape;
      wei:double;
      we:TdAR;
      fr:TiAr;
      sz:integer;
      rt,       //сумма весов включённых
      t:double; //порог как сумма всех весов

  begin
    if not Debug then exit;
    if i.Count=0 then exit;


    for j:=0 to i.Count-1 do begin
      TslShape(i.Objects[j]).skip:=false;
      TslShape(i.Objects[j]).non:=false;
    end;

    k:=0;
    repeat
      tsh:=TslShape(i.Objects[k]);
      if tsh.skip=false then begin
        tsh.skip:=true;
        if tsh.knd=2 then begin //out
          GetEl(k,tshf,wei);
          if tshf.en then tsh.non:=true;
        end else begin          //neuron
          sz:=FillIn(tsh,fr);
          t:=0;
          rt:=0;
          for j:=1 to sz do begin
            GetEl(fr[j],tshf,we[j]);
            t:=t+abs(we[j]);
            if not tshf.en then we[j]:=0;
            rt:=rt+we[j];
          end;
          if t=0 then t:=1; //так как rt всё равно равно 0, и rt/t=0
          if rt/t>=tsh.T then tsh.non:=true;
        end;
      end;
      inc(k);
    until k>i.Count-1;

    for j:=0 to o.Count-1 do begin
      TslShape(o.Objects[j]).en:=false;
    end;

    for j:=0 to i.Count-1 do begin
      TslShape(i.Objects[j]).en:=TslShape(i.Objects[j]).non;
    end;
    main.Repaint;
  end;

  procedure TslCon.HackGetALL;
  begin
    i:=self.i;
    o:=self.o;
    c:=self.c;
    w:=self.w;
  end;

 procedure TslCon.HackPutALL;
 begin
   self.w.free;
   self.i.free;
   self.o.free;
   self.c.free;

   self.w:=w;
   self.i:=i;
   self.o:=o;
   self.c:=c;
 end;

procedure GenerateTemplate(n,k:integer);
var i,j:integer;
    ts:TslShape;
begin
  for i:=0 to n-1 do for j:=0 to k-1 do begin
    ts:=TslShape.Create(main,1);
    ts.left:=20+j*55;
    ts.top:=20+i*55;
  end;
end;

initialization
  scon:=TslCon.Create;
end.

