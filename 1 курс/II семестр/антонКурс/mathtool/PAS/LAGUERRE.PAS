program Laguerre_Prog;

{---------------------------------------------------------------------------}
{-                                                                         -}
{-     Turbo Pascal Numerical Methods Toolbox                              -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.               -}
{-                                                                         -}
{-               Purpose: This program demonstrates Laguerre's method      -}
{-                                                                         -}
{-               Unit   : RootsEqu    procedure Laguerre                   -}
{-                                                                         -}
{---------------------------------------------------------------------------}

{$I-}                { Disable I/O error trapping }
{$R+}                { Enable range checking }

uses
  RootsEqu, Dos, Crt, Common;

var
  Guess : TNcomplex;                 { Initial approximation }
  InitDegree, Degree : integer;      { Degree of polynomial }
  InitPoly, Poly : TNCompVector;     { Coefficients of polynomial }
  Tol : Float;                       { Tolerance in answer }
  Iter : TNIntVector;                { Number of iterations to find each root }
  MaxIter : integer;                 { Max number of iterations allowed }
  NumRoots : integer;                { Number of roots found }
  Answer : TNCompVector;             { Roots }
  yAnswer : TNCompVector;            { Function evaluated at roots }
  Error : byte;                      { Flags an error }

procedure Initial(var Degree  : integer;
                  var Poly    : TNCompVector;
                  var Guess   : TNcomplex;
                  var Tol     : Float;
                  var MaxIter : integer);

{-----------------------------------------------------------}
{- Output: Degree, Poly, Guess, Tol, MaxIter               -}
{-                                                         -}
{- This procedure initializes the above variables to zero. -}
{-----------------------------------------------------------}

begin
  Degree := 0;
  FillChar(Poly, SizeOf(Poly), 0);
  FillChar(Guess, SizeOf(Guess), 0);
  Tol := 0;
  MaxIter := 0
end; { procedure Initial }

procedure UserInput(var Degree  : integer;
                    var Poly    : TNCompVector;
                    var Guess   : TNcomplex;
                    var Tol     : Float;
                    var MaxIter : integer);

{---------------------------------------------------------------}
{- Output: Degree, Poly, Guess, Tol, MaxIter                   -}
{-                                                             -}
{- This procedure assigns values to the above variables from   -}
{- keyboard input.  The Degree of the polynomial (Degree), the -}
{- coefficients of the polynomial (Poly), the initial guess    -}
{- (Guess), the tolerance (Tol), and the maximum number of     -}
{- iterations (MaxIter) are all read in here.                  -}
{---------------------------------------------------------------}

var
  Ch : char;

procedure GetCoefficientsFromKeyboard(var Degree : integer;
                                      var Poly   : TNCompVector);

{-------------------------------------------------}
{- Output: Degree, Poly                          -}
{-                                               -}
{- The Degree and coefficients of the polynomial -}
{- are read in from the keyboard.                -}
{-------------------------------------------------}

var
  Term : integer;
begin
  Writeln;
  repeat
    Write('Degree of the polynomial (<= ',TNArraySize,')? ');
    Readln(Degree);
    IOCheck;
  until (Degree > 1) and (Degree <= TNArraySize) and not IOerr;
  Writeln;
  Writeln('Input the complex coefficients of the polynomial');
  Writeln('where Poly[n] is the coefficients of x^n');
  Writeln;
  for Term := Degree downto 0 do
  begin
    repeat
      Write('Re(Poly[',Term,']) = ');
      Readln(Poly[Term].Re);
      IOCheck;
    until not IOerr;
    repeat
      Write('Im(Poly[',Term,']) = ');
      Readln(Poly[Term].Im);
      IOCheck;
    until not IOerr;
    Writeln;
  end;
end; { procedure GetCoefficientsFromKeyboard }

procedure GetCoefficientsFromFile(var Degree : integer;
                                  var Poly   : TNCompVector);

{------------------------------------------------------}
{- Output: Degree, Poly                               -}
{-                                                    -}
{- This procedure reads in values for Degree and Poly -}
{- from a text file.                                  -}
{------------------------------------------------------}

var
  Term : integer;
  InFile : text;
  FileName : string[255];

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
     Degree := 0;
     Read(InFile, Degree);
     IOCheck;
     if not(Degree in [0..TNArraySize]) and not IOerr then
       Writeln('Degree too big');
     Term := Degree;
     while (not IOerr) and (Term >= 0) do
     begin
       Read(InFile, Poly[Term].Re);
       Read(InFile, Poly[Term].Im);
       IOCheck;
       Term := Pred(Term);
     end;
   until not IOerr;
   Close(InFile);
 end; { procedure GetCoefficientsFromFile }

procedure GetInitialGuess(var Guess : TNcomplex);
begin
  Writeln;
  Writeln('Initial approximation to the root: ');
  repeat
    Write('Re(Approximation) = ');
    Readln(Guess.Re);
    IOCheck;
  until not IOerr;
  repeat
    Write('Im(Approximation) = ');
    Readln(Guess.Im);
    IOCheck;
  until not IOerr;
end; { procedure GetInitialGuess }

procedure GetTolerance(var Tol : Float);
begin
  Writeln;
  repeat
    Tol := 1E-8;
    Write('Tolerance (> 0): ');
    ReadFloat(Tol);
    IOCheck;
    if Tol <= 0 then
    begin
      IOerr := true;
      Tol := 1E-8;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIter(var MaxIter : integer);
begin
  Writeln;
  repeat
    MaxIter := 100;
    Write('Maximum number of iterations (> 0): ');
    ReadInt(MaxIter);
    IOCheck;
    if MaxIter < 0 then
    begin
      IOerr := true;
      MaxIter := 100;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure UserInput }
  case InputChannel('Input Data From') of
    'K' : GetCoefficientsFromKeyboard(Degree, Poly);
    'F' : GetCoefficientsFromFile(Degree, Poly);
  end;
  GetInitialGuess(Guess);
  GetTolerance(Tol);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure UserInput }

