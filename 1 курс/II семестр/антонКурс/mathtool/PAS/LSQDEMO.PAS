program Least_Squares_Graphix;

{--------------------------------------------------------------------------}
{-                                                                        -}
{-   Turbo Numerical Methods Toolbox                                      -}
{-   Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                        -}
{-     Purpose: This program provides routines from the Turbo Graphix     -}
{-              Toolbox to demonstrate least squares techniques.          -}
{-                                                                        -}
{-    Unit used from the Turbo Numeric Toolbox: LeastSqr.TPU              -}
{-                                                                        -}
{-    Units used from the Turbo Graphix Toolbox:                          -}
{-      GDriver.TPU, GKernel.TPU, GWindow.TPU, GShell.TPU                 -}
{-                                                                        -}
{- Files which must be in the current directory so that they              -}
{-      can be automatically read by Graphix Toolbox: 4x6.fon,            -}
{-      8x8.fon (needed for IBM color graphics),                          -}
{-      14x9.fon (needed for Hercules mono graphics), and Error.msg.      -}
{-                                                                        -}
{-   The data file SAMP11A.DAT must also be in the current directory.     -}
{-                                                                        -}
{-   For disk output to the default file name FFTout.dat,                 -}
{-   change the constant WriteToFile to True.                             -}
{-                                                                        -}
{--------------------------------------------------------------------------}

{$M 20480, 0, 655360}

uses
  Dos, Crt, GDriver, GKernel, GWindow, GShell, LeastSqr;

const
  IOerr : boolean = false;       { Flags an I/O error  }
  FirstFit : boolean = true;     { Needed for precedure results.  }
  WriteToFile : boolean = false; { Set true for disk output.  }

  { Printer mode is set for Epson FX-80 and compatible printers.  }
  { If you are using an with some non-Hercules graphics card,     }
  { such as the IBM CGA or EGA, PrinterMode = 4 will give         }
  { slightly better results.                                      }
  { The IBM Pro Printer requires PrinterMode = 1, and other       }
  { printers may require other modes.                             }
  PrinterMode = 6;

