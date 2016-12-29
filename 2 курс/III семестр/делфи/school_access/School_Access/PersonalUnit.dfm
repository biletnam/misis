object PersonalForm: TPersonalForm
  Left = 114
  Top = 159
  Width = 679
  Height = 380
  Caption = #1064#1082#1086#1083#1072' - '#1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1087#1077#1088#1089#1086#1085#1072#1083
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 29
    Width = 671
    Height = 305
    Align = alClient
    DataSource = DataModule1.PersonalDataSource
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
    Width = 671
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
      OnKeyPress = FilterFamEditKeyPress
    end
    object DBNavigator1: TDBNavigator
      Left = 153
      Top = 2
      Width = 240
      Height = 23
      DataSource = DataModule1.PersonalDataSource
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 328
    Top = 176
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object Excel1: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
        OnClick = Excel1Click
      end
      object N2: TMenuItem
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1090#1072#1073#1083#1080#1094#1077
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N4: TMenuItem
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
      object N5: TMenuItem
        Caption = #1055#1088#1077#1087#1086#1076#1072#1074#1072#1090#1077#1083#1080
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1059#1095#1077#1085#1080#1082#1080
        OnClick = N6Click
      end
    end
    object N7: TMenuItem
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      object N8: TMenuItem
        Caption = #1055#1086' '#1092#1072#1084#1080#1083#1080#1080
        OnClick = N8Click
      end
    end
    object N9: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N10: TMenuItem
        Caption = #1055#1086#1084#1086#1097#1100
      end
      object N11: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
end
