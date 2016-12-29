program Secant_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-        Purpose: This sample program demonstrates the secant method.      -}
{-                                                                          -}
{-        Unit   : RootsEqu    procedure Secant                             -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}          { Disable I/O error trapping }
{$R+}          { Enable range checking }

uses
  RootsEqu, Dos, Crt, Common;

var
  InitGuess1 : Float;         { Initial approximation #1 }
  InitGuess2 : Float;         { Initial approximation #2 }
  Tolerance : Float;          { Tolerance in answer }
  Root, Value : Float;        { Resulting root and other info }
  Iter : integer;             { Number of iterations to find root }
  MaxIter : integer;          { Maximum number of iterations }
  Error : byte;               { Error flag }

{$F+}
{------- HERE IS THE FUNCTION ----------}
function TNTargetF(X : Float) : Float;
begin
  TNTargetF := Cos(X) - X;
end;  { function TNTargetF }
{---------------------------------------}
{$F-}

procedure Initialize(var InitGuess1 : Float;
                     var InitGuess2 : Float;
                     var Tolerance  : Float;
                     var Root       : Float;
                     var Value      : Float;
                     var MaxIter    : integer;
                     var Iter       : integer;
                     var Error      : byte);

{-----------------------------------------------------------}
{- Output: InitGuess1, InitGuess2, Tolerance, Root, Value, -}
{-         MaxIter, Iter, Error                            -}
{-                                                         -}
{- This procedure initializes the above variables to zero. -}
{-----------------------------------------------------------}

begin
  InitGuess1 := 0;
  InitGuess2 := 0;
  Tolerance := 0;
  MaxIter := 0;
  Root := 0;
  Value := 0;
  Error := 0;
  Iter := 0;
end; { procedure Initialize }

procedure UserInput(var InitGuess1 : Float;
                    var InitGuess2 : Float;
                    var Tol        : Float;
                    var MaxIter    : integer);

{-------------------------------------------------------------}
{- Output: InitGuess1, InitGuess2, Tol, MaxIter              -}
{-                                                           -}
{- This procedure assigns values to the initial guesses      -}
{- (InitGuess1, InitGuess2), to the tolerance to which the   -}
{- answer should be found, and to the maximum number of      -}
{- iterations to be performed. Input is from the keyboard.   -}
{-------------------------------------------------------------}

procedure GetInitialGuess(var InitGuess1 : Float;
                          var InitGuess2 : Float);
begin
  repeat
    Writeln;
    Write('First initial approximation to the root: ');
    Readln(InitGuess1);
    IOCheck;        { Check for I/O errors }
  until not IOerr;
  repeat
    Writeln;
    Write('Second initial approximation to the root: ');
    Readln(InitGuess2);
    IOCheck;        { Check for I/O errors }
  until not IOerr;
end; { procedure GetInitialGuess }

procedure GetTolerance(var Tol : Float);
begin
  Tol := 1E-8;
  repeat
    Writeln;
    Write('Tolerance (> 0): ');
    ReadFloat(Tol);
    IOCheck;        { Check for I/O errors }
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
  repeat
    Writeln;
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
  GetInitialGuess(InitGuess1, InitGuess2);
  GetTolerance(Tol);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure UserInput }

procedure Results(InitGuess1 : Float;
                  InitGuess2 : Float;
                  Tol        : Float;
                  MaxIter    : integer;
              var OutFile    : text;
                  Root       : Float;
                  Value      : Float;
                  Iter       : integer;
                  Error      : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, ' First initial approximation: ' : 30, InitGuess1);
  Writeln(OutFile, 'Second initial approximation: ': 30, InitGuess2);
  Writeln(OutFile, 'Tolerance: ' : 30, Tol);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error in [1, 2] then
    DisplayWarning;
  if Error >= 3 then
    DisplayError;

  case Error of
    1 : Writeln(OutFile, 'It will take more than ',MaxIter,
                ' iterations to solve this equation.');

    2 : Writeln(OutFile, 'The slope is approaching zero.');

    3 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    4 : Writeln(OutFile,
                'The maximum number of iterations must be greater than zero.');

  end; { case }
  if Error <= 2 then
  begin
    Writeln(OutFile);
    Writeln(OutFile, 'Number of iterations: ' : 30, Iter : 3);
    Writeln(OutFile, 'Calculated root: ' : 30, Root);
    Writeln(OutFile, 'Value of the function  ' : 30);
    Writeln(OutFile, 'at the calculated root: ' : 30, Value);
    Writeln(OutFile);
  end;
end; { procedure Results }

begin { program Secant }
  ClrScr;
  Initialize(InitGuess1, InitGuess2, Tolerance, Root,
             Value, MaxIter, Iter, Error);
  UserInput(InitGuess1, InitGuess2, Tolerance, MaxIter);
  { Use the Secant method to converge onto a root }
  Secant(InitGuess1, InitGuess2, Tolerance, MaxIter,
         Root, Value, Iter, Error, @TNTargetF);
  Results(InitGuess1, InitGuess2, Tolerance, MaxIter, OutFile,
          Root, Value, Iter, Error);
  Close(OutFile);         { Close output file }
end. { program Secant }
