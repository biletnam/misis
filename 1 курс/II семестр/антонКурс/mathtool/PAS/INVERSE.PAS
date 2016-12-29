program Inverse_Prog;

{--------------------------------------------------------------------------}
{-                                                                        -}
{-     Turbo Pascal Numerical Methods Toolbox                             -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.              -}
{-                                                                        -}
{-       Purpose : To demonstrate procedure Inverse, which computes       -}
{-                 the inverse of a square matrix.                        -}
{-                                                                        -}
{-       Unit    : Matrix    procedure Inverse                            -}
{-                                                                        -}
{--------------------------------------------------------------------------}

{$R+}    { Enable range checking }
{$I-}    { Disable I/O checking }

uses
  Matrix, Dos, Crt, Common;

var
  Dimen : integer;     { Size of the square matrix }
  Data : TNmatrix;     { The matrix }
  Inv : TNmatrix;      { The inverse of Data }
  Error : byte;        { Flags if something went wrong }

procedure Initial(var Dimen : integer;
                  var Data  : TNmatrix);

{----------------------------------------------------------}
{- Output: Dimen, Data                                    -}
{-                                                        -}
{- This procedure intializes the above variables to zero. -}
{----------------------------------------------------------}

begin
  Dimen := 0;
  FillChar(Data, SizeOf(Data), 0);
end; { procedure Initial }

procedure GetData(var Dimen : integer;
                  var Data  : TNmatrix);

{---------------------------------------------------}
{- Output: Dimen, Data                             -}
{-                                                 -}
{- This procedure sets the value of Dimen and Data -}
{- from either keyboard input or file input        -}
{---------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen : integer;
                              var Data  : TNmatrix);

{--------------------------------------}
{- Output: Dimen, Data                -}
{-                                    -}
{- This procedure sets the value of   -}
{- Dimen and Data from keyboard input -}
{--------------------------------------}

var
  Row, Column : integer;

begin
  Writeln;
  repeat
    Write('Dimension of the square matrix (1-', TNArraySize,')? ');
    Readln(Dimen);
    IOCheck;
  until (not IOerr) and (Dimen >= 1) and (Dimen <= TNArraySize);
  Writeln;
  for Row := 1 to Dimen do
    for Column := 1 to Dimen do
      repeat
        Write('Matrix[', Row, ', ', Column, ']: ');
        Readln(Data[Row, Column]);
        IOCheck;
      until not IOerr;
end; { procedure GetDataFromKeyboard }

procedure GetDataFromFile(var Dimen : integer;
                          var Data  : TNmatrix);

{--------------------------------------}
{- Output: Dimen, Data                -}
{-                                    -}
{- This procedure sets the value of   -}
{- Dimen and Data from file input     -}
{--------------------------------------}

var
  FileName : string[255];
  InFile : text;
  Row, Column : integer;

begin
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
        Read(InFile, Data[Row, Column]);
        IOCheck;
      end;
    end;
  until not IOerr;
  Close(InFile);
end; { procedure GetDataFromFile }

begin { procedure GetData }
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Data);
    'F' : GetDataFromFile(Dimen, Data);
  end;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(Dimen : integer;
              var Data  : TNmatrix;
              var Inv   : TNmatrix;
                  Error : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Column, Row : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'The matrix: ');
  for Row := 1 to Dimen do
  begin
    for Column := 1 to Dimen do
      Write(OutFile, Data[Row, Column]:18:9);
    Writeln(OutFile);
  end;
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, 'Inverse:');
          for Row := 1 to Dimen do
          begin
            for Column := 1 to Dimen do
              Write(OutFile, Inv[Row, Column]:18:9);
            Writeln(OutFile);
          end;
        end;

    1 : Writeln(OutFile,
                'The dimension of the matrix must be greater than 0.');

    2 : Writeln(OutFile, 'This is a singular matrix.');

  end; { case }
end; { procedure Results }

begin { program Inverse }
  ClrScr;
  Initial(Dimen, Data);
  GetData(Dimen, Data);
  Inverse(Dimen, Data, Inv, Error);
  Results(Dimen, Data, Inv, Error);
  Close(OutFile);
end. { program Inverse }