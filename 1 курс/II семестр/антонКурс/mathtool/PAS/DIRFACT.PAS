program Direct_Factorization_Prog;

{--------------------------------------------------------------------------}
{-                                                                        -}
{-     Turbo Pascal Numerical Methods Toolbox                             -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.              -}
{-                                                                        -}
{-       Purpose : This program demonstrates how to solve a system of     -}
{-                 linear equations with direct factorization (LU         -}
{-                 decomposition).                                        -}
{-                                                                        -}
{-       Unit    : Matrix    procedure LU_Decompose                       -}
{-                           procedure LU_Solve                           -}
{-                                                                        -}
{--------------------------------------------------------------------------}

{$R+}                  { Enable range checking }
{$I-}                  { Disable I/O checking }
{$M 32768, 0, 655360}

uses
  Matrix, Dos, Crt, Common;

type
  Ptr = ^StackItem;

  QueueItem = record
                Front, Back : Ptr;
              end;

  StackItem = record
                Info : TNvector;
                Next : Ptr;
              end;


var
  Dimen : integer;          { Size of the square matrix }
  Coefficients : TNmatrix;  { The matrix }
  Queue : QueueItem;        { Pointer to Queue of constant vectors }
  Decomp : TNmatrix;        { LU decompostion of Coefficients matrix }
  Permute : TNmatrix;       { Permutation matrix from partial pivoting }
  Solution : TNvector;      { Solution to the set of equations }
  Error : byte;             { Flags if something went wrong }

procedure InitializeStack(var Queue : QueueItem);

begin
  Queue.Front := nil;
  Queue.Back := nil;
end; { procedure InitializeStack }

procedure InsertQueue(Data  : TNvector;
                  var Queue : QueueItem);

