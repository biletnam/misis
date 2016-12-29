object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 273
  ClientWidth = 234
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 161
    Height = 19
    Caption = #1042#1088#1077#1084#1103' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103':'
  end
  object Label2: TLabel
    Left = 8
    Top = 35
    Width = 145
    Height = 19
    Caption = #1086#1090'          '#1076#1086'          '#1084#1080#1085'.'
  end
  object Label3: TLabel
    Left = 8
    Top = 60
    Width = 164
    Height = 19
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1084#1072#1096#1080#1085': 10'
  end
  object Label4: TLabel
    Left = 8
    Top = 119
    Width = 169
    Height = 19
    Caption = #1048#1085#1090#1077#1085#1089#1080#1074#1085#1086#1089#1090#1100' '#1079#1072#1103#1074#1086#1082':'
  end
  object Label5: TLabel
    Left = 8
    Top = 150
    Width = 220
    Height = 19
    Caption = '       '#1082#1083#1080#1077#1085#1090#1086#1074' '#1082#1072#1078#1076#1099#1077'       '#1084#1080#1085'.'
  end
  object Label6: TLabel
    Left = 8
    Top = 175
    Width = 184
    Height = 19
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object Button1: TButton
    Left = 8
    Top = 237
    Width = 220
    Height = 33
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 27
    Width = 25
    Height = 25
    TabOrder = 1
    Text = '20'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 88
    Top = 27
    Width = 25
    Height = 25
    TabOrder = 2
    Text = '45'
    OnKeyPress = Edit1KeyPress
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 85
    Width = 220
    Height = 28
    Max = 20
    Min = 3
    Position = 10
    TabOrder = 3
    OnChange = TrackBar1Change
  end
  object Edit3: TEdit
    Left = 8
    Top = 144
    Width = 25
    Height = 25
    TabOrder = 4
    Text = '15'
    OnKeyPress = Edit1KeyPress
  end
  object Edit4: TEdit
    Left = 170
    Top = 144
    Width = 25
    Height = 25
    TabOrder = 5
    Text = '35'
    OnKeyPress = Edit1KeyPress
  end
  object TrackBar2: TTrackBar
    Left = 8
    Top = 200
    Width = 220
    Height = 28
    Max = 15
    Min = 1
    Position = 1
    TabOrder = 6
    OnChange = TrackBar1Change
  end
end
