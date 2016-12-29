program First_Derivative_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates 2, 3 and 5 point            -}
{-                    differentiation.                                      -}
{-                                                                          -}
{-           Unit   : Differ    procedure First_Derivative                  -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping }
{$R+}      { Enable range checking }

uses
  Differ, Dos, Crt, Common;

var
  XData, YData : TNvector;          { Data points (X,Y) }
  NumPoints : integer;              { Number of data points }
  NumDeriv : integer;               { Number of points at which }
                                    { to find derivative }
  XDeriv : TNvector;                { Values at which to differentiate }
  YDeriv : TNvector;                { 1st derivative at XDeriv points }
  Point : integer;                  { 2, 3, or 5 point differentiation }
  Error : byte;                     { Flags if something went wrong }

procedure Initialize(var XData        : TNvector;
                     var YData        : TNvector;
                     var XDeriv       : TNvector;
                     var YDeriv       : TNvector;
                     var Point        : integer;
                     var Error        : byte);

{-----------------------------------------------------------}
{- Output: XData, YData, XDeriv, YDeriv, Point, Error      -}
{-                                                         -}
{- This procedure initializes the above variables to zero. -}
{-----------------------------------------------------------}

begin
  Writeln;
  Point := 0;
  Error := 0;
  FillChar(XData, SizeOf(XData), 0);
  FillChar(YData, SizeOf(YData), 0);
  FillChar(XDeriv, SizeOf(XDeriv), 0);
  FillChar(YDeriv, SizeOf(YDeriv), 0);
end; { procedure Initialize }

procedure GetData(var NumPoints : integer;
                  var NumDeriv  : integer;
                  var XData     : TNvector;
                  var YData     : TNvector;
                  var XDeriv    : TNvector;
                  var Point     : integer);

{------------------------------------------------------------}
{- Output: NumPoints, NumDeriv, XData, YData, XDeriv, Point -}
{-                                                          -}
{- This procedure assigns values to the above variables     -}
{- from either keyboard or data file input                  -}
{------------------------------------------------------------}

procedure GetDataPoints(var NumPoints : integer;
                        var XData     : TNvector;
                        var YData     : TNvector);

{------------------------------------------------------------}
{- Output: NumPoints, XData, YData                          -}
{-                                                          -}
{- This procedure assigns values to the data points         -}
{- from either keyboard or data file input                  -}
{------------------------------------------------------------}

procedure GetTwoVectorsFromFile(var NumPoints : integer;
                                var XData     : TNvector;
                                var YData     : TNvector);

{------------------------------------------------------------}
{- Output: NumPoints, XData, YData                          -}
{-                                                          -}
{- This procedure assigns values to the data points         -}
{- from data file input                                     -}
{------------------------------------------------------------}

var
  FileName : string[255];
  InFile : text;
begin
  Writeln;
  repeat
    Write('File name? ');
    Readln(FileName);
    Assign(InFile, FileName);
    Reset(InFile);
    IOCheck;
  until not IOerr;
  NumPoints := 0;
  while not(EOF(InFile)) do
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

{------------------------------------------------------------}
{- Output: NumPoints, XData, YData                          -}
{-                                                          -}
{- This procedure assigns values to the data points         -}
{- from keyboard input                                      -}
{------------------------------------------------------------}

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
  Write('Input the X and Y values,');
  Writeln(' separated by a space (not a comma):');
  for Term := 1 to NumPoints do
  repeat
    Write('X[', Term, '], Y[', Term, ']: ');
    Read(XData[Term], YData[Term]);
    Writeln;
    IOCheck;
  until not IOerr;
end; { procedure GetTwoVectorsFromKeyboard }

begin
  case InputChannel('Input Data Points From') of
    'K' : GetTwoVectorsFromKeyboard(NumPoints, XData, YData);
    'F' : GetTwoVectorsFromFile(NumPoints, XData, YData);
  end;
end; { procedure GetDataPoints }

procedure GetDerivPoints(var NumDeriv : integer;
                         var XDeriv   : TNvector);

{------------------------------------------------------------}
{- Output: NumDeriv, XDeriv                                 -}
{-                                                          -}
{- This procedure assigns values to the derivative points   -}
{- from either keyboard or data file input                  -}
{------------------------------------------------------------}

procedure GetOneVectorFromFile(var NumDeriv : integer;
                               var XDeriv   : TNvector);

{------------------------------------------------------------}
{- Output: NumDeriv, XDeriv                                 -}
{-                                                          -}
{- This procedure assigns values to the derivative points   -}
{- from data file input                                     -}
{------------------------------------------------------------}

