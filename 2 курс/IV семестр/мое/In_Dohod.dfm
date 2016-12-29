object In_Dohodi: TIn_Dohodi
  Left = 468
  Top = 409
  BorderStyle = bsDialog
  Caption = #1044#1086#1093#1086#1076#1099' - '#1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 197
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label_Dohod_KontrAgent: TLabel
    Left = 48
    Top = 40
    Width = 66
    Height = 13
    Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099
  end
  object Label_Dohod_Name: TLabel
    Left = 40
    Top = 64
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label_Dohod_Ed: TLabel
    Left = 8
    Top = 88
    Width = 104
    Height = 13
    Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  end
  object Label_Dohod_Cena: TLabel
    Left = 88
    Top = 112
    Width = 26
    Height = 13
    Caption = #1062#1077#1085#1072
  end
  object Label_Dohod_Kolichestvo: TLabel
    Left = 56
    Top = 136
    Width = 59
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Label_Dohod_Data: TLabel
    Left = 88
    Top = 16
    Width = 26
    Height = 13
    Caption = #1044#1072#1090#1072
  end
  object Dohod_Name: TDBEdit
    Left = 120
    Top = 56
    Width = 121
    Height = 21
    DataField = 'Name'
    DataSource = Tabl_Dohodi.Dohodi_DataSource
    TabOrder = 0
  end
  object Dohod_Ed: TDBEdit
    Left = 120
    Top = 80
    Width = 41
    Height = 21
    DataField = 'Ed'
    DataSource = Tabl_Dohodi.Dohodi_DataSource
    TabOrder = 1
  end
  object Dohod_Cena: TDBEdit
    Left = 120
    Top = 104
    Width = 65
    Height = 21
    DataField = 'Cena'
    DataSource = Tabl_Dohodi.Dohodi_DataSource
    TabOrder = 2
  end
  object Dohod_Kolichestvo: TDBEdit
    Left = 120
    Top = 128
    Width = 65
    Height = 21
    DataField = 'Kolichestvo'
    DataSource = Tabl_Dohodi.Dohodi_DataSource
    TabOrder = 3
  end
  object Button_Add_Dohod: TButton
    Left = 88
    Top = 160
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = Button_Add_DohodClick
  end
  object Dohod_Data: TDateTimePicker
    Left = 120
    Top = 8
    Width = 97
    Height = 21
    Date = 39432.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39432.000000000000000000
    TabOrder = 5
  end
  object Dohod_KontrAgent: TDBLookupComboBox
    Left = 120
    Top = 32
    Width = 97
    Height = 21
    DataField = 'KontrAgents'
    DataSource = Tabl_Dohodi.Dohodi_DataSource
    KeyField = 'Name'
    ListField = 'Name'
    ListSource = KontrAgenti.Kontragenti_DataSource
    TabOrder = 6
  end
end
