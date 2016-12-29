program FFTPrograms;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose:  This procedure provides I/O routines for using the       -}
{-                 fast Fourier transform, convolution and correlation      -}
{-                 routines.                                                -}
{-                                                                          -}
{-       Unit   :  FFT????.TPU       procedure MakeSinCosTable              -}
{-                                             BitInvert                    -}
{-                                             FFT                          -}
{-                                   procedure RealFFT                      -}
{-                                   procedure RealConvolution              -}
{-                                   procedure RealCorrelation              -}
{-                                   procedure ComplexFFT                   -}
{-                                   procedure ComplexConvolution           -}
{-                                   procedure ComplexCorrelation           -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }

uses
  FFTB2, Dos, Crt, Common;

type
  Analyses = (RF, RN, RC, RA, CF, CN, CC, CA);

var
  WhichAnalysis : Analyses;         { Indicates which application  }
                                    { will be run                  }
  NumPoints : integer;              { Number of points  }
  XReal, XImag : TNvectorPtr;       { One set of complex data points  }
  HReal, HImag : TNvectorPtr;       { Another set of complex data points  }
  Inverse : boolean;                { False ==> forward Fourier transform  }
                                    { True ===> inverse Fourier transform  }
  Auto : boolean;                   { False ==> crosscorrelation  }
                                    { True ===> autocorrelation  }
  Error : byte;                     { Flags if something went wrong  }

procedure Initialize(var NumPoints : integer;
                     var XReal     : TNvectorPtr;
                     var XImag     : TNvectorPtr;
                     var HReal     : TNvectorPtr;
                     var HImag     : TNvectorPtr;
                     var Error     : byte);

{----------------------------------------------------------}
{- Output: NumPoints, XReal, XImag, HReal, HImag, Error   -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}

begin
  NumPoints := 0;
  New(XReal);
  New(XImag);
  New(HReal);
  New(HImag);
  FillChar(XReal^, SizeOf(XReal^), 0);
  FillChar(XImag^, SizeOf(XImag^), 0);
  FillChar(HReal^, SizeOf(HReal^), 0);
  FillChar(HImag^, SizeOf(HImag^), 0);
  Error := 0;
end; { procedure Initialize }

procedure GetData(var NumPoints     : integer;
                  var WhichAnalysis : Analyses;
                  var Auto          : boolean;
                  var XReal         : TNvectorPtr;
                  var XImag         : TNvectorPtr;
                  var HReal         : TNvectorPtr;
                  var HImag         : TNvectorPtr);

{--------------------------------------------------------------}
{- Output: NumPoints, WhichAnalysis, Auto, XReal, XImag,      -}
{-         HReal, HImag                                       -}
{-                                                            -}
{- This procedure reads in data from either the keyboard      -}
{- or a data file.                                            -}
{--------------------------------------------------------------}

var
  Ch : char;
  NumPoints1 : integer;
  NumPoints2 : integer;

function TestForPowersOfTwo(NumPoints : integer) : boolean;

{---------------------------------------------------------}
{- Input: NumPoints                                      -}
{- Output: TestForPowersOfTwo                            -}
{-                                                       -}
{- This procedure checks if NumPoints is a power of two. -}
{- It returns True if it is, False if it isn't.          -}
{---------------------------------------------------------}

type
  ShortArray = array[1..13] of integer;

const
  PowersOfTwo : ShortArray = (2, 4, 8, 16, 32, 64, 128, 256,
                              512, 1024, 2048, 4096, 8192);

var
  Term : integer;
  Test : boolean;

begin
  Test := false; { Assume NumPoints not a power of two  }
  Term := 1;
  while (Term <= 13) and (not Test) do
  begin
    if NumPoints = PowersOfTwo[Term] then
      Test := true; { NumPoints is a power of two  }
    Term := Succ(Term);
  end;
  TestForPowersOfTwo := Test;
end; { function TestForPowersOfTwo }

procedure GetRealVectorFromFile(var NumPoints : integer;
                                var XReal     : TNvectorPtr);

{-----------------------------------------------}
{- Output: NumPoints, X                        -}
{-                                             -}
{- This procedure reads in a real vector of    -}
{- data points from a data file.               -}
{-----------------------------------------------}

var
  FileName : string[255];
  InFile : text;

begin
  Writeln;
  repeat
    Write('File name? ');
    Readln(FileName);
    Assign(InFile, FileName);
    Reset(InFile);
    IOCheck;
  until not IOerr ;
  NumPoints := 0;
  while not EOF(InFile)  do
  begin
    Readln(InFile, XReal^[NumPoints]);
    NumPoints := Succ(NumPoints);
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetRealVectorFromFile }

