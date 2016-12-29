unit FFT87B4;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for performing real and complex fast      -}
{-  fourier transforms. Radix-4 8087 version                                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$N+} { Requires the 8087 numeric co-processor }

interface

const
  TNArraySize = 1023;

type
  Float       = double;
  TNvector    = array[0..TNArraySize] of Float;
  TNvectorPtr = ^TNvector;

procedure TestInput(NumPoints       : integer;
                var NumberOfTwoBits : byte;
                var Error           : byte);

{-------------------------------------------------------------}
{- Input: NumPoints                                          -}
{- Output: NumberOfTwoBits, Error                            -}
{-                                                           -}
{- This procedure checks the input.  If the number of points -}
{- (NumPoints) is less than four or is not a multiple of     -}
{- four then an error is returned.  NumberOfTwoBits is the   -}
{- number of twobits (i.e. two bits) necessary to represent  -}
{- NumPoints in base 4 (e.g. if NumPoints = 16,              -}
{- NumberOfTwoBits = 3).                                     -}
{-------------------------------------------------------------}

procedure MakeSinCosTable(NumPoints : integer;
                      var SinTable  : TNvectorPtr;
                      var CosTable  : TNvectorPtr);

{--------------------------------------------------------}
{- Input: NumPoints                                     -}
{- Output: SinTable, CosTable                           -}
{-                                                      -}
{- This procedure fills in a table with sin and cosine  -}
{- values.  It is faster to pull data out of this table -}
{- than it is to recalculate the sines and cosines.     -}
{--------------------------------------------------------}

procedure FFT(NumberOfTwoBits : byte;
              NumPoints       : integer;
              Inverse         : boolean;
          var XReal           : TNvectorPtr;
          var XImag           : TNvectorPtr;
          var SinTable        : TNvectorPtr;
          var CosTable        : TNvectorPtr);

{-----------------------------------------------------}
{- Input: NumberOfTwoBits, NumPoints, Inverse,       -}
{-        XReal, XImag, SinTable, CosTable           -}
{- Output: XReal, XImag                              -}
{-                                                   -}
{- This procedure implements the actual fast fourier -}
{- transform routine.  The vector X, which must be   -}
{- entered in twobit-inverted order, is transformed  -}
{- in place.  The transformation uses the            -}
{- Cooley-Tukey algorithm.                           -}
{-----------------------------------------------------}

procedure RealFFT(NumPoints : integer;
                  Inverse   : boolean;
              var XReal     : TNvectorPtr;
              var XImag     : TNvectorPtr;
              var Error     : byte);


{---------------------------------------------------------------------------}
{-                                                                         -}
{-    Input: NumPoints, Inverse, XReal, XImag,                             -}
{-    Output: XReal, XImag, Error                                          -}
{-                                                                         -}
{-    Purpose:  This procedure uses the complex Fourier transform          -}
{-              routine (FFT) to transform real data.  The real data       -}
{-              is in the vector XReal.  Appropriate shuffling of indices  -}
{-              changes the real vector into two vectors (representing     -}
{-              complex data) which are only half the size of the original -}
{-              vector.  Appropriate unshuffling at the end produces the   -}
{-              transform of the real data.                                -}
{-                                                                         -}
{-  User Defined Types:                                                    -}
{-         TNvector = array[0..TNArraySize] of real                        -}
{-      TNvectorPtr = ^TNvector                                            -}
{-                                                                         -}
{- Global Variables:  NumPoints   : integer     Number of data             -}
{-                                              points in X                -}
{-                    Inverse     : boolean     False => forward transform -}
{-                                              True ==> inverse transform -}
{-                    XReal,XImag : TNvectorPtr Data points                -}
{-                    Error       : byte        Indicates an error         -}
{-                                                                         -}
{-             Errors:  0: No Errors                                       -}
{-                      1: NumPoints < 2                                   -}
{-                      2: NumPoints not a power of two                    -}
{-                         (or 4 for radix-4 transforms)                   -}
{-                                                                         -}
{---------------------------------------------------------------------------}

procedure RealConvolution(NumPoints : integer;
                      var XReal     : TNvectorPtr;
                      var XImag     : TNvectorPtr;
                      var HReal     : TNvectorPtr;
                      var Error     : byte);

