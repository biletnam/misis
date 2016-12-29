object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1053#1077#1092#1090#1077#1073#1072#1079#1072
  ClientHeight = 487
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TimeLabel: TLabel
    Left = 8
    Top = 427
    Width = 112
    Height = 54
    Caption = '12:55'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 626
    Height = 209
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
  end
  object LogListBox: TListBox
    Left = 134
    Top = 223
    Width = 500
    Height = 258
    ItemHeight = 13
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 223
    Width = 120
    Height = 25
    Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
    TabOrder = 2
    OnClick = Button1Click
  end
  object Panel2: TPanel
    Left = 640
    Top = 6
    Width = 257
    Height = 475
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Button3: TButton
    Left = 8
    Top = 254
    Width = 120
    Height = 25
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button2: TButton
    Left = 8
    Top = 368
    Width = 120
    Height = 47
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 71
    Top = 337
    Width = 57
    Height = 25
    Caption = #1057#1085#1072#1095#1072#1083#1072
    TabOrder = 6
    OnClick = Button4Click
  end
  object XPManifest1: TXPManifest
    Left = 808
    Top = 448
  end
  object InfoTimer: TTimer
    Interval = 100
    OnTimer = InfoTimerTimer
    Left = 872
    Top = 448
  end
  object TickTimer: TTimer
    Enabled = False
    OnTimer = TickTimerTimer
    Left = 840
    Top = 448
  end
end
