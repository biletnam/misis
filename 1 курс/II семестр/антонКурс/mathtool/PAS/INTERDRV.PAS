program Interpolate_Derivative_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates first and second            -}
{-                    differentiation with a cubic spline interpolant.      -}
{-                                                                          -}
{-           Unit   : Differ    procedure Interpolate_Derivative            -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}                  { Disable I/O error trapping }
{$R+}                  { Enable range checking }

uses
  Differ, Dos, Crt, Common;

var
  XData, YData : TNvector;          { Data points (X,Y) }
  NumPoints : integer;              { Number of data points }
  NumDeriv : integer;               { Number of points at which }
                                    { to find derivative   }
  XDeriv : TNvector;                { Values at which to differentiate }
  YInter : TNvector;                { Interpolated value at XDeriv }
  YDeriv : TNvector;                { 1st derivative at XDeriv points }
  YDeriv2 : TNvector;               { 2nd derivative at XDeriv points }
  Error : byte;                     { Flags if something went wrong }

procedure Initialize(var XData  : TNvector;
                     var YData  : TNvector;
                     var XDeriv : TNvector;
                     var YDeriv : TNvector;
                     var Error  : byte);

{-----------------------------------------------------------}
{- Output: XData, YData, XDeriv, YDeriv, Error             -}
{-                                                         -}
{- This procedure initializes the above variables to zero. -}
{-----------------------------------------------------------}

begin
  Writeln;
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
                  var XDeriv    : TNvector);

{------------------------------------------------------------}
{- Output: NumPoints, NumDeriv, XData, YData, XDeriv        -}
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
  Write('Input the X and Y values, ');
  Writeln('separated by a space (not a comma):');
  for Term := 1 to NumPoints do
  repeat
    Write('X[', Term, '], Y[', Term, ']:');
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
  Writeln;
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
    Write('Number of derivative points (0-', TNArraySize, ')? ');
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

begin { procedure GetDerivPoints }
  case InputChannel('Input Derivative Points From') of
    'K' : GetOneVectorFromKeyboard(NumDeriv, XDeriv);
    'F' : GetOneVectorFromFile(NumDeriv, XDeriv);
  end;
  Writeln;
end; { procedure GetDerivPoints }

begin { procedure GetData }
  GetDataPoints(NumPoints, XData, YData);
  GetDerivPoints(NumDeriv, XDeriv);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumPoints : integer;
              var XData     : TNvector;
              var YData     : TNvector;
                  NumDeriv  : integer;
              var XDeriv    : TNvector;
              var YInter    : TNvector;
              var YDeriv    : TNvector;
              var YDeriv2   : TNvector;
                  Error     : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Input Data:');
  Writeln(OutFile,'     X                   Y');
  for Index := 1 to NumPoints do
    Writeln(OutFile, XData[Index] : 8 : 3, ' ' : 10, YData[Index] : 12 : 7);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

   case Error of
     0 : begin
           Writeln(OutFile, 'Using free cubic spline interpolation: ');
           Writeln(OutFile);
           Writeln(OutFile, '   X', ' ' : 10, 'Value at X', ' ' : 13,
                            '1st Deriv at X', ' ' : 13, '2nd Deriv at X');
           for Index := 1 to NumDeriv do
             Writeln(OutFile, XDeriv[Index] : 6 : 3, ' ' : 3,
                              YInter[Index], ' ' : 3,
                              YDeriv[Index], ' ' : 3,
                              YDeriv2[Index] : 14 : 8);
         end;

     1 : Writeln(OutFile, 'The X data points must be unique.');

     2 : Writeln(OutFile, 'The data must be in increasing sequential order.');

   end; { case }
end; { procedure Results }

begin { program Interpolate_Derivative }
  ClrScr;
  Initialize(XData, YData, XDeriv, YDeriv, Error);
  GetData(NumPoints, NumDeriv, XData, YData, XDeriv);
  Interpolate_Derivative(NumPoints, XData, YData, NumDeriv, XDeriv, YInter,
                         YDeriv, YDeriv2, Error);
  Results(NumPoints, XData, YData, NumDeriv, XDeriv, YInter,
          YDeriv, YDeriv2, Error);
  Close(OutFile);
end. { program Interpolate_Derivative }
