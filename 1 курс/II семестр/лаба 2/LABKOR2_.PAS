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
   Gd, Gm: Integer;
   F:text;
   Name: string;
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
      PieSlice(X,Y,TAngle1,Tangle1+dAngle,R);
      PieSlice(X,Y,TAngle2,Tangle2+dAngle,R);
      PieSlice(X,Y,TAngle3,Tangle3+dAngle,R);
      SetColor(0);
      SetFillStyle(EmptyFill,0);
      FillEllipse(X,Y,R div 3,R div 3);
      SetColor(Color);
      SetFillStyle(BkSlashFill,Color);
      FillEllipse(X,Y,R div 5,R div 5);
   end;



   Function Rval:integer;
   Var s: string;
       Code,i:integer;
   begin
     ReadLn(F,s);
     While  (s='') or (copy(s,1,2)='//') do ReadLn(F,s);
     Val(s,i,code);
     Rval := i;
   end;

   Procedure Move(X1,Y1,X2,Y2,X3,Y3,X4,Y4,Shag,wait,N: integer);
   Var X,Y,i,z: integer;
       s: string;
   begin
      SetColor(15);
      OutTextXY(0,0,'Нажмите любую клавишу для продолжения');
      Repeat until KeyPressed;
      Size := ImageSize(X1,Y1,X2,Y2);
      GetMem(P,Size);
      GetImage(X1,Y1,X2,Y2,P^);
      X:=X3;
      Y:=Y3;
      for i := 0 to N do
      begin
         z:=0;
         repeat
            If z mod Shag = 0 then
            begin
               Delay(wait);
               ClearDevice;
               PutImage(X,Y,P^,NormalPut);
            end;
            if (X<>X4) and (X3<X4) then X:=X+1;
            if (Y<>Y4) and (Y3<Y4) then Y:=Y+1;
            if (X<>X4) and (X3>X4) then X:=X-1;
            if (Y<>Y4) and (Y3>Y4) then Y:=Y-1;
            z := z+1;
         until (X=X4) and (Y=Y4);

         if (N>0) and (i<>N) then
            begin
              X3:=X4;
              Y3:=Y4;
              X4:=Rval;
              Y4:=Rval;
            end;
      end;
   end;

   Procedure DrawFromFile;
   Var s: string;
   begin
      While not EOF(F) do
      begin
      ReadLn(F,s);
      If Copy(s,1,2) <> '//' then
         begin
         ReadLn(F,s);
         If s = 'Circle' then
            begin
               New(PCircle);
               PCircle^.Init(Rval,Rval,Rval,Rval);
               PCircle^.Draw;
            end;

         If s = 'Rectangle' then
            begin
               New(PRinC);
               PRinC^.Init(Rval,Rval,Rval,Rval,Rval);
               PRinC^.Draw;
            end;

         If s = 'Triangle' then
            begin
               New(PTRinC);
               PTRinC^.Init(Rval,Rval,Rval,Rval,Rval,Rval,Rval);
               PTRinC^.Draw;
            end;

         If s = 'Knopka' then
            begin
               New(PKnopka);
               PKnopka^.Init(Rval,Rval,Rval,Rval,Rval,Rval,Rval,Rval);
               PKnopka^.Draw;
            end;

         If s = 'Move' then
            begin
               Move(Rval,Rval,Rval,Rval,Rval,Rval,Rval,Rval,Rval,Rval,Rval);
            end;
         end;
      end;
   end;

BEGIN
   ClrScr;
   WriteLn('Введите имя файла');
   ReadLn(Name);
   Assign(F, Name);
   Reset(F);
   Gd := Detect;
   InitGraph(Gd,Gm,'');
   If GraphResult <> grOK then
      begin
           WriteLn(GraphErrorMsg(GraphResult));
           Halt;
      end;
   DrawFromFile;
   repeat until KeyPressed;
END.