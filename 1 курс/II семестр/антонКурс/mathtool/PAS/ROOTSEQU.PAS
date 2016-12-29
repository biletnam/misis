unit RootsEqu;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for finding the roots                     -}
{-  of a single equation in one variable.                                   -}
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

  TNArraySize  = 30;   { maximum size of vectors }

type
  TNvector     = array[0..TNArraySize] of Float;
  TNIntVector  = array[0..TNArraySize] of integer;
  TNcomplex    = record
                   Re, Im : Float;
                 end;
  TNCompVector = array[0..TNArraySize] of TNcomplex;

procedure Bisect(LeftEnd  : Float;
                 RightEnd : Float;
                 Tol      : Float;
                 MaxIter  : integer;
             var Answer   : Float;
             var fAnswer  : Float;
             var Iter     : integer;
             var Error    : byte;
                 FuncPtr  : Pointer);


{----------------------------------------------------------------------------}
{-                                                                          -}
{- Input:  LeftEnd, RightEnd, Tol, MaxIter                                  -}
{- Output: Answer, fAnswer, Iter, Error                                     -}
{-                                                                          -}
{-          Purpose: This unit provides a procedure for finding a root      -}
{-                   of a user specified function, for a user specified     -}
{-                   interval, [a,b], where f(a) and f(b) are of opposite   -}
{-                   signs.  The algorithm successively bisects the         -}
{-                   interval, closing in on the root.  The user must       -}
{-                   supply the desired tolerance to which the root should  -}
{-                   be found.                                              -}
{-                                                                          -}
{- Global Variables: LeftEnd  : real    left endpoint                       -}
{-                   RightEnd : real    right endpoint                      -}
{-                   Tol      : real    tolerance of error                  -}
{-                   MaxIter  : real    maximum number of iterations        -}
{-                   Answer   : real    root of the function TNTargetF      -}
{-                   fAnswer  : real    TNTargetF(Answer)                   -}
{-                                      (should be close to 0)              -}
{-                   Iter     :integer  number of iterations                -}
{-                   Error    : byte    flags if something went wrong       -}
{-                                                                          -}
{-           Errors: 0: No error                                            -}
{-                   1: maximum number of iterations exceeded               -}
{-                   2: f(a) and f(b) are not of opposite signs             -}
{-                   3: Tol <= 0                                            -}
{-                   4: MaxIter < 0                                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Newton_Raphson(Guess    : Float;
                         Tol      : Float;
                         MaxIter  : integer;
                     var Root     : Float;
                     var Value    : Float;
                     var Deriv    : Float;
                     var Iter     : integer;
                     var Error    : byte;
                         FuncPtr1 : Pointer;
                         FuncPtr2 : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-             Input: Guess, Tol, MaxIter                                   -}
{-            Output: Root, Value, Deriv, Iter, Error                       -}
{-                                                                          -}
{-           Purpose: This unit provides a procedure for finding a single   -}
{-                    real root of a user specified function with a known   -}
{-                    continuous first derivative, given a user             -}
{-                    specified initial guess.  The procedure implements    -}
{-                    Newton-Raphson's algorithm for finding a single       -}
{-                    zero of a function.                                   -}
{-                    The user must specify the desired tolerance           -}
{-                    in the answer.                                        -}
{-                                                                          -}
{-  Global Variables: Guess   : real;    user's estimate of root            -}
{-                    Tol     : real;    tolerance in answer                -}
{-                    MaxIter : integer; maximum number of iterations       -}
{-                    Root    : real;    real part of calculated roots      -}
{-                    Value   : real;    value of the polynomial at root    -}
{-                    Deriv   : real;    value of the derivative at root    -}
{-                    Iter    : real;    number of iterations it took       -}
{-                                       to find root                       -}
{-                    Error   : byte;    flags if something went wrong      -}
{-                                                                          -}
{-            Errors: 1: Iter >= MaxIter                                    -}
{-                    2: The slope was zero at some point                   -}
{-                    3: Tol <= 0                                           -}
{-                    4: MaxIter < 0                                        -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Secant(Guess1  : Float;
                 Guess2  : Float;
                 Tol     : Float;
                 MaxIter : integer;
             var Root    : Float;
             var Value   : Float;
             var Iter    : integer;
             var Error   : byte;
                 FuncPtr : Pointer);
{----------------------------------------------------------------------------}
{-                                                                          -}
{-             Input: Guess1, Guess2, Tol, MaxIter                          -}
{-            Output: Root, Value, Iter, Error                              -}
{-                                                                          -}
{-           Purpose: This unit provides a procedure for finding a single   -}
{-                    real root of a user specified function, given a       -}
{-                    specified initial guess.  The procedure implements    -}
{-                    the secant method for finding a single                -}
{-                    root of a function.                                   -}
{-                    The user must specify the desired tolerance           -}
{-                    in the answer.                                        -}
{-                                                                          -}
{-  Global Variables: Guess1  : real;    initial approx #1                  -}
{-                    Guess2  : real;    initial approx #2                  -}
{-                    Tol     : real;    tolerance in answer                -}
{-                    MaxIter : integer; maximum number of iterations       -}
{-                    Root    : real;    real part of calculated roots      -}
{-                    Value   : real;    value of the polynomial at root    -}
{-                    Iter    : real;    number of iterations it took       -}
{-                                       to find root                       -}
{-                    Error   : byte;    flags if something went wrong      -}
{-                                                                          -}
{-            Errors: 1: Iter >= MaxIter                                    -}
{-                    2: The slope was zero at some point                   -}
{-                    3: Tol <= 0                                           -}
{-                    4: MaxIter < 0                                        -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Newt_Horn_Defl(InitDegree : integer;
                         InitPoly   : TNvector;
                         Guess      : Float;
                         Tol        : Float;
                         MaxIter    : integer;
                     var Degree     : integer;
                     var NumRoots   : integer;
                     var Poly       : TNvector;
                     var Root       : TNvector;
                     var Imag       : TNvector;
                     var Value      : TNvector;
                     var Deriv      : TNvector;
                     var Iter       : TNIntVector;
                     var Error      : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-             Input: InitDegree, InitPoly, Guess, Tol, MaxIter             -}
{-            Output: Degree, NumRoots, Poly, Root, Imag, Value, Deriv      -}
{-                    Iter, Error                                           -}
{-                                                                          -}
{-           Purpose: This unit provides a procedure for finding several    -}
{-                    roots of a user specified polynomial given a user     -}
{-                    specified initial guess.  The procedure implements    -}
{-                    Newton-Horner's algorithm for finding a single        -}
{-                    root of a polynomial and deflation techniques for     -}
{-                    reducing a polynomial given one of its roots.         -}
{-                    Should the polynomial contain no more than two        -}
{-                    complex roots, they may also be determined.           -}
{-                    The user must specify the desired tolerance in the    -}
{-                    answer and the maximum number of iterations.          -}
{-                                                                          -}
{- Pre-Defined Types: TNvector    = array[0..TNArraySize] of real;          -}
{-                    TNIntVector = array[0..TNArraySize] of integer;       -}
{-                                                                          -}
{-  Global Variables: InitDegree : integer;  degree of user's polynomial    -}
{-                    InitPoly   : TNvector; coefficients of user's         -}
{-                                           polynomial where InitPoly[n]   -}
{-                                           is the coefficient of X^n      -}
{-                    Guess      : real;     user's estimate of root        -}
{-                    Tol        : real;     tolerance in answer            -}
{-                    Degree     : real;     degree of reduced polynomial   -}
{-                                           left when procedure is done    -}
{-                                           (>0 if all the roots were      -}
{-                                           not Found)                     -}
{-                    Poly       : TNvector; coefficients of reduced poly   -}
{-                    NumRoots   : integer;  number of roots calculated     -}
{-                    Root       : TNvector; real parts of calculated roots -}
{-                    Imag       : TNvector; imaginary parts of roots (non- -}
{-                                           zero for no more than 2)       -}
{-                    Value      : TNvector; value of the polynomial at     -}
{-                                           each root                      -}
{-                    Deriv      : TNvector; value of the derivative at     -}
{-                                           each root                      -}
{-                    Iter       : TNIntVector; number of iterations it     -}
{-                                              took to find each root      -}
{-                    Error      : byte;     flags if something went wrong  -}
{-                                                                          -}
{-            Errors: 0: No error                                           -}
{-                    1: Iter >= MaxIter                                    -}
{-                    2: The slope was zero at some point                   -}
{-                    3: Degree <= 0                                        -}
{-                    4: Tol <= 0                                           -}
{-                    5: MaxIter < 0                                        -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Muller(Guess   : TNcomplex;
                 Tol     : Float;
                 MaxIter : integer;
             var Answer  : TNcomplex;
             var yAnswer : TNcomplex;
             var Iter    : integer;
             var Error   : byte;
                 FuncPtr : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-               Input: Guess, Tol, MaxIter                                 -}
{-              Output: Answer, yAnswer, Iter, Error                        -}
{-                                                                          -}
{-             Purpose: This program uses Muller's method to find a root    -}
{-                      of a user defined function Y=TNTargetF given an     -}
{-                      initial approximation.  The root may be complex.    -}
{-                                                                          -}
{-                                                                          -}
{-   User-Defined                                                           -}
{-          Procedures: TNTargetF(X : TNcomplex; VAR Y : TNcomplex);        -}
{-                                                                          -}
{-  User-Defined Types: TNcomplex = record                                  -}
{-                                    Re, Im : real;                        -}
{-                                  end;                                    -}
{-                                                                          -}
{-    Global Variables: Guess   : real;            initial guess            -}
{-                      Tol     : real;            tolerance in the         -}
{-                                                 answer                   -}
{-                      MaxIter : integer;         maximum number of        -}
{-                                                 iterations               -}
{-                      Answer  : TNcomplex;       a root of the            -}
{-                                                 polynomial               -}
{-                      yAnswer : TNcomplex;       value of the             -}
{-                                                 polynomial at the        -}
{-                                                 root (close to zero)     -}
{-                      Iter    : integer;         number of iterations     -}
{-                                                 it took to find root     -}
{-                      Error   : byte;            flags an error           -}
{-                                                                          -}
{-              Errors: 0: No errors                                        -}
{-                      1: Iter > MaxIter                                   -}
{-                      2: parabola could not                               -}
{-                         be formed                                        -}
{-                      3: Tol <= 0                                         -}
{-                      4: MaxIter < 0                                      -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Laguerre(var Degree    : integer;
                   var Poly      : TNCompVector;
                       InitGuess : TNcomplex;
                       Tol       : Float;
                       MaxIter   : integer;
                   var NumRoots  : integer;
                   var Roots     : TNCompVector;
                   var yRoots    : TNCompVector;
                   var Iter      : TNIntVector;
                   var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-            Input: Degree, Poly, InitGuess, Tol, MaxIter                  -}
{-           Output: Degree, Poly, NumRoots, Roots, yRoots, Iter, Error     -}
{-                                                                          -}
{-          Purpose: This unit provides a procedure for finding all the     -}
{-                   roots (real and complex) to a polynomial.              -}
{-                   Laguerre's method with deflation is used.              -}
{-                   The user must input the coefficients of the quadratic  -}
{-                   and the tolerance in the answers generated.            -}
{-                                                                          -}
{-  Pre-defined Types: TNcomplex    = record                                -}
{-                                      Re, Im : real;                      -}
{-                                    end;                                  -}
{-                                                                          -}
{-                     TNIntVector  = array[0..TNArraySize] of integer;     -}
{-                     TNCompVector = array[0..TNArraySize] of TNcomplex;   -}
{-                                                                          -}
{- Global Variables: Degree    : integer;      degree of deflated           -}
{-                                             polynomial                   -}
{-                   Poly      : TNCompVector; coefficients of deflated     -}
{-                                             polynomial where Poly[n] is  -}
{-                                             the coefficient of X^n       -}
{-                   InitGuess : TNcomplex;    initial guess to a root      -}
{-                                             (may be very crude)          -}
{-                   Tol       : real;         tolerance in the answer      -}
{-                   MaxIter   : integer;      number of iterations         -}
{-                   NumRoots  : integer;      number of roots calculated   -}
{-                   Roots     : TNCompVector; the roots calculated         -}
{-                   yRoots    : TNCompVector; the value of the function    -}
{-                                             at the calculated roots      -}
{-                   Iter      : TNIntVector;  number iteration it took to  -}
{-                                             find each root               -}
{-                   Error     : byte;         flags an error               -}
{-                                                                          -}
{-           Errors: 0: No error                                            -}
{-                   1: Iter > MaxIter                                      -}
{-                   2: Degree <= 0                                         -}
{-                   3: Tol <= 0                                            -}
{-                   4: MaxIter < 0                                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

{$F+}
{$L RootsEqu.OBJ} { Link in external routines }

function UserFunction(X : Float; ProcAddr : Pointer) : Float; external;

procedure UserProcedure(X : TNcomplex; var Y : TNcomplex; ProcAddr : Pointer); external;
{$F-}

{$I RootsEqu.inc}  { Include procedure code }

end. { RootsEqu }
