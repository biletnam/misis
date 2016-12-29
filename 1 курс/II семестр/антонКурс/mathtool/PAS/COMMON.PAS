unit Common;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Numerical Methods Toolbox                                      -}
{-     Copyright (c) 1986, 87 Borland International, Inc.                   -}
{-                                                                          -}
{-     Contains I/O routines common to the entire toolbox.                  -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}                  { Turn off I/O error checking }

{$I Float.inc}         { Determines the setting of $N compiler directive }

interface

uses
  Dos, Crt;

var
  OutFile : text;      { The standard output channel }
  IOerr   : boolean;   { Flags I/O errors }

procedure DisplayWarning;
{ Send a warning message to OutFile. }

procedure DisplayError;
{ Send an error message to OutFile. }

procedure IOCheck;
{ Check for an I/O error and display an error message if needed. }

function InputChannel(Title : string) : char;
{ Displays a menu which allows the user to select either }
{ the keyboard or a file as a choice of where to get     }
{ input data from. If the keyboard is selected, 'K' is   }
{ returned otherwise, 'F' is returned.                   }

procedure GetOutputFile(var OutFile : text);
{ This procedure determines whether output should  }
{ be sent to the screen, printer, or a disk file.  }
{ The variable OutFile is returned as the standard }
{ output channel.                                  }

procedure ReadFloat(var FloatVar);
{ Returns a real number input from the user. If the user }
{ hits Return when being prompted for input, the default }
{ value assigned to FloatVar is returned. Editing is     }
{ allowed on all input.                                  }

procedure ReadInt(var IntVar : integer);
{ Returns an integer number input from the user. If the user }
{ hits Return when being prompted for input, the default     }
{ value assigned to IntVar is returned. Editing is allowed   }
{ on all input.                                              }

implementation

const
  Null = #0;          { Ascii character codes }
  Bell = #7;
  Esc  = #27;
  Cr   = #13;

type
  String80 = string[80];  { Generic string type }

procedure DisplayWarning;
begin
  Writeln(OutFile, '               <* --------------------------- *>');
  Write(OutFile, '               <*           ');
  LowVideo;
  Write(OutFile, 'WARNING           ');
  HighVideo;
  Writeln(OutFile, '*>');
  Writeln(OutFile, '               <* --------------------------- *>');
  Writeln(OutFile);
end;  { procedure DisplayWarning }

procedure DisplayError;
begin
  Writeln(OutFile, '               !! --------------------------- !!');
  Write(OutFile, '               !!            ');
  LowVideo;
  Write(OutFile, 'ERROR            ');
  HighVideo;
  Writeln(OutFile, '!!');
  Writeln(OutFile, '               !! --------------------------- !!');
  Writeln(OutFile);
end;  { procedure DisplayError }

procedure Beep;
begin
  Write(Bell);
end;

procedure IOCheck;
var
  IOcode : integer;

procedure Error(Msg : String80);
begin
  Writeln;
  Beep;
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
      150 : Error('Disk is write-protected.');
      151 : Error('Unknown unit.');
      152 : Error('Drive not ready.');
      153 : Error('Unknown command.');
      154 : Error('CRC error in data.');
      155 : Error('Bad drive request structure length.');
      156 : Error('Disk seek error.');
      157 : Error('Unknown media type.');
      158 : Error('Sector not found.');
      159 : Error('Printer out of paper.');
      160 : Error('Device write fault.');
      161 : Error('Device read fault.');
      162 : Error('Hardware failure.');
    else
      begin
        Writeln;
        Writeln(Bell);
        Writeln('Unidentified error message = ', IOcode, '. See manual.');
        Writeln;
      end;
    end; { case }
end; { procedure IOCheck }

{------------------------------------}
{-                                  -}
{-  Screen and cursor routines      -}
{-                                  -}
{------------------------------------}

const
  FirstCol       = 1;    { The number of display columns }
  LastCol        = 80;

type
  CursorState    = (SaveCursor, RestoreCursor, OffCursor, BoxCursor, ULCursor);

  CursorRec      = record
                     StartLine, EndLine : integer;
                   end;


