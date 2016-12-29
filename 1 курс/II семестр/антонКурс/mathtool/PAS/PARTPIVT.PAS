program Partial_Pivoting_Prog;

{--------------------------------------------------------------------------}
{-                                                                        -}
{-     Turbo Pascal Numerical Methods Toolbox                             -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.              -}
{-                                                                        -}
{-       Purpose : This program demonstrates how to solve a system of     -}
{-                 linear equations with Gaussian elimination and partial -}
{-                 pivoting.                                              -}
{-                                                                        -}
{-       Unit    : Matrix    procedure Partial_Pivoting                   -}
{-                                                                        -}
{--------------------------------------------------------------------------}

{$R+}                  { Enable range checking }
{$I-}                  { Disable I/O checking }

uses
  Matrix, Dos, Crt, Common;

var
  Dimen : integer;          { Dimen of the square matrix }
  Coefficients : TNmatrix;  { The matrix }
  Constants : TNvector;     { Constant terms in the equations }
  Solution : TNvector;      { Solution to the set of equations }
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
                  var Constants    : TNvector);

{-----------------------------------------------------------}
{- Output: Dimen, Coefficients, Constants                  -}
{-                                                         -}
{- This procedure sets the value of Dimen, Coefficients    -}
{- and Constants from either keyboard input or file input. -}
{-----------------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen        : integer;
                              var Coefficients : TNmatrix;
                              var Constants    : TNvector);

{--------------------------------------------------}
{- Output: Dimen, Coefficients, Constants         -}
{-                                                -}
{- This procedure sets the value of Dimen,        -}
{- Coefficients and Constants from keyboard input -}
{--------------------------------------------------}

var
  Row, Column : integer;

begin
  Writeln;
  repeat
    Write('Dimension of the coefficient matrix (1-', TNArraySize,')? ');
    Readln(Dimen);
    IOCheck;
  until (not IOerr) and (Dimen >= 1) and (Dimen <= TNArraySize);
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

{--------------------------------------------------}
{- Output: Dimen, Coefficients, Constants         -}
{-                                                -}
{- This procedure sets the value of Dimen,        -}
{- Coefficients and Constants from file input     -}
{--------------------------------------------------}

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
    if not IOerr then
    begin
      Row := 0;
      while (not IOerr) and (Row < Dimen) do
      begin
        Row := Succ(Row);
        Read(InFile, Constants[Row]);
        IOCheck;
      end;
    end;
  until not IOerr;
  Close(InFile);
end; { procedure GetDataFromFile }

begin { procedure GetData }
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Coefficients, Constants);
    'F' : GetDataFromFile(Dimen, Coefficients, Constants);
  end;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(Dimen        : integer;
              var Coefficients : TNmatrix;
              var Constants    : TNvector;
              var Solution     : TNvector;
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
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, 'The solution:');
          for Row := 1 to Dimen do
            Writeln(OutFile, Solution[Row]);
          Writeln(OutFile);
        end;

    1 : Writeln(OutFile, 'The dimension of the matrix must be greater than 1.');

    2 : Writeln(OutFile, 'There is no solution to this set of equations.');

  end; { case }
end; { procedure Results }

begin { program Partial_Pivoting }
  ClrScr;
  Initial(Dimen, Coefficients, Constants);
  GetData(Dimen, Coefficients, Constants);
  Partial_Pivoting(Dimen, Coefficients, Constants, Solution, Error);
  Results(Dimen, Coefficients, Constants, Solution, Error);
  Close(OutFile);
end. { program Partial_Pivoting }