procedure Results(InitDegree : integer;
                  InitPoly   : TNCompVector;
                  Degree     : integer;
                  Poly       : TNCompVector;
                  Guess      : TNcomplex;
                  Answer     : TNCompVector;
                  yAnswer    : TNCompVector;
                  Tol        : Float;
                  Iter       : TNIntVector;
                  Error      : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Term : integer;

begin
  Writeln(OutFile, 'Initial polynomial:');
  Writeln(OutFile);
  for Term := InitDegree downto 0 do
    Writeln(OutFile, 'InitPoly[',Term,']:',
  InitPoly[Term].Re, ' +', InitPoly[Term].Im,'i');
  Writeln(OutFile);
  Writeln(OutFile);
  Write(OutFile,'Initial approximation: ' : 30);
  Writeln(OutFile,Guess.Re, ' +',Guess.Im,'i');
  Writeln(OutFile,'Tolerance: ' : 30, Tol);
  Writeln(OutFile,'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error = 1 then
    DisplayWarning;
  if Error >= 2 then
    DisplayError;

  case Error of
    1 : Writeln(OutFile,'This will take more than ', MaxIter,' iterations.');

    2 : Writeln(OutFile,
                'The degree of the polynomial must be greater than zero.');

    3 : Writeln(OutFile,'The tolerance must be greater than zero.');

    4 : Writeln(OutFile,
                'The maximum number of iterations must be greater than zero.');

  end; { case }
  Writeln(OutFile);
  if Degree > 0 then
  begin
    Writeln(OutFile,'The deflated polynomial:');
    for Term := Degree downto 0 do
      Writeln(OutFile, 'Poly[',Term,']:',
                        Poly[Term].Re, ' +', Poly[Term].Im,'i');
  end;

  if Error <= 1 then
    for Term := 1 to NumRoots do
    begin
      Writeln(OutFile);
      Writeln(OutFile, 'Root ', Term);
      Writeln(OutFile, 'Number of iterations: ':25, Iter[Term] : 3);
      Write(OutFile,'Calculated root: ':25);
      Writeln(OutFile, Answer[Term].Re, ' +', Answer[Term].Im, 'i');
      Writeln(OutFile,'Value of the function at');
      Write(Outfile,'the calculated root: ':25);
      Writeln(OutFile, yAnswer[Term].Re, ' +', yAnswer[Term].Im, 'i');
    end;
end; { procedure Results }

begin { program Laguerre }
  ClrScr;
  Initial(InitDegree, InitPoly, Guess, Tol, MaxIter);
  UserInput(InitDegree, InitPoly, Guess, Tol, MaxIter);
  Degree := InitDegree;
  Poly := InitPoly;
  Laguerre(Degree, Poly, Guess, Tol, MaxIter,
           NumRoots, Answer, yAnswer, Iter, Error);
  Results(InitDegree, InitPoly, Degree, Poly, Guess,
          Answer, yAnswer, Tol, Iter, Error);
  Close(OutFile);
end. { program Laguerre }
