object Funt_Kg: TFunt_Kg
  Left = 644
  Top = 576
  Width = 317
  Height = 206
  Caption = #1060#1091#1085#1090#1099'-'#1082#1080#1083#1086#1075#1088#1072#1084#1084#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelText: TLabel
    Left = 16
    Top = 16
    Width = 257
    Height = 39
    BiDiMode = bdLeftToRight
    Caption = 
      #1042#1074#1077#1076#1080#1090#1077' '#1074#1077#1089' '#1074' '#1092#1091#1085#1090#1072#1093' '#1080' '#1097#1077#1083#1082#1085#1080#1090#1077' '#1085#1072' '#1082#1085#1086#1087#1082#1077' '#1055#1077#1088#1077#1089#1095#1077#1090'. '#1044#1083#1103' '#1086#1090#1076#1077#1083#1077#1085#1080 +
      #1103' '#1076#1088#1086#1073#1085#1086#1081' '#1095#1072#1089#1090#1080' '#1086#1090' '#1094#1077#1083#1086#1081' '#1080#1089#1087#1086#1083#1100#1079#1091#1081#1090#1077' '#1079#1072#1087#1103#1090#1091#1102'.'
    ParentBiDiMode = False
    WordWrap = True
  end
  object LabelKg: TLabel
    Left = 16
    Top = 112
    Width = 161
    Height = 49
    AutoSize = False
    WordWrap = True
  end
  object ButtonPerechet: TButton
    Left = 176
    Top = 64
    Width = 75
    Height = 25
    Caption = #1055#1077#1088#1077#1089#1095#1077#1090
    Enabled = False
    TabOrder = 0
    OnClick = ButtonPerechetClick
  end
  object EditFunt: TEdit
    Left = 32
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = EditFuntChange
    OnKeyPress = EditFuntKeyPress
  end
end
