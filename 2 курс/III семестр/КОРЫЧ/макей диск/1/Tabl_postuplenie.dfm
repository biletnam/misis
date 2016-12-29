object Tabl_postup: TTabl_postup
  Left = 409
  Top = 315
  Width = 547
  Height = 212
  Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Postup_DBGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 529
    Height = 129
    DataSource = Postup_DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Postup_DBNavigator: TDBNavigator
    Left = 56
    Top = 128
    Width = 400
    Height = 41
    DataSource = Postup_DataSource
    TabOrder = 1
  end
  object Postup_DataSource: TDataSource
    DataSet = Postup_Table
    Left = 16
    Top = 136
  end
  object Postup_Table: TTable
    Active = True
    TableName = 'Postup_prod.DB'
    Left = 472
    Top = 136
  end
end
