program Bisect_Prog;

{---------------------------------------------------------------------------}
{-                                                                         -}
{-     Turbo Pascal Numerical Methods Toolbox                              -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.               -}
{-                                                                         -}
{-        Purpose: This program demonstrates the bisection routine.        -}
{-                                                                         -}
{-        Unit   : RootsEqu   procedure Bisect                             -}
{-                                                                         -}
{---------------------------------------------------------------------------}

{$I-}                                    { Disable I/O error trapping }
{$R+}                                    { Enable range checking }

uses
  RootsEqu, Dos, Crt, Common;

var
  LeftEndpoint, RightEndpoint : Float;   { Endpoints of the region }
  Answer, yAnswer             : Float;   { Root of f(x) }
  Tol                         : Float;   { Tolerance }
  Iter, MaxIter               : integer; { Number of iterations }
  Error                       : byte;    { Flags if something went wrong }

{$F+}
{----- HERE IS THE FUNCTION TO FIND A ROOT OF ------}
function TNTargetF(X : Float) : Float;
begin
  TNTargetF := Cos(X) - X;
end; { function TNTargetF }
{---------------------------------------------------}
{$F-}

procedure Initial(var LeftEndpoint  : Float;
                  var RightEndpoint : Float;
                  var Answer        : Float;
                  var yAnswer       : Float;
                  var Tol           : Float;
                  var Iter          : integer;
                  var MaxIter       : integer;
                  var Error         : byte);

{----------------------------------------------------------}
{- Output: LeftEndpoint, RightEndpoint, Answer, yAnswer,  -}
{-         Tol, Iter, MaxIter, Error                      -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}
begin
  LeftEndpoint := 0;
  RightEndpoint := 0;
  Answer := 0;
  yAnswer := 0;
  Tol := 0;
  Iter := 0;
  MaxIter := 0;
  Error := 0;
end; { procedure Initial }

procedure UserInput(var LeftEndpoint  : Float;
                    var RightEndpoint : Float;
                    var Tol           : Float;
                    var MaxIter       : integer);

{-------------------------------------------------------}
{- Output: LeftEndpoint, RightEndpoint, Tol, MaxIter   -}
{-                                                     -}
{- This procedure assigns values to the left and       -}
{- right endpoints of the interval, to the tolerance   -}
{- with which the answer should be found, and to the   -}
{- maximum number of iterations to be performed. Input -}
{- is from the keyboard.                               -}
{-------------------------------------------------------}

procedure GetEndPoints(var LeftEndpoint  : Float;
                       var RightEndpoint : Float);
begin
  Writeln;
  repeat
    Write(' Left endpoint: ');
    Readln(LeftEndpoint);
    IOCheck;
  until not IOerr;
  repeat
    Write('Right endpoint: ');
    Readln(RightEndpoint);
    IOCheck;      { check for I/O errors }
  until not IOerr;
end; { procedure GetEndPoints }

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
    Write('Maximum number of iterations (> 0)? ');
    ReadInt(MaxIter);
    IOCheck;        { Check for I/O errors }
    if MaxIter < 0 then
    begin
      IOerr := true;
      MaxIter := 100;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure UserInput }
  GetEndPoints(LeftEndpoint, RightEndpoint);
  GetTolerance(Tol);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure UserInput }

procedure Results(LeftEndpoint  : Float;
                  RightEndpoint : Float;
                  Tol           : Float;
                  MaxIter       : integer;
                  Answer        : Float;
                  yAnswer       : Float;
                  Iter          : integer;
                  Error         : byte);
{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}
begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile,'left endpoint: ' : 30, LeftEndpoint);
  Writeln(OutFile,'right endpoint: ' : 30, RightEndpoint);
  Writeln(OutFile,'Tolerance: ' : 30, Tol);
  Writeln(OutFile,'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error = 1 then
    DisplayWarning;
  if Error >= 2 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile,'Number of iterations: ' : 26, Iter : 3);
          Writeln(OutFile,'Calculated root: ' : 26, Answer);
          Writeln(OutFile,'Value of the function  ' : 26);
          Writeln(OutFile,'at the calculated root: ' : 26, yAnswer);
        end;

    1 : begin
          Writeln(OutFile,'It will take more than ',MaxIter,
                          ' iterations to get within tolerance.');
          Writeln(OutFile);
          Writeln(OutFile,'Number of iterations: ' : 26, Iter);
          Writeln(OutFile,'Calculated root: ' : 26, Answer);
          Writeln(OutFile,'Value of the function  ' : 26);
          Writeln(OutFile,'at the calculated root: ' : 26, yAnswer);
        end;

    2 : begin
          Writeln(OutFile,
                  'The sign of the function at the two endpoints is the same.');
          Writeln(OutFile, 'Change the endpoints.');
        end;

    3 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    4 : Writeln(OutFile,
                'The maximum number of iteration must be greater than zero.');
  end; { case }
end; { procedure Results }

begin { program Bisect }
  ClrScr;
  Initial(LeftEndpoint, RightEndpoint, Answer,
          yAnswer, Tol, Iter, MaxIter, Error);
  UserInput(LeftEndpoint, RightEndpoint, Tol, MaxIter);
  Bisect(LeftEndpoint, RightEndpoint, Tol, MaxIter,
         Answer, yAnswer, Iter, Error, @TNTargetF);
  Results(LeftEndpoint, RightEndpoint, Tol, MaxIter,
          Answer, yAnswer, Iter, Error);
  Close(OutFile);
end. { program Bisect }