{-------------------------------------------------------------------}
{-                                                                 -}
{-   Input: NumPoints, XReal, XImag, HReal                         -}
{-   Output: XReal, XImag, Error                                   -}
{-                                                                 -}
{-   Purpose: This procedure performs a convolution of the         -}
{-            real data XReal and HReal.  The result is returned   -}
{-            in the complex vector XReal, XImag.                  -}
{-                                                                 -}
{- User Defined Types:                                             -}
{-         TNvector = array[0..TNArraySize] of real                -}
{-      TNvectorPtr = ^TNvector                                    -}
{-                                                                 -}
{- Global Variables:  NumPoints : integer     Number of data       -}
{-                                            points in X          -}
{-                    XReal     : TNvectorPtr Data points          -}
{-                    HReal     : TNvectorPtr Data points          -}
{-                    Error     : byte        Indicates an error   -}
{-                                                                 -}
{-             Errors:  0: No Errors                               -}
{-                      1: NumPoints < 2                           -}
{-                      2: NumPoints not a power of two            -}
{-                                                                 -}
{-------------------------------------------------------------------}

procedure RealCorrelation(NumPoints : integer;
                      var Auto      : boolean;
                      var XReal     : TNvectorPtr;
                      var XImag     : TNvectorPtr;
                      var HReal     : TNvectorPtr;
                      var Error     : byte);

{-------------------------------------------------------------------}
{-                                                                 -}
{-   Input: NumPoints, Auto, XReal, XImag, HReal                   -}
{-   Output: XReal, XImag, Error                                   -}
{-                                                                 -}
{-   Purpose: This procedure performs a correlation (auto or       -}
{-            cross) of the real data XReal and HReal. The         -}
{-            correlation is returned in the complex vector        -}
{-            XReal, XImag.                                        -}
{-                                                                 -}
{- User Defined Types:                                             -}
{-         TNvector = array[0..TNArraySize] OF real                -}
{-      TNvectorPtr = ^TNvector                                    -}
{-                                                                 -}
{- Global Variables:  NumPoints : integer     Number of data       -}
{-                                            points in X          -}
{-                    Auto      : boolean     True => auto-        -}
{-                                                    correlation  -}
{-                                            False=> cross-       -}
{-                                                    correlation  -}
{-                    XReal     : TNvectorPtr First sample         -}
{-                    HReal     : TNvectorPtr Second sample        -}
{-                    Error     : byte        Indicates an error   -}
{-                                                                 -}
{-             Errors:  0: No Errors                               -}
{-                      1: NumPoints < 2                           -}
{-                      2: NumPoints not a power of two            -}
{-                                                                 -}
{-------------------------------------------------------------------}

procedure ComplexFFT(NumPoints : integer;
                     Inverse   : boolean;
                 var XReal     : TNvectorPtr;
                 var XImag     : TNvectorPtr;
                 var Error     : byte);

{-------------------------------------------------------------------}
{-                                                                 -}
{-   Input: NumPoints, Inverse, XReal, XImag                       -}
{-   Output: XReal, XImag, Error                                   -}
{-                                                                 -}
{-   Purpose: This procedure performs a fast Fourier transform     -}
{-            of the complex data XReal, XImag. The vectors XReal  -}
{-            and XImag are transformed in place.                  -}
{-                                                                 -}
{- User Defined Types:                                             -}
{-         TNvector = array[0..TNArraySize] of real                -}
{-         TNvectorPtr = ^TNvector                                 -}
{-                                                                 -}
{- Global Variables:  NumPoints : integer      Number of data      -}
{-                                             points in X         -}
{-                    Inverse   : BOOLEAN      FALSE => Forward    -}
{-                                                      Transform  -}
{-                                             TRUE => Inverse     -}
{-                                                     Transform   -}
{-                    XReal,                                       -}
{-                    XImag     : TNvectorPtr  Data points         -}
{-                    Error     : byte         Indicates an error  -}
{-                                                                 -}
{-             Errors:  0: No Errors                               -}
{-                      1: NumPoints < 2                           -}
{-                      2: NumPoints not a power of two            -}
{-                                                                 -}
{-------------------------------------------------------------------}

procedure ComplexConvolution(NumPoints : integer;
                         var XReal     : TNvectorPtr;
                         var XImag     : TNvectorPtr;
                         var HReal     : TNvectorPtr;
                         var HImag     : TNvectorPtr;
                         var Error     : byte);

