object In_Rashodi: TIn_Rashodi
  Left = 788
  Top = 555
  Width = 400
  Height = 332
  Caption = #1056#1072#1089#1093#1086#1076#1099' - '#1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label_Rashod_Data: TLabel
    Left = 32
    Top = 24
    Width = 26
    Height = 13
    Caption = #1044#1072#1090#1072
  end
  object Label_Rashod_Vid: TLabel
    Left = 16
    Top = 56
    Width = 63
    Height = 13
    Caption = #1042#1080#1076' '#1088#1072#1089#1093#1086#1076#1072
  end
  object Label_Rashod_KontrAgent: TLabel
    Left = 8
    Top = 80
    Width = 71
    Height = 13
    Caption = #1050#1086#1085#1090#1088#1072#1075#1075#1077#1085#1090#1099
  end
  object Label_Rashod_Summa: TLabel
    Left = 40
    Top = 104
    Width = 34
    Height = 13
    Caption = #1057#1091#1084#1084#1072
  end
  object Rashod_Data: TDateTimePicker
    Left = 88
    Top = 24
    Width = 137
    Height = 21
    Date = 39432.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39432.000000000000000000
    TabOrder = 0
  end
  object DBEdit1: TDBEdit
    Left = 88
    Top = 56
    Width = 121
    Height = 21
    DataField = 'Vid'
    DataSource = Tabl_Rashodi.Rashodi_DataSource
    TabOrder = 1
  end
  object Rashod_KontrAgent: TDBEdit
    Left = 88
    Top = 80
    Width = 121
    Height = 21
    DataField = 'KontrAgents'
    DataSource = Tabl_Rashodi.Rashodi_DataSource
    TabOrder = 2
  end
  object Rashod_Summa: TDBEdit
    Left = 88
    Top = 104
    Width = 121
    Height = 21
    DataField = 'Summa'
    DataSource = Tabl_Rashodi.Rashodi_DataSource
    TabOrder = 3
  end
  object Button_Add_Rashod: TButton
    Left = 160
    Top = 160
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = Button_Add_RashodClick
  end
end
