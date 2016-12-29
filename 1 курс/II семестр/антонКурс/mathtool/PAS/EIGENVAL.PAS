unit EigenVal;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for finding eigenvalues and eigenvectors. -}
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

  TNArraySize = 30;               { Maximum size of matrix }

type
  TNvector    = array[1..TNArraySize] of Float;
  TNmatrix    = array[1..TNArraySize] of TNvector;
  TNIntVector = array[1..TNArraySize] of integer;

procedure Power(Dimen       : integer;
            var Mat         : TNmatrix;
            var GuessVector : TNvector;
                MaxIter     : integer;
                Tolerance   : Float;
            var Eigenvalue  : Float;
            var Eigenvector : TNvector;
            var Iter        : integer;
            var Error       : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-              Input:  Dimen, Mat, GuessVector, MaxIter, Tolerance         -}
{-             Output:  Eigenvalue, Eigenvector, Iter, Error                -}
{-                                                                          -}
{-            Purpose:  The power method approximates the dominant          -}
{-                      eigenvalue of a matrix.  The dominant               -}
{-                      eigenvalue is the eigenvalue of largest             -}
{-                      absolute magnitude. Given a square matrix Mat       -}
{-                      and an arbitrary vector OldApprox, the vector       -}
{-                      NewApprox is constructed by the matrix              -}
{-                      operation NewApprox = Mat - OldApprox .             -}
{-                      NewApprox is divided by its largest element         -}
{-                      ApproxEigenval, thereby normalizing                 -}
{-                      NewApprox. If NewApprox is the same as              -}
{-                      OldApprox then ApproxEigenval is the dominant       -}
{-                      eigenvalue and NewApprox is the associated          -}
{-                      eigenvector of the matrix Mat. If NewApprox         -}
{-                      is not the same as OldApprox then OldApprox         -}
{-                      is set equal to NewApprox and the operation         -}
{-                      repeats until a solution is reached. Aitken's       -}
{-                      delta-squared acceleration is used to speed         -}
{-                      the convergence from linear to quadratic.           -}
{-                                                                          -}
{- User-defined Types:  TNvector = array[1..TNArraySize] of real;           -}
{-                      TNmatrix = array[1..TNArraySize] of TNvector;       -}
{-                                                                          -}
{-   Global Variables:  Dimen       : integer;  Dimension of the matrix     -}
{-                      Mat         : TNmatrix; The matrix                  -}
{-                      GuessVector : TNvector; An initial guess of an      -}
{-                                              eigenvector                 -}
{-                      MaxIter     : integer;  Max. number of iterations   -}
{-                      Tolerance   : real;     Tolerance in answer         -}
{-                      Eigenvalue  : real;     Eigenvalue of the matrix    -}
{-                      Eigenvector : TNvector  Eigenvector of the matrix   -}
{-                      Iter        : integer;  Number of iterations        -}
{-                      Error       : byte;     Flags if something goes     -}
{-                                              wrong                       -}
{-             Errors:  0: No Errors                                        -}
{-                      1: Dimen < 2                                        -}
{-                      2: Tolerance <= 0                                   -}
{-                      3: MaxIter < 1                                      -}
{-                      4: Iter >= MaxIter                                  -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InversePower(Dimen       : integer;
                       Mat         : TNmatrix;
                   var GuessVector : TNvector;
                       ClosestVal  : Float;
                       MaxIter     : integer;
                       Tolerance   : Float;
                   var Eigenvalue  : Float;
                   var Eigenvector : TNvector;
                   var Iter        : integer;
                   var Error       : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-          Input:  Dimen, Mat, GuessVector, ClosestVal, MaxIter, Tolerance -}
{-         Output:  Eigenvalue, Eigenvector, Iter, Error                    -}
{-                                                                          -}
{-            Purpose:  Whereas the power method converges onto the         -}
{-                      dominant eigenvalue of a matrix (see                -}
{-                      POWER.INC), the inverse power method                -}
{-                      converges onto the eigenvalue closest to a          -}
{-                      user-supplied value.  The user supplies a           -}
{-                      square matrix Mat, an initial approximation         -}
{-                      ClosestVal to the eigenvalue and an initial         -}
{-                      vector OldApprox.  The linear system                -}
{-                      (Mat - ClosestVal - I)OldApprox = NewApprox is      -}
{-                      solved via LU decomposition (see                    -}
{-                      DECMP-LU.INC\SOLVE-LU.INC).  The vector             -}
{-                      NewApprox is divided by its largest element         -}
{-                      ApproxEigenval (thereby normalizing the             -}
{-                      vector).  If NewApprox is identical to              -}
{-                      OldApprox then (1/ApproxEigenval + ClosestVal)      -}
{-                      is the eigenvalue of A closest to ClosestVal        -}
{-                      and OldApprox is the associated eigenvector.        -}
{-                      If NewApprox is not identical to OldApprox          -}
{-                      then OldApprox is set equal to NewApprox and        -}
{-                      the process repeats until a solution is             -}
{-                      reached.                                            -}
{-                                                                          -}
{- User-defined Types:  TNvector = array[1..TNArraySize] of real;           -}
{-                      TNmatrix = array[1..TNArraySize] of TNvector;       -}
{-                                                                          -}
{-   Global Variables:  Dimen       : integer;  Dimension of the matrix     -}
{-                      Mat         : TNmatrix; The matrix                  -}
{-                      GuessVector : TNvector; Initial guess of an         -}
{-                                              Eigenvector                 -}
{-                      ClosestVal  : real;     Converge to eigenvalue      -}
{-                                              Closest to this             -}
{-                      MaxIter     : integer;  Max. number of iterations   -}
{-                      Tolerance   : real;     Tolerance in answer         -}
{-                      Eigenvalue  : real;     Eigenvalue of the matrix    -}
{-                      Eigenvector : TNvector  Eigenvector of the matrix   -}
{-                      Iter        : integer;  Number of iterations        -}
{-                      Error       : byte;     Flags if something goes     -}
{-                                              wrong                       -}
{-             Errors:  0: No Errors                                        -}
{-                      1: Dimen < 2                                        -}
{-                      2: Tolerance <= 0                                   -}
{-                      3: MaxIter < 1                                      -}
{-                      4: Iter >= MaxIter                                  -}
{-                      5: eigenvalue/eigenvector not calculated            -}
{-                         See note below.                                  -}
{-                                                                          -}
{-               Note:  If the matrix Mat - EigenValue-I, where I           -}
{-                      is the identity matrix, is singular, then           -}
{-                      the inverse power method may not be used            -}
{-                      to approximate an eigenvalue and eigenvector        -}
{-                      of Mat and Error = 5 will be returned.              -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Wielandt(Dimen        : integer;
                   Mat          : TNmatrix;
               var GuessVector  : TNvector;
                   MaxEigens    : integer;
                   MaxIter      : integer;
                   Tolerance    : Float;
               var NumEigens    : integer;
               var Eigenvalues  : TNvector;
               var Eigenvectors : TNmatrix;
               var Iter         : TNIntVector;
               var Error        : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-        Input: Dimen, Mat, GuessVector, MaxEigens, MaxIter, Tolerance     -}
{-       Output: NumEigens, Eigenvalues, Eigenvectors, Iter, Error          -}
{-                                                                          -}
{-            Purpose:  This procedure attempts to approximate some (or     -}
{-                      all, depending on MaxEigens)  of the                -}
{-                      eigenvectors and eigenvalues of a matrix.  The      -}
{-                      power method is used in conjunction with Wielandt's -}
{-                      deflation.                                          -}
{-                                                                          -}
{- User-defined Types:  TNvector = array[1..RowSize] of real;               -}
{-                      TNmatrix = array[1..ColumnSize] of TNvector;        -}
{-                      TNIntVector = array[1..RowSize] of integer;         -}
{-                                                                          -}
{-   Global Variables:  Dimen        : integer;  Dimension of the matrix    -}
{-                      Mat          : TNmatrix; The matrix                 -}
{-                      GuessVector  : TNvector; An initial guess of an     -}
{-                                               eigenvector                -}
{-                      MaxEigens    : integer;  Maximum number of eigens   -}
{-                                               to find                    -}
{-                      MaxIter      : integer;  Max. number of iterations  -}
{-                      Tolerance    : real;     Tolerance in answer        -}
{-                      NumEigens    : integer;  Number of eigenvalues      -}
{-                                               calculated                 -}
{-                      Eigenvalues  : TNvector; Eigenvalues of the matrix  -}
{-                      Eigenvectors : TNmatrix  Eigenvectors of the matrix -}
{-                      Iter         : TNInTVector; Number of iterations    -}
{-                      Error        : byte;     Flags if something goes    -}
{-                                               wrong                      -}
{-             Errors:  0: No Errors                                        -}
{-                      1: Dimen < 2                                        -}
{-                      2: Tolerance <= 0                                   -}
{-                      3: MaxIter < 1                                      -}
{-                      4: MaxEigens < 1                                    -}
{-                      5: Iter >= MaxIter                                  -}
{-                      6: Last two roots aren't real                       -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Jacobi(Dimen        : integer;
                 Mat          : TNmatrix;
                 MaxIter      : integer;
                 Tolerance    : Float;
             var Eigenvalues  : TNvector;
             var Eigenvectors : TNmatrix;
             var Iter         : integer;
             var Error        : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Input: Dimen, Mat, MaxIter, Tolerance                                -}
{-    Output: Eigenvalues, Eigenvector, Iter, Error                         -}
{-                                                                          -}
{-   Purpose: The eigensystem of a symmetric matrix can be                  -}
{-            computed much more simply than the                            -}
{-            eigensystem of an arbitrary matrix.  The                      -}
{-            cyclic Jacobi method is an iterative                          -}
{-            technique for approximating the complete                      -}
{-            eigensystem of a symmetric matrix to a given                  -}
{-            tolerance. The method consists of multiplying                 -}
{-            the matrix, Mat, by a series of rotation                      -}
{-            matrices, r@-[i].  The rotation matrices are                  -}
{-            chosen so that the elements of the upper                      -}
{-            triangular part of Mat are systematically                     -}
{-            annihilated.  That is, r@-[1] is chosen so                    -}
{-            that Mat[1, 1] is identically zero; r@-[2] is                 -}
{-            chosen so that Mat[1, 2] is identically zero;                 -}
{-            etc.  Since each operation will probably                      -}
{-            change the value of elements annihilated in                   -}
{-            previous operations, the method is iterative.                 -}
{-            Eventually, the matrix will be diagonal. The                  -}
{-            eigenvalues will be the elements along the                    -}
{-            diagonal of the matrix and the eigenvectors                   -}
{-            will be the rows of the matrix created by the                 -}
{-            product of all the rotation matrices r@-[i].                  -}
{-                                                                          -}
{-            The user inputs the matrix, tolerance and maximum             -}
{-            number of iterations. The procedure returns the               -}
{-            eigenvalues and eigenvectors (or error code) of the           -}
{-            matrix.                                                       -}
{-                                                                          -}
{-   User-Defined Types: TNvector = array[1..TNArraySize] of real;          -}
{-                       TNmatrix = array[1..TNArraySize] of TNvector;      -}
{-                                                                          -}
{-   Global Variables:  Dimen        : integer   Dimension of square matrix -}
{-                      Mat          : TNmatrix  Square matrix              -}
{-                      MaxIter      : integer   Maximum number of          -}
{-                                               Iterations                 -}
{-                      Tolerance    : real      Tolerance in answer        -}
{-                      Eigenvalues  : TNvector  Eigenvalues of Mat         -}
{-                      Eigenvectors : TNmatrix  Eigenvectors of Mat        -}
{-                      Iter         : integer   Number of iterations       -}
{-                      Error        : byte      Error code                 -}
{-                                                                          -}
{-             Errors:  0: No error                                         -}
{-                      1: Dimen < 1                                        -}
{-                      2: Tolerance < TNNearlyZero                         -}
{-                      3: MaxIter < 1                                      -}
{-                      4: Mat not symmetric                                -}
{-                      5: Iter > MaxIter                                   -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

{$I Eigen1.inc}   { Include procedure code }

{$I Eigen2.inc}

end. { EigenVal }
