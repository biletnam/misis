program FFTDemo;

{-----------------------------------------------------------------------}
{-                                                                     -}
{-   Turbo Numerical Methods Toolbox                                   -}
{-   Copyright (c) 1986, 87 by Borland International, Inc.             -}
{-                                                                     -}
{-   Purpose:  This program demostrates the use of the Fast Fourier    -}
{-             Transform package in the Turbo Numeric Toolbox, in      -}
{-             combination with graphing routines from the Turbo       -}
{-             Graphix Toolbox.                                        -}
{-                                                                     -}
{-   Units used from the Graphix Toolbox: GDriver, GKernel, GWindow,   -}
{-                                        GShell                       -}
{-                                                                     -}
{-   Files which must be in the current directory so that they         -}
{-      can be automatically read by Graphix Toolbox: 4x6.fon,         -}
{-      8x8.fon (needed for IBM color graphics),                       -}
{-      14x9.fon (needed for Hercules mono graphics), and Error.msg.   -}
{-                                                                     -}
{-   The data file SAMP11B.DAT must also be in the current directory.  -}
{-                                                                     -}
{-   (Note: The constant MaxPlotGlb in the file GDriver.pas            -}
{-    must be changed to 1024 before compiling this program.)          -}
{-                                                                     -}
{-   Unit used from Turbo Numeric Toolbox:  FFT????.TPU                -}
{-                                                                     -}
{-    (Note: In order to use an 8087 or 80287 numeric coprocessor      -}
{-     this program should use the unit FFT87B2.TPU instead of the     -}
{-     unit FFTB2.TPU                                                  -}
{-                                                                     -}
{-   For disk output to the default file name FFTout.dat,              -}
{-   change the constant WriteToFile to True.                          -}
{-                                                                     -}
{-----------------------------------------------------------------------}

uses
  Dos, Crt, GDriver, GKernel, GWindow, GShell, FFTB2;

const
  TotNumPts = 1024;
  NumReps : integer = 4;
  MaxReps = 4;
  WriteToFile : boolean = false; { Set true for disk output.  }

  { Printer mode is set for Epson FX-80 and compatible printers.  }
  { If you are using an with some non-Hercules graphics card,     }
  { such as the IBM CGA or EGA, PrinterMode = 4 will give         }
  { slightly better results.                                      }
  { The IBM Pro Printer requires PrinterMode = 1, and other       }
  { printers may require other modes.                             }
  PrinterMode = 6;

type
  FileName = string[80];
  TimeArray = array[1..MaxReps] of Float;
  TNString40 = string[40];

var
  DataFile, ResFile : text;
  RawPlot, PlotReal, PlotImag : PlotArray;
  ForwardTime, InverseTime : TimeArray;
  FileErr : byte;
  IOErr, MemFull : boolean;
  RawData : TNvectorPtr;
  NumPoints, Rep : integer;
  Ans : char;

{$I-} { Turn off I/O  error trapping }

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
  Write(^G);   { Beep! }
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

procedure SetColors;
begin
  if XScreenMaxGlb <> 719 then
    begin { CGA graphics }
      SetForegroundColor(3); { Cyan  }
      SetBackgroundColor(0); { Black }
    end
  else
    begin { Hercules graphics }
      SetForegroundColor(1); { White }
      SetBackgroundColor(0); { Black }
    end;
end; { procedure SetColors }

function CheckCapacity : integer;

var
  Screens : integer;

begin
  Screens := MaxAvail div (ScreenSizeGlb * 2);
  if Screens > 4 then
    Screens := 4;
  CheckCapacity := Screens;
end; { function CheckCapacity }


procedure IntroScreen;
var
  I : integer;
  X, Y, OldX, OldY : Float;

begin { procedure IntroScreen }
  ClearScreen;
  DefineWorld(1, 0, 0, 640, 350);
  SelectWorld(1); SelectWindow(1);
  OldX := 320 - 315 * Cos(1);
  OldY := 175 - 170 * Sin(1);
  if XScreenMaxGlb = 719 then
    begin { Hercules }
      SetForegroundColor(1); SetBackgroundColor(0);
    end
  else
    begin { CGA or others }
      SetforeGroundColor(Magenta); SetBackgroundColor(LightCyan);
    end;
  DrawTextW(207, 30, 3, '** BORLAND **');
  DrawTextW(207, 320, 3, 'INTERNATIONAL');
  DrawTextW(100, 175, 3, ' TURBO ');
  DrawTextW(420, 175, 3, 'NUMERIC');
  for I := 2 to 200 do
  begin
    X := 320 - 315 * Cos(1.25 * I);
    Y := 175 - 170 * Sin(2.5 * I);
    DrawLine(OldX, OldY, X, Y);
    OldX := X;
    OldY := Y;
  end;
  for I := 15 downto 1 do
  begin
    Delay(200);
    if XScreenMaxGlb <> 719 then
      begin { CGA }
        SetForegroundColor(I);
        SetBackgroundColor((I+10) mod 15);
      end
    else { Hercules }
      InvertScreen;
  end;
  ClearScreen;
end; { procedure IntroScreen }

procedure DisplayInstruct;
var
  Ch: char;
begin
  Writeln('This program finds Fourier transforms of the data in SAMP11B.DAT.');
  Write('The files SAMP11B.DAT, 4x6.FON, ');
  if XScreenMaxGlb = 719 then { Hercules }
    Write('14X9')
  else { CGA or others }
    Write('8X8');
  Writeln('.FON, and ERROR.MSG');
  Writeln('  must also be on the current directory at run time.');
  Writeln('To run your own data files, use: FFT* InFileName OutFileName');
  Halt;
end; { DisplayInstruct }


procedure Initialize(var XReal : TNvectorPtr);

{----------------------------------------------------------}
{- Output:  XReal                                         -}
{-                                                        -}
{- This procedure initializes the above variables to zero -}
{----------------------------------------------------------}

begin
  New(XReal);
  FillChar(XReal^, SizeOf(XReal^), 0);
end; { procedure Initialize }


procedure GetRealVectorFromFile(var DataFile  : text;
                                    NumPoints : integer;
                                var XReal     : TNvectorPtr;
                                var Error     : byte);
{-----------------------------------------------}
{- Output: XReal                               -}
{-                                             -}
{- This procedure reads in a real vector of    -}
{- data points from a data file.               -}
{-----------------------------------------------}
var
  Count : integer;

begin
  Count := 0;  ClearScreen;
  GotoXY(1, 1);
  Writeln('Reading input data....');
  while (not(EOF(DataFile))) and (Count <= TotNumPts) do
  begin
    if Count < TotNumPts then
      Readln(DataFile, XReal^[Count]);
    Count := Succ(Count);
  end;
  if Count = NumPoints then
    Error := 0
  else
    Error := 1;
  Close(DataFile);
end; { procedure GetRealVectorFromFile }


procedure GetFiles(var DataFile,
                       ResFile  : text;
                   var FileErr  : byte);
{-----------------------------------------------------------}
{- Output: DatFile, ResFile, FileErr                       -}
{-                                                         -}
{-   This procedure gets the file names from the user and  -}
{- sets up the files.  The default files are SAMP11B.DAT   -}
{- for the raw data and FFTOut.dat for the results.        -}
{-----------------------------------------------------------}

var
  DataFileName, ResFileName : FileName;

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

begin { procedure GetFiles }
  if ParamCount = 0 then
    begin { default files }
      DataFileName := 'SAMP11B.DAT';
      ResFileName := 'FFTOut.dat';
      FileErr := 0;
    end {ParamCount = 0}
  else
    if ParamCount = 2 then
      begin { User files }
        DataFileName := ParamStr(1);
        ResFileName := ParamStr(2);
        WriteToFile := true;
        FileErr := 0;
      end
    else { ParamCount <> 0,2 }
      begin
        DisPlayInstruct;
        Halt;
      end;
  if FileErr = 0 then
  begin
    if FileExists(DataFileName) then
      Assign(DataFile, DataFileName)
    else
      begin
        Writeln('Input data file ', DataFileName,' not found.');
        Halt;
      end;
    Reset(DataFile);
    IOCheck;
    if WriteToFile then
      if not IOErr then
      begin
        Assign(ResFile, ResFileName);
        Rewrite(ResFile);
        IOCheck;
      end;
  end;
end; { procedure GetFiles }


procedure SetPlot(var YData         : TNVectorPtr;
                      NumPoints     : integer;
                      FirstX, LastX : Float;
                  var Plot          : PlotArray);
{-----------------------------------------------------------------}
{-  Output: Plot                                                 -}
{-                                                               -}
{-    This procedure takes a vector from the FFT system and puts -}
{- it into an array for graphing.  The values FirstX and LastX   -}
{- give the range of values for the X-axis.                      -}
{-----------------------------------------------------------------}
var
  Increment, XVal : Float;
  Count : integer;

begin { procedure SetPlot }
  Increment := (LastX-FirstX) / NumPoints;
  XVal := FirstX;
  for Count := 1 to numPoints do
  begin
    Plot[Count, 1] := XVAl;
    Plot[Count, 2] := YData^[Count-1];
    XVal := XVal+Increment;
  end;
end; { procedure SetPlot }


procedure MakeDataWindow(var Plot               : PlotArray;
                             NumPoints, WindNum : integer;
                         var MemFull            : boolean);
{-----------------------------------------------------------------}
{-  This procedure initializes the window indicated by WindNum   -}
{-  sets axes using PlotArray, and plots the data in PlotArray.  -}
{-  The MemFull flag TRUE indicates there was insufficient space -}
{-  to store the windows.                                        -}
{-----------------------------------------------------------------}

var
  MemoryLeft : longint;
  XHi, YHi : integer;

begin { procedure MakeDataWindow }
  ClearScreen;
  XHi := (3 * XMaxGlb) div 4;
  YHi := (3 * YMaxGlb) div 4;
  DefineWindow(WindNum, 0, 0, XHi, YHi);
  DefineHeader(WindNum, 'Original Data = ...  Inverse Transform = ___');
  SelectWorld(1);
  SelectWindow(WindNum);
  SetHeaderOn;
  DrawBorder;
  DrawAxis(8, -8, 0, 0, 0, 0, 0, 0, false);
  SetLineStyle(1);
  DrawPolygon(Plot, 1, -NumPoints, 0, 1, 0);
  MemoryLeft := MaxAvail;
  if (not MemFull) and (MemoryLeft > WindowSize(WindNum)) then
    StoreWindow(WindNum)
  else
    MemFull := true;
end; { procedure NewPlot }


procedure MakeWorld(var Plot                : PlotArray;
                        NumPoints, WorldNum : integer);
{--------------------------------------------------------------}
{-   This procedure applies FindWorld to set up a coordinate  -}
{- system.                                                    -}
{--------------------------------------------------------------}

begin { procedure MakeWorld }
  FindWorld(WorldNum, Plot, NumPoints, 1, 1.1);
end; { procedure MakeWorld }


procedure SetPlotTrans(YData                  : TNVectorPtr;
                       NumPoints              : integer;
                       FirstX, LastX, MaxFreq : Float;
                   var Plot                   : PlotArray);
{--------------------------------------------------------------}
{-   This procedure sets up the plotting array for an inverse -}
{- transform.  The upper half of the transform is shifted to  -}
{- negative values on the X-axis. The procedure cuts off      -}
{- points beyond the maximum frequency.                       -}
{--------------------------------------------------------------}

var
  Increment, XVal : Float;
  Count : integer;

begin { procedure SetPlotTrans }
  Increment := (LastX - FirstX) / NumPoints;
  XVal := 0;
  for Count := 1 to NumPoints div 2 do
  begin
    if (XVal <= MaxFreq-1) and (XVal >= -MaxFreq) then
      begin
        Plot[Count, 1] := XVal;
        Plot[Count, 2] := YData^[Count-1];
      end {IF XVal in range}
    else
      begin
        Plot[Count, 1] := 0;
        Plot[Count, 2] := 0;
      end;
    XVal := XVal+Increment;
  end;
  XVal := -XVal - Increment;
  for Count := (NumPoints div 2)+1 to NumPoints do
  begin
    if (XVal <= MaxFreq-1) and (XVal >= -MaxFreq) then
      begin
        Plot[Count, 1] := XVal;
        Plot[Count, 2] := YData^[Count-1];
      end
    else
      begin
        Plot[Count, 1] := 0;
        Plot[Count, 2] := 0;
      end;
    XVal := XVal + Increment;
  end;
end; { procedure SetPlotTrans }


procedure DisplayTrans(var PlotReal, PlotImag   : PlotArray;
                       var XDataReal, XDataImag : TNvectorPtr;
                           NumPoints, Rep       : integer;
                       var MemFull              : boolean);
{------------------------------------------------------------------}
{-    This procedure plots the tranforms in two small windows,    -}
{- which are also stored on the window stack.  It calls the       -}
{- procedure SetPlotTrans to prepare the plot.                    -}
{------------------------------------------------------------------}
const
  MaxFreqPlot = 128;

var
  WindNum, XLow, YHi, YLow : integer;
  MaxFreq, YMax, YMin, MemoryLeft : Float;

begin { procedure DisplayTrans }
  MaxFreq := NumPoints / 2;
  SetPlotTrans(XDataReal, NumPoints, -MaxFreq, MaxFreq-1, MaxFreqPlot, PlotReal);
  MakeWorld(PlotReal, NumPoints, 2);
  YMax := World[2].Y2;
  YMin := World[2].Y1;
  SetPlotTrans(XDataImag, NumPoints, -MaxFreq, MaxFreq-1, MaxFreqPlot, PlotImag);
  MakeWorld(PlotImag, NumPoints, 2);
  if World[2].Y2 > YMax then
    YMax := World[2].Y2;
  if World[2].Y1 < YMin then
    YMin := World[2].Y1;
  DefineWorld(2, -MaxFreqPlot, YMax, MaxFreqPlot-1, Ymin);
  SelectWorld(2);
  XLow := (3 * XMaxGlb div 4) + 1;
  YHi := 3 * YMaxGlb div 8;
  WindNum := NumReps + Rep;
  DefineWindow(WindNum, XLow, 0, XMaxGlb, YHi);
  DefineHeader(WindNum, 'Real Transform');
  SelectWindow(WindNum);
  SetHeaderOn;
  SetLineStyle(0);
  DrawBorder;
  DrawPolygon(PlotReal, 1, -NumPoints, -9, 1, -1);
  InvertWindow;
  MemoryLeft := MaxAvail;
  if MemoryLeft < 0 then
    MemoryLeft := 65536.0 + MemoryLeft;
  if (16.0 * MemoryLeft > WindowSize(WindNum)) and (not MemFull) then
    StoreWindow(WindNum)
  else
    MemFull := true;
  YLow := YHi + 1;
  YHi := 3 * YMaxGlb div 4;
  WindNum := 2 * NumReps + Rep;
  DefineWindow(WindNum, XLow, YLow, XMaxGlb, YHi);
  DefineHeader(WindNum, 'Imaginary Transform');
  SelectWindow(WindNum);
  SetHeaderOn;
  DrawBorder;
  DrawPolygon(PlotImag, 1, -NumPoints, -9, 1, -1);
  InvertWindow;
  MemoryLeft := MaxAvail;
  if MemoryLeft < 0 then
    MemoryLeft := 65536.0 + MemoryLeft;
  if (16.0 * MemoryLeft > WindowSize(WindNum)) and (not MemFull) then
    StoreWindow(WindNum)
  else
    MemFull := true;
end; { procedure DisplayTransform }


procedure TextDisplay(NumPoints : integer);
{---------------------------------------------------------}
{-  This procedure displays a window containing the       -}
{-  current information on the windows displayed and      -}
{-  instructions for rotating among the windows.          -}
{----------------------------------------------------------}
var
  YLow, WindNum : integer;

begin { procedure TextDisplay }
  WindNum := 3 * NumReps + 1;
  YLow := (3 * YMaxGlb div 4) + 1;
  DefineWindow(WindNum, 0, YLow, XMaxGlb, YMaxGlb);
  SelectWindow(WindNum);
  SetLineStyle(0);
  DrawBorder;
  GoToXY(12, 20);
  Write('Time interval = 2 seconds.  Sample rate = ', NumPoints div 2);
  Write(' per second.');
end; { procedure TextDisplay }


procedure DisplayInverse(var XdataReal          : TNvectorPtr;
                         var Plot               : PlotArray;
                             NumPoints, WindNum : integer;
                         var MemFull            : boolean);
{---------------------------------------------------------------}
{-   This procedure sets up the inverse transform for plotting -}
{- and plots it in a window already containing the raw data    -}
{- plot.  The window is then stored for retrival later.        -}
{---------------------------------------------------------------}
var
  MemoryLeft : Float;

begin { procedure DisplayInverse }
  SetPlot(XDataReal, NumPoints, -1, 1, Plot);
  SelectWorld(1);
  SelectWindow(WindNum);
  DrawAxis(8, -8, 0, 0, 0, 0, 0, 0, false);
  SetLineStyle(0);
  DrawPolygon(Plot, 1, -NumPoints, 0, 1, 0);
  MemoryLeft := MaxAvail;
  if MemoryLeft < 0 then
    MemoryLeft := 65536.0 + MemoryLeft;
  if (16.0 * MemoryLeft > WindowSize(WindNum)) and (not MemFull) then
    StoreWindow(WindNum)
  else
    MemFull := true;
end; { procedure DisplayInverse }


procedure GetSeconds(var RealSeconds : Float);
{------------------------------------------------------------------}
{-   This procedure reads MSDOS registers to record the time.  It -}
{- returns the current time in real seconds.                      -}
{------------------------------------------------------------------}
var
  Hours, Minutes, Seconds, Hundredths : integer;
  Regs : Registers;

begin { procedure GetSeconds }
  with Regs do
  begin
    AH := $2C;
    MsDos(Regs);
    Hours := CH;
    Minutes := CL;
    Seconds := DH;
    Hundredths := DL;
  end;
  RealSeconds := 3600 * Hours + 60 * Minutes + Seconds + 0.01 * Hundredths;
end; { procedure GetSeconds }

procedure CheckUserQuery;
var
  Query, DummyChar : char;

begin
  repeat
    Query := UpCase(ReadKey);
    while KeyPressed do
      DummyChar := ReadKey;
  until Query in [' ','Q'];
  if UpCase(Query)='Q' then
  begin
    {$I-} Close(ResFile); {$I+}
    ClearScreen;
    LeaveGraphic;
    Halt;
  end;
end; { procedure CheckUserQuery }

procedure FindFFTs(var RawData                     : TNvectorPtr;
                   var PlotReal, PlotImag, RawPlot : PlotArray;
                       NumPoints, Rep              : integer;
                   var ResFile                     : text;
                   var MemFull                     : boolean;
                   var ForwardTime, InverseTime    : TimeArray);
{-----------------------------------------------------------------}
{-    This procedure finds and plots the FFT for a given number  -}
{-  of sample points.  It also prints the FFTs for the maximum   -}
{-  sample size (1024) to the output file.                       -}
{-----------------------------------------------------------------}
var
  Count, Increment : integer;
  SampleResReal, SampleResImag : TNvectorPtr;
  Error : byte;
  Ch : char;
  StartSeconds, EndSeconds : Float;

begin { procedure FindFFTs }
  Initialize(SampleResReal);
  Initialize(SampleResImag);
  MakeDataWindow(RawPlot, TotNumPts, Rep, MemFull);
  TextDisplay(NumPoints);
  Increment := TotNumPts div NumPoints;
  for Count := 0 to NumPoints-1 do
    SampleResReal^[Count] := RawData^[Count*Increment];
  GoToXY(2, 23);
  Write('                                                             ');
  Write('               ');
  GoToXY(20, 23);
  Write('Now calculating transform.  Please wait.');
  GetSeconds(StartSeconds);
  RealFFT(NumPoints, false, SampleResReal, SampleResImag, Error);
  GetSeconds(EndSeconds);
  ForwardTime[Rep] := EndSeconds-StartSeconds;
  DisplayTrans(PlotReal, PlotImag, SampleResReal, SampleResImag,
               NumPoints, Rep, MemFull);
  GoToXY(2, 21);
  Write('                                                                          ');
  GoToXY(8, 21);
  Write('Transform time = ', ForwardTime[Rep]:5:1, ' seconds.');
  if Rep = NumReps then
  begin
    GoToXY(2, 23);
    Write('                                                             ');
    Write('               ');
    GoToXY(20, 23);
    Write('Writing to output file. Please wait.');
    if WriteToFile then
    begin
      Writeln(ResFile, 'Results from FFTDemo 1024 sample points.');
      Writeln(ResFile);
      Writeln(ResFile, '      Real         Imaginary');
      Writeln(ResFile);
      for Count := 0 to NumPoints-1 do
        Writeln(ResFile, SampleResReal^[Count], ' ', SampleResImag^[Count]);
      Close(ResFile);
    end
  end;
  GoToXY(2, 23);
  Write('                                                             ');
  Write('              ');
  GoToXY(16, 23);
  Write('Now calculating inverse transform.  Please wait.');
  GetSeconds(StartSeconds);
  ComplexFFT(NumPoints, true, SampleResReal, SampleResImag, Error);
  GetSeconds(EndSeconds);
  InverseTime[rep] := EndSeconds-StartSeconds;
  DisplayInverse(SampleResReal, PlotReal, NumPoints, Rep, MemFull);
  GoToXY(44, 21);
  Write('Inverse time = ', InverseTime[Rep]:5:1, ' seconds.');
  GoToXY(2, 23);
  Write('                                                             ');
  Write('               ');
  GoToXY(28, 23);
  GoToXY(20, 23);
  Write('Press <SPACE> to continue,  <Q> to quit ');
  CheckUserQuery;
  Dispose(SampleResReal);
  Dispose(SampleResImag);
end; { procedure FindFFTs }


procedure PrintScreen(Rep : integer);
{-----------------------------------------------------------------}
{-    This procedure prints the current screen image.  Only      -}
{- Epson printers are supported.                                 -}
{-----------------------------------------------------------------}
var
  WindNum : integer;
  Ch : char;

begin { procedure PrintScreen }
  GoToXY(2, 23);
  Write('                                                             ');
  Write('               ');
  GoToXY(4, 23);
  Write('Be sure printer is on and ready. Only Epson printers are supported.');
  GoToXY(2, 24);
  Write('                                                             ');
  Write('               ');
  GoToXY(14, 24);
  Write('Press any key when ready, A to abort printing.');
  Ch := UpCase(ReadKey);
  if Ch <> 'A' then
  begin
    WindNum := NumReps + Rep;
    SelectWindow(WindNum);
    InvertWindow;
    WindNum := 2 * NumReps + Rep;
    SelectWindow(WindNum);
    InvertWindow;
    GoToXY(2, 23);
    Write('                                                             ');
    Write('               ');
    GoToXY(2, 24);
    Write('                                                             ');
    Write('               ');
    HardCopy(false, PrinterMode);
    InvertWindow;
    WindNum := NumReps + Rep;
    SelectWindow(WindNum);
    InvertWindow;
  end;
end; { procedure PrintScreen }


procedure RotateWindows(MemFull                  : boolean;
                        ForwardTime, InverseTime : TimeArray);
{----------------------------------------------------------}
{-   This procedure allows the user to rotate around the  -}
{- four sets of windows.  It also give the option of      -}
{- printing the current window set before rotating.       -}
{----------------------------------------------------------}
var
  Ch : char;
  Rate : integer;

begin { procedure RotateWindows }
  if MemFull then
    begin
      GoToXY(2, 23);
      Write('                                                             ');
      Write('               ');
      GoToXY(12, 23);
      Write('Memory full.  Previous windows cannot be displayed. ');
      GoToXY(2, 24);
      Write('                                                             ');
      Write('               ');
      GoToXY(20, 24);
      Write('HARDCOPY with H, any other key to QUIT.');
      Ch := UpCase(ReadKey);
      if Ch = 'H' then
        PrintScreen(Rep);
    end
  else
    begin { Not MemFull, Can Rotate screens}
      Rep := 1;
      GoToXY(2, 23);
      Write('                                                             ');
      Write('               ');
      GoToXY(22, 23);
      Write('CYCLE through screens with SPACE KEY. ');
      GoToXY(2, 24);
      Write('                                                             ');
      Write('               ');
      GoToXY(25, 24);
      Write('QUIT with Q, HARDCOPY with H.');
      repeat
        Ch := UpCase(ReadKey);
        if Ch <> 'Q' then
        begin
          if Ch = 'H' then
            PrintScreen(Rep);
          SetColors;
          if Rep = 1 then
            Rate := 8
          else
            Rate := 4 * Rate;
          GoToXY(54, 20);
          Write(Rate, ' per second           ');
          GoToXY(2, 21);
          Write('                                                                          ');
          GoToXY(8, 21);
          Write('Transform time = ', ForwardTime[Rep]:5:1, ' seconds.');
          GoToXY(44, 21);
          Write('Inverse time = ', InverseTime[Rep]:5:1, ' seconds.');
          GoToXY(2, 23);
          Write
           ('                                                             ');
          Write('               ');
          GoToXY(22, 23);
          Write('CYCLE through screens with SPACE KEY. ');
          GoToXY(2, 24);
          Write
           ('                                                             ');
          Write('               ');
          GoToXY(25, 24);
          Write('QUIT with Q, HARDCOPY with H.');
          RestoreWindow(Rep, 0, 0);
          RestoreWindow(NumReps + Rep, 0, 0);
          RestoreWindow(2 * NumReps + Rep, 0, 0);
          Rep := Rep mod NumReps + 1;
        end;
      until Ch = 'Q';
    end;
end; { procedure RotateWindows }

{$F+}
function HeapFunc(Size : word) : integer;
begin
  LeaveGraphic;
  ClrScr;
  GotoXY(1, 1);
  Writeln('No space on Heap for dynamic variables in FFT routines.');
  Writeln('Try running FFTDemo as an .EXE file from disk.');
  HeapFunc := 1;
  Halt(1);
end;
{$F-}

begin { program FFTDemo }
  HeapError := @HeapFunc;  { Install heap error handler }
  MemFull := false;
  NumReps := CheckCapacity;
  GetFiles(DataFile, ResFile, FileErr);
  if MaxPlotGlb=1024 then
    InitGraphic
  else
    begin
      ClrScr;
      Writeln('MaxPlotGlb must be set to 1024 in GDriver.pas');
      Writeln('Strike any key to exit.'); Ans := ReadKey; Halt;
    end;
  if (FileErr = 0) and (not IOErr) then
  begin
    Initialize(RawData);
    GetRealVectorFromFile(DataFile, TotNumPts, RawData, FileErr);
    if FileErr = 0 then
    begin
      if ParamCount = 0 then
        IntroScreen;
      SetPlot(RawData, TotNumPts, -1, 1, RawPlot);
      MakeWorld(RawPlot, TotNumPts, 1);
      NumPoints := 4;
      for Rep := 1 to NumReps do
      begin
        NumPoints := NumPoints * 4;
        SetColors;
        FindFFTs(RawData, PlotReal, PlotImag, RawPlot, NumPoints, Rep,
                 ResFile, MemFull, ForWardTime, InverseTime);
      end;
      RotateWindows(MemFull, ForwardTime, InverseTime);
    end;
  end;
  Dispose(RawData);
  LeaveGraphic;
end. { program FFTDemo }

