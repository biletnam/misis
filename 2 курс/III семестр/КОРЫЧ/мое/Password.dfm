object PasswordForm: TPasswordForm
  Left = 686
  Top = 485
  Width = 229
  Height = 204
  Caption = #1055#1072#1088#1086#1083#1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 84
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100':'
  end
  object Info: TLabel
    Left = 16
    Top = 112
    Width = 203
    Height = 57
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 119
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    Visible = False
  end
  object Edit_Pass: TEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object ButtonOK: TButton
    Left = 152
    Top = 16
    Width = 49
    Height = 41
    Caption = 'OK'
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object EditNewPas: TEdit
    Left = 16
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
    Visible = False
  end
  object ButtonChange: TButton
    Left = 32
    Top = 64
    Width = 89
    Height = 25
    Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
    TabOrder = 3
    OnClick = ButtonChangeClick
  end
  object ButtonNewPas: TButton
    Left = 152
    Top = 56
    Width = 49
    Height = 41
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 4
    Visible = False
    OnClick = ButtonNewPasClick
  end
end
