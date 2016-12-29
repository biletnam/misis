object FormTimer: TFormTimer
  Left = 806
  Top = 500
  Width = 155
  Height = 164
  Caption = #1058#1072#1081#1084#1077#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTimer: TLabel
    Left = 24
    Top = 24
    Width = 89
    Height = 49
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object LabelMin: TLabel
    Left = 16
    Top = 24
    Width = 24
    Height = 13
    Caption = #1052#1080#1085'.'
  end
  object LabelSec: TLabel
    Left = 16
    Top = 56
    Width = 22
    Height = 13
    Caption = #1057#1077#1082'.'
  end
  object ButtonPusk: TButton
    Left = 40
    Top = 80
    Width = 57
    Height = 25
    Caption = #1055#1091#1089#1082
    TabOrder = 0
    OnClick = ButtonPuskClick
  end
  object EditMin: TEdit
    Left = 48
    Top = 16
    Width = 33
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object EditSec: TEdit
    Left = 48
    Top = 48
    Width = 33
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 104
    Top = 80
  end
end
