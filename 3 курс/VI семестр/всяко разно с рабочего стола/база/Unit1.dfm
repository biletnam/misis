object Form1: TForm1
  Left = 1040
  Top = 315
  BorderStyle = bsSingle
  Caption = 'UFO '#1042#1072#1088#1080#1072#1085#1090' 7'
  ClientHeight = 269
  ClientWidth = 558
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
  object DBGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 363
    Height = 233
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator: TDBNavigator
    Left = 0
    Top = 240
    Width = 270
    Height = 25
    DataSource = DataSource
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 368
    Top = 0
    Width = 185
    Height = 105
    Caption = #1047#1072#1087#1088#1086#1089' 1'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 169
      Height = 65
      AutoSize = False
      Caption = 
        #1053#1072#1087#1077#1095#1072#1090#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1090#1080#1087#1086#1074' UFO, '#1082#1086#1090#1086#1088#1099#1077' '#1087#1086#1103#1074#1083#1103#1083#1080#1089#1100' '#1074' '#1076#1085#1077#1074#1085#1086#1077' '#1074#1088#1077#1084#1103' ' +
        '('#1089' 12:00 '#1076#1086' 18:00) '#1080' '#1089#1086#1087#1088#1086#1074#1086#1078#1076#1072#1083#1080#1089#1100' '#1089#1074#1077#1090#1086#1074#1099#1084#1080' '#1101#1092#1092#1077#1082#1090#1072#1084#1080
      WordWrap = True
    end
    object Button1: TButton
      Left = 104
      Top = 72
      Width = 75
      Height = 25
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 368
    Top = 112
    Width = 185
    Height = 153
    Caption = #1047#1072#1087#1088#1086#1089' 2'
    TabOrder = 3
    object Label2: TLabel
      Left = 10
      Top = 16
      Width = 167
      Height = 57
      AutoSize = False
      Caption = 
        #1047#1072#1084#1077#1085#1080#1090#1100' '#1076#1072#1090#1091' '#1087#1086#1103#1074#1083#1077#1085#1080#1103' UFO '#1076#1072#1085#1085#1086#1075#1086' '#1090#1080#1087#1072' '#1089' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1081' '#1087#1088#1086#1076#1086#1083#1078#1080 +
        #1090#1077#1083#1100#1085#1086#1089#1090#1100#1102' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1081' (1-'#1075#1086' '#1087#1086' '#1089#1087#1080#1089#1082#1091')'
      WordWrap = True
    end
    object Label3: TLabel
      Left = 64
      Top = 80
      Width = 19
      Height = 13
      Caption = #1058#1080#1087
    end
    object Label4: TLabel
      Left = 56
      Top = 104
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object CodeComboBox: TComboBox
      Left = 88
      Top = 72
      Width = 89
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'UFO-T-001'
      Items.Strings = (
        'UFO-T-001'
        'UFO-T-002'
        'UFO-T-003'
        'UFO-T-004')
    end
    object DateTimePicker: TDateTimePicker
      Left = 88
      Top = 96
      Width = 89
      Height = 21
      Date = 39955.769395254630000000
      Time = 39955.769395254630000000
      TabOrder = 1
    end
    object Button2: TButton
      Left = 104
      Top = 120
      Width = 75
      Height = 25
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Button3: TButton
    Left = 288
    Top = 240
    Width = 75
    Height = 25
    Caption = #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
    TabOrder = 4
    OnClick = Button3Click
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 128
    Top = 48
  end
  object Table: TTable
    Left = 184
    Top = 48
  end
  object XPManifest: TXPManifest
    Left = 232
    Top = 48
  end
  object Query: TQuery
    Left = 80
    Top = 48
  end
  object DataSource2: TDataSource
    Left = 16
    Top = 48
  end
end
