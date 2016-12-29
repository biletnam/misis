object QRashodi: TQRashodi
  Left = 362
  Top = 157
  Width = 870
  Height = 600
  Caption = #1056#1072#1089#1093#1086#1076#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 24
    Top = 24
    Width = 320
    Height = 120
    DataSource = QRashodi_DataSource2
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ButtonDo: TButton
    Left = 200
    Top = 344
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 1
    OnClick = ButtonDoClick
  end
  object Vid: TDBLookupComboBox
    Left = 32
    Top = 192
    Width = 145
    Height = 21
    KeyField = 'Vid'
    ListField = 'Vid'
    ListSource = QRashodi_DataSource1
    TabOrder = 2
  end
  object Data1: TDateTimePicker
    Left = 184
    Top = 192
    Width = 186
    Height = 21
    Date = 39435.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39435.000000000000000000
    TabOrder = 3
  end
  object Data2: TDateTimePicker
    Left = 184
    Top = 224
    Width = 186
    Height = 21
    Date = 39435.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39435.000000000000000000
    TabOrder = 4
  end
  object QRashodi_DataSource1: TDataSource
    DataSet = QRashodi_Table
    Left = 56
    Top = 344
  end
  object QRashodi_DataSource2: TDataSource
    DataSet = QRashodi_Query
    Left = 120
    Top = 344
  end
  object QRashodi_Table: TTable
    Active = True
    TableName = 'Rashodi.DB'
    Left = 24
    Top = 344
  end
  object QRashodi_Query: TQuery
    DataSource = QRashodi_DataSource1
    SQL.Strings = (
      'SELECT Data, Vid, KontrAgents, Summa'
      'FROM Rashodi'
      
        'WHERE Rashodi.Data>=:first_date and Rashodi.Data<=:last_date and' +
        ' Rashodi.Vid = :name'
      '')
    Left = 88
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'first_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'last_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'name'
        ParamType = ptUnknown
      end>
  end
end
