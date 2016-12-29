object KontrAgenti: TKontrAgenti
  Left = 516
  Top = 339
  BorderStyle = bsDialog
  Caption = #1057#1083#1086#1074#1072#1088#1100' '#1076#1072#1085#1085#1099#1093' - '#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099
  ClientHeight = 238
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 24
    Width = 19
    Height = 13
    Caption = #1050#1086#1076
  end
  object Label2: TLabel
    Left = 48
    Top = 48
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 115
    Height = 13
    Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label4: TLabel
    Left = 96
    Top = 96
    Width = 24
    Height = 13
    Caption = #1048#1053#1053
  end
  object Label5: TLabel
    Left = 16
    Top = 120
    Width = 101
    Height = 13
    Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
  end
  object Label6: TLabel
    Left = 40
    Top = 144
    Width = 83
    Height = 13
    Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
  end
  object Label7: TLabel
    Left = 72
    Top = 168
    Width = 45
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085
  end
  object Label8: TLabel
    Left = 40
    Top = 192
    Width = 80
    Height = 13
    Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
  end
  object Kontragenti_DBNavigator: TDBNavigator
    Left = 16
    Top = 208
    Width = 240
    Height = 25
    DataSource = Kontragenti_DataSource
    TabOrder = 0
  end
  object Kontragenti_Kod: TDBEdit
    Left = 128
    Top = 16
    Width = 49
    Height = 21
    DataField = 'Kod'
    DataSource = Kontragenti_DataSource
    TabOrder = 1
  end
  object Kontragenti_Name: TDBEdit
    Left = 128
    Top = 40
    Width = 89
    Height = 21
    DataField = 'Name'
    DataSource = Kontragenti_DataSource
    TabOrder = 2
  end
  object Kontragenti_FullName: TDBEdit
    Left = 128
    Top = 64
    Width = 121
    Height = 21
    DataField = 'FullName'
    DataSource = Kontragenti_DataSource
    TabOrder = 3
  end
  object Kontragenti_INN: TDBEdit
    Left = 128
    Top = 88
    Width = 89
    Height = 21
    DataField = 'INN'
    DataSource = Kontragenti_DataSource
    TabOrder = 4
  end
  object Kontragenti_YrAdres: TDBEdit
    Left = 128
    Top = 112
    Width = 121
    Height = 21
    DataField = 'YrAdres'
    DataSource = Kontragenti_DataSource
    TabOrder = 5
  end
  object Kontragenti_PochtAdres: TDBEdit
    Left = 128
    Top = 136
    Width = 121
    Height = 21
    DataField = 'PochtAdres'
    DataSource = Kontragenti_DataSource
    TabOrder = 6
  end
  object Kontragenti_Telefon: TDBEdit
    Left = 128
    Top = 160
    Width = 73
    Height = 21
    DataField = 'Telefon'
    DataSource = Kontragenti_DataSource
    TabOrder = 7
  end
  object Kontragenti_Chet: TDBEdit
    Left = 128
    Top = 184
    Width = 73
    Height = 21
    DataField = 'Chet'
    DataSource = Kontragenti_DataSource
    TabOrder = 8
  end
  object Kontragenti_DataSource: TDataSource
    DataSet = Kontragenti_Table
    Left = 8
    Top = 24
  end
  object Kontragenti_Table: TTable
    Active = True
    TableName = 'KontrAgenti.DB'
    Left = 8
    Top = 8
  end
end
