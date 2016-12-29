program InitialConditionSystem_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-   Purpose:  This unit demonstrates the procedure InitialConditionSystem. -}
{-             This procedure solves a system of n first order ordinary     -}
{-             differential equations with initial conditions specified     -}
{-             using the fourth order  Runge-Kutta formula.                 -}
{-                                                                          -}
{-   Unit   : InitVal    procedure InitialConditionSystem                   -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

const
  TNRowSize    = TNArraySize;    { Maximum number of diff. eqs.  }
  TNColumnSize = TNArraySize;    { Maximum size of vectors  }

var
  NumEquations : integer;        { The number of first order equations  }
  LowerLimit : Float;            { Lower limit of interval  }
  UpperLimit : Float;            { Upper limit of interval  }
  InitialValues : TNvector;      { Initial values at lower limit  }
  NumReturn : integer;           { Number of values to return  }
  NumIntervals : integer;        { Number of intervals  }
  SolutionValues : TNmatrix;     { Values of the n parameters at NumReturn  }
                                 { Mesh points between the intervals  }
  Error : byte;                  { Flags if something went wrong  }
  Vector : FuncVect;             { Pointers to user defined functions }

{$F+}
function TNTargetF1(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the first differential equation.       -}
{-                                                -}
{-  dx[1]                                         -}
{-  -----  = TNTargetF1(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
  TNTargetF1 := V[2];
end; { function TNTargetF1 }

function TNTargetF2(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the 2nd differential equation.         -}
{-                                                -}
{-  dx[2]                                         -}
{-  -----  = TNTargetF2(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
  TNTargetF2 := 9/2 * Sin(5 * V[0]) - 32/2 * V[1];
end; { function TNTargetF2 }

function TNTargetF3(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the third differential equation.       -}
{-                                                -}
{-  dx[3]                                         -}
{-  -----  = TNTargetF3(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF3 }

function TNTargetF4(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the fourth differential equation.      -}
{-                                                -}
{-  dx[4]                                         -}
{-  -----  = TNTargetF4(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF4 }

function TNTargetF5(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the fifth differential equation.       -}
{-                                                -}
{-                                                -}
{-  dx[5]                                         -}
{-  -----  = TNTargetF5(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF5 }

function TNTargetF6(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the sixth differential equation.       -}
{-                                                -}
{-  dx[6]                                         -}
{-  -----  = TNTargetF6(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF6 }

function TNTargetF7(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the seventh differential equation.     -}
{-                                                -}
{-                                                -}
{-  dx[7]                                         -}
{-  -----  = TNTargetF7(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF7 }

function TNTargetF8(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the eighth differential equation.      -}
{-                                                -}
{-  dx[8]                                         -}
{-  -----  = TNTargetF8(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF8 }

function TNTargetF9(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the ninth differential equation.       -}
{-                                                -}
{-  dx[9]                                         -}
{-  -----  = TNTargetF9(T, X[1], X[2], ... X[m])  -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF9 }

function TNTargetF10(V : TNvector) : Float;

{--------------------------------------------------}
{- This is the tenth differential equation.       -}
{-                                                -}
{-  dx[10]                                        -}
{-  -----  = TNTargetF10(T, X[1], X[2], ... X[m]) -}
{-    dt                                          -}
{-                                                -}
{- The vector V is defined:                       -}
{-      V[0] = T                                  -}
{-      V[1] = X[1]                               -}
{-      V[2] = X[2]                               -}
{-           .                                    -}
{-           .                                    -}
{-           .                                    -}
{-      V[m] = X[m]                               -}
{-                                                -}
{- where m is the number of coupled equations.    -}
{--------------------------------------------------}

begin
end; { function TNTargetF10 }
{$F-}

procedure Initialize(var NumEquations : integer;
                     var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var InitialValue : TNvector;
                     var NumIntervals : integer;
                     var NumReturn    : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: NumEquations, LowerLimit, UpperLimit, LowerInitial,    -}
{-         InitialValues, NumIntervals, NumReturn, Error          -}
{-                                                                -}
{- This procedure initializes the above variables to zero.        -}
{------------------------------------------------------------------}

begin
  NumEquations := 0;
  LowerLimit := 0;
  UpperLimit := 0;
  FillChar(InitialValue, SizeOf(InitialValue), 0);
  NumReturn := 0;
  NumIntervals := 0;
  Error := 0;
  Vector[1] := @TNTargetF1;
  Vector[2] := @TNTargetF2;
  Vector[3] := @TNTargetF3;
  Vector[4] := @TNTargetF4;
  Vector[5] := @TNTargetF5;
  Vector[6] := @TNTargetF6;
  Vector[7] := @TNTargetF7;
  Vector[8] := @TNTargetF8;
  Vector[9] := @TNTargetF9;
  Vector[10] := @TNTargetF10;
end; { procedure Initialize }

procedure GetData(var NumEquations  : integer;
                  var LowerLimit    : Float;
                  var UpperLimit    : Float;
                  var InitialValues : TNvector;
                  var NumReturn     : integer;
                  var NumIntervals  : integer);

{------------------------------------------------------------}
{- Output: NumEquations, LowerLimit, UpperLimit,            -}
{-         InitialValues, NumReturn, NumIntervals           -}
{-                                                          -}
{- This procedure assigns values to the above variables     -}
{- from keyboard input                                      -}
{------------------------------------------------------------}

procedure GetNumEquations(var NumEquations : integer);

{--------------------------------------}
{- Output: NumEquations               -}
{-                                    -}
{- This procedure reads in the number -}
{- of equations from the keyboard.    -}
{--------------------------------------}

begin
  Writeln;
  repeat
    Write('Number of first order equations: (1-', TNRowSize, ')? ');
    Readln(NumEquations);
    IOCheck;
  until not IOerr and (NumEquations <= TNRowSize) and (NumEquations >= 1);
end; { procedure GetNumEquations }

procedure GetLimits(var LowerLimit : Float;
                    var UpperLimit : Float);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit                           -}
{-                                                          -}
{- This procedure assigns values to the limits of           -}
{- integration from keyboard input                          -}
{------------------------------------------------------------}

begin
  Writeln;
  repeat
    repeat
      Write('Lower limit of interval? ');
      Readln(LowerLimit);
      IOCheck;
    until not IOerr;
    Writeln;
    repeat
      Write('Upper limit of interval? ');
      Readln(UpperLimit);
      IOCheck;
    until not IOerr;
    if LowerLimit = UpperLimit then
    begin
      Writeln;
      Writeln('       The limits of integration must be different.');
      Writeln;
    end;
  until LowerLimit <> UpperLimit;
end; { procedure GetLimits }

  procedure GetInitialValues(NumEquations  : integer;
                             LowerLimit    : Float;
                         var InitialValues : TNvector);

{--------------------------------------------------}
{- Input: NumEquations, LowerLimit                -}
{- Output: InitialValues                          -}
{-                                                -}
{- This procedure assigns values to InitialValues -}
{- from keyboard input.                           -}
{--------------------------------------------------}

var
  Term : integer;

begin
  InitialValues[0] := LowerLimit;
  Writeln;
  for Term := 1 to NumEquations do
  repeat
    Write('Enter X[', Term, '] value at t =', LowerLimit : 14, ': ');
    Readln(InitialValues[Term]);
    IOCheck;
  until not IOerr;
end; { procedure GetInitialValues }

procedure GetNumReturn(var NumReturn : integer);

{----------------------------------------------------------}
{- Output: NumReturn                                      -}
{-                                                        -}
{- This procedure reads in the number of values to return -}
{- in the vectors TValues, XValues and XDerivValues.      -}
{----------------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Number of values to return (1-', TNColumnSize, ')? ');
    Readln(NumReturn);
    IOCheck;
  until not IOerr and (NumReturn <= TNColumnSize) and (NumReturn >= 1);
end; { procedure GetNumReturn }

procedure GetNumIntervals(NumReturn    : integer;
                      var NumIntervals : integer);

{------------------------------------------------------------}
{- Input: NumReturn                                         -}
{- Output: NumIntervals                                     -}
{-                                                          -}
{- This procedure reads in the number of intervals          -}
{- over which to solve the equation.                        -}
{------------------------------------------------------------}

begin
  Writeln;
  NumIntervals := NumReturn;
  repeat
    Write('Number of intervals (>= ', NumReturn, ')? ');
    ReadInt(NumIntervals);
    IOCheck;
    if NumIntervals < NumReturn then
    begin
      IOerr := true;
      NumIntervals := NumReturn;
    end;
  until not IOerr;
end; { procedure GetNumIntervals }

begin { procedure GetData }
  GetNumEquations(NumEquations);
  GetLimits(LowerLimit, UpperLimit);
  GetInitialValues(NumEquations, LowerLimit, InitialValues);
  GetNumReturn(NumReturn);
  GetNumIntervals(NumReturn, NumIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumEquations   : integer;
                  LowerLimit     : Float;
                  UpperLimit     : Float;
                  InitialValues  : TNvector;
                  NumIntervals   : integer;
                  NumReturn      : integer;
              var SolutionValues : TNmatrix;
                  Error          : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Term : integer;
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit:' : 35, LowerLimit);
  Writeln(OutFile, 'Upper Limit:' : 35, UpperLimit);
  Writeln(OutFile, 'Number of intervals:' : 35, NumIntervals);
  Writeln(OutFile, 'Initial conditions at lower limit:' : 35);
  for Term := 1 to NumEquations do
    Writeln(OutFile, 'X[' : 21, Term,']= ', InitialValues[Term]);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

  case Error of
    0 : begin
          for Term := 1 to NumEquations do
          begin
            Writeln(OutFile, 't':10, 'Value X[' : 30, Term, ']');
            for Index := 0 to NumReturn do
              Writeln(OutFile, SolutionValues[Index, 0] : 15 : 8,
                               SolutionValues[Index, Term] : 30);
            Writeln(OutFile);
          end;
        end;

    1 : Writeln(OutFile,
                'The number of values to return must be greater than zero.');

    2 : begin
          Writeln(OutFile, 'The number of intervals must be greater than');
          Writeln(OutFile, 'or equal to the number of values to return.');
        end;

    3 : Writeln(OutFile,
                'The number of equations must be greater than zero.');
    4 : Writeln(OutFile, 'The lower limit must be different ',
                         'from the upper limit.');
  end; { case }
end; { procedure Results }

begin { program InitialConditionSystem }
  ClrScr;
  Initialize(NumEquations, LowerLimit, UpperLimit, InitialValues,
             NumIntervals, NumReturn, Error);
  GetData(NumEquations, LowerLimit, UpperLimit, InitialValues,
          NumReturn, NumIntervals);
  InitialConditionSystem(NumEquations, LowerLimit, UpperLimit, InitialValues,
                         NumReturn, NumIntervals, SolutionValues, Error, Vector);
  Results(NumEquations, LowerLimit, UpperLimit, InitialValues, NumIntervals,
          NumReturn, SolutionValues, Error);
  Close(OutFile);
end. { program InitialConditionSystem }
