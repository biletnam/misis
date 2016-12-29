object Form1: TForm1
  Left = 301
  Top = 217
  BorderStyle = bsSingle
  Caption = #1060#1080#1088#1084#1072'. '#1056#1077#1089#1091#1088#1089#1099
  ClientHeight = 273
  ClientWidth = 687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label17: TLabel
    Left = 536
    Top = 8
    Width = 112
    Height = 13
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1099':'
  end
  object Label18: TLabel
    Left = 504
    Top = 40
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label19: TLabel
    Left = 504
    Top = 64
    Width = 96
    Height = 13
    Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103':'
  end
  object Label20: TLabel
    Left = 512
    Top = 168
    Width = 80
    Height = 13
    Caption = #1050#1086#1076' '#1084#1072#1090#1077#1088#1080#1072#1083#1072':'
  end
  object PageControl1: TPageControl
    Left = 88
    Top = 0
    Width = 401
    Height = 241
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      TabVisible = False
      object Label1: TLabel
        Left = 112
        Top = 16
        Width = 80
        Height = 13
        Caption = #1050#1086#1076'  '#1084#1072#1090#1077#1088#1080#1072#1083#1072
      end
      object Label2: TLabel
        Left = 88
        Top = 40
        Width = 108
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1072
      end
      object Label3: TLabel
        Left = 32
        Top = 64
        Width = 160
        Height = 13
        Caption = #1054#1089#1090#1072#1090#1086#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1085#1072' '#1089#1082#1083#1072#1076#1077
      end
      object Label4: TLabel
        Left = 96
        Top = 88
        Width = 93
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
      end
      object Label5: TLabel
        Left = 48
        Top = 112
        Width = 142
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086' '#1087#1088#1080#1093#1086#1076#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
      end
      object Label6: TLabel
        Left = 40
        Top = 136
        Width = 151
        Height = 13
        Caption = #1054#1073#1097#1077#1077' '#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
      end
      object DBEdit1: TDBEdit
        Left = 200
        Top = 8
        Width = 49
        Height = 21
        DataField = 'Kod'
        DataSource = DataSource1
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 200
        Top = 32
        Width = 121
        Height = 21
        DataField = 'Name'
        DataSource = DataSource1
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 200
        Top = 56
        Width = 49
        Height = 21
        DataField = 'Ostatok'
        DataSource = DataSource1
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 200
        Top = 80
        Width = 73
        Height = 21
        DataField = 'Data'
        DataSource = DataSource1
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 200
        Top = 104
        Width = 49
        Height = 21
        DataField = 'NumPrihod'
        DataSource = DataSource1
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 200
        Top = 128
        Width = 49
        Height = 21
        DataField = 'NumObsh'
        DataSource = DataSource1
        TabOrder = 5
      end
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 208
        Width = 390
        Height = 25
        DataSource = DataSource1
        TabOrder = 6
      end
      object Button4: TButton
        Left = 312
        Top = 176
        Width = 75
        Height = 25
        Caption = #1054#1090#1095#1077#1090
        TabOrder = 7
        OnClick = Button4Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      TabVisible = False
      object Label7: TLabel
        Left = 48
        Top = 40
        Width = 124
        Height = 26
        Caption = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086#1089#1090#1100' '#1079#1072#1082#1072#1079#1072' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1082#1086#1083'-'#1074#1072
        WordWrap = True
      end
      object Label8: TLabel
        Left = 64
        Top = 72
        Width = 112
        Height = 13
        Caption = #1047#1072#1082#1072#1079#1095#1080#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
      end
      object Label9: TLabel
        Left = 72
        Top = 120
        Width = 107
        Height = 13
        Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1081' '#1090#1077#1083#1077#1092#1086#1085
      end
      object Label10: TLabel
        Left = 112
        Top = 96
        Width = 65
        Height = 13
        Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
      end
      object Label11: TLabel
        Left = 96
        Top = 24
        Width = 80
        Height = 13
        Caption = #1050#1086#1076'  '#1084#1072#1090#1077#1088#1080#1072#1083#1072
      end
      object Label12: TLabel
        Left = 96
        Top = 144
        Width = 86
        Height = 13
        Caption = #1043#1086#1088#1086#1076' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      end
      object DBEdit7: TDBEdit
        Left = 184
        Top = 16
        Width = 121
        Height = 21
        DataField = 'Kod'
        DataSource = DataSource2
        TabOrder = 0
      end
      object DBEdit9: TDBEdit
        Left = 184
        Top = 64
        Width = 121
        Height = 21
        DataField = 'Zakazchik'
        DataSource = DataSource2
        TabOrder = 1
      end
      object DBEdit10: TDBEdit
        Left = 184
        Top = 88
        Width = 121
        Height = 21
        DataField = 'Data'
        DataSource = DataSource2
        TabOrder = 2
      end
      object DBEdit11: TDBEdit
        Left = 184
        Top = 112
        Width = 121
        Height = 21
        DataField = 'Telefon'
        DataSource = DataSource2
        TabOrder = 3
      end
      object DBEdit12: TDBEdit
        Left = 184
        Top = 136
        Width = 121
        Height = 21
        DataField = 'Gorod'
        DataSource = DataSource2
        TabOrder = 4
      end
      object DBNavigator2: TDBNavigator
        Left = 0
        Top = 208
        Width = 390
        Height = 25
        DataSource = DataSource2
        TabOrder = 5
      end
      object DBCheckBox1: TDBCheckBox
        Left = 184
        Top = 40
        Width = 41
        Height = 25
        DataField = 'Need'
        DataSource = DataSource2
        TabOrder = 6
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object Button5: TButton
        Left = 304
        Top = 176
        Width = 75
        Height = 25
        Caption = #1054#1090#1095#1077#1090
        TabOrder = 7
        OnClick = Button5Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      TabVisible = False
      object Label13: TLabel
        Left = 88
        Top = 24
        Width = 77
        Height = 13
        Caption = #1050#1086#1076' '#1084#1072#1090#1077#1088#1080#1072#1083#1072
      end
      object Label14: TLabel
        Left = 56
        Top = 48
        Width = 108
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1072
      end
      object Label15: TLabel
        Left = 16
        Top = 72
        Width = 151
        Height = 13
        Caption = #1062#1077#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074', '#1088#1086#1079#1085#1080#1095#1085#1099#1081
      end
      object Label16: TLabel
        Left = 32
        Top = 96
        Width = 139
        Height = 13
        Caption = #1062#1077#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074', '#1086#1087#1090#1086#1074#1099#1081
      end
      object DBEdit8: TDBEdit
        Left = 176
        Top = 16
        Width = 49
        Height = 21
        DataField = 'Kod'
        DataSource = DataSource3
        TabOrder = 0
      end
      object DBEdit13: TDBEdit
        Left = 176
        Top = 40
        Width = 121
        Height = 21
        DataField = 'Name'
        DataSource = DataSource3
        TabOrder = 1
      end
      object DBEdit14: TDBEdit
        Left = 176
        Top = 64
        Width = 49
        Height = 21
        DataField = 'CenaR'
        DataSource = DataSource3
        TabOrder = 2
      end
      object DBEdit15: TDBEdit
        Left = 176
        Top = 88
        Width = 49
        Height = 21
        DataField = 'CenaO'
        DataSource = DataSource3
        TabOrder = 3
      end
      object DBNavigator3: TDBNavigator
        Left = 0
        Top = 208
        Width = 390
        Height = 25
        DataSource = DataSource3
        TabOrder = 4
      end
      object Button6: TButton
        Left = 304
        Top = 176
        Width = 75
        Height = 25
        Caption = #1054#1090#1095#1077#1090
        TabOrder = 5
        OnClick = Button6Click
      end
    end
  end
  object Button1: TButton
    Left = 8
    Top = 32
    Width = 75
    Height = 25
    Caption = #1057#1082#1083#1072#1076
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 41
    Caption = #1054#1078#1080#1076#1072#1077#1084#1099#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
    TabOrder = 2
    WordWrap = True
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 41
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1077
    TabOrder = 3
    WordWrap = True
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 592
    Top = 32
    Width = 89
    Height = 21
    TabOrder = 4
    Text = #1052#1072#1090#1077#1088#1080#1072#1083'1'
  end
  object DateTimePicker1: TDateTimePicker
    Left = 600
    Top = 56
    Width = 81
    Height = 21
    Date = 39443.846589074080000000
    Format = 'dd.MM.yyyy'
    Time = 39443.846589074080000000
    TabOrder = 5
  end
  object Button7: TButton
    Left = 608
    Top = 80
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 6
    OnClick = Button7Click
  end
  object Edit2: TEdit
    Left = 600
    Top = 160
    Width = 49
    Height = 21
    TabOrder = 7
    Text = '2'
  end
  object Button8: TButton
    Left = 608
    Top = 192
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 8
    OnClick = Button8Click
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        object N7: TMenuItem
          Caption = #1057#1082#1083#1072#1076
          OnClick = N7Click
        end
        object N8: TMenuItem
          Caption = #1054#1078#1080#1076#1072#1077#1084#1099#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
          OnClick = N8Click
        end
        object N9: TMenuItem
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1077
          OnClick = N9Click
        end
      end
      object N3: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N4: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N5: TMenuItem
        Caption = #1056#1091#1082#1086#1074#1086#1076#1089#1090#1074#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N6Click
      end
    end
  end
  object Table1: TTable
    Active = True
    TableName = 'Sklad.DB'
    Left = 4
    Top = 238
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 32
    Top = 240
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 96
    Top = 240
  end
  object Table2: TTable
    Active = True
    TableName = 'Zakazi.DB'
    Left = 64
    Top = 240
  end
  object DataSource3: TDataSource
    DataSet = Table3
    Left = 152
    Top = 240
  end
  object Table3: TTable
    Active = True
    TableName = 'Info.DB'
    Left = 128
    Top = 240
  end
  object Query1: TQuery
    SQL.Strings = (
      'SELECT Kod, Name, Ostatok, Data, NumPrihod, NumObsh'
      'FROM Sklad'
      'WHERE Name=:iName and Data=:iData')
    Left = 184
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iName'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'iData'
        ParamType = ptUnknown
      end>
  end
  object Query2: TQuery
    SQL.Strings = (
      'SELECT Kod, Name, Ostatok, Data, NumPrihod, NumObsh'
      'FROM Sklad'
      'WHERE Kod=:kodd')
    Left = 208
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kodd'
        ParamType = ptUnknown
      end>
  end
  object RvProject1: TRvProject
    Left = 240
    Top = 240
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
    Left = 272
    Top = 240
  end
  object RvTableConnection1: TRvTableConnection
    RuntimeVisibility = rtDeveloper
    Table = Table1
    Left = 304
    Top = 240
  end
  object RvTableConnection2: TRvTableConnection
    RuntimeVisibility = rtDeveloper
    Table = Table2
    Left = 336
    Top = 240
  end
  object RvTableConnection3: TRvTableConnection
    RuntimeVisibility = rtDeveloper
    Table = Table3
    Left = 368
    Top = 240
  end
  object DataSource4: TDataSource
    Left = 400
    Top = 240
  end
end
