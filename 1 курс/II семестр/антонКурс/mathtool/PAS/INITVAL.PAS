unit InitVal;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for solving:                              -}
{-                                                                          -}
{-  (1) Initial value problems for nth-order ordinary differential          -}
{-      equations.                                                          -}
{-                                                                          -}
{-  (2) Initial value problems for systems of coupled first-order           -}
{-      ordinary differential equations.                                    -}
{-                                                                          -}
{-  (3) Boundary value problems for second-order ordinary differential      -}
{-      equations.                                                          -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I Float.inc} { Determines the setting of the $N compiler directive }

interface

{$IFOPT N+}
type
  Float = Double; { 8 byte real, requires 8087 math chip }

const
  TNNearlyZero = 1E-015;
{$ELSE}
type
  Float = real;   { 6 byte real, no math chip required }

const
  TNNearlyZero = 1E-07;
{$ENDIF}

  TNArraySize  = 50;           { Maximum size of vectors }
  MaxFuncs     = 10;           { Maximum number of user defined functions }

type
  TNvector  = array[0..TNArraySize] of Float;
  TNmatrix  = array[0..TNArraySize] of TNvector;
  TNData    = record
                X : Float;
                xDeriv : Float;
              end;

  TNvector2 = array[0..TNArraySize] of TNData;
  TNmatrix2 = array[0..TNArraySize] of TNvector2;
  FuncVect  = array[1..MaxFuncs] of Pointer;