procedure GetComplexVectorFromFile(var NumPoints : integer;
                                   var XReal     : TNvectorPtr;
                                   var XImag     : TNvectorPtr);

{-----------------------------------------------}
{- Output: NumPoints, XReal, XImag             -}
{-                                             -}
{- This procedure reads in a complex vector    -}
{- of data points from a data file.            -}
{-----------------------------------------------}

var
  FileName : string[255];
  InFile : text;

begin
  Writeln;
  repeat
    Write('File name? ');
    Readln(FileName);
    Assign(InFile, FileName);
    Reset(InFile);
    IOCheck;
  until not IOerr;
  NumPoints := 0;
  while not EOF(InFile) do
  begin
    Readln(InFile, XReal^[NumPoints], XImag^[NumPoints]);
    NumPoints := Succ(NumPoints);
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetComplexVectorFromFile }

procedure GetRealVectorFromKeyboard(var NumPoints : integer;
                                    var XReal     : TNvectorPtr);

{----------------------------------------------}
{- Output: NumPoints, X                       -}
{-                                            -}
{- This procedure reads in a real vector of   -}
{- data points from the keyboard.             -}
{----------------------------------------------}

var
  Term : integer;

begin
  NumPoints := 0;
  Writeln;
  repeat
    Write('Number of points (a power of two between 2-', TNArraySize + 1,')? ');
    Readln(NumPoints);
    IOCheck;
    IOerr := not TestForPowersOfTwo(NumPoints);
  until (NumPoints >= 2) and (NumPoints <= TNArraySize + 1) and not IOerr;
  Writeln;
  Writeln('Type in the X values:');
  for Term := 0 to NumPoints - 1  do
  repeat
    Write('Real(X[', Term, ']): ');
    Readln(XReal^[Term]);
    IOCheck;
  until not IOerr;
end; { procedure GetRealVectorFromKeyboard }

procedure GetComplexVectorFromKeyboard(var NumPoints : integer;
                                       var XReal     : TNvectorPtr;
                                       var XImag     : TNvectorPtr);

{-----------------------------------------------}
{- Output: NumPoints, XReal, XImag             -}
{-                                             -}
{- This procedure reads in a complex vector of -}
{- data points from the keyboard.              -}
{-----------------------------------------------}

var
  Term : integer;

begin
  NumPoints := 0;
  repeat
    Write('Number of points (a power of two between 2-', TNArraySize + 1,')? ');
    Readln(NumPoints);
    IOCheck;
    IOerr := not TestForPowersOfTwo(NumPoints);
  until (NumPoints >= 2) and (NumPoints <= TNArraySize + 1) and not IOerr;
  Writeln;
  Writeln('Type in the X values:');
  for Term := 0 to NumPoints - 1  do
  begin
    repeat
      Write('Real(X[', Term, ']): ');
      Readln(XReal^[Term]);
      IOCheck;
    until not IOerr;
    repeat
      Write('Imaginary(X[', Term, ']): ');
      Readln(XImag^[Term]);
      IOCheck;
    until not IOerr;
  end;
end; { procedure GetComplexVectorFromKeyboard }

procedure GetInverse(var Inverse : boolean);

var
  Ch : char;

