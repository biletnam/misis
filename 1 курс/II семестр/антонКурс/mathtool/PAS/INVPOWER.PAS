program InversePower_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose : to demonstrate the procedure InversePower for            -}
{-                 approximating an eigenvalue and eigenvector of a         -}
{-                 matrix.                                                  -}
{-                                                                          -}
{-       Unit    : EigenVal    procedure InversePower                       -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$R+}                  { Enable range checking }
{$I-}                  { Disable I/O checking }
{$M 45056, 0, 655360}  { Set MinStack:MinHeap:MaxHeap }

uses
  EigenVal, Dos, Crt, Common;

var
  Dimen : integer;          { Size of the square matrix }
  Mat : TNmatrix;           { The matrix }
  MaxIter : integer;        { Maximum # iterations allowed }
  Tolerance : Float;        { Tolerance }
  GuessVector : TNvector;   { Initial guess of an eigenvector }
  ClosestVal : Float;       { Initial approximation of the eigenvalues. }
                            { The algorithm will converge to the        }
                            { eigenvalue closest to ClosestVal          }
  Eigenvector : TNvector;   { Eigenvector of the matrix }
  Eigenvalue : Float;       { Associated eigenvector }
  Iter : integer;           { Number of iterations }
  Error : byte;             { Flags if something went wrong }

procedure GetData(var Dimen       : integer;
                  var Mat         : TNmatrix;
                  var ClosestVal  : Float;
                  var Tolerance   : Float;
                  var MaxIter     : integer;
                  var GuessVector : TNvector);

{-------------------------------------------------}
{- Output: Dimen, Mat, ClosestVal, Tolerance,    -}
{-         MaxIter, GuessVector                  -}
{-                                               -}
{- This procedure assigns values to the above    -}
{- variables from either keyboad or file input.  -}
{-------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen       : integer;
                              var Mat         : TNmatrix;
                              var GuessVector : TNvector);

{----------------------------------------------}
{- Output: Dimen, Mat, GuessVector            -}
{-                                            -}
{- This procedure assigns values to the above -}
{- variables from keyboard input.             -}
{----------------------------------------------}

var
  Row, Column : integer;

begin
  Writeln;
  repeat
    Write('Dimension of the matrix (1-', TNArraySize, ')? ');
    Readln(Dimen);
    IOCheck;
  until (not IOerr) and (Dimen >= 1) and (Dimen <= TNArraySize);
  Writeln;
  for Row := 1 to Dimen do
    for Column := 1 to Dimen do
    repeat
      Write('Matrix[', Row, ', ', Column, ']: ');
      Readln(Mat[Row, Column]);
      IOCheck;
    until not IOerr;
  Writeln;
  Writeln('Now input an initial guess for the eigenvector:');
  for Row := 1 to Dimen do
  repeat
    Write('Vector[', Row, ']: ');
    Readln(GuessVector[Row]);
    IOCheck;
  until not IOerr;
end; { procedure GetDataFromKeyboard }

procedure GetDataFromFile(var Dimen       : integer;
                          var Mat         : TNmatrix;
                          var GuessVector : TNvector);

{----------------------------------------------}
{- Output: Dimen, Mat, GuessVector            -}
{-                                            -}
{- This procedure assigns values to the above -}
{- variables from file input.                 -}
{----------------------------------------------}

var
  FileName : string[255];
  InFile : text;
  Row, Column : integer;

begin
  Writeln;
  repeat
    Writeln;
    repeat
      Write('File name? ');
      Readln(FileName);
      Assign(InFile,FileName);
      Reset(InFile);
      IOCheck;
    until not IOerr;
    Read(InFile, Dimen);
    IOCheck;
    Row := 0;
    while (not IOerr) and (Row < Dimen) do
    begin
      Row := Succ(Row);
      Column := 0;
      while (not IOerr) and (Column < Dimen) do
      begin
        Column := Succ(Column);
        Read(InFile, Mat[Row, Column]);
        IOCheck;
      end;
    end;
    Row := 0;
    while (not IOerr) and (Row < Dimen) do
    begin
      Row := Succ(Row);
      Read(InFile, GuessVector[Row]);
      IOCheck;
    end;
  until not IOerr;
  Close(InFile);
end; { procedure GetDataFromFile }


procedure GetClosestVal(Dimen       : integer;
                    var Mat         : TNmatrix;
                    var GuessVector : TNvector;
                    var ClosestVal  : Float);

{-------------------------------------------------------------}
{- Input: Dimen, Mat, GuessVector                            -}
{- Output: ClosestVal                                        -}
{-                                                           -}
{- ClosestVal is the user's approximation of the eigenvalue. -}
{- This procedure makes an estimate of the eigenvalue based  -}
{- based on the initial approximation to the eigenvalue      -}
{- (GuessVector) and the matrix (Mat).  The formula used in  -}
{- making this estimate is:                                  -}
{-                                                           -}
{-                (GuessVector - (Mat # GuessVector))        -}
{-   ClosestVal = ------------------------------------       -}
{-                    (GuessVector - GuessVector)            -}
{-                                                           -}
{- where - is a dot product and # is matrix multiplication.  -}
{- If the user wants to input a different value for          -}
{- ClosestVal, she may do so.                                -}
{-------------------------------------------------------------}

var
  Numerator, Denominator : Float;
  TempVector : TNvector;

procedure Mult_Mat_Vec(Dimen  : integer;
                   var Mat    : TNmatrix;
                   var Vec    : TNvector;
                   var Result : TNvector);

{-----------------------------------------}
{- Input: Dimen, Mat, Vec                -}
{- Output: Result                        -}
{-                                       -}
{- Multiply a square matrix and a vector -}
{-----------------------------------------}

var
  Row, Column : integer;
  Entry : Float;

begin
  for Row := 1 to Dimen do
  begin
    Entry := 0;
    for Column := 1 to Dimen do
      Entry := Entry + Mat[Row, Column] * Vec[Column];
    Result[Row] := Entry;
  end;
end; { procedure Mult_Mat_Vec }

procedure Dot_Product(Dimen      : integer;
                  var Vec1, Vec2 : TNvector;
                  var Result     : Float);

{--------------------------------------------}
{- Input: Dimen, Vec1, Vec2                 -}
{- Output: Result                           -}
{-                                          -}
{- Calculate the dot product of two vectors -}
{--------------------------------------------}

var
  Row : integer;

begin
  Result := 0;
  for Row := 1 to Dimen do
    Result := Result + Vec1[Row] * Vec2[Row];
end; { procedure Dot_Product }

begin { procedure GetClosestVal }
  Dot_Product(Dimen, GuessVector, GuessVector, Denominator);
  Mult_Mat_Vec(Dimen, Mat, GuessVector, TempVector);
  Dot_Product(Dimen, GuessVector, TempVector, Numerator);
  if Denominator <> 0 then
    ClosestVal := Numerator/Denominator
  else
    ClosestVal := 0;
  Writeln;
  repeat
    Write('Approximate eigenvalue: ');
    ReadFloat(ClosestVal);
    IOCheck;
  until not IOerr;
end; { procedure GetClosestVal }

procedure GetTolerance(var Tolerance : Float);

{-----------------------------------------------------------}
{- Output: Tolerance                                       -}
{-                                                         -}
{- This procedure reads in the Tolerance from the keyboard -}
{-----------------------------------------------------------}

begin
  Writeln;
  Tolerance := 1E-6;
  repeat
    Write('Tolerance (> 0): ');
    ReadFloat(Tolerance);
    IOCheck;
    if Tolerance <= 0 then
    begin
      IOerr := true;
      Tolerance := 1E-6;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIter(var MaxIter : integer);

{-------------------------------------------------}
{- Output: MaxIter                               -}
{-                                               -}
{- This procedure reads in the maximum number of -}
{- iterations from the keyboard                  -}
{-------------------------------------------------}

begin
  Writeln;
  MaxIter := 200;
  repeat
    Write('Maximum number of iterations (> 0): ');
    ReadInt(MaxIter);
    IOCheck;
    if MaxIter <= 0 then
    begin
      IOerr := true;
      MaxIter := 200;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure GetData }
  Dimen := 0;
  FillChar(Mat, SizeOf(Mat), 0);
  FillChar(GuessVector, SizeOf(GuessVector), 0);
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Mat, GuessVector);
    'F' : GetDataFromFile(Dimen, Mat, GuessVector);
  end;
  GetClosestVal(Dimen, Mat, GuessVector, ClosestVal);
  GetTolerance(Tolerance);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(Dimen       : integer;
              var Mat         : TNmatrix;
                  ClosestVal  : Float;
                  Tolerance   : Float;
                  MaxIter     : integer;
                  Eigenvector : TNvector;
                  Eigenvalue  : Float;
                  Iter        : integer;
                  Error       : byte);

{---------------------------------------------}
{- Output the results to the device OutFile. -}
{---------------------------------------------}

var
  Column, Row : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'The matrix: ');
  for Row := 1 to Dimen do
  begin
    for Column := 1 to Dimen do
      Write(OutFile, Mat[Row, Column]);
    Writeln(OutFile);
  end;
  Writeln(OutFile);
  Writeln(OutFile, 'Approximate eigenvalue: ' : 30, ClosestVal);
  Writeln(OutFile, 'Tolerance: ' : 30, Tolerance);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error = 4 then
    DisplayWarning;
  if Error in [1, 2, 3, 5] then
    DisplayError;
  case Error of
    1 : Writeln(OutFile,
                'The dimension of the matrix must be greater than zero.');

    2 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    3 : Writeln(OutFile,
                'Maximum number of iterations must be greater than zero.');

    4 : begin
          Writeln(OutFile, 'Convergence did not occur after ',
                            Iter, ' iterations.');
          Writeln(OutFile);
          Writeln(OutFile, 'The results of the last iteration:');
        end;

    5 : begin
          Writeln(OutFile, 'The inverse power method may not be able');
          Writeln(OutFile,
                  'to compute an eigenvalue/vector of this matrix.');
          Writeln(OutFile,
                  'Try inputing a different approximate eigenvalue.');
        end;
  end; { case }

  if Error in [0, 4] then
  begin
    Writeln(OutFile);
    Writeln(OutFile, 'Number of iterations: ' : 30, Iter : 3);
    Writeln(OutFile, ' The approximate eigenvector:');
    for Row := 1 to Dimen do
      Writeln(OutFile, Eigenvector[Row]);
    Writeln(OutFile);
    Writeln(OutFile, 'The associated eigenvalue: ': 30, Eigenvalue);
  end;
end;  {procedure Results}

begin { program InversePower }
  ClrScr;
  GetData(Dimen, Mat, ClosestVal, Tolerance, MaxIter, GuessVector);
  InversePower(Dimen, Mat, GuessVector, ClosestVal, MaxIter, Tolerance,
               Eigenvalue, Eigenvector, Iter, Error);
  Results(Dimen, Mat, ClosestVal, Tolerance, MaxIter,
          Eigenvector, Eigenvalue, Iter, Error);
  Close(OutFile);
end. { program InversePower }