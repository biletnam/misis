object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1058#1072#1082#1089#1086#1087#1072#1088#1082
  ClientHeight = 348
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 569
    Top = 215
    Width = 56
    Height = 18
    Caption = '10:00'
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Terminal'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 8
    Top = 239
    Width = 617
    Height = 106
    ItemHeight = 14
    TabOrder = 0
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 425
    Height = 225
    ColCount = 4
    DefaultColWidth = 100
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 20
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 439
    Top = 8
    Width = 186
    Height = 170
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 47
      Height = 14
      Caption = #1047#1072#1103#1074#1082#1080':'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 132
      Height = 14
      Caption = #1054#1073#1089#1083#1091#1078#1077#1085#1086' '#1082#1083#1080#1085#1090#1086#1074':'
    end
    object Label4: TLabel
      Left = 16
      Top = 84
      Width = 114
      Height = 14
      Caption = #1057#1074#1086#1073#1086#1076#1085#1086' '#1084#1072#1096#1080#1085':'
    end
    object Label5: TLabel
      Left = 16
      Top = 44
      Width = 69
      Height = 14
      Caption = #1042' '#1086#1095#1077#1088#1077#1076#1080':'
    end
  end
  object Button4: TButton
    Left = 439
    Top = 184
    Width = 124
    Height = 49
    Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button1: TButton
    Left = 569
    Top = 184
    Width = 56
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 4
    OnClick = Button1Click
  end
  object TickTimer: TTimer
    Enabled = False
    OnTimer = TickTimerTimer
    Left = 104
    Top = 272
  end
  object InfoTimer: TTimer
    Interval = 250
    OnTimer = InfoTimerTimer
    Left = 72
    Top = 272
  end
  object XPManifest1: TXPManifest
    Left = 144
    Top = 272
  end
end
