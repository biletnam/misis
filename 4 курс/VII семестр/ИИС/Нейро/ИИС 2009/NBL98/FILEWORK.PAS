unit filework;

interface

procedure Save;
procedure Load;
procedure ClearW;
procedure GenReport;

implementation
uses dialogs,sysutils,nshape,mainunit,classes,shellapi,windows;
var knd,col,lef,top:TiAR;
    tar:TdAR;
    fn:string;
    f:file;
    buf:array[1..round(AR*(AR+1)*1/2)+1] of char;
      tsh:TslShape;
      sz,shs:integer;
      w,i,o,c:TStringList;
    st:string;
    caps:TStringList;

  procedure Save;
      var j:integer;
      function Find(obj:TObject):integer;
      var k:integer;
      begin
        Find:=0;
        for k:=0 to main.ControlCount-1 do begin
          if main.Controls[k]=obj then begin
            result:=k;
            exit;
          end;
        end;
      end;
  begin

    if main.SaveDialog1.Execute then fn:=main.SaveDialog1.Filename else exit;

    caps:=TStringList.Create;
    for j:=0 to main.ControlCount-1 do begin
       tsh:=TslShape(main.Controls[j]);
       knd[j+1]:=tsh.knd;
       col[j+1]:=tsh.Brush.Color;
       lef[j+1]:=tsh.left;
       top[j+1]:=tsh.top;
       tar[j+1]:=tsh.T;
       caps.Add(tsh.Caption);
    end;


    scon.HackGetAll(w,i,o,c);
    for j:=0 to w.Count-1 do begin
       i.Strings[j]:=IntToStr(Find(i.Objects[j]));
       o.Strings[j]:=IntToStr(Find(o.Objects[j]));
       c.Strings[j]:=IntToStr(Integer(c.Objects[j]));
    end;

    Assign(f,fn);
    try
    ReWrite(f,1);
    except
      ShowMessage('Ошибка создания файла.');
      exit;
    end;
    shs:=main.ControlCount;

    BlockWrite(f,shs,4);
    BlockWrite(f,knd,sizeof(knd));
    BlockWrite(f,col,sizeof(col));
    BlockWrite(f,lef,sizeof(lef));
    BlockWrite(f,top,sizeof(top));
    BlockWrite(f,tar,8*AR);

    sz:=Length(w.Text);
    BlockWrite(f,sz,4);
    for j:=1 to sz do
    buf[j]:=w.Text[j];
    //вместо системного разделителя в файл пишем точку
    for j:=1 to sz do if buf[j]=DecimalSeparator then buf[j]:='.';
    BlockWrite(f,buf,sz);

    sz:=Length(i.Text);
    BlockWrite(f,sz,4);
    for j:=1 to sz do
    buf[j]:=i.Text[j];
    BlockWrite(f,buf,sz);

    sz:=Length(o.Text);
    BlockWrite(f,sz,4);
    for j:=1 to sz do
    buf[j]:=o.Text[j];
    BlockWrite(f,buf,sz);

    sz:=Length(c.Text);
    BlockWrite(f,sz,4);
    for j:=1 to sz do
    buf[j]:=c.Text[j];
    BlockWrite(f,buf,sz);

    sz:=Length(caps.Text);
    BlockWrite(f,sz,4);
    for j:=1 to sz do
    buf[j]:=caps.Text[j];
    BlockWrite(f,buf,sz);

    caps.Free;

    close(f);
  end;

  procedure Load;
  var j:integer;

  begin
    if main.OpenDialog1.Execute then fn:=main.OpenDialog1.Filename else exit;
    Assign(f,fn);
    try
    ReSet(f,1);
    except
      ShowMessage('Ошибка открытия файла.');
      exit;
    end;

    w:=TStringList.Create;
    i:=TStringList.Create;
    o:=TStringList.Create;
    c:=TStringList.Create;
    caps:=TStringList.Create;

    BlockRead(f,shs,4);
    BlockRead(f,knd,sizeof(knd));
    BlockRead(f,col,sizeof(col));
    BlockRead(f,lef,sizeof(lef));
    BlockRead(f,top,sizeof(top));
    BlockRead(f,tar,8*AR);

    BlockRead(f,sz,4);
    BlockRead(f,buf,sz);
    st:='';
    for j:=1 to sz do st:=st+buf[j];
    //контроль разделителя, в файле он всегда = '.'
    for j:=1 to sz do if st[j]='.' then st[j]:=DecimalSeparator;
    w.text:=st;

    BlockRead(f,sz,4);
    BlockRead(f,buf,sz);
    st:='';
    for j:=1 to sz do st:=st+buf[j];
    i.text:=st;

    BlockRead(f,sz,4);
    BlockRead(f,buf,sz);
    st:='';
    for j:=1 to sz do st:=st+buf[j];
    o.text:=st;

    BlockRead(f,sz,4);
    BlockRead(f,buf,sz);
    st:='';
    for j:=1 to sz do st:=st+buf[j];
    c.text:=st;

    BlockRead(f,sz,4);
    BlockRead(f,buf,sz);
    st:='';
    for j:=1 to sz do st:=st+buf[j];
    caps.text:=st;

    close(f);

    for j:=0 to main.ControlCount-1 do
    main.Controls[0].Free;

    for j:=1 to shs do begin
      tsh:=TslShape.Create(main,knd[j]);
      tsh.Brush.Color:=col[j];
      tsh.left:=lef[j];
      tsh.top:=top[j];
      tsh.T:=tar[j];
      tsh.Caption:=caps.Strings[j-1];
    end;

    for j:=0 to i.Count-1 do begin
     i.Objects[j]:=main.Controls[StrToInt(i.Strings[j])];
     o.Objects[j]:=main.Controls[StrToInt(o.Strings[j])];
     c.Objects[j]:=TObject(StrToInt(c.Strings[j]));
    end;

    caps.Free;

    scon.hackputall(w,i,o,c);
    main.Repaint;
  end;

  procedure ClearW;
  var j:integer;
      w,i,o,c:TStringList;
  begin
    for j:=0 to main.ControlCount-1 do
    main.Controls[0].Free;
    w:=TStringList.Create;
    i:=TStringList.Create;
    o:=TStringList.Create;
    c:=TStringList.Create;
    scon.hackputall(w,i,o,c);
  end;

  procedure GenReport;
  var j,k:integer;
      fn:string;
      f:text;
      ts,tshf:TslShape;
      we:TdAR;
      fr:TiAR;
  begin
    if main.SaveDialog2.Execute then fn:=main.SaveDialog2.Filename else exit;
    try
    assign(f,fn);
    rewrite(f);
    except
      ShowMessage('Ошибка создания файла.');
      exit;
    end;

    writeln(f,'generated ',DateToStr(Date),' ',TimeToStr(Time),#13#10);
    for k:=0 to main.ControlCount-1 do begin

      ts:=TslShape(main.Controls[k]);
      if ts.knd=3 then begin
        writeln(f,'Neuron:''',ts.Caption,''' connected with:');
        sz:=scon.FillIn(ts,fr);

        for j:=1 to sz do begin
          scon.GetEl(fr[j],tshf,we[j]);
          writeln(f,'W('+tshf.Caption+')=',FloatToStr(we[j]));
        end;

        writeln(f);
      end;

    end;
    close(f);
    try
      ShellExecute(0,'open','notepad',pchar(fn),nil,SW_SHOWDEFAULT);
    except                                       
    end;


  end;

end.