{-------------------------------------------------------------------}
{-                                                                 -}
{-   Input: NumPoints, XReal, XImag, HReal, HImag                  -}
{-   Output: XReal, XImag, Error                                   -}
{-                                                                 -}
{-   Purpose: This procedure performs a convolution of the         -}
{-            data XReal, XImag and the data HReal and HImag. The  -}
{-            vectors XReal, XImag, HReal and HImag are            -}
{-            transformed in place.                                -}
{-                                                                 -}
{- User Defined Types:                                             -}
{-         TNvector = array[0..TNArraySize] of real                -}
{-      TNvectorPtr = ^TNvector                                    -}
{-                                                                 -}
{- Global Variables:  NumPoints   : integer     Number of data     -}
{-                                              points in X        -}
{-                    XReal,XImag : TNvectorPtr Data points        -}
{-                    HReal,HImag : TNvectorPtr Data points        -}
{-                    Error       : byte        Indicates an error -}
{-                                                                 -}
{-             Errors:  0: No Errors                               -}
{-                      1: NumPoints < 2                           -}
{-                      2: NumPoints not a power of two            -}
{-                                                                 -}
{-------------------------------------------------------------------}

procedure ComplexCorrelation(NumPoints : integer;
                         var Auto      : boolean;
                         var XReal     : TNvectorPtr;
                         var XImag     : TNvectorPtr;
                         var HReal     : TNvectorPtr;
                         var HImag     : TNvectorPtr;
                         var Error     : byte);

{-------------------------------------------------------------------}
{-                                                                 -}
{-   Input: NumPoints, Auto, XReal, XImag, HReal, HImag            -}
{-   Output: XReal, XImag, Error                                   -}
{-                                                                 -}
{-   Purpose: This procedure performs a correlation (auto or       -}
{-            cross) of the complex data XReal, XImag and the      -}
{-            complex data HReal, HImag. The vectors XReal, XImag, -}
{-            HReal, and HImag are transformed in place.           -}
{-                                                                 -}
{- User Defined Types:                                             -}
{-         TNvector = array[0..TNArraySize] of real                -}
{-      TNvectorPtr = ^TNvector                                    -}
{-                                                                 -}
{- Global Variables:  NumPoints   : integer   Number of data       -}
{-                                            points in X          -}
{-                    Auto        : boolean   True => auto-        -}
{-                                                    correlation  -}
{-                                            False=> cross-       -}
{-                                                    correlation  -}
{-                    XReal,XImag : TNvectorPtr First sample       -}
{-                    HReal,HImag : TNvectorPtr Second sample      -}
{-                    Error       : byte        Indicates an error -}
{-                                                                 -}
{-             Errors:  0: No Errors                               -}
{-                      1: NumPoints < 2                           -}
{-                      2: NumPoints not a power of two            -}
{-                                                                 -}
{-------------------------------------------------------------------}

implementation

procedure TestInput{(NumPoints       : integer;
                 var NumberOfTwoBits : byte;
                 var Error           : byte)};

type
  ShortArray = array[1..6] of integer;

var
  Term : integer;

const
  PowersOfFour : ShortArray = (4, 16, 64, 256, 1024, 4096);

begin
  Error := 2;  { Assume NumPoints not a power of four  }
  if NumPoints < 4 then
    Error := 1;     { NumPoints < 4  }
  Term := 1;
  while (Term <= 6) and (Error = 2) do
  begin
    if NumPoints = PowersOfFour[Term] then
    begin
      NumberOfTwoBits := Term;
      Error := 0;  { NumPoints is a power of four  }
    end;
    Term := Succ(Term);
  end;
end; { procedure TestInput }

procedure MakeSinCosTable{(NumPoints : integer;
                       var SinTable  : TNvectorPtr;
                       var CosTable  : TNvectorPtr)};

var
  RealFactor, ImagFactor : Float;
  Term : integer;
  TermMinus1 : integer;
  UpperLimit : integer;

begin
  RealFactor :=  Cos(Pi / (NumPoints SHR 1));
  ImagFactor := -Sqrt(1 - Sqr(RealFactor));
  CosTable^[0] := 1;
  SinTable^[0] := 0;
  CosTable^[1] := RealFactor;
  SinTable^[1] := ImagFactor;
  UpperLimit := 3 * NumPoints SHR 2 - 1;
  for Term := 2 to UpperLimit do
  begin
    TermMinus1 := Term - 1;
    CosTable^[Term] := CosTable^[TermMinus1] * RealFactor -
                       SinTable^[TermMinus1] * ImagFactor;
    SinTable^[Term] := CosTable^[TermMinus1] * ImagFactor +
                       SinTable^[TermMinus1] * RealFactor;
  end;
