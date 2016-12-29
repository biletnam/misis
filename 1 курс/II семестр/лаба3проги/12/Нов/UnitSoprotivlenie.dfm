object FormSoprotivlenie: TFormSoprotivlenie
  Left = 915
  Top = 395
  Width = 262
  Height = 358
  Caption = #1057#1086#1087#1088#1086#1090#1080#1074#1083#1077#1085#1080#1077' '#1101#1083#1077#1082#1090#1088#1080#1095#1077#1089#1082#1086#1081' '#1094#1077#1087#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelText: TLabel
    Left = 8
    Top = 8
    Width = 201
    Height = 49
    AutoSize = False
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1074#1099#1095#1080#1089#1083#1080#1090' '#1089#1086#1087#1088#1086#1090#1080#1074#1083#1077#1085#1080#1077' '#1101#1083#1077#1082#1090#1088#1080#1095#1077#1089#1082#1086#1081' '#1094#1077#1087#1080', '#1082#1086#1090#1086#1088#1072#1103' '#1089#1086#1089 +
      #1090#1086#1080#1090' '#1080#1079' '#1076#1074#1091#1093' '#1088#1077#1079#1080#1089#1090#1086#1088#1086#1074'.'
    WordWrap = True
  end
  object LabelR1: TLabel
    Left = 8
    Top = 88
    Width = 39
    Height = 13
    Caption = 'R1 ('#1054#1084')'
  end
  object LabelR2: TLabel
    Left = 8
    Top = 128
    Width = 39
    Height = 13
    Caption = 'R2 ('#1054#1084')'
  end
  object LabelResult: TLabel
    Left = 8
    Top = 272
    Width = 153
    Height = 41
    AutoSize = False
    WordWrap = True
  end
  object GroupBoxTip: TGroupBox
    Left = 8
    Top = 160
    Width = 153
    Height = 73
    Caption = #1058#1080#1087' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 72
    Top = 80
    Width = 49
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Edit2: TEdit
    Left = 72
    Top = 120
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object RadioButtonPosled: TRadioButton
    Left = 24
    Top = 184
    Width = 113
    Height = 17
    Caption = #1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = RadioButtonPosledClick
  end
  object RadioButtonParall: TRadioButton
    Left = 24
    Top = 208
    Width = 113
    Height = 17
    Caption = #1087#1072#1088#1072#1083#1083#1077#1083#1100#1085#1086
    TabOrder = 3
    OnClick = RadioButtonParallClick
  end
  object ButtonCalculate: TButton
    Left = 8
    Top = 240
    Width = 75
    Height = 25
    Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
    TabOrder = 4
    OnClick = ButtonCalculateClick
  end
end