var
  XData, YData : TNColumnVector; { Data points (X,Y)  }
  NumPoints : integer;           { # of points  }
  Solution : TNRowVector;        { Coefficients of the l.s. fit  }
  YFit : TNColumnVector;         { Least squares solution  }
                                 { at XData points  }
  Residual : TNColumnVector;     { YFit - YData  }
  StandardDeviation : Float;
                                 { Indicates goodness of fit  }
  TNError : byte;                { Flags if something went wrong  }
  OutFile : text;                { Output file  }
  Multiplier : Float;            { Used in some modules  }
  Constant : Float;              { Used in some modules  }
  WData : TNColumnVector;        { Transformed X-values  }
  ZData : TNColumnVector;        { Transformed Y-values  }
  Basis : TNmatrix;              { Matrix of basis functions  }
  OutfileName : TNString40;      { File name for data and coefficients  }
  GraphArray, VarianceArray : ^PlotArray;


procedure IOCheck;

{---------------------------------------------------}
{- Check for I/O error; print message if needed.   -}
{---------------------------------------------------}

type
  String80 = string[80];

var
  IOcode : integer;

procedure Error(Msg : String80);
begin
  Writeln;
  Write(^G); { Beep! }
  Writeln(Msg);
  Writeln;
end; { procedure Error }

begin { procedure IOCheck }
  IOcode := IOresult;
  IOerr := IOcode <> 0;
  if IOerr then
    case IOcode of
      2   : Error('File not found.');
      3   : Error('Path not found.');
      4   : Error('Too many open files.');
      5   : Error('File access denied.');
      6   : Error('Invalid file handle.');
      12  : Error('Invalid file access code.');
      15  : Error('Invalid drive number.');
      16  : Error('Cannot remove current directory.');
      17  : Error('Cannot rename across drives.');
      100 : Error('Disk read error.');
      101 : Error('Disk write error.');
      102 : Error('File not assigned.');
      103 : Error('File not open.');
      104 : Error('File not open for input.');
      105 : Error('File not open for output.');
      106 : Error('Invalid numeric format.');
    else
      begin
        Writeln;
        Writeln(^G);
        Writeln('Unidentified error message = ', IOcode, '. See manual.');
        Writeln;
      end;
    end; { case }
end; { procedure IOCheck }

function FileExists(Fname : TNString40) : boolean;
var
  CheckFile : file;
begin
  Assign(CheckFile, Fname);
  {$I-} Reset(CheckFile); {$I+}
   if IOresult = 0 then
   begin
     FileExists := true;
     Close(CheckFile)
   end
 else
   FileExists := false;
end; { function FileExists }


procedure Initialize(var XData, YData, YFit, Residual : TNColumnVector;
                     var Solution                     : TNRowVector;
                     var TNError                      : byte);

{----------------------------------------------------------}
{- Output: XData, YData, Solution, YFit,                  -}
{-         Residual, TNError                              -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}

begin
  FillChar(XData, SizeOf(XData), 0);
  FillChar(YData, SizeOf(XData), 0);
  FillChar(Solution, SizeOf(Solution), 0);
  FillChar(YFit, SizeOf(XData), 0);
  FillChar(Residual, SizeOf(XData), 0);
  TNError := 0;
  New(GraphArray);
  New(VarianceArray);
end;  { procedure Initialize }


procedure Results(NumPoints         : integer;
              var XData, YData      : TNColumnVector;
                  NumTerms          : integer;
              var Solution          : TNRowVector;
              var YFit, Residual    : TNColumnVector;
                  StandardDeviation : Float;
                  TNError, FitNum   : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

type
  CoeffArray = array[1..5] of string[17];

var
  Index : integer;

const
  CoeffNames : CoeffArray = ('POWER LAW', 'EXPONENTIAL', 'LOGARITHMIC',
                             '5-Term FOURIER', '5-Term POLYNOMIAL');
begin
  if WriteToFile then
  begin
    if FirstFit then
    begin
      Writeln(OutFile, 'The Data Points:');
      Writeln(OutFile, '     X                   Y');
      for Index := 1 to NumPoints do
        Writeln(OutFile, XData[Index]:8:3, ' ':10, YData[Index]:12:7);
      Writeln(OutFile); FirstFit := false;
    end;
    case TNError of
      0 : begin
            Writeln(OutFile, CoeffNames[FitNum],
                             ' coefficients in least squares approximation:');
            for Index := 1 to NumTerms do
              Writeln(OutFile, '   Coefficient ', Index-1, ': ',
                               Solution[Index]);
            Writeln;
            Writeln(OutFile, '     X', ' ':11, 'Least Squares Fit', ' ':15,
                             'Residual');
            for Index := 1 to NumPoints do
              Writeln(OutFile, XData[Index]:8:4, ' ':4,
                               YFit[Index], ' ':9, Residual[Index]);
            Writeln(OutFile);
            Writeln(OutFile, 'Standard Deviation : ', StandardDeviation:12);
            Writeln(OutFile,
            '----------------------------------------------------------------');
            Writeln(OutFile);
          end;

      1 : Writeln(OutFile, 'There must be more than one data point!');

      2 : begin
            Writeln(OutFile,
                  'The number of terms in the fit must be greater than zero.');
            Writeln(Outfile, 'OR, no least squares solution possible.');
          end;

      3 : begin
            Writeln(OutFile, 'The number of terms in the solution must be');
            Writeln(OutFile, 'less than the number of data points.');
            Writeln(OutFile, 'OR can not fit negative Ydata.');
          end;

      4 : Writeln(OutFile,
                    'There is no least squares solution to this set of data.');
    end; { case }
  end; { if }
end; { procedure Results }


procedure ReportError(PrintString : TNString40; TNError : byte);
var
  Answer : char;

begin
  Writeln(PrintString, ' Error = ', TNError);
  Writeln('Strike any key to continue.');
  Answer := ReadKey;
end; { procedure ReportError }

procedure HelpScreen;
var
  Answer : char;

begin
  Writeln('This program finds least squares fits to the data in SAMP11A.DAT.');
  Write('The files SAMP11A.DAT, 4x6.FON, ');
  if XScreenMaxGlb = 719 then
    { Hercules }
    Write('14X9')
  else
    { CGA or others }
    Write('8X8');
  Writeln('.FON, and ERROR.MSG');
  Writeln('  must also be on the current directory at run time.');
  Writeln('To run your own data files, use: LSQ* InFileName OutFileName');
  Halt;
end; { procedure HelpScreen }


procedure GetData(var NumPoints    : integer;
                  var XData, YData : TNColumnVector;
                  var OutFileName  : TNString40);

{--------------------------------------------------------------}
{- Output: NumPoints, XData, YData, OutFileName.              -}
{-                                                            -}
{- This procedure reads the number of data points (NumPoints),-}
{- gets XData, YData and the OutFileName.                     -}
{--------------------------------------------------------------}

var
  InFileName : TNString40;

procedure GetTwoVectorsFromFile(InFileName   : TNString40;
                            var NumPoints    : integer;
                            var XData, YData : TNColumnVector);

{-------------------------------------------------------------}
{- Output: NumPoints, XData, YData                           -}
{-                                                           -}
{- This procedure reads in the data points from a data file. -}
{-------------------------------------------------------------}

var
  InFile : text;

begin
  if not FileExists(InFileName) then
  begin
    Writeln('Input data file ', InFileName,' not found.');
    Halt;
  end;
  Assign(InFile, InFileName);
  Reset(InFile);
  NumPoints := 0;
  while not EOF(InFile) do
  begin
    NumPoints := Succ(NumPoints);
    {$I-} Readln(InFile, XData[NumPoints], YData[NumPoints]);{$I+}
    IOCheck;
  end;
  Close(InFile);
end; { procedure GetTwoVectorsFromFile }


begin { procedure GetData }
  InFileName := 'SAMP11A.dat';
  OutFileName := 'LSQout.dat';
  if ParamCount > 0 then
  begin
    if (ParamStr(1) = '?') or (ParamCount <> 2) then
      HelpScreen;
    InFileName := ParamStr(1);
    OutFileName := ParamStr(2);
    WriteToFile := true;
  end;
  GetTwoVectorsFromFile(InFileName, NumPoints, XData, YData);
  if WriteToFile then
  begin
    Assign(OutFile, OutFileName); Rewrite(OutFile);
  end;
end; { procedure GetData }

{ ######## GRAPHICS PROCEDURES STARTING HERE ############ }

type
  Strg20 = string[20];
  ColorArray = array[1..4] of byte;

const
  WindowColor : ColorArray = (Green, Magenta, LightCyan, White);
  BackColor   : ColorArray = (Black, Black, Black, Black);
  NotEnoughMemory : boolean = false;

var

  Ans : char;
  WindowNUM : byte;


procedure SetColors(Fore, Back : integer);
begin
  if MaxForeground = 15 then
  begin
    SetForeGroundColor(Fore);
    SetBackGroundColor(Back);
  end;
end; { procedure SetColors }


procedure CheckAndStore(I : byte);
begin
  if MaxAvail > WindowSize(I) then
    StoreWindow(I)
  else
    NotEnoughMemory := true;
end; { procedure CheckAndStore }


procedure WarnAndExit;
begin
  ClearScreen; LeaveGraphic; Writeln;
  Writeln('INSUFFICIENT MEMORY TO RUN PROGRAM.');
  Writeln;
  Writeln('Strike any key to exit.');
  Ans := ReadKey;
  Halt;
end; { procedure WarnAndExit }


procedure FindMaxResiduals(var MaxResids     : Float;
                           var VarianceArray : PlotArray);
var
  J : byte;

begin
  MaxResids := VarianceArray[1, 2];
  for J := 2 to 5 do
    if MaxResids < VarianceArray[J, 2] then
      MaxResids := VarianceArray[J, 2];
end; { procedure FindMaxResiduals }


procedure GetGraphData(var X, Y       : TNColumnVector;
                       var GraphArray : PlotArray);
var
  Index : byte;

begin
  for Index := 1 to NumPoints do
  begin
    GraphArray[Index, 1] := X[Index];
    GraphArray[Index, 2] := Y[Index];
  end;
end; { procedure GetGraphData }


procedure PlotFits(var X, Y       : TNColumnVector;
                   var GraphArray : PlotArray;
                       Code       : integer);
begin
  GetGraphData(X, Y, GraphArray);
  DrawAxis(8, 7, 0, 0, 0, 0, 0, 0, true);
  DrawPolygon(GraphArray, 1, -NumPoints, Code, 3, 0);
end; { procedure PlotFits }


procedure StartGraphics(var Xdata, Ydata : TnColumnVector;
                        var GraphArray   : PlotArray);
begin
  GetGraphData(Xdata, Ydata, GraphArray);
  RAMScreenGlb := FALSE;
  InitGraphic;
  SetColors(WindowColor[1], BackColor[1]);
  DefineWindow(1, 0, 0, XMaxGlb, YMaxGlb);
  FindWorld(1, GraphArray, NumPoints, 1, 1.0);
  DefineHeader(1,
      '    LEAST SQUARE FITS:  POWER = +  EXPONENTIAL = X  LOGARITHM = Y');
  SetHeaderOn;  DrawBorder;
  DrawAxis(8, 7, 0, 0, 0, 0, -1, -1, true);
  DrawPolygon(GraphArray, 1, -NumPoints, -3, 1, 0);
end; { procedure StartGraphics }


procedure MakeNewScreen(var Xdata, Ydata : TNColumnVector;
                        var GraphArray   : PlotArray);
begin
  CheckAndStore(1);
  ClearScreen;
  GetGraphData(Xdata, Ydata, GraphArray);
  SetColors(WindowColor[2], BackColor[2]);
  DefineWindow(2, 0, 0, XMaxGlb, YMaxGlb);
  SelectWindow(2);
  DefineHeader(2,
      '        LEAST SQUARE FITS:  5-Term FOURIER = *  5-Term POLYNOMIAL = +');
  SetHeaderOn;  DrawBorder;
  DrawAxis(8, 7, 0, 0, 0, 0, 0, 0, true);
  DrawPolygon(GraphArray, 1, -NumPoints, -3, 1, 0);
end; { procedure MakeNewScreen }


procedure PlotResiduals(var VarianceArray : PlotArray);
var
  MaxResids : Float;

begin
  CheckAndStore(2);
  SetColors(WindowColor[3], BackColor[3]);
  DefineWindow(3, 0, 0, XMaxGlb DIV 2, YMaxGlb);
  FindMaxResiduals(MaxResids, VarianceArray);
  DefineWorld(3, 0, 0, 5, 1.3*MaxResids);
  SelectWorld(3); SelectWindow(3); SetBackground(0);
  DefineHeader(3, 'SUMS OF SQUARES OF RESIDUALS FOR 5 FITS.');
  SetHeaderOn; DrawBorder; DrawAxis(0, 5, 0, 0, 0, 0, 0, 0, false);
  DrawHistogram(VarianceArray, 5, true, 7);
  GoToXY(5, 3);
  Write('POWER    EXP   LOG  5-FOUR. 5-POLY.');
end; { procedure PlotResiduals }


procedure GiveInstructions;
begin
  CheckAndStore(3);
  DefineTextWindow(4, 42, 0, 79, 8, 2);
  SelectWindow(4); SetBackground(0);
  SetColors(WindowColor[4], BackColor[4]);
  DefineHeader(4, 'INSTRUCTIONS FOR DEMONSTRATION');
  SetHeaderOn; DrawBorder;
  GoToXY(43, 3);
  Write('CYCLE through screens with SPACE KEY.');
  GoToXY(43, 4);
  Write('QUIT with Q, HARDCOPY with H.');
  GoToXY(43, 5);
  Write('Turn printer on before hardcopy.');
  GoToXY(43, 6);
  Write('Only Epson printers supported.');
  GoToXY(43, 7);
  Write('Coefficients written in ', OutFileName);
  CheckAndStore(4)
end; { procedure GiveInstructions }

{ ############## GRAPHIX PROCEDURES END HERE ############# }

begin { program LeastSquares }
  Initialize(XData, YData, YFit, Residual, Solution, TNError);
  GetData(NumPoints, XData, YData, OutFileName);
  StartGraphics(Xdata, YData, GraphArray^);

  { #### Now Find the POWER LAW fit and plot. #### }
  LeastSquares(NumPoints, XData, YData, 2, Solution, YFit, Residual,
               StandardDeviation, VarianceArray^[1, 2], TNError, Power);
  Results(NumPoints, XData, YData, 2, Solution, YFit, Residual,
  StandardDeviation, TNError, 1);
  PlotFits(Xdata, Yfit, GraphArray^, 1);

  { #### Now Find the EXPONENTIAL fit and plot. #### }
  LeastSquares(NumPoints, XData, YData, 2, Solution, YFit, Residual,
               StandardDeviation, VarianceArray^[2, 2], TNError, Expo);
  Results(NumPoints, XData, YData, 2, Solution, YFit, Residual,
  StandardDeviation, TNError, 2);
  PlotFits(Xdata, Yfit, GraphArray^, 2);

  { #### Now Find the LOGARITHMIC fit and plot. #### }
  LeastSquares(NumPoints, XData, YData, 2, Solution, YFit, Residual,
               StandardDeviation, VarianceArray^[3, 2], TNError, Log);
  Results(NumPoints, XData, YData, 2, Solution, YFit, Residual,
  StandardDeviation, TNError, 3);
  PlotFits(Xdata, Yfit, GraphArray^, 6);

  { #### Now Find the 5 Term FOURIER fit and plot. #### }
  LeastSquares(NumPoints, XData, YData, 5, Solution, YFit, Residual,
               StandardDeviation, VarianceArray^[4, 2], TNError, Fourier);
  Results(NumPoints, XData, YData, 5, Solution, YFit, Residual,
  StandardDeviation, TNError, 4);
  MakeNewScreen(Xdata, Ydata, GraphArray^);
  PlotFits(Xdata, Yfit, GraphArray^, 7);


  { #### Now Find the 5-Term POLYNOMIAL fit and plot. #### }
  LeastSquares(NumPoints, XData, YData, 5, Solution, YFit,
               Residual, StandardDeviation, VarianceArray^[5, 2], TNError, Poly);
  Results(NumPoints, XData, YData, 5, Solution, YFit,
  Residual, StandardDeviation, TNError, 5);
  PlotFits(Xdata, Yfit, GraphArray^, 1);

  PlotResiduals(VarianceArray^); GiveInstructions;
  Ans := UpCase(ReadKey);
  WindowNum := 4;
  if NotEnoughMemory then
    WarnAndExit
  else
    begin
      while Ans <> 'Q' do
      begin
        if Ans = 'H' then
          HardCopy(false, PrinterMode);
        WindowNum := WindowNum mod 4+1; { Only Epson printers supported }
        SetColors(WindowColor[WindowNum], BackColor[WindowNum]);
        RestoreWindow(WindowNum, 0, 0);
        Ans := UpCase(ReadKey);
      end;
    end;
  LeaveGraphic;
  Dispose(GraphArray);
  Dispose(VarianceArray);
  if WriteToFile then
    Close(OutFile);
end. { program LeastSquares }
