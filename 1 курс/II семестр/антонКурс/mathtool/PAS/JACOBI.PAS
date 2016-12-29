program Jacobi_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose : to demonstrate procedure Jacobi for approximating        -}
{-                 all the eigenvalues of a matrix.                         -}
{-                                                                          -}
{-       Unit    : EigenVal    procedure Jacobi                             -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$R+}                  { Enable range checking }
{$I-}                  { Disable I/O checking }
{$M 24576, 0, 655360}  { Set MinStack:MinHeap:MaxHeap }

uses
  EigenVal, Dos, Crt, Common;

var
  Dimen : integer;          { Size of the square matrix }
  Mat : TNmatrix;           { The matrix }
  MaxIter : integer;        { Maximum number iterations allowed }
  Tolerance : Float;        { Tolerance }
  Eigenvectors : TNmatrix;  { Eigenvectors of the matrix }
  Eigenvalues : TNvector;   { Associated eigenvalues }
  Iter : integer;           { Number of iterations }
  Error : byte;             { Flags if something went wrong }

procedure GetData(var Dimen     : integer;
                  var Mat       : TNmatrix;
                  var Tolerance : Float;
                  var MaxIter   : integer);

{--------------------------------------------------------------}
{- Output: Dimen, Mat, Tolerance, MaxIter                     -}
{-                                                            -}
{- This procedure reads in the data.  The dimension and the   -}
{- matrix, Mat can be read in from either a file or the       -}
{- keyboard.  The Tolerance and MaxIter are read in from      -}
{- the keyboard.                                              -}
{--------------------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen : integer;
                              var Mat   : TNmatrix);


{-------------------------------------}
{- Output: Dimen, Mat                -}
{-                                   -}
{- This procedure reads in the above -}
{- variables from the keyboard.      -}
{-------------------------------------}

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
end; { procedure GetDataFromKeyboard }

procedure GetDataFromFile(var Dimen : integer;
                          var Mat   : TNmatrix);

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
      Assign(InFile, FileName);
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
  until not IOerr;
  Close(InFile);
end; { procedure GetDataFromFile }

begin { procedure GetData }
  Dimen := 0;
  FillChar(Mat, SizeOf(Mat), 0);
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Mat);
    'F' : GetDataFromFile(Dimen, Mat);
  end;
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
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(Dimen        : integer;
              var Mat          : TNmatrix;
                  Tolerance    : Float;
                  MaxIter      : integer;
              var Eigenvalues  : TNvector;
              var Eigenvectors : TNmatrix;
                  Iter         : integer;
                  Error        : byte);

{-----------------------}
{- Output the results! -}
{-----------------------}

var
  Index, Column, Row : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'The matrix: ');
  for Row := 1 to Dimen do
  begin
    for Column := 1 to Dimen do
      Write(OutFile, Mat[Row, Column]:13:9);
    Writeln(OutFile);
  end;
  Writeln(OutFile);
  Writeln(OutFile, 'Tolerance: ' : 31, Tolerance);
  Writeln(OutFile, 'Maximum number of iterations: ' : 31, MaxIter);
  Writeln(OutFile);
  if Error = 5 then
    DisplayWarning;
  if Error in [1, 2, 3, 4] then
    DisplayError;
  case Error of
    0 : Writeln(OutFile, 'Number of iterations: ' : 31, Iter : 3);

    1 : Writeln(OutFile, 'The matrix must be of dimension greater than 1.');

    2 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    3 : Writeln(OutFile,
                'Maximum number of iterations must be greater than zero.');

    4 : Writeln(OutFile, 'The matrix must be symmetric.');

    5 : begin
          Writeln(OutFile, 'Convergence did not occur after ',
                           Iter, 'iterations.');
          Writeln(OutFile, 'The results of the last iteration are:');
        end;
  end; { case }
  if Error in [0, 5] then
    for Index := 1 to Dimen do
    begin
      Writeln(OutFile);
      Writeln(OutFile, 'The approximate eigenvector:' : 30);
      for Row := 1 to Dimen do
        Writeln(OutFile, Eigenvectors[Index, Row]);
      Writeln(OutFile);
      Writeln(OutFile, 'The associated eigenvalue: ': 31, Eigenvalues[Index]);
    end;
end; { procedure Results }

begin { program Jacobi }
  ClrScr;
  GetData(Dimen, Mat, Tolerance, MaxIter);
  Jacobi(Dimen, Mat, MaxIter, Tolerance,
         Eigenvalues, Eigenvectors, Iter, Error);
  Results(Dimen, Mat, Tolerance, MaxIter,
          Eigenvalues, Eigenvectors, Iter, Error);
  Close(OutFile);
end. { program Jacobi }