end; { procedure MakeSinCosTable }

procedure FFT{(NumberOfTwoBits : byte;
               NumPoints       : integer;
               Inverse         : boolean;
           var XReal           : TNvectorPtr;
           var XImag           : TNvectorPtr;
           var SinTable        : TNvectorPtr;
           var CosTable        : TNvectorPtr)};

const
  RootTwoOverTwo = 0.707106781186548;

var
  Term : byte;
  CellSeparation : integer;
  NumberOfCells : integer;
  NumElementsInCell : integer;
  NumElInCellLess1 : integer;
  NumElInCellDIV2 : integer;
  NumElInCellDIV4 : integer;
  CellElements : integer;
  Index : integer;
  RealRootOfUnity1, ImagRootOfUnity1 : Float;
  RealRootOfUnity2, ImagRootOfUnity2 : Float;
  RealRootOfUnity3, ImagRootOfUnity3 : Float;
  Element0 : integer;
  Element1 : integer;
  Element2 : integer;
  Element3 : integer;
  RealDummy0, ImagDummy0 : Float;
  RealDummy1, ImagDummy1 : Float;
  RealDummy2, ImagDummy2 : Float;
  RealDummy3, ImagDummy3 : Float;
  RealSum02, ImagSum02 : Float;
  RealDif02, ImagDif02 : Float;
  RealSum13, ImagSum13 : Float;
  RealDifi13, ImagDifi13 : Float;

procedure BitInvert(NumberOfTwoBits : byte;
                    NumPoints       : integer;
                var XReal           : TNvectorPtr;
                var XImag           : TNvectorPtr);

{-----------------------------------------------------------}
{- Input: NumberOfBits, NumPoints                          -}
{- Output: XReal, XImag                                    -}
{-                                                         -}
{- This procedure twobit inverts the order of data in the  -}
{- vector X.  Twobit inversion reverses the order of the   -}
{- base 4 representation of the indices; thus 2 indices    -}
{- will be switched.  For example, if there are 16 points, -}
{- Index 11 (23 base 4) would be switched with Index 14    -}
{- (32 base 4).  It is necessary to twobit invert the      -}
{- order of the data so that the transformation comes out  -}
{- in the correct order.                                   -}
{-----------------------------------------------------------}

var
  Term : integer;
  Invert : integer;
  Hold : Float;
  DummyTerm, TwoBits : integer;

begin
  for Term := 1 to NumPoints - 1 do
  begin
    Invert := 0;
    DummyTerm := Term;
    for TwoBits := 1 to NumberOfTwoBits do
    begin
      Invert := Invert SHL 2 + DummyTerm MOD 4;
      DummyTerm := DummyTerm SHR 2;
    end;
    if Invert > Term then     { Switch the two indices  }
    begin
      Hold := XReal^[Invert];
      XReal^[Invert] := XReal^[Term];
      XReal^[Term] := Hold;
      Hold := XImag^[Invert];
      XImag^[Invert] := XImag^[Term];
      XImag^[Term] := Hold;
    end;
  end;
end; { procedure BitInvert }