var
  FileName : string[255];
  InFile : text;
begin
  Writeln;
  repeat
    Write('File name? ');
    Readln(FileName);
    Assign(InFile, FileName);
    Reset(InFile);
    IOCheck;
  until not IOerr;
  NumDeriv := 0;
  while not(EOF(InFile)) do
  begin
    NumDeriv := Succ(NumDeriv);
    Readln(InFile, XDeriv[NumDeriv]);
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetOneVectorFromFile }

procedure GetOneVectorFromKeyboard(var NumDeriv : integer;
                                   var XDeriv   : TNvector);

{------------------------------------------------------------}
{- Output: NumDeriv, XDeriv                                 -}
{-                                                          -}
{- This procedure assigns values to the derivative points   -}
{- from keyboard input                                      -}
{------------------------------------------------------------}

var
  Term : integer;

begin
  NumDeriv := 0;
  Writeln;
  repeat
    Write('Number of X values (0-', TNArraySize, ')? ');
    Readln(NumDeriv);
    IOCheck;
  until((NumDeriv >= 0) and (NumDeriv <= TNArraySize) and not IOerr);
  Writeln;
  for Term := 1 to NumDeriv do
  repeat
    Write('Point ', Term, ': ');
    Readln(XDeriv[Term]);
    IOCheck;
  until not IOerr;
end; { procedure GetOneVectorFromKeyboard }

var
  Ch : char;

begin
  case InputChannel('Input Derivative Points From') of
    'K' : GetOneVectorFromKeyboard(NumDeriv, XDeriv);
    'F' : GetOneVectorFromFile(NumDeriv, XDeriv);
  end;
end; { procedure GetDerivPoints }

procedure GetPoint(var Point : integer);

{---------------------------------------------------------}
{- Output: Point                                         -}
{-                                                       -}
{- This procedure sets the value of Point which          -}
{- determines which differentiation formula will be used -}
{---------------------------------------------------------}

begin
  Writeln;
  repeat
    Point := 5;
    Write('2, 3 or 5 point differentiation ? ');
    ReadInt(Point);
    IOCheck;
    if not(Point in [2, 3, 5]) then
    begin
      IOerr := true;
      Point := 5;
    end;
  until not IOerr;
end; { procedure GetPoint }

begin { procedure GetData }
  GetDataPoints(NumPoints, XData, YData);
  GetDerivPoints(NumDeriv, XDeriv);
  GetPoint(Point);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumPoints : integer;
              var XData     : TNvector;
              var YData     : TNvector;
                  NumDeriv  : integer;
              var XDeriv    : TNvector;
              var YDeriv    : TNvector;
                  Point     : integer);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Input Data:');
  Writeln(OutFile, '     X                        Y');
  for Index := 1 to NumPoints do
    Writeln(OutFile, XData[Index] : 12 : 7, ' ' : 10, YData[Index]);
  Writeln(OutFile);
  if Error = 1 then
    DisplayWarning;
  if Error >= 2 then
    DisplayError;
  case Error of
    0, 1 : begin
             Writeln(OutFile, 'Using ', Point, ' point differentiation:');
             Writeln(OutFile);
             Writeln(OutFile, '     X                 Derivative at X');
             for Index := 1 to NumDeriv do
             begin
               Write(OutFile, XDeriv[Index] : 8 : 3, ' ' : 10);
               if ABS(YDeriv[Index]) >= 9.999999E35 then
                 Writeln(OutFile, 'No derivative calculated')
               else
                 Writeln(OutFile, YDeriv[Index]);
             end;
           end;

    2 : Writeln(OutFile, 'The X data points must be unique.');

    3 : Writeln(OutFile, 'The data must be in increasing sequential order.');

    4 : Writeln(OutFile, 'There are too few data points to do ',
                          Point, ' point differentiation.');

    5 : Writeln(OutFile, 'There is no ', Point, ' point differentiation.');

    6 : Writeln(OutFile,
                'The data must be evenly spaced for 5 point differentiation.');

  end; { case }
end; { procedure Results }

begin  { program First_Derivative }
  ClrScr;
  Initialize(XData, YData, XDeriv, YDeriv, Point, Error);
  GetData(NumPoints, NumDeriv, XData, YData, XDeriv, Point);
  First_Derivative(NumPoints, XData, YData, Point, NumDeriv, XDeriv,
                   YDeriv, Error);
  Results(NumPoints, XData, YData, NumDeriv, XDeriv, YDeriv, Point);
  Close(OutFile);
end. { program First_Derivative }
