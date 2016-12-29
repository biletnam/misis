object QPostup: TQPostup
  Left = 253
  Top = 194
  Width = 581
  Height = 283
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
  object ButtonDo: TButton
    Left = 352
    Top = 208
    Width = 89
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 0
    OnClick = ButtonDoClick
  end
  object Button2: TButton
    Left = 456
    Top = 208
    Width = 89
    Height = 25
    Caption = #1054#1090#1095#1077#1090
    TabOrder = 1
    OnClick = Button2Click
  end
  object Data1: TDateTimePicker
    Left = 240
    Top = 192
    Width = 81
    Height = 21
    Date = 39441.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39441.000000000000000000
    TabOrder = 2
  end
  object Data2: TDateTimePicker
    Left = 240
    Top = 216
    Width = 81
    Height = 21
    Date = 39441.000000000000000000
    Format = 'dd.MM.yyyy'
    Time = 39441.000000000000000000
    TabOrder = 3
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 553
    Height = 145
    DataSource = Qpostup_TableDataSource2
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Naimenovanie: TDBEdit
    Left = 56
    Top = 208
    Width = 97
    Height = 21
    DataField = 'Naimenovanie'
    DataSource = Qpostup_TableDataSource2
    TabOrder = 5
  end
  object QPostup_Table: TTable
    Active = True
    TableName = 'Postup_prod.DB'
    Left = 8
    Top = 160
  end
  object Qpostup_TableQuery: TQuery
    DataSource = QPostup_TableDataSource1
    SQL.Strings = (
      'SELECT Nomer,Data_P, Sklad, Naimenovanie, Cena,Kolvo'
      'FROM Postup_prod'
      
        'WHERE Postup_prod.Data_P>=:first_date and Postup_prod.Data_P<=:l' +
        'ast_date and Postup_prod.Naimenovanie = :Naimenovanie')
    Left = 72
    Top = 160
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
        Name = 'Naimenovanie'
        ParamType = ptUnknown
      end>
  end
  object QPostup_TableDataSource1: TDataSource
    DataSet = QPostup_Table
    Left = 40
    Top = 160
  end
  object Qpostup_TableDataSource2: TDataSource
    DataSet = QPostup_Table
    Left = 104
    Top = 160
  end
  object RvProject1: TRvProject
    ProjectFile = 'C:\Program Files\Borland\Delphi7\Projects\Dohodi.rav'
    Left = 200
    Top = 160
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 168
    Top = 160
  end
  object RvQueryConnection1: TRvQueryConnection
    RuntimeVisibility = rtDeveloper
    Query = Qpostup_TableQuery
    Left = 136
    Top = 160
  end
end
