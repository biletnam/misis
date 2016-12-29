object Form1: TForm1
  Left = 137
  Top = 152
  Width = 621
  Height = 355
  Caption = #1064#1082#1086#1083#1072' - '#1059#1095#1077#1085#1080#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 29
    Width = 613
    Height = 280
    Align = alClient
    DataSource = DataModule1.StudentDataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 613
    Height = 29
    ButtonHeight = 23
    Caption = 'ToolBar1'
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 2
      Width = 46
      Height = 23
      Caption = #1060#1072#1084#1080#1083#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object FilterFamEdit: TEdit
      Left = 46
      Top = 2
      Width = 107
      Height = 23
      TabOrder = 0
      OnChange = FilterFamEditChange
    end
    object StudentNavigator: TDBNavigator
      Left = 153
      Top = 2
      Width = 240
      Height = 23
      DataSource = DataModule1.StudentDataSource
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 160
    object FileItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object ExitItem: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = ExitItemClick
      end
    end
    object CategoryItem: TMenuItem
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
    end
    object SortItem: TMenuItem
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      object ByFamItem: TMenuItem
        Caption = #1055#1086' '#1092#1072#1084#1080#1083#1080#1080
        OnClick = ByFamItemClick
      end
      object ByClassItem: TMenuItem
        Caption = #1055#1086' '#1082#1083#1072#1089#1089#1091
        OnClick = ByClassItemClick
      end
    end
    object HelpItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object ProgrammInfo: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
end
