program Newt_Horn_Defl_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-        Purpose: This sample program demonstrates the                     -}
{-                 Newton-Horner algorithm and deflation techniques.        -}
{-                                                                          -}
{-        Unit   : RootsEqu    procedure Newt_Horn_Defl                     -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}               { disable I/O error trapping }
{$R+}               { enable range checking }

uses
  RootsEqu, Dos, Crt, Common;

var
  InitGuess                : Float;       { initial approximation }
  Tolerance                : Float;       { tolerance of approximation }
  Root, Imag, Value, Deriv : TNvector;    { resulting roots and other info }
  Iter                     : TNIntVector; { number of iterations to find each root }
  MaxIter                  : integer;     { maximum number of iterations }
  InitDegree, Degree       : integer;     { initial and final degree }
                                          { of polynomial }
  InitPoly, Poly           : TNvector;    { initial and final coefficients }
                                          { of the polynomial }
  NumRoots                 : integer;     { number of roots }
  Error                    : byte;        { error flag }

procedure Initialize(var InitGuess : Float;
                     var Tolerance : Float;
                     var MaxIter : integer;
                     var InitDegree : integer;
                     var InitPoly : TNvector;
                     var Root : TNvector;
                     var Imag : TNvector;
                     var Value : TNvector;
                     var Deriv : TNvector;
                     var Iter : TNIntVector);

{----------------------------------------------------------------}
{- Output: InitGuess, Tolerance, MaxIter, InitDegree, InitPoly, -}
{-         Root, Imag, Value, Deriv, Iter                       -}
{-                                                              -}
{- This procedure initializes the above variables to zero.      -}
{----------------------------------------------------------------}

begin
  InitGuess := 0;
  Tolerance := 0;
  MaxIter := 0;
  InitDegree := 0;
  fillchar(InitPoly, sizeof(InitPoly), 0);
  fillchar(Root, sizeof(Root), 0);
  fillchar(Imag, sizeof(Imag), 0);
  fillchar(Value, sizeof(Value), 0);
  fillchar(Deriv, sizeof(Deriv), 0);
  fillchar(Iter, sizeof(Iter), 0);
end; {procedure Initialize}

procedure UserInput(var Degree : integer;
                    var Poly : TNvector;
                    var InitGuess : Float;
                    var Tol : Float;
                    var MaxIter : integer);

{-------------------------------------------------------------*-}
{- Output: Degree, Poly, InitGuess, Tol, MaxIter               -}
{-                                                             -}
{- This procedure assigns values to the above variables from   -}
{- keyboard input.  The Degree of the polynomial (Degree), the -}
{- coefficients of the polynomial (Poly), the initial guess    -}
{- (InitGuess), and the tolerance (Tol) are all input here.    -}
{-------------------------------------------------------------*-}

var
  ch : char;

  procedure GetCoefficientsFromKeyboard(var Degree : integer;
                                        var Poly : TNvector);

  {------------------------------------------------------}
  {- Output: Degree, Poly                               -}
  {-                                                    -}
  {- This procedure reads in values for Degree and Poly -}
  {- from the keyboard.                                 -}
  {------------------------------------------------------}

  var
    term : integer;

  begin
    writeln;
    repeat
      write('Degree of the polynomial (<= ',TNArraySize,')? ');
      readln(Degree);
      IOCheck;     {- check for I/O errors -}
    until (Degree > 0) and (Degree <= TNArraySize) and not IOerr;
    writeln;
    writeln('Input the coefficients of the polynomial');
    writeln('where Poly[n] is the coefficient of x^n');
    writeln;
    for term := Degree downto 0 do
    begin
      repeat
        write('Poly[',term,'] = ');
        readln(Poly[term]);
        IOCheck;      {- check for I/O errors -}
      until not IOerr;
    end;  {for term}
  end; {procedure GetCoefficientsFromKeyboard}

  procedure GetCoefficientsFromFile(var Degree : integer;
                                    var Poly : TNvector);

  {------------------------------------------------------}
  {- Output: Degree, Poly                               -}
  {-                                                    -}
  {- This procedure reads in values for Degree and Poly -}
  {- from a text file.                                  -}
  {------------------------------------------------------}

  var
    term     : integer;
    InFile   : text;
    Filename : string[255];

  begin
    repeat
      writeln;
      repeat
        write('File name? ');
        readln(filename);
        assign(InFile, filename);
        reset(InFile);
        IOCheck;
      until not IOerr;
      Degree := 0;
      read(InFile, Degree);
      IOCheck;
      if not(Degree IN [0..TNArraySize]) and not IOerr then
        writeln('Degree too big');

      Term := Degree;
      while (not IOerr) and (Term >= 0) do
      begin
        read(InFile, Poly[term]);
        IOCheck;
        Term := pred(Term);
      end;  {while ... (Term < Degree) do}
    until not IOerr;
    close(InFile);
  end; {procedure GetCoefficientsFromFile}

  procedure GetInitialGuess(var InitGuess : Float);
  begin
    repeat
      writeln;
      write('Initial approximation to the root: ');
      readln(InitGuess);
      IOCheck;        {- check for I/O errors -}
    until not IOerr;
  end; {procedure GetInitialGuess}

  procedure GetTolerance(var Tol : Float);
  begin
    Tol := 1E-8;
    repeat
      writeln;
      write('Tolerance (> 0): ');
      ReadFloat(Tol);
      IOCheck;     {- check for I/O errors -}
      if Tol <= 0 then
      begin
        IOerr := true;
        Tol := 1E-8;
      end;  {if Tol <= 0 then}
    until not IOerr;
  end; {procedure GetTolerance}

  procedure GetMaxIter(var MaxIter : integer);
  begin
    MaxIter := 100;
    repeat
      writeln;
      write('Maximum number of iterations (> 0): ');
      ReadInt(MaxIter);
      IOCheck;
      if MaxIter < 0 then
      begin
        IOerr := true;
        MaxIter := 100;
      end;  {if MaxIter < 0 then}
    until not IOerr;
  end; {procedure GetMaxIter}

