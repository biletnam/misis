object In_Zarplata: TIn_Zarplata
  Left = 686
  Top = 339
  Width = 448
  Height = 338
  Caption = #1047#1072#1088#1087#1083#1072#1090#1072' - '#1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 24
    Width = 26
    Height = 13
    Caption = #1044#1072#1090#1072
  end
  object Label2: TLabel
    Left = 104
    Top = 64
    Width = 27
    Height = 13
    Caption = #1060#1048#1054
  end
  object Label3: TLabel
    Left = 104
    Top = 112
    Width = 34
    Height = 13
    Caption = #1057#1091#1084#1084#1072
  end
  object Zarplat_Data: TDateTimePicker
    Left = 176
    Top = 24
    Width = 186
    Height = 21
    Date = 39433.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39433.000000000000000000
    TabOrder = 0
  end
  object Zarplat_FIO: TDBEdit
    Left = 176
    Top = 64
    Width = 121
    Height = 21
    DataField = 'FIO'
    DataSource = Tabl_Zarplata.Zarplata_DataSource
    TabOrder = 1
  end
  object Zarplat_Summa: TDBEdit
    Left = 176
    Top = 104
    Width = 121
    Height = 21
    DataField = 'Summa'
    DataSource = Tabl_Zarplata.Zarplata_DataSource
    TabOrder = 2
  end
  object Zarplat_ButtonAdd: TButton
    Left = 96
    Top = 200
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = Zarplat_ButtonAddClick
  end
end