const
  OriginalCursor : CursorRec = (StartLine : -1; { init to illegal value }
                                EndLine   : -1);

var
  BaseOfScreen   : word;         { The base address of screen memory }
  WaitForRetrace : boolean;      { Flags video snow checking         }

procedure Cursor(WhichCursor : CursorState; var SavedCursor : CursorRec);

procedure SetCursor(StartLine, EndLine : integer);
var
  RegPack : Registers;
begin
  with RegPack do
  begin
    AX := $0100;  { cursor interrupt }
    BX := $0;     { page #           }
    CH := Lo(StartLine);
    CL := Lo(EndLine);
    Intr($10, RegPack);
  end;
end; { SetCursor }

procedure GetCursor(var StartLine, EndLine : integer);
var
  RegPack : Registers;
begin
  with RegPack do
  begin
    AX := $0300;  { cursor interrupt }
    BX := $0;     { page #           }
    Intr($10, RegPack);
  end;
  StartLine := Hi(RegPack.CX);
  EndLine := Lo(RegPack.CX);
end; { GetCursor }

begin { Cursor }
  case WhichCursor of
    SaveCursor : begin
                   with SavedCursor do           { save previous cursor }
                     GetCursor(StartLine, Endline);
                 end;
    RestoreCursor
               : begin
                   with SavedCursor do           { restore previous cursor }
                     if (StartLine <> -1) and (EndLine <> -1) then
                       SetCursor(StartLine, EndLine)
                 end;
    OffCursor : SetCursor(32, 0);
    BoxCursor : SetCursor(1, 32);
    ULCursor  : if BaseOfScreen = $B800 then         { color }
                  SetCursor($06, $07)
                else
                  SetCursor($0B, $0C);               { mono }
  end; { case }
end; { Cursor }

procedure GetScreenMode;
var
  RegPack   : Registers;
  VideoMode : integer;
begin
  { Determine screen type for screen updating procedure }
  RegPack.AX := $0F00;
  { BIOS INT 10H call to get screen type }
  Intr($10, RegPack);
  VideoMode := RegPack.AL;
  WaitForRetrace := VideoMode <> 7;
  if WaitForRetrace then       { color? }
    BaseOfScreen := $B800
  else                         { mono }
    BaseOfScreen := $B000;
  Cursor(ULcursor, OriginalCursor);        { set UL cursor as default }
  Cursor(SaveCursor, OriginalCursor);      { save it }
end; { GetScreenMode }

var
  MemAdr : word;      { Address in memory for next char to display }

procedure MoveFromScreen(var Source, Dest; Len : integer);

{  Move memory, as Turbo Move, but assume that the source is in
   video memory; prevent screen flicker based on this assumption,
   unless WaitForRetrace is false.  Timing is VERY tight: if the code
   were 1 clock cycle slower, it would cause flicker. }

begin
  if not WaitForRetrace then
    Move(Source,Dest,Len)
  else
    begin
      Len := Len Shr 1;
      Inline($1E/$55/$BA/$DA/$03/$C5/$B6/ Source /$C4/$BE/ Dest /$8B/$8E/
             Len /$FC/$EC/$D0/$D8/$72/$FB/$FA/$EC/$D0/$D8/$73/$FB/$AD/
             $FB/$AB/$E2/$F0/$5D/$1F);
    end;
{
        push    ds              ; Save Turbo's DS
        push    bp              ;   and BP
        mov     DX,3da          ; Point DX to CGA status port
        lds     si,source[bp]   ; Source pointer into DS:SI
        les     di,dest[bp]     ; Dest pointer into ES:DI
        mov     CX,len[bp]      ; Length value into CX
        cld                     ; Set string direction to forward
.0:     in      al,DX           ; Get 6845 status
        rcr     al,1            ; Check horizontal retrace
        jb      .0              ; Loop if in horizontal retrace: this prevents
                                ;   starting in mid-retrace, since there is
                                ;   exactly enough time for 1 and only 1 LODSW
                                ;   during horizontal retrace
        cli                     ; No ints during critical section
.1:     in      al,DX           ; Get 6845 status
        rcr     al,1            ; Check for horizontal retrace: LODSW is 1
                                ;   clock cycle slower than STOSW; because of
                                ;   this, the vertical retrace trick can't be
                                ;   used because it causes flicker!  (RCR AL,1
                                ;   is 1 cycle faster than AND AL,AH)
        jnb     .1              ; Loop if not in retrace
        lodsw                   ; Load the video word
        sti                     ; Allow interrupts
        stosw                   ; Store the video word
        loop    .0              ; Go do next word
        pop     bp              ; Restore Turbo's BP
        pop     ds              ;   and DS
}
end; { MoveFromScreen }

procedure MoveToScreen(var Source, Dest; Len: integer);

{  Move memory, as Turbo Move, but assume that the target is in
   video memory; prevent screen flicker based on this assumption,
   unless RetraceMode is false.  Timing is VERY tight: if the code
   were 1 clock cycle slower, it would cause flicker. }

begin
  if not WaitForRetrace then
    Move(Source,Dest,Len)
  else
    begin
      Len := Len Shr 1;
      Inline($1E/$55/$BA/$DA/$03/$C5/$B6/ Source /$C4/$BE/ Dest /$8B/$8E/
             Len /$FC/$AD/$89/$C5/$B4/$09/$EC/$D0/$D8/$72/$FB/$FA/$EC/
             $20/$E0/$74/$FB/$89/$E8/$AB/$FB/$E2/$EA/$5D/$1F);
    end;
{
        push    ds              ; Save Turbo's DS
        push    bp              ;   and BP
        mov     DX,3da          ; Point DX to CGA status port
        lds     si,source[bp]   ; Source pointer into DS:SI
        les     di,dest[bp]     ; Dest pointer into ES:DI
        mov     CX,len[bp]      ; Length value into CX
        cld                     ; Set string direction to forward
.0:     lodsw                   ; Grab a video word
        mov     bp,AX           ; Save it in BP
        mov     ah,9            ; Move horiz. + vertical retrace mask to fast
                                ;   storage
.1:     in      al,DX           ; Get 6845 status
        rcr     al,1            ; Check horizontal retrace
        jb      .1              ; Loop if in horizontal retrace: this prevents
                                ;   starting in mid-retrace, since there is
                                ;   exactly enough time for 1 and only 1 STOSW
                                ;   during horizontal retrace
        cli                     ; No ints during critical section
.2:     in      al,DX           ; Get 6845 status
        and     al,ah           ; Check for both kinds of retrace: IF the
                                ;   video board does not report horizontal
                                ;   retrace while in vertical retrace, this
                                ;   will allow several characters to be
                                ;   stuffed in during vertical retrace
        jnz     .2              ; Loop if not equal zero
        mov     AX,bp           ; Get the video word
        stosw                   ; Store the video word
        sti                     ; Allow interrupts
        loop    .0              ; Go do next word
        pop     bp              ; Restore Turbo's BP
        pop     ds              ;   and DS
}
end; { MoveToScreen }

procedure SetMemAddress(Col, Row : byte);

{ The global variable MemAdr is assigned the value of the next location
  on the screen to be written to. }

begin
  MemAdr := Pred(Row) * (2 * LastCol) +     { add in prev. rows }
            (Pred(Col) * 2);                { add in Column offsets}
end; { SetMemAddress }

procedure SaveScreen(Var Adr; Num : byte);

{ Saves area of screen to temporary buffer.
  The paramater Adr passed to this routine is used as a temporary buffer
  to hold the next Num characters on the screen. }

begin
  MoveFromScreen(Mem[BaseOfScreen:MemAdr], Adr, Num shl 1);
end; { SaveScreen }

procedure RestoreScreen(var Adr; Num : byte);

{ Restore the original contents of the screen.
  The screen is restored with the contents of Adr. }

begin
  MoveToScreen(Adr, Mem[BaseOfScreen:MemAdr], Num shl 1);
end; { RestoreScreen }

procedure SaveWindow(var P; X1, Y1, X2, Y2 : integer);

{ Fill buffer "P" with screen memory under window defined by parameters }

var
  I : integer;
  Width : integer;
  Buffer : array[0..3999] of byte absolute P;
begin;
  Width := Succ(X2 - X1);
  for I := Y1 to Y2 do
  begin
    SetMemAddress(X1, I);                       { current row, first col }
    SaveScreen(Buffer[(I - Y1) * (Width * 2)], Width);
  end;
end;  { SaveWindow }

procedure RestoreWindow(var P; X1, Y1, X2, Y2 : integer);

{ Restore screen memory window defined by parameters with contents of
  buffer "P" }

var
  I : integer;
  Width : integer;
  Buffer : array[0..3999] of byte absolute P;
begin;
  Width := Succ(X2 - X1);
  for I := Y1 to Y2 do
  begin
    SetMemAddress(X1, I);     { current row, first col }
    RestoreScreen(Buffer[(I - Y1) * (Width * 2)], Width);
  end;
end;  { RestoreScreen }

{------------------------------------}
{-                                  -}
{-  Menu routines                   -}
{-                                  -}
{------------------------------------}

const
  ON  = true;    { Signals menu highlighting }
  OFF = false;

type
  { type for menu device selection }
  OutputDevice    = (NoDevice, ScreenDevice, FileDevice, PrinterDevice);

  { types for save screen logic }
  VideoRec        = record
                      ASCIIchar : char;
                      Att       : byte;
                    end;

  VideoLineBuffer = array[1..LastCol] of VideoRec;

function GetWsKey : char;
var
  Ch : char;
begin
  Ch := ReadKey;
  if (Ch = Null) and KeyPressed then
  begin
    Ch := ReadKey;
    case Ch of
      'H' : Ch := ^E;
      'P' : Ch := ^X;
    end;
  end;
  GetWsKey := UpCase(Ch);
end; { GetWsKey }

type
  BoxRec = record
             UL, UR, LL, LR, Horiz, Vert, LT, RT, TT, BT : char;
           end;
const
  { Used to store Ascii graphics charaters for drawing boxes }
  SingleBox : BoxRec = (UL    : 'Ú'; UR    : '¿';
                        LL    : 'À'; LR    : 'Ù';
                        Horiz : 'Ä'; Vert  : '³';
                        LT    : 'Ã'; RT    : '´';
                        TT    : 'Â'; BT    : 'Á');

procedure DrawBox(X, Y, Width, Height : integer;
                  Title : string80;
                  BorderAtt, TitleAtt : integer);
{ This routine draws a box AROUND (outside) the window coordinates it is
  given. It starts drawing a box at (x - 1, y - 1). The boxes dimensions
  are be width + 2 wide and height + 2 high. }
var
  I        : integer;
  S        : string[80];
  SLen     : byte absolute S;
  OldColor : integer;
begin
  Window(1, 1, 80, 25);
  OldColor := TextAttr;
  with SingleBox do
  begin
    FillChar(S, SizeOf(S), Horiz);  { fill string with horiz. chars }
    SLen := Width;
    X := Pred(X);
    Y := Pred(Y);
    Width := Succ(Width);
    Height := Succ(Height);
    TextAttr := BorderAtt;
    GoToXY(X, Y);                               { upper left }
    Write(UL, S, UR);
    for I := 1 to Height do                     { sides }
    begin
      GoToXY(X, Y + I);
      Write(Vert);
      GoToXY(X + Width, Y + I);
      Write(Vert);
    end;
    GoToXY(X, Y + Height);                      { lower left }
    Write(LL, S, LR);

    { Center title on top of box }
    if Title <> '' then
    begin
      GoToXY(X + Pred(Width - Ord(Title[0])) shr 1, Y);
      TextAttr := TitleAtt;
      Write(' ', Title, ' ');
    end;
  end; { with }
  TextAttr := OldColor;
end; { DrawBox }

procedure ShowMenuLine(S : String80;
                   NumHi : integer;
             HiAtt, X, Y : integer);
{ Write the string S at (X,Y). The first NumHi chars will be highlighted
  using the HiAtt color. The remaining chars will be written in the current
  color. }
var
  OldAtt : byte;
begin
  OldAtt := TextAttr;        { remember prev. attribute }
  TextAttr := HiAtt;
  GoToXY(X, Y);
  Write(Copy(S, 1, NumHi));
  TextAttr := OldAtt;        { restore }
  Write(Copy(S, Succ(NumHi), 255));
end; { ShowMenuLine }

var
  PrevLineBuffer : VideoLineBuffer;

procedure ShowMenuBar(TurnOn : boolean;
                        X, Y : integer;
                    BarWidth : integer;
                    BarColor : integer);
{ This routine reads the screen starting at (X, Y) and changes the
  next BarWidth characters to the BarColor color. When the bar is turned
  on, the current video line is preserved in the global PrevLineBuffer. When
  the bar is turned off, the screen is restored from PrevLineBuffer). }
var
  I          : integer;
  LineBuffer : VideoLineBuffer;
begin
  { calculate menu line's memory }
  SetMemAddress(X, Y);
  if TurnOn then
    begin
      SaveScreen(PrevLineBuffer, BarWidth);     { save curr. line from screen }
      Move(PrevLineBuffer,                      { copy curr. line }
           LineBuffer,
           SizeOf(LineBuffer));
      for I := 1 to BarWidth do                 { change attributes }
        Linebuffer[I].Att := BarColor;
      RestoreScreen(LineBuffer, BarWidth);      { write new line to screen }
    end { if }
  else
    RestoreScreen(PrevLineBuffer, BarWidth);    { restore prev. line }
end; { ShowMenuBar }

function UseMenu(X, Y, CurrItem, NumItems, BarWidth,
                 MenuBarColor : integer; MenuChoices : String80) : char;

{ Menu control routine: get a legal menu selection character }

var
  CursorData : CursorRec;
  P          : integer;
  Ch         : char;

begin { UseMenu }
  Cursor(SaveCursor, CursorData);            { save prev. cursor }
  Cursor(OffCursor, CursorData);             { turn cursor off }
  repeat
    repeat
      ShowMenuBar(ON,
                  X, Y + Pred(CurrItem),
                  BarWidth, MenuBarColor);
      Ch := GetWsKey;                      { Get a menu command key }
      ShowMenuBar(OFF,
                  X, Y + Pred(CurrItem),
                  BarWidth, MenuBarColor);

      { process keyboard input }
      case Ch of
        Esc, Cr : { Do nothing };

        ^E      : begin                         { up arrow }
                    CurrItem := Pred(CurrItem);
                    if CurrItem < 1 then
                      CurrItem := NumItems;
                  end;

        ^X      : begin                         { dn arrow }
                    CurrItem := Succ(CurrItem);
                    if CurrItem > NumItems then
                      CurrItem := 1;
                  end;
      else                               { legal menu choice? }
        P := Pos(Ch, MenuChoices);
        if P = 0 then
          Ch := Null
        else
          begin
            CurrItem := P;     { move curr item to selected one }
            Ch := Cr;          { simulate CR }
          end;
      end; { case }
    until Ch <> Null;
  until (Ch = Cr) or (Ch = Esc);

  { Done: return ordinal # (1, 2, 3..) or ESC }
  if Ch = Cr then
    UseMenu := Chr(CurrItem) { return ordinal number as a character #1, #2 etc. }
  else
    UseMenu := Ch;
  Cursor(RestoreCursor, CursorData);         { restore cursor }
end; { UseMenu }

type
  { The type of menu requested }
  MenuType = (InputSelection, OutPutSelection);

function PrintMenu(Title : String80; TypeOfMenu : MenuType) : OutputDevice;
{ Displays a menu for either input or output selection }

const
  X         = 30;   { The upper left corner of the menu }
  Y         = 10;
  Height    = 5;    { The height of the menu }
  HiAtt     = $0F;  { Character attributes for menu }
  LoAtt     = $07;
  BarAtt    = $70;
  CurrItem  = 1;    { The default item that is highlighted }
  BoxHeight = 7;    { The height of the menu box }
  MaxBuffer = 40;   { Determines size of MenuBuf }

var
  { Stores the screen beneath the menu }
  MenuBuf    : array[1..MaxBuffer, 1..MaxBuffer] of VideoRec;
  { Stores the screen beneath the help line }
  HelpBuf    : array[1..80] of VideoRec;

  OldX, OldY : integer; { Old cursor position }
  OldColor   : integer; { Old text color }
  Ch         : char;    { Key hit by user }
  NumItems   : integer; { # of menu items }
  Width      : integer; { Width of a particular menu }
  BoxWidth   : integer; { Width of Box around menu }

procedure ShowMenuHelpLine;
{ Display some help text on the 25th line of the screen }

const
  KeyHelpRow  = 25;
  KeyCapColor = $70;

begin
  GoToXY(1, KeyHelpRow);
  ClrEOL;
  ShowMenuLine(^X'-', 1, KeyCapColor, 2, KeyHelpRow);
  ShowMenuLine(^Y'-scroll', 1, KeyCapColor, WhereX, KeyHelpRow);
  ShowMenuLine(^Q#217'-select', 2, KeyCapColor, WhereX + 2, KeyHelpRow);
  ShowMenuLine('ESC-exit', 3, KeyCapColor, WhereX + 2, KeyHelpRow);
end; { ShowMenuHelpLine }

procedure ShowMenuLines;
begin
  DrawBox(X, Y, Width, Height, Title, HiAtt, HiAtt);
  Window(X, Y, X + Pred(Width), Y + Pred(height));
  ClrScr;
  if TypeOfMenu = InputSelection then
    begin
      ShowMenuLine('Keyboard',  1, HiAtt, 2, 2);
      ShowMenuLine('File',    1, HiAtt, 2, 3);
      NumItems := 2;
    end
  else
    begin
      ShowMenuLine('Screen',  1, HiAtt, 2, 2);
      ShowMenuLine('File',    1, HiAtt, 2, 3);
      ShowMenuLine('Printer', 1, HiAtt, 2, 4);
      NumItems := 3;
    end;
end; { ShowMenuLines }

begin
  Width := Length(Title) + 2;
  if Width < 18 then
    Width := 18;
  BoxWidth := Width + 2;
  GetScreenMode;
  { Save old "environment" }
  OldX := WhereX;
  OldY := WhereY;
  OldColor := TextAttr; { save color }
  SaveWindow(MenuBuf, Pred(X), Pred(Y), X + BoxWidth - 1, Y + BoxHeight - 1);

  { Paint the menu }
  TextAttr := LoAtt;
  Window(1, 1, 80, 25);
  SaveWindow(HelpBuf, 1, 25, 80, 25);
  ShowMenuHelpLine;
  ShowMenuLines;
  if TypeOfMenu = OutputSelection then
    { use the menu, return #1..#3 or ESC }
    Ch := UseMenu(X, Y + 1, CurrItem, NumItems, Width, BarAtt, 'SFP')
  else
    { use the menu, return #1, #2 or ESC }
    Ch := UseMenu(X, Y + 1, CurrItem, NumItems, Width, BarAtt, 'KF');
  case Ch of
    Esc : PrintMenu := NoDevice
  else
    PrintMenu := OutputDevice(Ord(Ch));
  end;

  { Restore old "environment" }
  Window(1, 1, 80, 25);
  GoToXY(OldX, OldY);
  TextAttr := OldColor;  { restore color }
  RestoreWindow(MenuBuf, Pred(X), Pred(Y), X + BoxWidth - 1, Y + BoxHeight - 1);
  RestoreWindow(HelpBuf, 1, 25, 80, 25);
end; { PrintMenu }

{------------------------------------}
{-                                  -}
{-  I/O Selection routines          -}
{-                                  -}
{------------------------------------}

procedure Abort;
begin
  Window(1, 1, 80, 25);
  NormVideo;
  ClrEol;
  GotoXY(1, 25);
  Write('Program terminated by user.');
  Halt;
end; { Abort }

function InputChannel(Title : string) : char;
begin
  case PrintMenu(Title, InputSelection) of
    ScreenDevice : InputChannel := 'K';
    FileDevice   : InputChannel := 'F';
    NoDevice     : Abort; { Halt the program! }
  else
    InputChannel := 'K';
  end; { case }
end; { InputChannel }

procedure GetOutputFile(var OutFile : text);
var
  FileName : String;
  Ch       : char;

begin
  case PrintMenu('Send Output To', OutPutSelection) of
    ScreenDevice  : begin
                      FileName  := 'CON';
                      Assign(OutFile, FileName);
                      Rewrite(OutFile);
                    end;

    PrinterDevice : begin
                      FileName := 'PRN';
                      Assign(OutFile, FileName);
                      Rewrite(OutFile);
                    end;

    FileDevice    : begin
                      repeat
                        Ch := 'Y';
                        Writeln;
                        Write('Enter file name ');
                        Readln(FileName);
                        Assign(OutFile, FileName);
                        Reset(OutFile);
                        if IOresult = 0 then  { The file already exists. }
                        begin
                          Close(OutFile);
                          Writeln;
                          Write('This file already exists. ');
                          Write('Write over it (Y/N)? ');
                          Ch := UpCase(ReadKey);
                          Writeln(Ch);
                        end;
                        if Ch = 'Y' then
                        begin
                          Rewrite(OutFile);
                          IOCheck;
                        end;
                      until((Ch = 'Y') and not(IOerr));
                    end;
    NoDevice      : Abort; { Halt the program! }
  else
    FileName  := 'CON';
    Assign(OutFile, FileName);
    Rewrite(OutFile);
  end; { case }
end; { procedure GetOutputFile }

{------------------------------------}
{-                                  -}
{-  String input routines           -}
{-                                  -}
{------------------------------------}

const
  BS       = #8;       { Ascii character return codes }
  LF       = #10;
  F1       = #187;
  F2       = #188;
  F3       = #189;
  F4       = #190;
  F5       = #191;
  F6       = #192;
  F7       = #193;
  F8       = #194;
  F9       = #195;
  F10      = #196;
  UpKey    = #200;
  DownKey  = #208;
  LeftKey  = #203;
  RightKey = #205;
  PgUpKey  = #201;
  PgDnKey  = #209;
  HomeKey  = #199;
  EndKey   = #207;
  InsKey   = #210;
  DelKey   = #211;

type
  CharSet = set of char;  { Character set type }

function ScanKey : char;
{ Scan for a key. Two charater return codes are }
{ returned as the second character + #128.      }
var
  Ch : Char;
begin
  Ch := ReadKey;
  if Ch = Null then
    Ch := Chr(Ord(ReadKey) + 128);
  if Ch in [^C, Esc] then
    Abort;
  ScanKey := Ch;
end; { ScanKey }

procedure InputStr(var S     : String;
                       L,X,Y : Integer;
                       LegalChars,
                       Term  : CharSet;
                   var TC    : Char    );
{ Input the string S with a maximum length of L at position (X, Y).  }
{ LegalChars contains all of the characters allowed for input. Term  }
{ contains all of the characters allowed for terminating input. TC   }
{ is the actual charater that terminated input.                      }
var
  P     : integer;
  Ch    : char;
  first : boolean;

begin
  first := true;
  GotoXY(X,Y); Write(S);
  P := 0;
  repeat
    GotoXY(X + P,Y);
    Ch := Upcase(ScanKey);
    if not (Ch in Term) then
      case Ch of
        #32..#126 : if (P < L) and
                       (ch in LegalChars) then
                    begin
                      if First then
                      begin
                        Write(' ':L);
                        Delete(S,P + 1,L);
                        GotoXY(X + P,Y);
                      end;
                      if Length(S) = L then
                        Delete(S,L,1);
                      P := succ(P);
                      Insert(Ch,S,P);
                      Write(Copy(S,P,L));
                    end
                    else Beep;
        ^S, LeftKey : if P > 0 then
                        P := pred(P)
                      else Beep;
        ^D, RightKey : if P < Length(S) then
                         P := succ(P)
                       else Beep;
         ^A, HomeKey : P := 0;
         ^F, EndKey  : P := Length(S);
         ^G, DelKey  : if P < Length(S) then
                       begin
                         Delete(S,P + 1,1);
                         Write(Copy(S,P + 1,L),' ');
                       end;
                 BS : if P > 0 then
                 begin
                   Delete(S,P,1);
                   Write(^H,Copy(S,P,L),' ');
                   P := pred(P);
                 end
                 else Beep;
        ^Y : begin
               Write(' ':L);
               Delete(S,P + 1,L);
             end;
      else;
    end;  {of case}
    First := false;
  until Ch in Term;
  P := Length(S);
  GotoXY(X + P,Y);
  Write('' :L - P);
  TC := Ch;
end; { InputStr }

{------------------------------------}
{-                                  -}
{-  Numeric input routines          -}
{-                                  -}
{------------------------------------}

function StrToFloat(NumStr : string; var Num) : integer;
{ Converts a numeric string to either real or double  }
{ depending upon how the $N compiler directive is set }
{ A function result of zero indicates that no errors  }
{ occurred.                                           }
var
  Code : integer;
{$IFOPT N+}
  r    : double;
{$ELSE}
  r    : real;
{$ENDIF}

begin
  Val(NumStr, r, Code);
  StrToFloat := Code;
  if Code <> 0 then Exit;   { Invalid numeric string }
  {$IFOPT N+}
    double(Num) := r
  {$ELSE}
    real(Num) := r
  {$ENDIF}
end; { StrToFloat }

function StrToInt(NumStr : string; var Num : integer) : integer;
{ Coverts a numeric string to an integer.             }
{ A function result of zero indicates that no errors  }
{ occurred. -1 is returned if a range error occurred. }
var
  Code : integer;
  l    : longint;
begin
  Val(NumStr, l, Code);
  StrToInt := Code;
  if Code <> 0 then Exit;      { Invalid numeric string }
  if (l >= -32768) and (l <= 32767) then
    Num := l
  else
    StrToInt := -1;  { Value out of legal integer range }
end; { StrToInt }

const
  Terminators : CharSet = [CR];  { Legal terminating character set }

procedure ReadFloat(var FloatVar);
{ Returns a real number input from the user. If the user }
{ hits Return when being prompted for input, the default }
{ value assigned to FloatVar is returned. Editing is     }
{ allowed on all input.                                  }

const
  MaxLen = 25; { the maximum length of the input area }
var
  NumStr    : string;
{$IFOPT N+}
  TempFloat : double;
{$ELSE}
  TempFloat : real;
{$ENDIF}
  TC        : char;

begin
  {$IFOPT N+}
  Str(Double(FloatVar), NumStr);
  {$ELSE}
  Str(real(FloatVar), NumStr);
  {$ENDIF}
  InputStr(NumStr, MaxLen, WhereX, WhereY, ['0'..'9', '.', '-', '+', 'e', 'E'],
             Terminators, TC);
  if Length(NumStr) > 0 then
    if StrToFloat(NumStr, TempFloat) = 0 then
      {$IFOPT N+}
      double(FloatVar) := TempFloat;
      {$ELSE}
      real(FloatVar) := TempFloat;
      {$ENDIF}
end; { ReadFloat }

procedure ReadInt(var IntVar : integer);
{ Returns an integer number input from the user. If the user }
{ hits Return when being prompted for input, the default     }
{ value assigned to IntVar is returned. Editing is allowed   }
{ on all input.                                              }

const
  MaxLen = 8;  { the maximum length of the input area }
var
  NumStr  : string;
  TempInt : integer;
  TC      : char;

begin
  Str(IntVar, NumStr);
  InputStr(NumStr, MaxLen, WhereX, WhereY, ['0'..'9', '+', '-'],
             Terminators, TC);
  if Length(NumStr) > 0 then
    if StrToInt(NumStr, TempInt) = 0 then
      IntVar := TempInt;
end; { ReadInt }

begin { Initialization section }
  IOerr := false;
end. { Common }
