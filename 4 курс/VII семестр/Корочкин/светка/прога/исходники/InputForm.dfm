object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 168
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 351
    Top = 8
    Width = 134
    Height = 13
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103':'
  end
  object Label2: TLabel
    Left = 351
    Top = 71
    Width = 178
    Height = 13
    Caption = #1048#1085#1090#1077#1085#1089#1080#1074#1085#1086#1089#1090#1100' '#1087#1088#1080#1093#1086#1076#1072' '#1082#1083#1080#1077#1085#1090#1086#1074':'
  end
  object Label3: TLabel
    Left = 387
    Top = 97
    Width = 106
    Height = 13
    Caption = #1095#1077#1083'. '#1079#1072'                '#1084#1080#1085'.'
  end
  object TrackBar1: TTrackBar
    Left = 351
    Top = 27
    Width = 178
    Height = 45
    Max = 15
    Min = 1
    Position = 1
    TabOrder = 1
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 153
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1092#1080#1094#1080#1072#1085#1090#1086#1074
    TabOrder = 2
  end
  object Button1: TButton
    Left = 351
    Top = 117
    Width = 178
    Height = 43
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 351
    Top = 90
    Width = 34
    Height = 21
    TabOrder = 3
    Text = '10'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 431
    Top = 90
    Width = 34
    Height = 21
    TabOrder = 4
    Text = '60'
    OnKeyPress = Edit1KeyPress
  end
end
