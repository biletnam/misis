object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1056#1077#1089#1090#1086#1088#1072#1085
  ClientHeight = 486
  ClientWidth = 917
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
    Left = 704
    Top = 285
    Width = 149
    Height = 72
    Caption = '12:55'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object LogListBox: TListBox
    Left = 8
    Top = 367
    Width = 901
    Height = 111
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 640
    Top = 215
    Width = 114
    Height = 25
    Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 760
    Top = 215
    Width = 149
    Height = 56
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 640
    Top = 246
    Width = 114
    Height = 25
    Caption = #1057#1085#1072#1095#1072#1083#1072
    TabOrder = 3
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 640
    Top = 8
    Width = 269
    Height = 201
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 118
      Height = 13
      Caption = #1050#1083#1080#1077#1085#1090#1086#1074' '#1074' '#1088#1077#1089#1090#1086#1088#1072#1085#1077':'
    end
    object Label2: TLabel
      Left = 16
      Top = 43
      Width = 80
      Height = 13
      Caption = #1057#1074#1086#1073#1086#1076#1085#1086' '#1084#1077#1089#1090':'
    end
    object Label3: TLabel
      Left = 16
      Top = 62
      Width = 157
      Height = 13
      Caption = #1057#1088#1077#1076#1085#1077#1077' '#1074#1088#1077#1084#1103' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103':'
    end
    object Label4: TLabel
      Left = 16
      Top = 118
      Width = 131
      Height = 13
      Caption = #1053#1072#1080#1073#1086#1083#1100#1096#1072#1103' '#1079#1072#1085#1103#1090#1086#1089#1090#1100' '#1091':'
    end
    object Label5: TLabel
      Left = 16
      Top = 99
      Width = 131
      Height = 13
      Caption = #1052#1077#1085#1100#1096#1077' '#1074#1089#1077#1075#1086' '#1079#1072#1088#1072#1073#1086#1090#1072#1083':'
    end
    object Label6: TLabel
      Left = 16
      Top = 80
      Width = 129
      Height = 13
      Caption = #1041#1086#1083#1100#1096#1077' '#1074#1089#1077#1075#1086' '#1079#1072#1088#1072#1073#1086#1090#1072#1083':'
    end
    object Label10: TLabel
      Left = 16
      Top = 174
      Width = 74
      Height = 13
      Caption = #1054#1073#1097#1080#1081' '#1076#1086#1093#1086#1076':'
    end
    object Label11: TLabel
      Left = 16
      Top = 155
      Width = 90
      Height = 13
      Caption = #1042#1089#1077#1075#1086' '#1086#1073#1089#1083#1091#1078#1077#1085#1086':'
    end
    object Label12: TLabel
      Left = 16
      Top = 136
      Width = 131
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1100#1096#1072#1103' '#1079#1072#1085#1103#1090#1086#1089#1090#1100' '#1091':'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 626
    Height = 353
    Caption = #1054#1092#1080#1094#1080#1072#1085#1090#1099
    TabOrder = 5
  end
  object XPManifest1: TXPManifest
    Left = 608
    Top = 640
  end
  object InfoTimer: TTimer
    Interval = 100
    OnTimer = InfoTimerTimer
    Left = 680
    Top = 640
  end
  object TickTimer: TTimer
    Enabled = False
    OnTimer = TickTimerTimer
    Left = 640
    Top = 640
  end
end
