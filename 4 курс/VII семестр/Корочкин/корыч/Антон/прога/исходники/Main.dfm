object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1050#1072#1092#1077' '#1073#1099#1089#1090#1088#1086#1075#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103
  ClientHeight = 473
  ClientWidth = 920
  Color = clRed
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 790
    Top = 432
    Width = 122
    Height = 33
    Caption = '10:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 585
    Height = 241
    Caption = #1050#1072#1089#1089#1080#1088#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 8
    Top = 255
    Width = 583
    Height = 210
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
    Left = 597
    Top = 255
    Width = 133
    Height = 55
    BiDiMode = bdLeftToRight
    Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 736
    Top = 255
    Width = 177
    Height = 55
    Caption = #1055#1086#1076#1088#1086#1073#1085#1072#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1082#1083#1080#1077#1085#1090#1086#1074
    TabOrder = 3
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 599
    Top = 8
    Width = 314
    Height = 241
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 159
      Height = 19
      Caption = #1054#1073#1089#1083#1091#1078#1077#1085#1086' '#1082#1083#1080#1077#1085#1090#1086#1074':'
    end
    object Label3: TLabel
      Left = 16
      Top = 49
      Width = 131
      Height = 19
      Caption = #1050#1083#1080#1077#1085#1090#1086#1074' '#1074' '#1082#1072#1092#1077':'
    end
    object Label4: TLabel
      Left = 16
      Top = 74
      Width = 223
      Height = 19
      Caption = #1057#1088#1077#1076#1085#1077#1077' '#1074#1088#1077#1084#1103' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103':'
    end
    object Label5: TLabel
      Left = 16
      Top = 99
      Width = 112
      Height = 19
      Caption = #1057#1074#1086#1073#1086#1076#1085#1086' '#1084#1077#1089#1090':'
    end
    object Label6: TLabel
      Left = 16
      Top = 124
      Width = 146
      Height = 19
      Caption = 'Max '#1076#1083#1080#1085#1072' '#1086#1095#1077#1088#1077#1076#1080':'
    end
  end
  object Button2: TButton
    Left = 709
    Top = 440
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 709
    Top = 409
    Width = 75
    Height = 25
    Caption = #1057#1085#1072#1095#1072#1083#1072
    TabOrder = 6
    OnClick = Button4Click
  end
  object InfoTimer: TTimer
    Interval = 250
    OnTimer = InfoTimerTimer
    Left = 272
    Top = 120
  end
  object TickTimer: TTimer
    Enabled = False
    OnTimer = TickTimerTimer
    Left = 168
    Top = 160
  end
end
