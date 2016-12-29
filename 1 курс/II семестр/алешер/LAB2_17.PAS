Program Lab2;
Uses Crt, Graph;
Type
    TRect = Object
            X1, Y1, X2, Y2 : Integer;
            Color: Word;
            Constructor Init(aX1, aY1, aX2, aY2: Integer; aColor: Word);
            Procedure Draw;
    end;

    TLine = Object(TRect)
            StartX, EndX, StartY, EndY, N: Integer;
            Constructor Init(aStartX, aEndX, aStartY, aEndY, aN: Integer);
            Procedure Draw;
    end;

    TKrugAndTr = Object(TLine)
            R:integer;
            Constructor Init(aX1,aY1,aR:Integer;aColor: Word);
            Procedure Draw; virtual;
    end;

Var
   PRect : ^TRect;
   PLine:^ TLine;
   PKrugAndTr: ^TKrugAndTr;
   Gd, Gm, i,n: Integer;
   P:pointer;
   Size:word;

   Constructor TRect.Init;
   begin
      X1:=aX1;
      Y1:=aY1;
      X2:=aX2;
      Y2:=aY2;
      Color:=aColor;
   end;

   Procedure TRect.Draw;
   begin
      SetColor(Color);
      Rectangle(X1,Y1,X2,Y2);
   end;

   Constructor TLine.Init;
   begin
      StartX:=aStartX;
      EndX:=aEndX;
      StartY:=aStartY;
      EndY:=aEndY;
      N:=aN;
   end;

   Procedure TLine.Draw;
   var i:integer;
   begin
      Randomize;
      MoveTo(random(EndX-StartX)+StartX,random(EndY-StartY)+StartY);
      For i := 1 to N do
      begin
         SetColor(random(14)+1);
         LineTo(random(EndX-StartX)+StartX,random(EndY-StartY)+StartY);
      end;
   end;

   Constructor TKrugAndTr.Init;
   begin
      X1:=aX1;
      Y1:=aY1;
      R:=aR;
      Color:=aColor;
   end;

   Procedure TKrugAndTr.Draw;
   begin
      SetColor(Color);
      Circle(X1,Y1,R);
      SetColor(random(14)+1);
      MoveTo(X1-R,Y1);
      LineTo(X1,Y1-R);
      LineTo(X1+R,Y1);
      LineTo(X1-R,Y1);
   end;

BEGIN
   ClrScr;
   Gd := Detect;
   InitGraph(Gd,Gm,'');
   If GraphResult <> grOK then
      begin
           WriteLn(GraphErrorMsg(GraphResult));
           Halt;
      end;
   New(PRect);
   PRect^.Init(100,100,400,400,4);
   PRect^.Draw;
   New(PLine);
   PLine^.Init(150,350,150,350,5);
   PLine^.Draw;
   New(PKrugAndTr);
   PKrugAndTr^.Init(250,250,50,10);
   PKrugAndTr^.Draw;
   Size:=ImageSize(90,90,410,410);
   GetMem(P,Size);
   GetImage(90,90,410,410,P^);
   n:=1;
   i:=0;
   repeat
      PutImage(90+i,90,P^,NormalPut);
      case (90+i) of
           200:  n:=-1;
           90:  n:=1;
      end;
      i:=i+n;
   until KeyPressed;
readkey;
END.