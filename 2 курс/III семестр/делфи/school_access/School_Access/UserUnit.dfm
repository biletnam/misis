object UserForm: TUserForm
  Left = 796
  Top = 670
  Width = 321
  Height = 133
  BorderIcons = []
  Caption = #1042#1093#1086#1076' '#1074' '#1041#1072#1079#1091' '#1044#1072#1085#1085#1099#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 14
    Width = 48
    Height = 16
    Caption = #1051#1086#1075#1080#1085':'
  end
  object Label2: TLabel
    Left = 8
    Top = 39
    Width = 55
    Height = 16
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object Button1: TButton
    Left = 72
    Top = 72
    Width = 97
    Height = 25
    Caption = #1042#1093#1086#1076
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 72
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = Button2Click
  end
  object LoginEdit: TEdit
    Left = 72
    Top = 8
    Width = 233
    Height = 25
    TabOrder = 2
  end
  object PasswordEdit: TEdit
    Left = 72
    Top = 40
    Width = 233
    Height = 25
    PasswordChar = '*'
    TabOrder = 3
  end
  object Button3: TButton
    Left = 8
    Top = 72
    Width = 25
    Height = 25
    Caption = '?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
  end
  object UserQuery: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'log'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select*'
      'From '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      'Where '#1051#1086#1075#1080#1085' Like:Log')
    Left = 112
    Top = 24
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=SchoolDataBase.mdb;' +
      'Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 80
    Top = 24
  end
end
