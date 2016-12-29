object In_postup: TIn_postup
  Left = 518
  Top = 145
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076'-'#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077
  ClientHeight = 190
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label_data: TLabel
    Left = 72
    Top = 16
    Width = 26
    Height = 13
    Caption = #1044#1072#1090#1072
  end
  object Label_naimen: TLabel
    Left = 24
    Top = 40
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label_sklad: TLabel
    Left = 64
    Top = 64
    Width = 31
    Height = 13
    Caption = #1057#1082#1083#1072#1076
  end
  object Label_cena: TLabel
    Left = 72
    Top = 88
    Width = 26
    Height = 13
    Caption = #1062#1077#1085#1072
  end
  object Label_kolvo: TLabel
    Left = 40
    Top = 112
    Width = 59
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Postup_kolvo: TDBEdit
    Left = 104
    Top = 104
    Width = 97
    Height = 21
    DataField = 'Kolvo'
    DataSource = Tabl_postup.Postup_DataSource
    TabOrder = 0
  end
  object Postup_cena: TDBEdit
    Left = 104
    Top = 80
    Width = 97
    Height = 21
    DataField = 'Cena'
    DataSource = Tabl_postup.Postup_DataSource
    TabOrder = 1
  end
  object Postup_sklad: TDBEdit
    Left = 104
    Top = 32
    Width = 97
    Height = 21
    DataField = 'Naimenovanie'
    DataSource = Tabl_postup.Postup_DataSource
    TabOrder = 2
  end
  object Postup_data: TDateTimePicker
    Left = 104
    Top = 8
    Width = 97
    Height = 21
    Date = 39441.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39441.000000000000000000
    TabOrder = 3
  end
  object Postup_naimen: TDBComboBox
    Left = 104
    Top = 56
    Width = 97
    Height = 21
    DataField = 'Sklad'
    DataSource = Tabl_postup.Postup_DataSource
    ItemHeight = 13
    TabOrder = 4
  end
  object Button_add_postup: TButton
    Left = 88
    Top = 152
    Width = 113
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = Button_add_postupClick
  end
end
