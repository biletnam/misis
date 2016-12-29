program Lagrange_Prog;

{-------------------------------------------------------------------------}
{-                                                                       -}
{-     Turbo Pascal Numerical Methods Toolbox                            -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.             -}
{-                                                                       -}
{-         Purpose: This program demonstrates Lagrangian interpolation.  -}
{-                                                                       -}
{-         Unit   : Interp    procedure Lagrange                         -}
{-                                                                       -}
{-------------------------------------------------------------------------}

{$I-}        { Disable I/O error trapping }
{$R+}        { Enable range checking }

uses
  Interp, Dos, Crt, Common;

var
  NumPoints : integer;              { Number of data points }
  XData, YData : TNvector;          { Data points (X,Y) }
  Poly : TNvector;                  { The constructed polynomial }
  NumInter : integer;               { Number of interpolated points }
  XInter : TNvector;                { Values at which to evaluate Poly }
  YInter : TNvector;                { Interpolated values at XInter }
  Error : byte;                     { Flags if something went wrong }

procedure Initialize(var XData  : TNvector;
                     var YData  : TNvector;
                     var XInter : TNvector;
                     var YInter : TNvector;
                     var Poly   : TNvector);

{----------------------------------------------------------}
{- Output: XData, YData, XInter, YInter, Poly             -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}

begin
  FillChar(XData, SizeOf(XData), 0);
  FillChar(YData, SizeOf(XData), 0);
  FillChar(XInter, SizeOf(XData), 0);
  FillChar(YInter, SizeOf(XData), 0);
  FillChar(Poly, SizeOf(XData), 0);
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
  NumPoints := 0;
  while not EOF(InFile)  do
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
  Write('Enter the X ');
  Writeln('and Y values, separated by a space (not a comma):');
  for Term := 1 to NumPoints do
  repeat
    Write('X[', Term, '], Y[', Term, ']:');
    Read(XData[Term], YData[Term]);
    Writeln;
    { Read in the XData and YData }
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
    Write('Number of points (0-', TNArraySize, ')?');
    Readln(NumInter);
    IOCheck;
  until((NumInter >= 0) and (NumInter <= TNArraySize) and not IOerr);
  Writeln;
  for Term := 1 to NumInter do
  repeat
    Write('Point ', Term, ':');
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

procedure Results(var XData : TNvector;
                  var YData : TNvector;
                  var Poly  : TNvector;
                  NumInter  : integer;
              var XInter    : TNvector;
              var YInter    : TNvector;
                  Error     : byte);

{-------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile. -}
{-------------------------------------------------------------}

var
  Term : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'The Data : ');
  for Term := 1 to NumPoints do
    Writeln(OutFile, XData[Term] : 12 : 7, '             ', YData[Term]);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

  case Error of
    0 : begin
          Writeln(OutFile, 'The polynomial : ');
          for Term := NumPoints - 1 downto 0 do
            Writeln(OutFile, 'Poly[', Term : 2, ']=', Poly[Term]);
          Writeln(OutFile);
          Writeln(OutFile, '    X                  Interpolated Y value');
          for Term := 1 to NumInter do
            Writeln(OutFile, XInter[Term] : 8 : 3, '             ',
                             YInter[Term]);
          Writeln(OutFile);
        end;
    1 : Writeln(OutFile, 'The data points must be unique.');

    2 : Writeln(OutFile, 'There must be at least one data point.');

  end;
end; { procedure Results }

begin { program Lagrange }
  ClrScr;
  Initialize(XData, YData, XInter, YInter, Poly);
  GetData(NumPoints, NumInter, XData, YData, XInter);
  Lagrange(NumPoints, XData, YData, NumInter, XInter, YInter, Poly, Error);
  Results(XData, YData, Poly, NumInter, XInter, YInter, Error);
  Close(OutFile);
end. { program Lagrange }
