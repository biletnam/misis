program Gauss_Seidel_Prog;

{--------------------------------------------------------------------------}
{-                                                                        -}
{-     Turbo Pascal Numerical Methods Toolbox                             -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.              -}
{-                                                                        -}
{-       Purpose : This program demonstrates how to iteratively solve a   -}
{-                 system of linear equation with the Gauss Seidel        -}
{-                 iterative method.                                      -}
{-                                                                        -}
{-       Unit    : Matrix    procedure Gauss_Seidel                       -}
{-                                                                        -}
{--------------------------------------------------------------------------}

{$R+}                  { Enable range checking }
{$I-}                  { Disable I/O checking }
{$M 32768, 0, 655360}  { Set MinStack:MinHeap:MaxHeap }

uses
  Matrix, Dos, Crt, Common;

var
  Dimen : integer;          { Size of the square matrix }
  Coefficients : TNmatrix;  { The matrix }
  Constants : TNvector;     { Constant terms in the equations }
  MaxIter : integer;        { Maximum number of iterations allowed }
  Tol : Float;              { Tolerance }
  Solution : TNvector;      { Solution to the set of equations }
  Iter : integer;           { Number of iterations }
  Error : byte;             { Flags if something went wrong }

procedure Initial(var Dimen        : integer;
                  var Coefficients : TNmatrix;
                  var Constants    : TNvector);

{----------------------------------------------------------}
{- Output: Dimen, Coefficients, Constants                 -}
{-                                                        -}
{- This procedure intializes the above variables to zero. -}
{----------------------------------------------------------}

begin
  Dimen := 0;
  FillChar(Coefficients, SizeOf(Coefficients), 0);
  FillChar(Constants, SizeOf(Constants), 0);
end; { procedure Initial }

procedure GetData(var Dimen        : integer;
                  var Coefficients : TNmatrix;
                  var Constants    : TNvector;
                  var Tol          : Float;
                  var MaxIter      : integer);

{---------------------------------------------------------}
{- Output: Dimen, Coefficients, Constants, Tol, MaxIter  -}
{-                                                       -}
{- This procedure sets the value of Dimen, Coefficients, -}
{- and Constants from either keyboard or file input.     -}
{- Tol and MaxIter are read in from the keyboard.        -}
{---------------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen        : integer;
                              var Coefficients : TNmatrix;
                              var Constants    : TNvector);

{--------------------------------------}
{- Output: Dimen, Coefficients,       -}
{-         Constants                  -}
{-                                    -}
{- This procedure sets the value of   -}
{- Dimen, Coefficients and Constants  -}
{- from keyboard input                -}
{--------------------------------------}

var
  Row, Column : integer;

begin
  Writeln;
  repeat
    Write('Dimension of the coefficient matrix (1-', TNArraySize,')? ');
    Readln(Dimen);
    IOCheck;
  until not IOerr and (Dimen >= 1) and (Dimen <= TNArraySize);
  Writeln;
  for Row := 1 to Dimen do
    for Column := 1 to Dimen do
      repeat
        Write('Matrix[', Row, ', ', Column, ']: ');
        Readln(Coefficients[Row, Column]);
        IOCheck;
      until not IOerr;
  Writeln;
  Writeln('Now enter the constant terms:');
  for Row := 1 to Dimen do
  repeat
    Write('Vector[', Row, ']: ');
    Readln(Constants[Row]);
    IOCheck;
  until not IOerr;
end; { procedure GetDataFromKeyboard }

procedure GetDataFromFile(var Dimen        : integer;
                          var Coefficients : TNmatrix;
                          var Constants    : TNvector);

{--------------------------------------}
{- Dimen, Coefficients, Constants     -}
{-                                    -}
{- This procedure sets the value of   -}
{- Dimen, Coefficients and Constants  -}
{- from file input.                   -}
{--------------------------------------}

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
        Read(InFile, Coefficients[Row, Column]);
        IOCheck;
      end;
    end;
    Row := 0;
    while (not IOerr) and (Row < Dimen) do
    begin
      Row := Succ(Row);
      Read(InFile, Constants[Row]);
      IOCheck;
    end;
  until not IOerr;
  Close(InFile);
end; { procedure GetDataFromFile }

begin { procedure GetData }
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Coefficients, Constants);
    'F' : GetDataFromFile(Dimen, Coefficients, Constants);
  end;
  Writeln;
  repeat
    Tol := 1E-8;
    Write('Tolerance (> 0):');
    ReadFloat(Tol);
    IOCheck;
    if Tol <= 0 then
    begin
      IOerr := true;
      Tol := 1E-8;
    end;
  until not IOerr;
  Writeln;
  repeat
    MaxIter := 100;
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

procedure Results(Dimen        : integer;
              var Coefficients : TNmatrix;
              var Constants    : TNvector;
                  Tol          : Float;
                  MaxIter      : integer;
              var Solution     : TNvector;
                  Iter         : integer;
                  Error        : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Column, Row : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'The coefficients: ');
  for Row := 1 to Dimen do
  begin
    for Column := 1 to Dimen do
      Write(OutFile, Coefficients[Row, Column]:13:9);
    Writeln(OutFile);
  end;
  Writeln(OutFile);
  Writeln(OutFile, 'The constants:');
  for Row := 1 to Dimen do
    Writeln(OutFile, Constants[Row]);
  Writeln(OutFile);
  Writeln(OutFile, 'Tolerance: ' : 30, Tol);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error in [1, 2, 7] then
    DisplayWarning;
  if (Error >= 3) and (Error <> 7) then
    DisplayError;
  case Error of
    1 : begin
          Writeln(OutFile, 'The matrix is not diagonally dominant which');
          Writeln(OutFile, 'indicates that convergence may be impossible.');
          Writeln(OutFile, 'Convergence did not occur after ', Iter,
                           ' iterations.');
        end;

    2 : Writeln(OutFile, 'Convergence did not occur after ',
                          Iter, ' iterations.');

    3 : Writeln(OutFile, 'The dimension of the matrix must be greater than 1.');

    4 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    5 : Writeln(OutFile,
                'Maximum number of iterations must be greater than zero.');

    6 : begin
          Writeln(OutFile, 'The diagonal of the matrix contains a zero. The');
          Writeln(OutFile,
                  'Gauss-Seidel method may not be used to solve this system.');
        end;

    7 : begin
          Writeln(OutFile, 'The sequence is diverging. The Gauss-Seidel');
          Writeln(OutFile, 'may not be used to solve this system.');
        end;
  end; { case }
  if (Error <= 2) or (Error = 7) then
  begin
    Writeln(OutFile);
    Writeln(OutFile, 'Number of iterations: ' : 30, Iter : 3);
    Writeln(OutFile, 'The Result:');
    for Row := 1 to Dimen do
      Writeln(OutFile, Solution[Row]);
    Writeln(OutFile);
  end;
end; { procedure Results }

begin { program Gauss_Seidel }
  ClrScr;
  Initial(Dimen, Coefficients, Constants);
  GetData(Dimen, Coefficients, Constants, Tol, MaxIter);
  Gauss_Seidel(Dimen, Coefficients, Constants,
               Tol, MaxIter, Solution, Iter, Error);
  Results(Dimen, Coefficients, Constants, Tol, MaxIter, Solution, Iter, Error);
  Close(OutFile);
end. { program Gauss_Seidel }