program Power_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose : to demonstrate procedure Power for approximating the     -}
{-                 dominant eigenvalue and eigenvector of a matrix.         -}
{-                                                                          -}
{-       Unit    : EigenVal    procedure Power                              -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$R+}    { Enable range checking }
{$I-}    { Disable I/O checking }

uses
  EigenVal, Dos, Crt, Common;

var
  Dimen : integer;          { Size of the square matrix }
  Mat : TNmatrix;           { The matrix }
  MaxIter : integer;        { Maximum number iterations allowed }
  Tolerance : Float;        { Tolerance }
  GuessVector : TNvector;   { Initial GuessVector of an eigenvector }
  Eigenvector : TNvector;   { Eigenvector of the matrix }
  Eigenvalue : Float;       { Associated eigenvector }
  Iter : integer;           { Number of iterations }
  Error : byte;             { Flags if something went wrong }

procedure GetData(var Dimen       : integer;
                  var Mat         : TNmatrix;
                  var Tolerance   : Float;
                  var MaxIter     : integer;
                  var GuessVector : TNvector);

{-------------------------------------------------}
{- Output: Dimen, Mat, Tolerance, MaxIter,       -}
{-         GuessVector                           -}
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
        Write('Matrix[',Row,', ',Column,']: ');
        Readln(Mat[Row, Column]);
        IOCheck;
      until not IOerr;
  Writeln;
  Writeln('Now input an initial guess of an eigenvector:');
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

begin { procedure GetData }
  FillChar(Mat, SizeOf(Mat), 0);
  FillChar(GuessVector, SizeOf(GuessVector), 0);
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Mat, GuessVector);
    'F' : GetDataFromFile(Dimen, Mat, GuessVector);
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
  MaxIter := 100;
  repeat
    Write('Maximum number of iterations (> 0): ');
    ReadInt(MaxIter);
    IOCheck;
    if MaxIter <= 0 then
    begin
      IOerr := true;
      MaxIter := 100;
    end;
  until not IOerr;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(Dimen       : integer;
              var Mat         : TNmatrix;
                  Tolerance   : Float;
                  MaxIter     : integer;
              var Eigenvector : TNvector;
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
  Writeln(OutFile, 'Tolerance: ' : 30, Tolerance);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error = 4 then
    DisplayWarning;
  if Error in [1, 2, 3] then
    DisplayError;
  case Error of
    1 : Writeln(OutFile,
                'The dimension of the matrix must be greater than 1.');

    2 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    3 : Writeln(OutFile,
                'The maximum number of iterations must be greater than zero.');

    4 : begin
          Writeln(OutFile, 'Convergence did not occur after ',
                             Iter, ' iterations.');
          Writeln(OutFile);
          Writeln(OutFile, 'The results of the last iteration:');
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
end; { procedure Results }

begin { program Power }
  ClrScr;
  GetData(Dimen, Mat, Tolerance, MaxIter, GuessVector);
  Power(Dimen, Mat, GuessVector, MaxIter, Tolerance, Eigenvalue,
        Eigenvector, Iter, Error);
  Results(Dimen, Mat, Tolerance, MaxIter, Eigenvector, Eigenvalue, Iter, Error);
  Close(OutFile);
end. { program Power }