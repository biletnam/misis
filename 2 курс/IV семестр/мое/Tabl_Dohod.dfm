object Tabl_Dohodi: TTabl_Dohodi
  Left = 328
  Top = 459
  BorderStyle = bsDialog
  Caption = #1044#1086#1093#1086#1076#1099
  ClientHeight = 200
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Dohodi_DBGrid: TDBGrid
    Left = 8
    Top = 8
    Width = 697
    Height = 161
    DataSource = Dohodi_DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Dohodi_DBNavigator: TDBNavigator
    Left = 8
    Top = 168
    Width = 693
    Height = 25
    DataSource = Dohodi_DataSource
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbDelete, nbCancel, nbRefresh]
    TabOrder = 1
  end
  object Dohodi_DataSource: TDataSource
    DataSet = Dohodi_Table
    Left = 640
    Top = 64
  end
  object Dohodi_Table: TTable
    Active = True
    TableName = 'Dohodi.DB'
    Left = 640
    Top = 32
  end
end
