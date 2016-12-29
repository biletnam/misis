object Tabl_Zarplata: TTabl_Zarplata
  Left = 296
  Top = 456
  Width = 640
  Height = 286
  Caption = #1047#1072#1088#1087#1083#1072#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Zarplata_DBGrid: TDBGrid
    Left = 8
    Top = 8
    Width = 585
    Height = 120
    DataSource = Zarplata_DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Zarplata_DBNavigator: TDBNavigator
    Left = 24
    Top = 136
    Width = 231
    Height = 25
    DataSource = Zarplata_DataSource
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbDelete, nbCancel, nbRefresh]
    TabOrder = 1
  end
  object Zarplata_DataSource: TDataSource
    DataSet = Zarplata_Table
    Left = 24
    Top = 176
  end
  object Zarplata_Table: TTable
    Active = True
    TableName = 'Zarplata.DB'
    Left = 64
    Top = 176
  end
end
