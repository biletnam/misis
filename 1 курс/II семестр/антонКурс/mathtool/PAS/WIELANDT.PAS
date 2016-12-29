program Wielandt_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose : To demonstrate procedure Wielandt for approximating      -}
{-                 some (or all) of the eigenvalues and eigenvectors of     -}
{-                 of a matrix.                                             -}
{-                                                                          -}
{-       Unit    : EigenVal    procedure Wielandt                           -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$R+}    { Enable range checking }
{$I-}    { Disable I/O checking }
{$M 45056, 0, 655360} { Set MinStack:MinHeap:MaxHeap }

uses
  EigenVal, Dos, Crt, Common;

var
  Dimen : integer;          { Size of the square matrix }
  Mat : TNmatrix;           { The matrix }
  MaxEigens : integer;      { Maximum number eigens calculated }
  MaxIter : integer;        { Maximum number iterations allowed }
  Tolerance : Float;        { Tolerance }
  GuessVector : TNvector;   { Initial approximation of the eigenvector }
  NumEigens : integer;      { Number of eigenvalues found }
  Eigenvectors : TNmatrix;  { Eigenvectors of the matrix }
  Eigenvalues : TNvector;   { Associated eigenvalues }
  Iter : TNIntVector;       { Number of iterations }
  Error : byte;             { Flags if something went wrong }

procedure GetData(var Dimen       : integer;
                  var Mat         : TNmatrix;
                  var Tolerance   : Float;
                  var MaxEigens   : integer;
                  var MaxIter     : integer;
                  var GuessVector : TNvector);

{------------------------------------------------------------------}
{- Output: Dimen, Mat, Tolerance, MaxEigens, MaxIter, GuessVector -}
{-                                                                -}
{- This procedure reads in the data.  The dimension, the matrix,  -}
{- Mat, and the initial guess, GuessVector, can be read in from   -}
{- either a file or the keyboard.  The Tolerance, MaxEigens, and  -}
{- MaxIter are read in from the keyboard.                         -}
{------------------------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen       : integer;
                              var Mat         : TNmatrix;
                              var GuessVector : TNvector);

{-------------------------------------}
{- Output: Dimen, Mat, GuessVector   -}
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

{-------------------------------------}
{- Output: Dimen, Mat, GuessVector   -}
{-                                   -}
{- This procedure reads in the above -}
{- variables from the keyboard.      -}
{-------------------------------------}

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
  Dimen := 0;
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
  MaxEigens := Dimen;
  repeat
    Write('Maximum number of eigenvalues/eigenvectors to find (<= ', Dimen, '): ');
    ReadInt(MaxEigens);
    IOCheck;
    if (MaxEigens <= 0) or (MaxEigens > Dimen) then
    begin
      IOerr := true;
      MaxEigens := Dimen
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
                  MaxEigens    : integer;
                  MaxIter      : integer;
                  NumEigens    : integer;
              var Eigenvectors : TNmatrix;
              var Eigenvalues  : TNvector;
                  Iter         : TNIntVector;
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
      Write(OutFile, Mat[Row, Column]);
    Writeln(OutFile);
  end;
  Writeln(OutFile);
  Writeln(OutFile, 'Tolerance: ' : 30, Tolerance);
  Writeln(OutFile, 'Maximum number of eigenvalues/eigenvectors to find: ' :
                    30, MaxEigens);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error in [5, 6] then
    DisplayWarning;
  if Error in [1, 2, 3, 4] then
    DisplayError;
  case Error of
    1 : Writeln(OutFile, 'The matrix must be of order greater than 1.');

    2 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    3 : Writeln(OutFile,
                'Maximum number of iterations must be greater than zero.');

    4 : begin
          Writeln(OutFile,
                  'Maximum number of eigenvalues must be greater than zero');
          Writeln(OutFile, 'and less than the dimension of the matrix.');
        end;

    5 : begin
          Writeln(OutFile, 'Convergence did not occur after ',
                            Iter[NumEigens], ' iterations.');
          Writeln(OutFile);
          Writeln(OutFile, 'The results of the last iteration:');
        end;

    6 : Writeln(OutFile, 'The last two eigenvalues aren''t real.');
  end; { case }
  if Error in [0, 5, 6] then
  for Index := 1 to NumEigens do
  begin
    Writeln(OutFile);
    Writeln(OutFile);
    Writeln(OutFile, 'Number of iterations: ' : 30, Iter[Index] : 3);
    Writeln(OutFile, ' The approximate eigenvector:');
    for Row := 1 to Dimen do
      Writeln(OutFile, Eigenvectors[Index, Row]);
    Writeln(OutFile);
    Writeln(OutFile, 'The associated eigenvalue: ' : 30, Eigenvalues[Index]);
  end;
end; { procedure Results }

begin  { program Wielandt }
  ClrScr;
  GetData(Dimen, Mat, Tolerance, MaxEigens, MaxIter, GuessVector);
  Wielandt(Dimen, Mat, GuessVector, MaxEigens, MaxIter, Tolerance, NumEigens,
           Eigenvalues, Eigenvectors, Iter, Error);
  Results(Dimen, Mat, Tolerance, MaxEigens, MaxIter, NumEigens,
          Eigenvectors, Eigenvalues, Iter, Error);
  Close(OutFile);
end. { program Wielandt }