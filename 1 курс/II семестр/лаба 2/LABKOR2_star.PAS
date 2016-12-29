Program LabObj;
Uses Crt, Graph;
Type
    TCircle = Object
            X, Y, R: Integer;
            Color: Word;
            Constructor Init(aX, aY, aR: Integer; aColor: Word);
            Procedure Draw; virtual;
    end;
    TRectangle_in_Circle = Object(TCircle)
            RecAngle: Integer;
            Constructor Init(aX,aY,aR,aRecAngle: Integer; aColor: Word);
            Procedure Draw; virtual;
    end;
    TTriangle_in_Circle = Object(TCircle)
            TAngle1,TAngle2,TAngle3: Integer;
            Constructor Init(aX, aY, aR, aTAngle1, aTAngle2, aTAngle3: Integer; aColor: Word);
            Procedure Draw; virtual;
    end;
    TKnopka = Object(TTriangle_in_Circle)
            dAngle: Integer;
            Constructor Init(aX,aY,aR, aTAngle1, aTAngle2, aTangle3, adAngle: Integer; aColor: Word);
            Procedure Draw; virtual;
    end;
Var
   PCircle : ^TCircle;
   PRinC : ^TRectangle_in_Circle;
   PTRinC:^ TTriangle_in_Circle;
   PKnopka: ^TKnopka;
   Gd, Gm,rX,rY: Integer;
   P:pointer;
   Size:word;
   Function AngleToX(aX,aR,Angle: integer):integer;
   begin
      AngleToX := Trunc(aX+aR*cos(Angle*pi/180));
   end;
   Function AngleToY(aY,aR,Angle: integer):integer;
   begin
      AngleToY :=Trunc(aY-aR*sin(Angle*pi/180));
   end;
   Constructor TCircle.Init;
   begin
      X:=aX;
      Y:=aY;
      R:=aR;
      Color:=aColor;
   end;
   Procedure TCircle.Draw;
   begin
      SetColor(Color);
      Circle(X,Y,R);
   end;
   Constructor TRectangle_in_Circle.Init;
   begin
      X:=aX;
      Y:=aY;
      R:=aR;
      RecAngle:=aRecAngle;
      Color:=aColor;
   end;
   Procedure TRectangle_in_Circle.Draw;
   Var
      X1,Y1,X2,Y2:integer;
   begin
      SetColor(Color);
      X1:=AngleToX(X,R,RecAngle);
      Y1:=AngleToY(Y,R,RecAngle);
      X2:=AngleToX(X,R,RecAngle+180);
      Y2:=AngleToY(Y,R,RecAngle+180);
      Rectangle(X1,Y1,X2,Y2);
   end;
   Constructor TTriangle_in_Circle.Init;
   begin
      X:=aX;
      Y:=aY;
      R:=aR;
      TAngle1:=aTAngle1;
      TAngle2:=aTAngle2;
      TAngle3:=aTAngle3;
      Color:=aColor;
   end;
   Procedure TTriangle_in_Circle.Draw;
   begin
      SetColor(Color);
      MoveTo(AngleToX(X,R,TAngle1),AngleToY(Y,R,TAngle1));
      LineTo(AngleToX(X,R,TAngle2),AngleToY(Y,R,TAngle2));
      LineTo(AngleToX(X,R,TAngle3),AngleToY(Y,R,TAngle3));
      LineTo(AngleToX(X,R,TAngle1),AngleToY(Y,R,TAngle1));
   end;
   Constructor TKnopka.Init;
   begin
      X:=aX;
      Y:=aY;
      R:=aR;
      TAngle1:=aTAngle1;
      TAngle2:=aTAngle2;
      TAngle3:=aTAngle3;
      dAngle := adAngle;
      Color:=aColor;
   end;
   Procedure TKnopka.Draw;
   begin
      SetColor(Color);
      SetFillStyle(BkSlashFill,Color);
      Circle(X,Y,R);
      PieSlice(X,Y,TAngle1,Tangle1+dAngle,R);
      PieSlice(X,Y,TAngle2,Tangle2+dAngle,R);
      PieSlice(X,Y,TAngle3,Tangle3+dAngle,R);
      FillEllipse(X,Y,R div 5,R div 5);
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
   New(PCircle);
   PCircle^.Init(320,240,150,4);
   PCircle^.Draw;
   New(PRinC);
   PRinC^.Init(320,240,150,45,5);
   PRinC^.Draw;
   New(PTRinC);
   PTRinC^.Init(320,240,150,90,210,330,3);
   PTRinC^.Draw;
   New(PKnopka);
   PKnopka^.Init(320,240,30,10,130,250,50,6);
   PKnopka^.Draw;
   rX:=170;
   rY:=90;
   Size := ImageSize(rX,rY,rX+300,rY+300);
   GetMem(P,Size);
   GetImage(rX,rY,rX+300,rY+300,P^);
   ReadKey;
   Randomize;
   repeat
      Delay(50);
      ClearDevice;
      rX:=rX+random(9)-4;
      rY:=rY+random(9)-4;
      PutImage(rX,rY,P^,NormalPut);
   until KeyPressed;
END.