begin { procedure FFT }
  { The data must be entered in bit inverted order }
  { for the transform to come out in proper order  }
  BitInvert(NumberOfTwoBits, NumPoints, XReal, XImag);

  if Inverse then
    { Conjugate the input  }
    for Index := 0 to NumPoints - 1 do
      XImag^[Index] := -XImag^[Index];

  NumberOfCells := NumPoints;
  CellSeparation := 1;
  for Term := 1 to NumberOfTwoBits do
  begin
    NumberOfCells := NumberOfCells SHR 2;
    NumElementsInCell := CellSeparation;
    CellSeparation := CellSeparation SHL 2;
    NumElInCellLess1 := NumElementsInCell - 1;
    NumElInCellDIV2 := NumElementsInCell SHR 1;
    NumElInCellDIV4 := NumElInCellDIV2 SHR 1;

    { Special case: RootOfUnity1 = EXP(-i 0)  }
    Element0 := 0;
    while Element0 < NumPoints do
    begin
      { Combine the X[Element] with the element in  }
      { the identical location in the next cell     }
      Element1 := Element0 + NumElementsInCell;
      Element2 := Element1 + NumElementsInCell;
      Element3 := Element2 + NumElementsInCell;

      RealDummy0 := XReal^[Element0];
      ImagDummy0 := XImag^[Element0];
      RealDummy1 := XReal^[Element1];
      ImagDummy1 := XImag^[Element1];
      RealDummy2 := XReal^[Element2];
      ImagDummy2 := XImag^[Element2];
      RealDummy3 := XReal^[Element3];
      ImagDummy3 := XImag^[Element3];

      RealSum02 := RealDummy0 + RealDummy2;
      ImagSum02 := ImagDummy0 + ImagDummy2;
      RealSum13 := RealDummy1 + RealDummy3;
      ImagSum13 := ImagDummy1 + ImagDummy3;
      RealDif02 := RealDummy0 - RealDummy2;
      ImagDif02 := ImagDummy0 - ImagDummy2;
      RealDifi13 := ImagDummy3 - ImagDummy1;
      ImagDifi13 := RealDummy1 - RealDummy3;

      XReal^[Element0] := RealSum02 + RealSum13;
      XImag^[Element0] := ImagSum02 + ImagSum13;
      XReal^[Element1] := RealDif02 - RealDifi13;
      XImag^[Element1] := ImagDif02 - ImagDifi13;
      XReal^[Element2] := RealSum02 - RealSum13;
      XImag^[Element2] := ImagSum02 - ImagSum13;
      XReal^[Element3] := RealDif02 + RealDifi13;
      XImag^[Element3] := ImagDif02 + ImagDifi13;

      Element0 := Element0 + CellSeparation;
    end; { while }

    for CellElements := 1 to  NumElInCellDIV4 - 1 do
    begin
      Index := CellElements * NumberOfCells;
      RealRootOfUnity1 := CosTable^[Index];
      ImagRootOfUnity1 := SinTable^[Index];
      RealRootOfUnity2 := CosTable^[2*Index];
      ImagRootOfUnity2 := SinTable^[2*Index];
      RealRootOfUnity3 := CosTable^[3*Index];
      ImagRootOfUnity3 := SinTable^[3*Index];
      Element0 := CellElements;
      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := XReal^[Element1] * RealRootOfUnity1 -
                      XImag^[Element1] * ImagRootOfUnity1;
        ImagDummy1 := XReal^[Element1] * ImagRootOfUnity1 +
                      XImag^[Element1] * RealRootOfUnity1;
        RealDummy2 := XReal^[Element2] * RealRootOfUnity2 -
                      XImag^[Element2] * ImagRootOfUnity2;
        ImagDummy2 := XReal^[Element2] * ImagRootOfUnity2 +
                      XImag^[Element2] * RealRootOfUnity2;
        RealDummy3 := XReal^[Element3] * RealRootOfUnity3 -
                      XImag^[Element3] * ImagRootOfUnity3;
        ImagDummy3 := XReal^[Element3] * ImagRootOfUnity3 +
                      XImag^[Element3] * RealRootOfUnity3;

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end; { for }

    { special case: RootOfUnity = EXP(-i PI/8)  }
    if Term > 1 then
    begin
      Index := NumElInCellDIV4 * NumberOfCells;
      RealRootOfUnity1 := CosTable^[Index];
      ImagRootOfUnity1 := SinTable^[Index];
      RealRootOfUnity3 := -ImagRootOfUnity1;
      ImagRootOfUnity3 := -RealRootOfUnity1;

      Element0 := NumElInCellDIV4;
      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := XReal^[Element1] * RealRootOfUnity1 -
                      XImag^[Element1] * ImagRootOfUnity1;
        ImagDummy1 := XReal^[Element1] * ImagRootOfUnity1 +
                      XImag^[Element1] * RealRootOfUnity1;
        RealDummy2 := RootTwoOverTwo * (XReal^[Element2] + XImag^[Element2]);
        ImagDummy2 := RootTwoOverTwo * (XImag^[Element2] - XReal^[Element2]);
        RealDummy3 := XReal^[Element3] * RealRootOfUnity3 -
                      XImag^[Element3] * ImagRootOfUnity3;
        ImagDummy3 := XReal^[Element3] * ImagRootOfUnity3 +
                      XImag^[Element3] * RealRootOfUnity3;

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end;

    for CellElements := NumElInCellDIV4 + 1 to NumElInCellDIV2 - 1 do
    begin
      Index := CellElements * NumberOfCells;
      RealRootOfUnity1 := CosTable^[Index];
      ImagRootOfUnity1 := SinTable^[Index];
      RealRootOfUnity2 := CosTable^[2*Index];
      ImagRootOfUnity2 := SinTable^[2*Index];
      RealRootOfUnity3 := CosTable^[3*Index];
      ImagRootOfUnity3 := SinTable^[3*Index];
      Element0 := CellElements;
      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := XReal^[Element1] * RealRootOfUnity1 -
                      XImag^[Element1] * ImagRootOfUnity1;
        ImagDummy1 := XReal^[Element1] * ImagRootOfUnity1 +
                      XImag^[Element1] * RealRootOfUnity1;
        RealDummy2 := XReal^[Element2] * RealRootOfUnity2 -
                      XImag^[Element2] * ImagRootOfUnity2;
        ImagDummy2 := XReal^[Element2] * ImagRootOfUnity2 +
                      XImag^[Element2] * RealRootOfUnity2;
        RealDummy3 := XReal^[Element3] * RealRootOfUnity3 -
                      XImag^[Element3] * ImagRootOfUnity3;
        ImagDummy3 := XReal^[Element3] * ImagRootOfUnity3 +
                      XImag^[Element3] * RealRootOfUnity3;

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end; { for }

    { Special case: RootOfUnity1 := EXP(-i PI/4)  }
    if Term > 1 then
    begin
      Element0 := NumElInCellDIV2;
      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := RootTwoOverTwo * (XReal^[Element1] + XImag^[Element1]);
        ImagDummy1 := RootTwoOverTwo * (XImag^[Element1] - XReal^[Element1]);
        RealDummy2 :=  XImag^[Element2];
        ImagDummy2 := -XReal^[Element2];
        RealDummy3 := -RootTwoOverTwo * (XReal^[Element3] - XImag^[Element3]);
        ImagDummy3 := -RootTwoOverTwo * (XReal^[Element3] + XImag^[Element3]);

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end;

    for CellElements := NumElInCellDIV2 + 1 to
        (NumElementsInCell - NumElInCellDIV4 - 1) do
    begin
      Index := CellElements * NumberOfCells;
      RealRootOfUnity1 := CosTable^[Index];
      ImagRootOfUnity1 := SinTable^[Index];
      RealRootOfUnity2 := CosTable^[2*Index];
      ImagRootOfUnity2 := SinTable^[2*Index];
      RealRootOfUnity3 := CosTable^[3*Index];
      ImagRootOfUnity3 := SinTable^[3*Index];
      Element0 := CellElements;
      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := XReal^[Element1] * RealRootOfUnity1 -
                      XImag^[Element1] * ImagRootOfUnity1;
        ImagDummy1 := XReal^[Element1] * ImagRootOfUnity1 +
                      XImag^[Element1] * RealRootOfUnity1;
        RealDummy2 := XReal^[Element2] * RealRootOfUnity2 -
                      XImag^[Element2] * ImagRootOfUnity2;
        ImagDummy2 := XReal^[Element2] * ImagRootOfUnity2 +
                      XImag^[Element2] * RealRootOfUnity2;
        RealDummy3 := XReal^[Element3] * RealRootOfUnity3 -
                      XImag^[Element3] * ImagRootOfUnity3;
        ImagDummy3 := XReal^[Element3] * ImagRootOfUnity3 +
                      XImag^[Element3] * RealRootOfUnity3;

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end; { for }

    { Special case: RootOfUnity = EXP(-i 3*PI/8)  }
    if Term > 1 then
    begin
      Element0 := NumElementsInCell - NumElInCellDIV4;
      Index := Element0 * NumberOfCells;
      RealRootOfUnity1 := CosTable^[Index];
      ImagRootOfUnity1 := SinTable^[Index];
      RealRootOfUnity3 := ImagRootOfUnity1;
      ImagRootOfUnity3 := RealRootOfUnity1;

      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := XReal^[Element1] * RealRootOfUnity1 -
                      XImag^[Element1] * ImagRootOfUnity1;
        ImagDummy1 := XReal^[Element1] * ImagRootOfUnity1 +
                      XImag^[Element1] * RealRootOfUnity1;
        RealDummy2 := -RootTwoOverTwo * (XReal^[Element2] - XImag^[Element2]);
        ImagDummy2 := -RootTwoOverTwo * (XReal^[Element2] + XImag^[Element2]);
        RealDummy3 := XReal^[Element3] * RealRootOfUnity3 -
                      XImag^[Element3] * ImagRootOfUnity3;
        ImagDummy3 := XReal^[Element3] * ImagRootOfUnity3 +
                      XImag^[Element3] * RealRootOfUnity3;

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end;

    for CellElements := (NumElementsInCell - NumElInCellDIV4 + 1) to
                                                 NumElInCellLess1 do
    begin
      Index := CellElements * NumberOfCells;
      RealRootOfUnity1 := CosTable^[Index];
      ImagRootOfUnity1 := SinTable^[Index];
      RealRootOfUnity2 := CosTable^[2*Index];
      ImagRootOfUnity2 := SinTable^[2*Index];
      RealRootOfUnity3 := CosTable^[3*Index];
      ImagRootOfUnity3 := SinTable^[3*Index];
      Element0 := CellElements;
      while Element0 < NumPoints do
      begin
        { Combine the X[Element] with the element in  }
        { the identical location in the next cell     }
        Element1 := Element0 + NumElementsInCell;
        Element2 := Element1 + NumElementsInCell;
        Element3 := Element2 + NumElementsInCell;

        RealDummy0 := XReal^[Element0];
        ImagDummy0 := XImag^[Element0];
        RealDummy1 := XReal^[Element1] * RealRootOfUnity1 -
                      XImag^[Element1] * ImagRootOfUnity1;
        ImagDummy1 := XReal^[Element1] * ImagRootOfUnity1 +
                      XImag^[Element1] * RealRootOfUnity1;
        RealDummy2 := XReal^[Element2] * RealRootOfUnity2 -
                      XImag^[Element2] * ImagRootOfUnity2;
        ImagDummy2 := XReal^[Element2] * ImagRootOfUnity2 +
                      XImag^[Element2] * RealRootOfUnity2;
        RealDummy3 := XReal^[Element3] * RealRootOfUnity3 -
                      XImag^[Element3] * ImagRootOfUnity3;
        ImagDummy3 := XReal^[Element3] * ImagRootOfUnity3 +
                      XImag^[Element3] * RealRootOfUnity3;

        RealSum02 := RealDummy0 + RealDummy2;
        ImagSum02 := ImagDummy0 + ImagDummy2;
        RealSum13 := RealDummy1 + RealDummy3;
        ImagSum13 := ImagDummy1 + ImagDummy3;
        RealDif02 := RealDummy0 - RealDummy2;
        ImagDif02 := ImagDummy0 - ImagDummy2;
        RealDifi13 := ImagDummy3 - ImagDummy1;
        ImagDifi13 := RealDummy1 - RealDummy3;

        XReal^[Element0] := RealSum02 + RealSum13;
        XImag^[Element0] := ImagSum02 + ImagSum13;
        XReal^[Element1] := RealDif02 - RealDifi13;
        XImag^[Element1] := ImagDif02 - ImagDifi13;
        XReal^[Element2] := RealSum02 - RealSum13;
        XImag^[Element2] := ImagSum02 - ImagSum13;
        XReal^[Element3] := RealDif02 + RealDifi13;
        XImag^[Element3] := ImagDif02 + ImagDifi13;

        Element0 := Element0 + CellSeparation;
      end; { while }
    end; { for }
  end; { for }

  {----------------------------------------------------}
  {-  Divide all the values of the transformation     -}
  {-  by the square root of NumPoints. If taking the  -}
  {-  inverse, conjugate the output.                  -}
  {----------------------------------------------------}

  if Inverse then
    ImagDummy1 := -1 / Sqrt(NumPoints)
  else
    ImagDummy1 :=  1 / Sqrt(NumPoints);
  RealDummy1 := ABS(ImagDummy1);
  for Element0 := 0 to NumPoints - 1 do
  begin
    XReal^[Element0] := XReal^[Element0] * RealDummy1;
    XImag^[Element0] := XImag^[Element0] * ImagDummy1;
  end;
end; { procedure FFT }

{$I FFT.inc} { Include procedure code }

end. { FFT87B4 }