begin
  Writeln;
  Write('(F)orward or (I)nverse transform? ');
  repeat
    Ch := UpCase(ReadKey);
  until Ch in ['F', 'I'];
  Writeln(Ch);
  if Ch = 'F' then
    Inverse := false  { Forward transform  }
  else
    Inverse := true;  { Inverse transform  }
end; { procedure GetInverse }

begin { procedure GetData }
  Writeln('   1) Real Fast Fourier Transform');
  Writeln('   2) Real Convolution');
  Writeln('   3) Real Autocorrelation');
  Writeln('   4) Real Crosscorrelation');
  Writeln('   5) Complex Fast Fourier Transform');
  Writeln('   6) Complex Convolution');
  Writeln('   7) Complex Autocorrelation');
  Writeln('   8) Complex Crosscorrelation');
  Writeln;
  Write('   Select a number (1-8): ');
  repeat
    Ch := ReadKey;
  until Ch in ['1'..'8'];

  Writeln;
  case Ch of
    '1' : begin
            Writeln('********* Real fast Fourier transform *********');
            GetInverse(Inverse);
            WhichAnalysis := RF;
          end;

    '2' : begin
            Writeln('********* Real Convolution *********');
            WhichAnalysis := RN;
          end;

    '3' : begin
            Writeln('********* Real Autocorrelation *********');
            Auto := true;            { Autocorrelation  }
            WhichAnalysis := RA;
          end;

    '4' : begin
            Writeln('********* Real Crosscorrelation *********');
            Auto := false;           { Crosscorrelation  }
            WhichAnalysis := RC;
          end;

    '5' : begin
            Writeln('********* Complex fast Fourier transform *********');
            GetInverse(Inverse);
            WhichAnalysis := CF;
          end;

    '6' : begin
            Writeln('********* Complex Convolution *********');
            WhichAnalysis := CN;
          end;

    '7' : begin
            Writeln('********* Complex Autocorrelation *********');
            Auto := true;            { Autocorrelation  }
            WhichAnalysis := CA;
          end;

    '8' : begin
            Writeln('********* Complex Crosscorrelation *********');
            Auto := false;           { Crosscorrelation  }
            WhichAnalysis := CC;
          end;
  end; { case }

  Writeln;
  Ch := InputChannel('Input Data From');
  if Ch = 'K' then
    repeat  { Until NumPoints1 := NumPoints2  }
      NumPoints1 := NumPoints2;
      case WhichAnalysis of
        RF, RA : GetRealVectorFromKeyboard(NumPoints, XReal);

        RN, RC : begin
                   Writeln;
                   Writeln('The first function:');
                   GetRealVectorFromKeyboard(NumPoints1, XReal);
                   Writeln;
                   Writeln('The 2nd function:');
                   GetRealVectorFromKeyboard(NumPoints2, HReal);
                   if NumPoints1 <> NumPoints2 then
                   begin
                     Writeln;
                     Write('The number of points in these two files');
                     Writeln(' are different.');
                   end;
                   NumPoints := NumPoints1;
                 end;

        CF, CA : GetComplexVectorFromKeyboard(NumPoints, XReal, XImag);

        CN, CC : begin
                   Writeln;
                   Writeln('The first function:');
                   GetComplexVectorFromKeyboard(NumPoints1, XReal, XImag);
                   Writeln;
                   Writeln('The 2nd function:');
                   GetComplexVectorFromKeyboard(NumPoints2, HReal, HImag);
                   if NumPoints1 <> NumPoints2 then
                   begin
                     Writeln;
                     Write('The number of points in these two files');
                     Writeln(' are different.');
                   end;
                   NumPoints := NumPoints1;
                 end;
      end { case }
    until NumPoints1 = NumPoints2
  else { Ch = 'F' }
    repeat
      NumPoints2 := NumPoints1;
      case WhichAnalysis of
        RF, RA : GetRealVectorFromFile(NumPoints, XReal);

        RN, RC : begin
                   Writeln;
                   Writeln('The first function:');
                   GetRealVectorFromFile(NumPoints1, XReal);
                   Writeln;
                   Writeln('The 2nd function:');
                   GetRealVectorFromFile(NumPoints2, HReal);
                   if NumPoints1 <> NumPoints2 then
                   begin
                     Writeln;
                     Write('The number of points in these two files');
                     Writeln(' are different.');
                   end;
                   NumPoints := NumPoints1;
                 end;

        CF, CA : GetComplexVectorFromFile(NumPoints, XReal, XImag);

        CN, CC : begin
                   Writeln;
                   Writeln('The first function:');
                   GetComplexVectorFromFile(NumPoints1, XReal, XImag);
                   Writeln;
                   Writeln('The 2nd function:');
                   GetComplexVectorFromFile(NumPoints2, HReal, HImag);
                   if NumPoints1 <> NumPoints2 then
                   begin
                     Writeln;
                     Write('The number of points in these two files');
                     Writeln(' are different.');
                   end;
                   NumPoints := NumPoints1;
                 end;
      end; { case }
    until NumPoints1 = NumPoints2;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumPoints     : integer;
                  WhichAnalysis : Analyses;
              var XReal         : TNvectorPtr;
              var XImag         : TNvectorPtr;
                  Error         : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

  case Error of
    0 : begin
          case WhichAnalysis of
            RF : Writeln(OutFile, 'Results of real Fourier transform:');
            RN : Writeln(OutFile, 'Results of real convolution:');
            RC : Writeln(OutFile, 'Results of real crosscorrelation:');
            RA : Writeln(OutFile, 'Results of real autocorrelation:');
            CF : Writeln(OutFile, 'Results of complex Fourier transform:');
            CN : Writeln(OutFile, 'Results of complex convolution:');
            CC : Writeln(OutFile, 'Results of complex crosscorrelation:');
            CA : Writeln(OutFile, 'Results of complex autocorrelation:');
          end; { case }

          for Index := 0 to NumPoints - 1 do
            Writeln(OutFile, XReal^[Index], '    ',  XImag^[Index]);
          Writeln;
        end;

    1 : begin
          Writeln(OutFile, 'The number of data points: ', NumPoints);
          Writeln(OutFile, 'There are too few data points.');
        end;

    2 : begin
          Writeln(OutFile, 'The number of data points: ', NumPoints);
          Writeln(OutFile,
                  'The number of data points must be a power of two for a');
          Writeln(OutFile,
             'radix-2 transform or a power of four for a radix-4 transform.');
        end;
  end; { case }
