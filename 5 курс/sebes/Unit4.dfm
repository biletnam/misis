object Form4: TForm4
  Left = 0
  Top = 0
  Caption = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
  ClientHeight = 480
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 8
    Top = 8
    Width = 681
    Height = 464
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3DOptions.Elevation = 315
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 0
    View3DOptions.Rotation = 360
    Zoom.Animated = True
    TabOrder = 0
    PrintMargins = (
      15
      16
      15
      16)
    ColorPaletteIndex = 11
    object Series1: TPieSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Style = smsLabelPercent
      Marks.Visible = True
      Circled = True
      Shadow.HorizSize = 10
      Shadow.VertSize = 10
      Gradient.Direction = gdRadial
      OtherSlice.Legend.Visible = False
      PieValues.Name = 'Pie'
      PieValues.Order = loNone
    end
  end
end
