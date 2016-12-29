object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 290
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 192
    Top = 40
    Width = 75
    Height = 25
    Caption = 'encode'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 88
    Width = 75
    Height = 25
    Caption = 'decode'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 40
    Top = 160
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 256
    Top = 160
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo2')
    TabOrder = 3
  end
end
