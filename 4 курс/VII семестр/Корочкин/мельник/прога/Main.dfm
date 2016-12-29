object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1052#1086#1076#1077#1083#1100
  ClientHeight = 422
  ClientWidth = 597
  Color = clSkyBlue
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 8
    Top = 335
    Width = 220
    Height = 58
    Caption = '10:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 16
    Top = 8
    Width = 573
    Height = 36
    Caption = #1048#1084#1080#1090#1072#1094#1080#1086#1085#1085#1072#1103' '#1084#1086#1076#1077#1083#1100' "'#1055#1083#1103#1078#1085#1099#1081' '#1073#1072#1088'"'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlue
    Font.Height = -32
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 50
    Width = 585
    Height = 255
    Caption = #1041#1072#1088#1084#1077#1085#1099
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 745
    Top = 534
    Width = 167
    Height = 49
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 239
    Top = 318
    Width = 110
    Height = 28
    BiDiMode = bdLeftToRight
    Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 729
    Top = 157
    Width = 55
    Height = 55
    Caption = #1055#1086#1076#1088#1086#1073#1085#1072#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1082#1083#1080#1077#1085#1090#1086#1074
    TabOrder = 3
    Visible = False
  end
  object GroupBox2: TGroupBox
    Left = 355
    Top = 311
    Width = 238
    Height = 106
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    TabOrder = 4
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 159
      Height = 19
      Caption = #1054#1073#1089#1083#1091#1078#1077#1085#1086' '#1082#1083#1080#1077#1085#1090#1086#1074':'
    end
    object Label6: TLabel
      Left = 16
      Top = 74
      Width = 146
      Height = 19
      Caption = 'Max '#1076#1083#1080#1085#1072' '#1086#1095#1077#1088#1077#1076#1080':'
    end
    object Label3: TLabel
      Left = 16
      Top = 49
      Width = 179
      Height = 19
      Caption = #1053#1077' '#1086#1073#1089#1083#1091#1078#1077#1085#1086' '#1082#1083#1080#1077#1085#1090#1086#1074':'
    end
  end
  object Button2: TButton
    Left = 239
    Top = 386
    Width = 110
    Height = 28
    Cursor = crHandPoint
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 239
    Top = 352
    Width = 110
    Height = 28
    Caption = #1053#1086#1074#1072#1103' '#1080#1084#1080#1090#1072#1094#1080#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button4Click
  end
  object InfoTimer: TTimer
    Interval = 250
    OnTimer = InfoTimerTimer
    Left = 552
    Top = 96
  end
  object TickTimer: TTimer
    Enabled = False
    OnTimer = TickTimerTimer
    Left = 552
    Top = 136
  end
  object XPManifest1: TXPManifest
    Left = 880
    Top = 408
  end
end
