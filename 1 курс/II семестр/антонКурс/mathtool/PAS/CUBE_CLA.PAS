program CubicSplineClamped_Prog;

{------------------------------------------------------------------------}
{-                                                                      -}
{-     Turbo Pascal Numerical Methods Toolbox                           -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.            -}
{-                                                                      -}
{-       Purpose: This program demonstrates interpolation with          -}
{-                a clamped cubic spline.                               -}
{-                                                                      -}
{-       Unit   : Interp    procedure CubicSplineClamped                -}
{-                                                                      -}
{------------------------------------------------------------------------}

{$I-}           { Disable I/O error trapping }
{$R+}           { Enable range checking }

uses
  Interp, Dos, Crt, Common;

var
  XData, YData : TNvector;                  { Data points (X,Y) }
  NumPoints : integer;                      { Number of points }
  DerivLE, DerivRE : Float;                 { Derivative at the endpoints }
  Coef0, Coef1, Coef2, Coef3 : TNvector;    { Coefficients of the spline }
  NumInter : integer;                       { Number interpolating points }
  XInter, YInter : TNvector;                { Interpolating points }
  Error : byte;                             { Flags an error }

procedure Initialize(var Coef0     : TNvector;
                     var Coef1     : TNvector;
                     var Coef2     : TNvector;
                     var Coef3     : TNvector;
                     var XData     : TNvector;
                     var YData     : TNvector;
                     var DerivLE   : Float;
                     var DerivRE   : Float;
                     var NumPoints : integer;
                     var NumInter  : integer;
                     var XInter    : TNvector;
                     var YInter    : TNvector;
                     var Error     : byte);

{----------------------------------------------------------------}
{- Output: Coef0, Coef1, Coef2, Coef3, XData, YData, DerivLE,   -}
{-         DerivRe, NumPoints, NumInter, XInter, YInter, Error  -}
{-                                                              -}
{- This procedure initializes the above variables to zero.      -}
{----------------------------------------------------------------}

begin
  FillChar(Coef0, SizeOf(Coef0), 0);
  FillChar(Coef1, SizeOf(Coef1), 0);
  FillChar(Coef2, SizeOf(Coef2), 0);
  FillChar(Coef3, SizeOf(Coef3), 0);
  FillChar(XData, SizeOf(XData), 0);
  FillChar(YData, SizeOf(YData), 0);
  FillChar(XInter, SizeOf(XInter), 0);
  FillChar(YInter, SizeOf(YInter), 0);
  NumPoints := 0;
  NumInter := 0;
  DerivLE := 0;
  DerivRE := 0;
  Error := 0;
  Writeln;
end; { procedure Initialize }

procedure GetData(var NumPoints : integer;
                  var XData     : TNvector;
                  var YData     : TNvector;
                  var DerivLE   : Float;
                  var DerivRE   : Float;
                  var NumInter  : integer;
                  var XInter    : TNvector);

{----------------------------------------------------------------}
{- Output: NumPoints, XData, YData, DerivLE, DerivRE,           -}
{-         NumInter, XInter                                     -}
{-                                                              -}
{- This procedure reads in data from either the keyboard        -}
{- or a data file.  The number of data points (NumPoints),      -}
{- the data points (XData, YData), the second derivatives at    -}
{- the endpoints (DerivLE, DerivRE), the number of interpolated -}
{- points (NumInter) and the X values at which to interpolate   -}
{- (XInter) are all read in here.                               -}
{----------------------------------------------------------------}

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
  NumPoints := 0;
  while not EOF(InFile) do
  begin
    NumPoints := Succ(NumPoints);
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
  NumPoints := 0;
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
    Write('X[',Term,'], Y[',Term,']:');
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
  while not EOF(InFile) do
  begin
    NumInter := Succ(NumInter);
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
    Write('Number of points (0-',TNArraySize,')?');
    Readln(NumInter);
    IOCheck;
  until((NumInter >= 0) and (NumInter <= TNArraySize) and not IOerr);
  Writeln;
  for Term := 1 to NumInter do
  repeat
    Write('Point ',Term,':');
    Readln(XInter[Term]);
    IOCheck;
  until not IOerr;
end; { procedure GetOneVectorFromKeyboard }

begin { procedure GetData }
  case InputChannel('Input Data Points From') of
    'K' : begin
            GetTwoVectorsFromKeyboard(NumPoints, XData, YData);
            repeat
              Writeln;
              Write('Derivative of the function at the left endpoint: ');
              Readln(DerivLE);
              IOCheck;
            until not IOerr;
            repeat
              Writeln;
              Write('Derivative of the function at the right endpoint: ');
              Readln(DerivRE);
              IOCheck;
            until not IOerr;
          end;
    'F' : begin
            GetTwoVectorsFromFile(NumPoints, XData, YData);
            { The endpoint derivatives are the last data point }
            NumPoints := Pred(NumPoints);
            DerivLE := XData[NumPoints+1];
            DerivRE := YData[NumPoints+1];
          end;
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
                  DerivLE   : Float;
                  DerivRE   : Float;
              var Coef0     : TNvector;
              var Coef1     : TNvector;
              var Coef2     : TNvector;
              var Coef3     : TNvector;
                  NumInter  : integer;
              var XInter    : TNvector;
              var YInter    : TNvector;
                  Error     : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Data :           X                   Y');
  for Index := 1 to NumPoints do
    Writeln(OutFile, Index:3, ':    ', XData[Index]:15:10, '      ',
            YData[Index] : 15 : 10);
  Writeln(OutFile);
  Writeln(OutFile, 'Derivative at X=', XData[1], ' :  ', DerivLE);
  Writeln(OutFile, 'Derivative at X=', XData[NumPoints], ' :  ', DerivRE);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, 'Splines:',  ' ':7, 'Coef0', ' ':13,
                           'Coef1', ' ':14, 'Coef2', ' ':13, 'Coef3');
          for Index := 1 to NumPoints-1 do
            Writeln(OutFile, '  ', Index : 3, ':', '  ', Coef0[Index]:15:10,
                             ' ':3, Coef1[Index]:15:10, ' ':3,
                             Coef2[Index]:15:10, ' ':3, Coef3[Index]:15:10);
          Writeln(OutFile);
          Writeln(OutFile, 'Interpolated Points:    X                   Y');
          for Index := 1 to NumInter do
            Writeln(OutFile, Index:10, ':    ',
                             XInter[Index] : 15 : 10, '      ',
                             YInter[Index] : 15 : 10);
        end;

    1 : Writeln(OutFile, 'The X points must be unique.');

    2 : Writeln(OutFile,
                       'The X points must be in increasing sequential order.');

    3 : Writeln(OutFile, 'There must be at least two data points.');

  end; { case }
end; { procedure Results }

begin { program CubicSplineClamped }
  ClrScr;
  Initialize(Coef0, Coef1, Coef2, Coef3, XData, YData, DerivLE, DerivRE,
             NumPoints, NumInter, XInter, YInter, Error);
  GetData(NumPoints, XData, YData, DerivLE, DerivRE, NumInter, XInter);
  CubicSplineClamped(NumPoints, XData, YData, DerivLE, DerivRE, NumInter,
                     XInter, Coef0, Coef1, Coef2, Coef3, YInter, Error);
  Results(NumPoints, XData, YData, DerivLE, DerivRE,
          Coef0, Coef1, Coef2, Coef3, NumInter, XInter, YInter, Error);
  Close(OutFile);
end. { program CubicSplineClamped }
