program SecondDerivative_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates the differentiation         -}
{-                    routine SecondDerivative. This procedure performs     -}
{-                    second differentiation of a function.                 -}
{-                                                                          -}
{-           Unit   : Differ    procedure SecondDerivative                  -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping }
{$R+}      { Enable range checking }

uses
  Differ, Dos, Crt, Common;

var
  NumDeriv : integer;     { Number of points at which to find derivative }
  XDeriv : TNvector;      { Values at which to differentiate }
  YDeriv : TNvector;      { 1st derivative at XDeriv points }
  Tolerance : Float;      { Tolerance in answer }
  Error : byte;           { Flags if something went wrong }

{$F+}
{ ----- Here is the function to differentiate -------------------- }

function TNTargetF(X : Float) : Float;
begin
  TNTargetF := Sqr(X) * Cos(x);
end; { function TNTargetF }

{ ---------------------------------------------------------------- }
{$F-}

procedure Initialize(var XDeriv : TNvector;
                     var YDeriv : TNvector;
                     var Error  : byte);

{-----------------------------------------------------------}
{- Output: XDeriv, YDeriv, Error                           -}
{-                                                         -}
{- This procedure initializes the above variables to zero. -}
{-----------------------------------------------------------}

begin
  Error := 0;
  FillChar(XDeriv, SizeOf(XDeriv), 0);
  FillChar(YDeriv, SizeOf(YDeriv), 0);
end; { procedure Initialize }

procedure GetData(var NumDeriv  : integer;
                  var XDeriv    : TNvector;
                  var Tolerance : Float);

{------------------------------------------------------------}
{- Output: NumDeriv, XDeriv, Tolerance                      -}
{-                                                          -}
{- This procedure assigns values to the above variables     -}
{- from either keyboard or data file input                  -}
{------------------------------------------------------------}

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
    Write('Number of points (0-', TNArraySize, ')? ');
    Readln(NumDeriv);
    IOCheck;
  until (NumDeriv >= 0) and (NumDeriv <= TNArraySize) and not IOerr;
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

procedure GetTolerance(var Tolerance : Float);

{---------------------------------------------------------}
{- Output: Tolerance                                     -}
{-                                                       -}
{- This procedure sets the value of the Tolerance.       -}
{---------------------------------------------------------}

begin
  repeat
    Tolerance := 1E-2;
    Write('Tolerance (> 0)? ');
    ReadFloat(Tolerance);
    IOCheck;
    if Tolerance <= 0 then
    begin
      IOerr := true;
      Tolerance := 1E-2;
    end;
  until not IOerr;
end; { procedure GetTolerance }

begin { procedure GetData }
  GetDerivPoints(NumDeriv, XDeriv);
  GetTolerance(Tolerance);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumDeriv  : integer;
              var XDeriv    : TNvector;
              var YDeriv    : TNvector;
                  Tolerance : Float;
                  Error     : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  if Error = 1 then
    DisplayError;

  case Error of
    0 : begin
          Writeln(OutFile);
          Writeln(OutFile, 'Tolerance = ', Tolerance);
          Writeln(OutFile);
          Writeln(OutFile, '     X           Second Derivative at X');
          for Index := 1 to NumDeriv do
            Writeln(OutFile, XDeriv[Index] : 8 : 3, ' ' : 10, YDeriv[Index]);
        end;

    1 : Writeln(OutFile, 'The tolerance must be greater than zero.');
  end;
end; { procedure Results }

begin { program SecondDerivative }
  ClrScr;
  Initialize(XDeriv, YDeriv, Error);
  GetData(NumDeriv, XDeriv, Tolerance);
  SecondDerivative(NumDeriv, XDeriv, YDeriv, Tolerance, Error, @TNTargetF);
  Results(NumDeriv, XDeriv, YDeriv, Tolerance, Error);
  Close(OutFile);
end. { program SecondDerivative }