{--------------------------------}
{- Input: Data, Queue           -}
{- Output: Queue                -}
{-                              -}
{- Insert Data onto the Queue   -}
{--------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.Info := Data;
  NewNode^.Next := nil;
  if Queue.Back = nil then
    Queue.Front := NewNode
  else
    Queue.Back^.Next := NewNode;
  Queue.Back := NewNode;
end; { procedure InsertQueue }

procedure RemoveQueue(var Data  : TNvector;
                      var Queue : QueueItem);

{---------------------------------}
{- Input: Queue                  -}
{- Output: Data, Queue           -}
{-                               -}
{- Remove Data from the Queue    -}
{---------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Queue.Front;
  Queue.Front := OldNode^.Next;
  Data := OldNode^.Info;
  Dispose(OldNode);
end; { procedure RemoveQueue }


procedure Initial(var Dimen        : integer;
                  var Coefficients : TNmatrix;
                  var Queue        : QueueItem);

{----------------------------------------------------------}
{- Output: Dimen, Coefficients, Queue                     -}
{-                                                        -}
{- This procedure intializes the above variables to zero. -}
{----------------------------------------------------------}

begin
  Dimen := 0;
  FillChar(Coefficients, SizeOf(Coefficients), 0);
  InitializeStack(Queue);
end; { procedure Initial }

procedure GetData(var Dimen        : integer;
                  var Coefficients : TNmatrix;
                  var Queue        : QueueItem);

{-----------------------------------------------------------}
{- Output: Dimen, Coefficients, Queue                      -}
{-                                                         -}
{- This procedure sets the value of Dimen and Coefficients -}
{- keyboard input or file input. This procedure also sets  -}
{- the Queue pointer, Queue, so that it points to a Queue  -}
{- of constant vectors.                                    -}
{-----------------------------------------------------------}

var
  Ch : char;

procedure GetDataFromKeyboard(var Dimen        : integer;
                              var Coefficients : TNmatrix;
                              var Queue        : QueueItem);

{----------------------------------------------------}
{- Output: Dimen, Coefficients, Queue               -}
{-                                                  -}
{- This procedure sets the value of Dimen,          -}
{- Coefficients, and the Queue from keyboard input. -}
{----------------------------------------------------}

var
  Row, Column : integer;
  Constants : TNvector;
  Done : boolean;
  Ch : char;

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
  Done := false;
  while not Done do
  begin
    Writeln;
    Writeln('Elements of the constant vector: ');
    for Row := 1 to Dimen do
      repeat
        Write('Vector[', Row, ']: ');
        Readln(Constants[Row]);
        IOCheck;
      until not IOerr;
    InsertQueue(Constants, Queue);
    Writeln;
    Write('Another constant vector (Y/N)? ');
    repeat
      Ch := ReadKey;
      Ch := UpCase(Ch);
    until Ch in ['Y', 'N'];
    Writeln(Ch);
    if Ch = 'N' then
      Done := true;
  end; { while }
end; { procedure GetDataFromKeyboard }

procedure GetDataFromFile(var Dimen        : integer;
                          var Coefficients : TNmatrix;
                          var Queue        : QueueItem);

{--------------------------------------------------}
{- Output: Dimen, Coefficients, Queue             -}
{-                                                -}
{- This procedure sets the value of Dimen,        -}
{- Coefficients and the Queue from file input.    -}
{--------------------------------------------------}

var
  FileName    : string[255];
  Constants   : TNvector;
  InFile      : text;
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
    while (not EOF(InFile)) and (not IOerr) do
    begin
      Row := 0;
      while (not IOerr) and (Row < Dimen) do
      begin
        Row := Succ(Row);
        Readln(InFile, Constants[Row]);
        IOCheck;
      end;
      if not IOerr then
        InsertQueue(Constants, Queue);
    end;
  until not IOerr;
  Close(InFile);
end; { procedure GetDataFromFile }

begin { procedure GetData }
  case InputChannel('Input Data From') of
    'K' : GetDataFromKeyboard(Dimen, Coefficients, Queue);
    'F' : GetDataFromFile(Dimen, Coefficients, Queue);
  end;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure PrintCoefMatrix(Dimen        : integer;
                      var Coefficients : TNmatrix;
                          Error        : byte);

{------------------------------------------------------------}
{- Input: Dimen, Coefficients, Error                        -}
{-                                                          -}
{- This procedure prints the coefficients matrix to         -}
{- the device OutFile.                                      -}
{------------------------------------------------------------}

var
  Column, Row : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile, 'The coefficients: ');
  for Row := 1 to Dimen do
  begin
    for Column := 1 to Dimen do
      Write(OutFile, Coefficients[Row, Column]:13:9);
    Writeln(OutFile);
  end;
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

  case Error of
    1 : Writeln(OutFile, 'The dimension of the matrix must be greater than 0.');

    2 : Writeln(OutFile, 'There is no solution to this set of equations.');

  end; { case }
end; { PrintCoefMatrix }

procedure Results(Dimen     : integer;
              var Constants : TNvector;
              var Solution  : TNvector;
                  Error     : byte);

{------------------------------------------------------------}
{- Input: Dimen, Constants, Solution, Error                 -}
{-                                                          -}
{- This procedure outputs the solution to the system of     -}
{- equations with the constant terms contained in the       -}
{- vector Constants.                                        -}
{------------------------------------------------------------}

var
  Row : integer;

begin
  Writeln(OutFile);
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
        end;

    1 : Writeln(OutFile, 'The dimension of the matrix must be greater than 0.');
  end; { case }
end; { procedure Results }

procedure FindSolutions(Dimen   : integer;
                    var Decomp  : TNmatrix;
                    var Permute : TNmatrix;
                        Queue   : QueueItem);

{--------------------------------------------------------------}
{- Input: Dimen, Decomp, Permute, Queue                       -}
{-                                                            -}
{- This procedure solves each of the system of equations      -}
{- represented by the Constants vectors stored on the Queue.  -}
{- It pulls each Constants vector off the Queue and sends it  -}
{- to the procedure LU_Solve where backwards and forwards     -}
{- substitution is used to solve the matrix equation.  Each   -}
{- of the Solutions returned from this procedure are output   -}
{- in the procedure Results.                                  -}
{--------------------------------------------------------------}

var
  Constants : TNvector;

begin
  while Queue.Front <> nil do
  begin
    RemoveQueue(Constants, Queue);
    LU_Solve(Dimen, Decomp, Constants, Permute, Solution, Error);
    Results(Dimen, Constants, Solution, Error);
  end;
end; { procedure FindSolutions }

begin { program Direct_Factorization }
  ClrScr;
  Initial(Dimen, Coefficients, Queue);
  GetData(Dimen, Coefficients, Queue);
  LU_Decompose(Dimen, Coefficients, Decomp, Permute, Error);
  PrintCoefMatrix(Dimen, Coefficients, Error);
  if Error = 0 then
    FindSolutions(Dimen, Decomp, Permute, Queue);
  Close(OutFile);
end. { program Direct_Factorization }