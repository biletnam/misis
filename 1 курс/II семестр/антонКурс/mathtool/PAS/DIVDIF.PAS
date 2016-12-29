program Divided_Difference_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates interpolation with Newton's -}
{-                    general interpolatory divided difference equation.    -}
{-                                                                          -}
{-           Unit   : Interp    procedure Divided_Difference                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}                  { Disable I/O error trapping }
{$R+}                  { Enable range checking }
{$M 32000,0,655360}    { Memory allocation sizes }

uses
  Interp, Dos, Crt, Common;

var
  XData, YData : TNvector;          { Data points (X,Y) }
  NumPoints : integer;              { Number of points }
  NumInter : integer;               { Number of interpolated points }
  XInter : TNvector;                { Values at which to interpolate }
  YInter : TNvector;                { Interpolated values at XInterpolate }
  Error : byte;                     { Flags if something went wrong }

procedure Initialize(var XData  : TNvector;
                     var YData  : TNvector;
                     var XInter : TNvector;
                     var YInter : TNvector;
                     var Error  : byte);

{----------------------------------------------------------}
{- Output: XData, YData, XInter, YInter, Error            -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}

begin
  FillChar(XData, SizeOf(XData), 0);
  FillChar(YData, SizeOf(XData), 0);
  FillChar(XInter, SizeOf(XData), 0);
  FillChar(YInter, SizeOf(XData), 0);
  Error := 0;
end; { procedure Initialize }

procedure GetData(var NumPoints : integer;
                  var NumInter  : integer;
                  var XData     : TNvector;
                  var YData     : TNvector;
                  var XInter    : TNvector);

{--------------------------------------------------------------}
{- Output: NumPoints, NumInter, XData, YData, XInter          -}
{-                                                            -}
{- This procedure reads in data from either the keyboard      -}
{- or a data file.  The number of data points (NumPoints),    -}
{- the data points (XData, YData), the number of interpolated -}
{- points (NumInter) and the X values at which to interpolate -}
{- (XInter) are all read in here.                             -}
{--------------------------------------------------------------}

var
  Ch : char;

procedure GetTwoVectorsFromFile(var NumPoints : integer;
                                var XData     : TNvector;
                                var YData     : TNvector);

{-------------------------------------------------------------}
{- Output: NumPoints, XData, YData                           -}
{-                                                           -}
{- This procedure reads in the data points from a data file. -}
{-------------------------------------------------------------}

var
  Filename : string[255];
  InFile : text;

begin
  Writeln;
  repeat
    Write('File name? ');
    Readln(Filename);
    Assign(InFile, Filename);
    Reset(InFile);
    IOCheck;
  until not IOerr;
  NumPoints:=0;
  while not(EOF(InFile)) do
  begin
    NumPoints:=Succ(NumPoints);
    Readln(InFile, XData[NumPoints], YData[NumPoints]);
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetTwoVectorsFromFile }

procedure GetTwoVectorsFromKeyboard(var NumPoints : integer;
                                    var XData     : TNvector;
                                    var YData     : TNvector);

{--------------------------------------------------------------}
{- Output: NumPoints, XData, YData                            -}
{-                                                            -}
{- This procedure reads in the data points from the keyboard. -}
{--------------------------------------------------------------}

var
  Term : integer;

begin
  NumPoints:=0;
  Writeln;
  repeat
    Write('Number of points (0-', TNArraySize, ')? ');
    Readln(NumPoints);
    IOCheck;
  until ((NumPoints >= 0) and (NumPoints <= TNArraySize) and not IOerr);
  Writeln;
  Write('Type in the X ');
  Writeln('and Y values, separated by a space (not a comma):');
  for Term := 1 to NumPoints do
    repeat
      Write('X[', Term, '], Y[', Term, ']:');
      Read(XData[Term], YData[Term]);
      Writeln;
      IOCheck;
    until not IOerr;
end; { procedure GetTwoVectorsFromKeyboard }

procedure GetOneVectorFromFile(var NumInter : integer;
                               var XInter   : TNvector);

{------------------------------------------}
{- Output: NumInter, XInter               -}
{-                                        -}
{- This procedure reads in the points at  -}
{- which to interpolate from a data file. -}
{------------------------------------------}

var
  Filename : string[255];
  InFile : text;

begin
  Writeln;
  repeat
    Write('File name? ');
    Readln(Filename);
    Assign(InFile, Filename);
    Reset(InFile);
    IOCheck;
  until not IOerr;
  NumInter := 0;
  while not(EOF(InFile)) do
  begin
    NumInter:=Succ(NumInter);
    Readln(InFile, XInter[NumInter]);
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetOneVectorFromFile }

procedure GetOneVectorFromKeyboard(var NumInter : integer;
                                   var XInter   : TNvector);

{-------------------------------------------}
{- Output: NumInter, XInter                -}
{-                                         -}
{- This procedure reads in the points at   -}
{- which to interpolate from the keyboard. -}
{-------------------------------------------}

var
  Term : integer;

begin
  NumInter := 0;
  Writeln;
  repeat
    Write('Number of points (0-', TNArraySize, ')?');
    Readln(NumInter);
    IOCheck;
  until((NumInter >= 0) and (NumInter <= TNArraySize) and not IOerr);
  Writeln;
  for Term:=1 to NumInter do
  repeat
    Write('Point ', Term, ': ');
    Readln(XInter[Term]);
    IOCheck;
  until not IOerr;
end; { procedure GetOneVectorFromKeyboard }

begin { procedure GetData }
  case InputChannel('Input Data Points From') of
    'K' : GetTwoVectorsFromKeyboard(NumPoints, XData, YData);
    'F' : GetTwoVectorsFromFile(NumPoints, XData, YData);
  end;
  Writeln;
  case InputChannel('Input Interpolated Points From') of
    'K' : GetOneVectorFromKeyboard(NumInter, XInter);
    'F' : GetOneVectorFromFile(NumInter, XInter);
  end;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumPoints : integer;
              var XData     : TNvector;
              var YData     : TNvector;
                  NumInter  : integer;
              var XInter    : TNvector;
              var YInter    : TNvector);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, '     X                   Y');
  for Index := 1 to NumPoints do
    Writeln(OutFile, XData[Index] : 8 : 3, ' ' : 10, YData[Index] : 12 : 7);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, '     X              Interpolated Y value');
          for Index := 1 to NumInter do
            Writeln(OutFile, XInter[Index] : 8 : 3, ' ' : 10, YInter[Index]);
        end;

    1 : Writeln(OutFile, 'The X data points must be unique.');

    2 : Writeln(OutFile, 'There must be at least one data point.');

  end; { case }
end; { procedure Results }

begin { program Divided_difference }
  ClrScr;
  Initialize(XData, YData, XInter, YInter, Error);
  GetData(NumPoints, NumInter, XData, YData, XInter);
  Divided_Difference(NumPoints, XData, YData,
                     NumInter, XInter, YInter, Error);
  Results(NumPoints, XData, YData, NumInter, XInter, YInter);
  Close(OutFile);
end. { program Divided_difference }