begin {procedure UserInput}
  case InputChannel('Input Data From') of
    'K' : GetCoefficientsFromKeyboard(Degree, Poly);
    'F' : GetCoefficientsFromFile(Degree, Poly);
  end;
  GetInitialGuess(InitGuess);
  GetTolerance(tol);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; {procedure UserInput}

procedure Results(InitDegree : integer;
                  InitPoly : TNvector;
                  InitGuess : Float;
                  Tol : Float;
                  MaxIter : integer;
                  Degree : integer;
                  NumRoots : integer;
                  Poly : TNvector;
                  Root : TNvector;
                  Imag : TNvector;
                  Value : TNvector;
                  Deriv : TNvector;
                  Iter : TNIntVector;
                  Error : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  term : integer;

begin
  writeln(OutFile);
  writeln(OutFile);
  writeln(OutFile,'Initial Polynomial:');
  for term := InitDegree downto 0 do
    writeln(OutFile,'Poly[',term,']: ',InitPoly[term]);
  writeln(OutFile);
  writeln(OutFile,'Initial approximation: ' : 30, InitGuess);
  writeln(OutFile,'Tolerance: ' : 30, Tol);
  writeln(OutFile,'Maximum number of iterations: ' : 30, MaxIter);
  writeln(OutFile);
  if Error IN [1, 2] then
    DisplayWarning;
  if Error >= 3 then
    DisplayError;

  case Error of
    1 :  begin
           writeln(OutFile,'It will take more than ',MaxIter,
                   ' iterations to');
           writeln(OutFile,
                   'solve this polynomial.  The roots may be complex.');
         end;  {- 1 :  -}

    2 :  writeln(OutFile, 'The slope is approaching zero.');

    3 :  writeln(OutFile,
                 'The degree of the polynomial must be greater than 0.');

    4 : writeln(OutFile, 'The tolerance must be greater than zero.');

    5 : writeln(OutFile,
            'The maximum number iterations must be greater than zero.');

  end;  {case Error of}

  if Error <= 2 then
  begin
    writeln(OutFile);
    writeln(OutFile,'Number of calculated roots: ' : 26, NumRoots);
    for term := 1 to NumRoots do
    begin
      writeln(OutFile);
      writeln(OutFile, 'Root ', term);
      writeln(OutFile,'Number of iterations: ' : 26, Iter[term] : 3);
      write(OutFile,'Calculated root: ' : 26, Root[term]);
      if abs(Imag[term]) < TNNearlyZero then
        writeln(OutFile)
      else
        writeln(OutFile,' +',Imag[term],'i');
      writeln(OutFile,'Value of the function  ' : 26);
      writeln(OutFile,'at the calculated root: ' : 26, Value[term]);
      writeln(OutFile,'Value of the derivative  ' : 26);
      writeln(OutFile,'of the function at  ' : 26);
      writeln(OutFile,'the calculated root: ' : 26, Deriv[term]);
      writeln(OutFile);
    end; {for term}
  end;  {if Error <= 2}

  if Degree > 2 then
  begin
    writeln(OutFile);
    writeln('Deflated polynomial: ');
    for term := Degree downto 0 do
      writeln(OutFile, 'P[',term,']=',Poly[term]);
  end; {if Degree > 2}
end; {procedure Results}

begin {program Newt_Horn_Defl}
  ClrScr;
  Initialize(InitGuess, Tolerance, MaxIter, InitDegree, InitPoly,
             Root, Imag, Value, Deriv, Iter);
  UserInput(InitDegree, InitPoly, InitGuess, Tolerance, MaxIter);
     {- use the Newton-Horner method and deflation to converge onto a root -}
  Newt_Horn_Defl(InitDegree, InitPoly, InitGuess, Tolerance, MaxIter,
                 Degree, NumRoots, Poly, Root, Imag, Value, Deriv, Iter,
                 Error);
  Results(InitDegree, InitPoly, InitGuess, Tolerance, MaxIter,
          Degree, NumRoots, Poly, Root, Imag, Value, Deriv, Iter,
          Error);
  close(OutFile);         {- close output file -}
end.  {program Newt_Horn_Defl}
