program Muller_Prog;

{---------------------------------------------------------------------------}
{-                                                                         -}
{-     Turbo Pascal Numerical Methods Toolbox                              -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.               -}
{-                                                                         -}
{-        Purpose: This program demonstrates Muller's method.              -}
{-                                                                         -}
{-        Unit   : RootsEqu    procedure Muller                            -}
{-                                                                         -}
{---------------------------------------------------------------------------}

{$I-}          { Disable I/O error trapping }
{$R+}          { enable range checking }

uses
  RootsEqu, Dos, Crt, Common;

type
  TNCompVector = array[0..TNArraySize] of TNcomplex;

var
  Guess : TNcomplex;               { Initial approximations }
  Tol : Float;                     { Tolerance in answer }
  Iter : integer;                  { Number of iterations }
  MaxIter : integer;               { Max number of iterations allowed }
  Answer, yAnswer : TNcomplex;     { Root and function evaluated at root }
  Error : byte;                    { Flags an error }

{$F+}
{-------------- HERE IS THE FUNCTION ------------------}

procedure TNTargetF(X : TNcomplex; var Y : TNcomplex);

{----------------------------------------------------------}
{-                                                        -}
{-  Here are some standard complex functions:             -}
{-                                                        -}
{-    Cos(X) = Cos(X.Re)-(Exp(-X.Im) + Exp(X.Im))/2 +     -}
{-             (Sin(X.Re)-(Exp(-X.Im) - Exp(X.Im))/2)i    -}
{-                                                        -}
{-    Sin(X) = Sin(X.Re)-(Exp(-X.Im) + Exp(X.Im))/2 -     -}
{-             (Cos(X.Re)-(Exp(-X.Im) - Exp(X.Im))/2)i    -}
{-                                                        -}
{-    Exp(X) = Exp(X.Re)-Cos(X.Im) + Exp(X.Re)-Sin(X.Im)i -}
{-                                                        -}
{-    Sqr(X) = Sqr(X.Re) + Sqr(X.Im) + i(2 - X.Re - X.Im) -}
{-                                                        -}
{----------------------------------------------------------}
begin
  Y.Re := Cos(X.Re) * (Exp(-X.Im) + Exp(X.Im)) / 2 - X.Re;
  Y.Im := Sin(X.Re) * (Exp(-X.Im) - Exp(X.Im)) / 2 - X.Im;
  { This is the complex function Y := Cos(X) - X }
end; { procedure TNTargetF }
{$F-}

procedure UserInput(var Guess   : TNcomplex;
                    var Tol     : Float;
                    var MaxIter : integer);

{----------------------------------------------------------}
{- Output: Guess, Tol, MaxIter                            -}
{-                                                        -}
{- This procedure assigns values to the above variables   -}
{- from keyboard input.  The initial approximation of the -}
{- guess (Guess), tolerance (Tol), and maximum number of  -}
{- iterations (MaxIter) are all input here.               -}
{----------------------------------------------------------}

procedure GetInitialGuess(var Guess : TNcomplex);
begin
  Writeln;
  Writeln('Initial approximation to the root:  ');
  repeat
    Write('Re(Approximation) = ');
    Readln(Guess.Re);
    IOCheck;
  until not IOerr;
  repeat
    Write('Im(Approximation) = ');
    Readln(Guess.Im);
    IOCheck;
  until not IOerr;
end; { procedure GetInitialGuess }

procedure GetTolerance(var Tol : Float);
begin
  Tol := 1E-8;
  Writeln;
  repeat
    Write('Tolerance (> 0): ');
    ReadFloat(Tol);
    IOCheck;
    if Tol <= 0 then
    begin
      IOerr := true;
      Tol := 1E-8;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIter(var MaxIter : integer);
begin
  MaxIter := 100;
  Writeln;
  repeat
    Write('Maximum number of iterations (> 0): ');
    ReadInt(MaxIter);
    IOCheck;
    if MaxIter < 0 then
    begin
      IOerr := true;
      MaxIter := 100;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure UserInput }
  GetInitialGuess(Guess);
  GetTolerance(Tol);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure UserInput }

procedure Results(Guess   : TNcomplex;
                  Answer  : TNcomplex;
                  yAnswer : TNcomplex;
                  Tol     : Float;
                  MaxIter : integer;
                  Iter    : integer;
                  Error   : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Write(OutFile, 'Initial approximation: ' : 30);
  Writeln(OutFile, Guess.Re, ' +', Guess.Im, 'i');
  Writeln(OutFile, 'Tolerance: ' : 30, Tol);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error in [1, 2] then
    DisplayWarning;
  if Error >= 3 then
    DisplayError;

  case Error of
    1 : Writeln(OutFile, 'This will take more than ', MaxIter, ' iterations.');

    2 : begin
          Writeln(OutFile, 'A parabola which intersects the x-axis can not');
          Writeln(OutFile, 'be constructed through these three points.');
        end;

    3 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    4 : Writeln(OutFile,
                'The maximum number of iterations must be greater than zero.');
  end; { case }

  if Error <= 2 then
  begin
    Writeln(OutFile);
    Writeln(OutFile, 'Number of iterations: ' : 26, Iter : 3);
    Write(OutFile, 'Calculated root: ' : 26);
    Writeln(OutFile, Answer.Re, ' + ', Answer.Im, 'i');
    Writeln(OutFile, 'Value of the function  ' : 26);
    Write(OutFile, 'at the calculated root: ' : 26);
    Writeln(OutFile, yAnswer.Re, ' + ', yAnswer.Im, 'i');
    Writeln(OutFile);
  end;
end; { procedure Results }

begin { program Muller }
  ClrScr;
  UserInput(Guess, Tol, MaxIter);
  { Use Muller's method with deflation to find a root }
  Muller(Guess, Tol, MaxIter, Answer, yAnswer, Iter, Error, @TNTargetF);
  Results(Guess, Answer, yAnswer, Tol, MaxIter, Iter, Error);
  Close(OutFile);
end. { program Muller }

