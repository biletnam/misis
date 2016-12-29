object Form1: TForm1
  Left = 220
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1043#1072#1076#1072#1085#1080#1077' '#1087#1086' '#1080#1084#1077#1085#1080
  ClientHeight = 258
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 168
    Top = 16
    Width = 29
    Height = 16
    Caption = #1048#1084#1103' '
  end
  object Label2: TLabel
    Left = 166
    Top = 48
    Width = 63
    Height = 16
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
  end
  object Label3: TLabel
    Left = 167
    Top = 72
    Width = 59
    Height = 16
    Caption = #1060#1072#1084#1080#1083#1080#1103
  end
  object Label4: TLabel
    Left = 168
    Top = 104
    Width = 140
    Height = 16
    Caption = #1050#1072#1082' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1103#1077#1090#1077#1089#1100
  end
  object Label5: TLabel
    Left = 168
    Top = 136
    Width = 99
    Height = 16
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
  end
  object FirstName: TEdit
    Left = 8
    Top = 8
    Width = 151
    Height = 24
    Hint = #1042#1074#1086#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1090#1086#1083#1100#1082#1086' '#1050#1080#1088#1080#1083#1080#1094#1077#1081
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyPress = FirstNameKeyPress
  end
  object SecondName: TEdit
    Left = 8
    Top = 37
    Width = 151
    Height = 24
    Hint = #1042#1074#1086#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1090#1086#1083#1100#1082#1086' '#1050#1080#1088#1080#1083#1080#1094#1077#1081
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnKeyPress = FirstNameKeyPress
  end
  object Famelie: TEdit
    Left = 8
    Top = 66
    Width = 151
    Height = 24
    Hint = #1042#1074#1086#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1090#1086#1083#1100#1082#1086' '#1050#1080#1088#1080#1083#1080#1094#1077#1081
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnKeyPress = FirstNameKeyPress
  end
  object Psevdo: TEdit
    Left = 8
    Top = 96
    Width = 151
    Height = 24
    Hint = #1042#1074#1086#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1090#1086#1083#1100#1082#1086' '#1050#1080#1088#1080#1083#1080#1094#1077#1081
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnKeyPress = FirstNameKeyPress
  end
  object DateTimePicker1: TDateTimePicker
    Left = 8
    Top = 126
    Width = 154
    Height = 24
    Date = 38554.462496736100000000
    Time = 38554.462496736100000000
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 320
    Top = 7
    Width = 361
    Height = 242
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Button1: TButton
    Left = 8
    Top = 224
    Width = 305
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 160
    Width = 305
    Height = 25
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 192
    Width = 305
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
    TabOrder = 8
    OnClick = Button3Click
  end
  object MainMenu1: TMainMenu
    Left = 280
    Top = 16
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N3: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        OnClick = N3Click
      end
      object N5: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = N5Click
      end
    end
    object N2: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object N6: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N6Click
      end
    end
  end
end