end; { procedure Results }

begin { program FFTPrograms }
  ClrScr;
  Initialize(NumPoints, XReal, XImag, HReal, HImag, Error);
  GetData(NumPoints, WhichAnalysis, Auto, XReal, XImag, HReal, HImag);

  case WhichAnalysis of
    RF : RealFFT(NumPoints, Inverse, XReal, XImag, Error);
    RN : RealConvolution(NumPoints, XReal, XImag, HReal, Error);
    RC : RealCorrelation(NumPoints, Auto, XReal, XImag, HReal, Error);
    RA : RealCorrelation(NumPoints, Auto, XReal, XImag, XReal, Error);
    CF : ComplexFFT(NumPoints, Inverse, XReal, XImag, Error);
    CN : ComplexConvolution(NumPoints, XReal, XImag, HReal, HImag, Error);
    CC : ComplexCorrelation(NumPoints, Auto, XReal, XImag,
                            HReal, HImag, Error);
    CA : ComplexCorrelation(NumPoints, Auto, XReal, XImag,
                            XReal, XImag, Error);
  end; { case }

  Results(NumPoints, WhichAnalysis, XReal, XImag, Error);
  Close(OutFile);
  Dispose(XReal);
  Dispose(XImag);
  Dispose(HReal);
  Dispose(HImag);
end. { program FFTPrograms }
