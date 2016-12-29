object StudentForm: TStudentForm
  Left = 250
  Top = 135
  Width = 802
  Height = 330
  HelpContext = 1
  Caption = #1064#1082#1086#1083#1072' - '#1059#1095#1077#1085#1080#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  HelpFile = #1064#1082#1086#1083#1072'H.hlp'
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object DBGrid1: TDBGrid
    Left = 0
    Top = 29
    Width = 794
    Height = 249
    Align = alClient
    DataSource = DataModule1.StudentDataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 794
    Height = 29
    ButtonHeight = 23
    Caption = 'ToolBar1'
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 2
      Width = 72
      Height = 23
      Caption = #1060#1072#1084#1080#1083#1080#1103'  '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object FilterFamEdit: TEdit
      Left = 72
      Top = 2
      Width = 107
      Height = 23
      TabOrder = 0
      OnChange = FilterFamEditChange
    end
    object ToolButton1: TToolButton
      Left = 179
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object StudentNavigator: TDBNavigator
      Left = 187
      Top = 2
      Width = 240
      Height = 23
      DataSource = DataModule1.StudentDataSource
      Align = alCustom
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 160
    object FileItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object ExelItem: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
        OnClick = ExelItemClick
      end
      object TableInfoItem: TMenuItem
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1090#1072#1073#1083#1080#1094#1077
        OnClick = TableInfoItemClick
      end
      object N2: TMenuItem
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object ExitItem: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = ExitItemClick
      end
    end
    object CategoryItem: TMenuItem
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
      object CategoryPrepod: TMenuItem
        Caption = #1055#1088#1077#1087#1086#1076#1072#1074#1072#1090#1077#1083#1080
        OnClick = CategoryPrepodClick
      end
      object N1: TMenuItem
        Caption = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1087#1077#1088#1089#1086#1085#1072#1083
        OnClick = N1Click
      end
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
        OnClick = ProgrammInfoClick
      end
    end
  end
end
