program Least_Squares_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program provides I/O routines to demonstrate     -}
{-                    the least squares routine, procedure LeastSquares.    -}
{-                                                                          -}
{-           Unit   : LeastSqr    procedure LeastSquares                    -}
{-                                procedure Transform                       -}
{-                                procedure InverseTransform                -}
{-                                procedure CreateBasisFunctions            -}
{-                                procedure TransformSolution               -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}                  { Disable I/O error trapping  }
{$R+}                  { Enable range checking  }
{$M 61440, 0, 655360}  { Set MinStack:MinHeap:MaxHeap }

uses
  LeastSqr, Dos, Crt, Common;

var
  XData, YData : TNColumnVector;    { Data points (X,Y)  }
  NumPoints : integer;              { # of points  }
  NumTerms : integer;               { # of terms in least squares  }
  Solution : TNRowVector;           { Coefficients of the l.s. fit  }
  YFit : TNColumnVector;            { Least squares solution  }
                                    { at XData points  }
  Residual : TNColumnVector;        { YFit - YData  }
  StandardDeviation : Float;        { Square root of variance;   }
  Variance : Float;                 { Indicates goodness of fit  }
  Error : byte;                     { Flags if something went wrong  }
  Fit : FitType;                    { Indicates the type of fit requested }

procedure Initialize(var XData    : TNColumnVector;
                     var YData    : TNColumnVector;
                     var YFit     : TNColumnVector;
                     var Residual : TNColumnVector;
                     var Solution : TNRowVector;
                     var Error    : byte);

{----------------------------------------------------------}
{- Output: XData, YData, Solution, YFit,                  -}
{-         Residual, Error                                -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}

begin
  FillChar(XData, SizeOf(XData), 0);
  FillChar(YData, SizeOf(XData), 0);
  FillChar(Solution, SizeOf(Solution), 0);
  FillChar(YFit, SizeOf(XData), 0);
  FillChar(Residual, SizeOf(XData), 0);
  Error := 0;
end; { procedure Initialize }

procedure GetData(var NumPoints : integer;
                  var NumTerms  : integer;
                  var XData     : TNColumnVector;
                  var YData     : TNColumnVector);

{--------------------------------------------------------------}
{- Output: NumPoints, NumTerms, XData, YData                  -}
{-                                                            -}
{- This procedure reads in data from either the keyboard      -}
{- or a data file.  The number of data points (NumPoints),    -}
{- the data points (XData, YData), the number of terms        -}
{- (NumTerms) in the least squares fit are all read in here.  -}
{--------------------------------------------------------------}

var
  Ch : char;

procedure GetTwoVectorsFromFile(var NumPoints : integer;
                                var XData     : TNColumnVector;
                                var YData     : TNColumnVector);

{-------------------------------------------------------------}
{- Output: NumPoints, XData, YData                           -}
{-                                                           -}
{- This procedure reads in the data points from a data file. -}
{-------------------------------------------------------------}

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
  while not(EOF(InFile)) do
  begin
    NumPoints := Succ(NumPoints);
    Readln(InFile, XData[NumPoints], YData[NumPoints]);
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetTwoVectorsFromFile }

procedure GetTwoVectorsFromKeyboard(var NumPoints : integer;
                                    var XData     : TNColumnVector;
                                    var YData     : TNColumnVector);

{--------------------------------------------------------------}
{- Output: NumPoints, XData, YData                            -}
{-                                                            -}
{- This procedure reads in the data points from the keyboard. -}
{--------------------------------------------------------------}

var
  Term : integer;

begin
  NumPoints:=0;
  Writeln;
  repeat
    Write('Number of points (1-', TNColumnSize, ')? ');
    Readln(NumPoints);
    IOCheck;
  until ((NumPoints >= 1) and (NumPoints <= TNColumnSize) and not IOerr);
  Writeln;
  Write('Type in the X ');
  Writeln('and Y values, separated by a space (not a comma):');
  for Term:=1 to NumPoints do
  repeat
    Write('X[', Term, '], Y[', Term, ']:');
    Read(XData[Term], YData[Term]);
    Writeln;
    { Read in the XData and YData  }
    IOCheck;
  until not IOerr;
end; { procedure GetTwoVectorsFromKeyboard }

begin { procedure GetData }
  case InputChannel('Input Data From') of
    'K' : GetTwoVectorsFromKeyboard(NumPoints, XData, YData);
    'F' : GetTwoVectorsFromFile(NumPoints, XData, YData);
  end;
  Writeln;
  NumTerms := 0;
  repeat
    Write('Number of terms in the least squares fit (<= ', NumPoints, ')? ');
    Readln(NumTerms);
    IOCheck;
    if NumTerms <= 0 then
      IOerr := true;
    if NumTerms > NumPoints then
    begin
      IOerr := true;
      Writeln;
      Writeln('The number of terms in the fit must');
      Writeln('be less than the number of points.');
      Writeln;
    end;
  until not IOerr;
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(NumPoints         : integer;
              var XData             : TNColumnVector;
              var YData             : TNColumnVector;
                  NumTerms          : integer;
              var Solution          : TNRowVector;
              var YFit              : TNColumnVector;
              var Residual          : TNColumnVector;
                  StandardDeviation : Float;
                  Error             : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile, 'The Data Points:');
  Writeln(OutFile,'     X                   Y');
  for Index := 1 to NumPoints do
    Writeln(OutFile,XData[Index] : 8 : 3, ' ' : 10, YData[Index] : 12 : 7);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, '*----------------------------------------*');
          Writeln(OutFile, ModuleName(Fit));
          Writeln(OutFile, '*----------------------------------------*');
          Writeln(OutFile);
          Writeln(OutFile, 'Coefficients in least squares approximation:');
          for Index := 1 to NumTerms do
            Writeln(OutFile, '   Coefficient ', Index-1, ': ',
                             Solution[Index]);
          Writeln(OutFile);
          Writeln(OutFile,'     X', ' ':8, 'Least Squares Fit', ' ':15,
                          'Residual' :15);
          for Index := 1 to NumPoints do
            Writeln(OutFile, XData[Index] : 8 : 4, ' ':4,
                             YFit[Index], ' ' : 20, Residual[Index]:17);
          Writeln(OutFile);
          Writeln(OutFile, 'Standard Deviation : ', StandardDeviation : 13);
        end;

    1 : Writeln(OutFile,'There must be more than one data point.');

    2 : Writeln(OutFile,
                'The number of terms in the fit must be greater than zero.');

    3 : begin
          Writeln(OutFile, 'The number of terms in the solution must be');
          Writeln(OutFile, 'less than the number of data points.');
        end;

    4 : Writeln(OutFile,
                'There is no least squares solution to this set of data.');
  end; { case }
end; { procedure Results }

begin { program LeastSquares }
  ClrScr;
  Initialize(XData, YData, YFit, Residual, Solution, Error);
  GetData(NumPoints, NumTerms, XData, YData);

  {---------------------------------------------------------}
  {- The value of Fit determines the type of fit requested -}

  Fit := Poly;

  {---------------------------------------------------------}

  LeastSquares(NumPoints, XData, YData, NumTerms, Solution,
               YFit, Residual, StandardDeviation, Variance, Error, Fit);
  Results(NumPoints, XData, YData, NumTerms, Solution, YFit,
          Residual, StandardDeviation, Error);
  Close(OutFile);
end. { program LeastSquares }