procedure InitialCond1stOrder(LowerLimit   : Float;
                              UpperLimit   : Float;
                              XInitial     : Float;
                              NumReturn    : integer;
                              NumIntervals : integer;
                          var TValues      : TNvector;
                          var XValues      : TNvector;
                          var Error        : byte;
                              FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  LowerLimit, UpperLimit, XInitial, NumIntervals, NumReturn     -}
{-   Output:  TValues, XValues, Error                                       -}
{-                                                                          -}
{-  Purpose:  This unit solves a first order ordinary differential equation -}
{-            with initial condition specified).                            -}
{-            Given a function of the form                                  -}
{-                       dx/dt = TNTargetF(T, X)                            -}
{-            and an initial condition                                      -}
{-                       X[LowerLimit] = XInitial                           -}
{-            the fourth order Runge-Kutta method is used to solve for X    -}
{-            in the interval [LowerLimit, UpperLimit].  The interval is    -}
{-            divided up into NumIntervals sub-intervals.                   -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(T, X : real) : real;                  -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;       -}
{-                                                                          -}
{-    Global Variables:  LowerLimit : real;      Lower limit of interval    -}
{-                       UpperLimit : real;      Upper limit of interval    -}
{-                       XInitial : real;        Initial value at LowerLimit-}
{-                       NumIntervals : integer; Number of subintervals     -}
{-                       NumReturn : integer;    Number of values to return -}
{-                       TValues : TNvector;     Value of T between limits  -}
{-                       XValues : TNvector;     Value of X at TValues      -}
{-                       Error : byte;           Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 1                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: LowerLimit = UpperLimit                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure RungeKuttaFehlberg(LowerLimit : Float;
                             UpperLimit : Float;
                             XInitial   : Float;
                             Tolerance  : Float;
                             NumReturn  : integer;
                         var TValues    : TNvector;
                         var XValues    : TNvector;
                         var Error      : byte;
                             FuncPtr    : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  LowerLimit, UpperLimit, XInitial, Tolerance, NumReturn        -}
{-   Output:  TValues, XValues, Error                                       -}
{-                                                                          -}
{-  Purpose:  This unit solves a first order ordinary differential equation -}
{-            with a specified initial condition.                           -}
{-            Given a function of the form                                  -}
{-                       X' = TNTargetF(T, X)                               -}
{-            and an initial condition                                      -}
{-                       X[LowerLimit] = XInitial                           -}
{-            the Runge-Kutta-Fehlberg method is used to solve for X in the -}
{-            interval [LowerLimit, UpperLimit] with a given Tolerance.     -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(T, X : real) : real;                  -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;       -}
{-                                                                          -}
{-    Global Variables:  LowerLimit : real;     Lower limit of integration  -}
{-                       UpperLimit : real;     Upper limit of integration  -}
{-                       XInitial   : real;     Value of X at T=LowerLimit  -}
{-                       Tolerance  : real;     Tolerance in answer         -}
{-                       NumReturn  : integer;  Number of values to return  -}
{-                       TValues    : TNvector; Values of T                 -}
{-                       XValues    : TNvector; Values of X at TValues      -}
{-                       Error      : byte;     Flags if something goes     -}
{-                                              wrong                       -}
{-                                                                          -}
{-                       0: No errors                                       -}
{-                       1: Tolerance <= 0                                  -}
{-                       2: NumReturn < 1                                   -}
{-                       3: LowerLimit = UpperLimit                         -}
{-                       4: Tolerance not reached                           -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Adams(LowerLimit   : Float;
                UpperLimit   : Float;
                XInitial     : Float;
                NumReturn    : integer;
                NumIntervals : integer;
            var TValues      : TNvector;
            var XValues      : TNvector;
            var Error        : byte;
                FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  LowerLimit, UpperLimit, XInitial, NumReturn, NumIntervals     -}
{-   Output:  TValues, XValues, Error                                       -}
{-                                                                          -}
{-  Purpose:  This unit solves an initial value problem (a first order      -}
{-            differential equation with initial condition specified).      -}
{-            Given a function of the form                                  -}
{-                       dx/dt = TNTargetF(T, X)                            -}
{-            and an initial condition                                      -}
{-                       X[LowerLimit] = const                              -}
{-            the Adams-Bashforth/Adams-Moulton four step predictor/        -}
{-            corrector method is used to solve for X in  the interval      -}
{-            [LowerLimit, UpperLimit].  The interval is divided up into    -}
{-            NumIntervals equal sub-intervals.                             -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(T, X : real) : real;                  -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;       -}
{-                                                                          -}
{-    Global Variables:  LowerLimit   : real;    Lower limit of integration -}
{-                       UpperLimit   : real;    Upper limit of integration -}
{-                       XInitial     : real;    Value of X at LowerLimit   -}
{-                       NumReturn    : integer; Number of values to return -}
{-                       NumIntervals : integer; Number of subintervals     -}
{-                       TValues      : TNvector; Value of T between limits -}
{-                       XValues      : TNvector; Value of X at TValues     -}
{-                       Error        : byte;    Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn <= 0                                  -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: LowerLimit = UpperLimit                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InitialCond2ndOrder(LowerLimit   : Float;
                              UpperLimit   : Float;
                              InitialValue : Float;
                              InitialDeriv : Float;
                              NumReturn    : integer;
                              NumIntervals : integer;
                          var TValues      : TNvector;
                          var XValues      : TNvector;
                          var XDerivValues : TNvector;
                          var Error        : byte;
                              FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  LowerLimit, UpperLimit, InitialValue, InitialDeriv,           -}
{-            NumIntervals, NumReturn                                       -}
{-   Output:  NumIntervals, TValues, XValues, XDerivValues, Error           -}
{-                                                                          -}
{-  Purpose:  This unit solves a 2nd order ordinary differential            -}
{-            equation with specified initial conditions.                   -}
{-            Given a function of the form                                  -}
{-                       X" = TNTargetF(T, X, X')                           -}
{-            and initial conditions                                        -}
{-                 X[LowerLimit] = InitialValue,                            -}
{-                X'[LowerLimit] = InitialDeriv                             -}
{-            the Runge-Kutta method of two variables (X and X') is used to -}
{-            solve for X and X' in the interval [LowerLimit, UpperLimit].  -}
{-            The interval is divided up into NumIntervals sub-intervals.   -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(T, X, xPrime: real) : real;           -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;       -}
{-                                                                          -}
{-    Global Variables:  LowerLimit   : real;    Lower limit of integration -}
{-                       UpperLimit   : real;    Upper limit of integration -}
{-                       InitialValue : real;    Value of X at LowerLimit   -}
{-                       InitialDeriv : real;    Deriv. of X at LowerLimit  -}
{-                       NumReturn    : integer; Number of values to return -}
{-                       NumIntervals : integer; Number of subintervals     -}
{-                       TValues      : TNvector;Value of T between limits  -}
{-                       XValues      : TNvector;Value of X at TValues      -}
{-                       XDerivValues : TNvector Value of X' at TValues     -}
{-                       Error        : byte;    Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 1                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: LowerLimit = UpperLimit                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InitialCondition(Order          : integer;
                           LowerLimit     : Float;
                           UpperLimit     : Float;
                           InitialValues  : TNvector;
                           NumReturn      : integer;
                           NumIntervals   : integer;
                       var SolutionValues : TNmatrix;
                       var Error          : byte;
                           FuncPtr        : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  Order, LowerLimit, UpperLimit, InitialValues,                 -}
{-            NumReturn, NumIntervals                                       -}
{-   Output:  SolutionValues, Error                                         -}
{-                                                                          -}
{-    Purpose:  This procedure solves an n-order ordinary differential      -}
{-              equation with specified initial conditions.  The            -}
{-              generalized Runge-Kutta method solves for the n parameters  -}
{-              in a given interval.                                        -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(values : TNvector) : real;            -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;           -}
{-                          TNmatrix = array[0..TNColumnSize] of TNvector   -}
{-                                                                          -}
{-  Global Variables: Order : integer;           Order, n, of the diff. eq. -}
{-                    LowerLimit : real;         Lower limit of integration -}
{-                    UpperLimit : real;         Upper limit of integration -}
{-                    InitialValues : real;      Initial values of          -}
{-                                               The n parameters           -}
{-                    NumReturn : integer;       Number of values to return -}
{-                    NumIntervals : integer;    Number of subintervals     -}
{-                    SolutionValues : TNmatrix  Values of the n parameters -}
{-                                               at NumReturn points in the -}
{-                                               interval.                  -}
{-                    Error : byte;              Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 1                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: Order < 1                                       -}
{-                       4: LowerLimit = UpperLimit                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InitialConditionSystem(NumEquations   : integer;
                                 LowerLimit     : Float;
                                 UpperLimit     : Float;
                                 InitialValues  : TNvector;
                                 NumReturn      : integer;
                                 NumIntervals   : integer;
                             var SolutionValues : TNmatrix;
                             var Error          : byte;
                                 Vector         : FuncVect);
{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  NumEquations, LowerLimit, UpperLimit, InitialValues,          -}
{-            NumReturn, NumIntervals                                       -}
{-   Output:  SolutionValues, Error                                         -}
{-                                                                          -}
{-    Purpose:  This procedure solves m 1st-order ordinary differential     -}
{-              equation with specified initial conditions.  The            -}
{-              generalized Runge-Kutta method solves for the m parameters  -}
{-              in a given interval.                                        -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF1(values : TNvector) : real;           -}
{-                          TNTargetF2(values : TNvector) : real;           -}
{-                          TNTargetF3(values : TNvector) : real;           -}
{-                          TNTargetF4(values : TNvector) : real;           -}
{-                          TNTargetF5(values : TNvector) : real;           -}
{-                          TNTargetF6(values : TNvector) : real;           -}
{-                          TNTargetF7(values : TNvector) : real;           -}
{-                          TNTargetF8(values : TNvector) : real;           -}
{-                          TNTargetF9(values : TNvector) : real;           -}
{-                          TNTargetF10(values : TNvector) : real;          -}
{-                                                                          -}
{-    User-defined Types: TNvector = array[0..TNRowSize] of real;           -}
{-                        TNmatrix = array[0..TNColumnSize] of TNvector     -}
{-                                                                          -}
{-  Global Variables: NumEquations : integer;    Order & number of eqs.     -}
{-                    LowerLimit : real;         Lower limit of integration -}
{-                    UpperLimit : real;         Upper limit of integration -}
{-                    InitialValues : real;      Initial values of          -}
{-                                               The m parameters           -}
{-                    NumReturn : integer;       Number of values to return -}
{-                    NumIntervals : integer;    Number of subintervals     -}
{-                    SolutionValues : TNmatrix  Values of the m parameters -}
{-                                               at NumReturn points in the -}
{-                                               interval.                  -}
{-                    Error : byte;              Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 1                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: NumEquations < 1                                -}
{-                       4: LowerLimit = UpperLimit                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InitialConditionSystem2(NumEquations   : integer;
                                  LowerLimit     : Float;
                                  UpperLimit     : Float;
                                  InitialValues  : TNvector2;
                                  NumReturn      : integer;
                                  NumIntervals   : integer;
                              var SolutionValues : TNmatrix2;
                              var Error          : byte;
                                  Vector         : FuncVect);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  NumEquations, LowerLimit, UpperLimit, InitialValues,          -}
{-            NumReturn, NumIntervals                                       -}
{-   Output:  SolutionValues, Error                                         -}
{-                                                                          -}
{-    Purpose:  This procedure solves m 2nd-order ordinary differential     -}
{-              equation with specified initial conditions.  The            -}
{-              generalized Runge-Kutta method solves for the m parameters  -}
{-              in a given interval.                                        -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF1(values : TNvector2) : real;          -}
{-                          TNTargetF2(values : TNvector2) : real;          -}
{-                          TNTargetF3(values : TNvector2) : real;          -}
{-                          TNTargetF4(values : TNvector2) : real;          -}
{-                          TNTargetF5(values : TNvector2) : real;          -}
{-                          TNTargetF6(values : TNvector2) : real;          -}
{-                          TNTargetF7(values : TNvector2) : real;          -}
{-                          TNTargetF8(values : TNvector2) : real;          -}
{-                          TNTargetF9(values : TNvector2) : real;          -}
{-                          TNTargetF10(values : TNvector2) : real;         -}
{-                                                                          -}
{-    User-defined Types: TNData = record                                   -}
{-                                   X : real;                              -}
{-                                   xDeriv : real;                         -}
{-                                 end;                                     -}
{-                        TNvector2 = array[0..TNArraySize] of TNData;      -}
{-                        TNmatrix2 = array[0..TNArraySize] of TNvector2;   -}
{-                                                                          -}
{-  Global Variables: NumEquations   : integer; Order & number of eqs.      -}
{-                    LowerLimit     : real;    Lower limit of integration  -}
{-                    UpperLimit     : real;    Upper limit of integration  -}
{-                    InitialValues  : real;    Initial values of           -}
{-                                              the m parameters            -}
{-                    NumReturn      : integer; Number of values to return  -}
{-                    NumIntervals   : integer; Number of subintervals      -}
{-                    SolutionValues : TNmatrix Values of the m parameters  -}
{-                                              at NumReturn points in the  -}
{-                                              interval.                   -}
{-                    Error          : byte;    Flags if something goes     -}
{-                                              wrong                       -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 1                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: NumEquations < 1                                -}
{-                       4: LowerLimit = UpperLimit                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Shooting(LowerLimit   : Float;
                   UpperLimit   : Float;
                   LowerInitial : Float;
                   UpperInitial : Float;
                   InitialSlope : Float;
                   NumReturn    : integer;
                   Tolerance    : Float;
                   MaxIter      : integer;
                   NumIntervals : integer;
               var Iter         : integer;
               var XValues      : TNvector;
               var YValues      : TNvector;
               var YDerivValues : TNvector;
               var Error        : byte;
                   FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  LowerLimit, UpperLimit, LowerInitial, UpperInitial,           -}
{-            InitialSlope, NumReturn, Tolerance, MaxIter, NumIntervals     -}
{-   Output:  Iter, XValues, YValues, YDerivValues, Error                   -}
{-                                                                          -}
{-  Purpose:  This unit solves a possibly non-linear 2nd order ordinary     -}
{-            differential equation with specified boundary conditions.     -}
{-            Given a possible non-linear function of the form              -}
{-                       Y" = TNTargetF(X, Y, Y')                           -}
{-            and boundary conditions                                       -}
{-              Y[LowerLimit] = LowerInitial, Y[UpperLimit] = UpperInitial  -}
{-            the Runge-Kutta method is used to solve for Y in              -}
{-            the interval [LowerLimit, UpperLimit].  The algorithm uses    -}
{-            sub-intervals of length Spacing but returns only NumReturn    -}
{-            points.                                                       -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X, Y, yPrime : real) : real;          -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;       -}
{-                                                                          -}
{-    Global Variables:  LowerLimit   : real;    Lower limit of integration -}
{-                       UpperLimit   : real;    Upper limit of integration -}
{-                       LowerInitial : real;    Value of Y at LowerLimit   -}
{-                       UpperInitial : real;    Value of Y at UpperLimit   -}
{-                       InitialSlope : real;    Guess of slope @ LowerLimit-}
{-                       NumReturn    : integer; Number of points returned  -}
{-                       Tolerance    : real;    Tolerance in answer        -}
{-                       MaxIter      : integer; Max number of iterations   -}
{-                       NumIntervals : integer; Number of the sub-intervals-}
{-                       Iter         : integer; Number of iterations       -}
{-                       XValues      : TNvector;Values of X between limits -}
{-                       YValues      : TNvector;Value of Y at XValues      -}
{-                       YDerivValues : TNvector Value of Y' at XValues     -}
{-                       Error        : byte;    Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 0                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: LowerLimit = UpperLimit                         -}
{-                       4: Tolerance <= 0                                  -}
{-                       5: MaxIter <= 0                                    -}
{-                       6: Iter > MaxIter                                  -}
{-                       7: Convergence not possible                        -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure LinearShooting(LowerLimit   : Float;
                         UpperLimit   : Float;
                         LowerInitial : Float;
                         UpperInitial : Float;
                         NumReturn    : integer;
                         NumIntervals : integer;
                     var XValues      : TNvector;
                     var YValues      : TNvector;
                     var YDerivValues : TNvector;
                     var Error        : byte;
                         FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  LowerLimit, UpperLimit, LowerInitial, UpperInitial,           -}
{-            NumReturn, NumIntervals                                       -}
{-   Output:  XValues, YValues, YDerivValues                                -}
{-                                                                          -}
{-  Purpose:  This unit solves a 2nd order ordinary linear differential     -}
{-            equation with specified boundary conditions.                  -}
{-            Given a linear function of the form                           -}
{-                       Y" = TNTargetF(X, Y, Y')                           -}
{-            and boundary conditions                                       -}
{-              Y[LowerLimit] = LowerInitial, Y[UpperLimit] = UpperInitial  -}
{-            the Runge-Kutta method is used to solve for Y in              -}
{-            the interval [LowerLimit, UpperLimit].  The algorithm uses    -}
{-            sub-intervals of length Spacing.                              -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X, Y, YPrime : real) : real;          -}
{-                                                                          -}
{-      User-defined Types: TNvector = array[0..TNArraySize] of real;       -}
{-                                                                          -}
{-    Global Variables:  LowerLimit : real;      Lower limit of integration -}
{-                       UpperLimit : real;      Upper limit of integration -}
{-                       LowerInitial : real;    Value of Y at LowerLimit   -}
{-                       UpperInitial : real;    Value of Y at UpperLimit   -}
{-                       NumIntervals : real;    Number of the sub-intervals-}
{-                       NumReturn : integer;    Number of points returned  -}
{-                       XValues : TNvector;     Values of X between limits -}
{-                       YValues : TNvector;     Value of Y at XValues      -}
{-                       YDerivValues : TNvector Value of Y' at XValues     -}
{-                       Error : byte;           Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-               Notes:  NumIntervals should be an integer                  -}
{-                       multiple of NumReturn if you want                  -}
{-                       evenly spaced values returned.                     -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumReturn < 1                                   -}
{-                       2: NumIntervals < NumReturn                        -}
{-                       3: LowerLimit = UpperLimit                         -}
{-                       4: Equation not linear                             -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

{$L InitVal.OBJ}
{$F+}
function UserFunction1(T, X : Float; ProcAddr : Pointer) : Float; external;

function UserFunction2(T, X, XPrime : Float; ProcAddr : Pointer) : Float; external;

function UserFunction3(V : TNvector; ProcAddr : Pointer) : Float; external;

function UserFunction4(V : TNvector2; ProcAddr : Pointer) : Float; external;
{$F-}

{$I InitVal1.inc}   { Include procedure code }

{$I InitVal2.inc}

end. { InitVal }
