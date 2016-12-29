object Form1: TForm1
  Left = 393
  Top = 266
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1080#1089#1090#1077#1084#1099' '#1089#1095#1080#1089#1083#1077#1085#1080#1103
  ClientHeight = 155
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 87
    Height = 13
    Caption = #1055#1077#1088#1077#1074#1077#1089#1090#1080' '#1095#1080#1089#1083#1086
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 189
    Height = 13
    Caption = #1080#1079' '#1076#1077#1089#1103#1090#1077#1088#1080#1095#1085#1086#1081' '#1089#1080#1089#1090#1077#1084#1099' '#1089#1095#1080#1089#1083#1077#1085#1080#1103
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 6
    Height = 13
    Caption = #1074
  end
  object Edit1: TEdit
    Left = 128
    Top = 8
    Width = 73
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 64
    Top = 96
    Width = 75
    Height = 25
    Caption = #1055#1077#1088#1077#1074#1077#1089#1090#1080
    TabOrder = 1
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 56
    Top = 64
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = #1044#1074#1086#1080#1095#1085#1091#1102
    Items.Strings = (
      #1044#1074#1086#1080#1095#1085#1091#1102
      #1042#1086#1089#1100#1084#1077#1088#1080#1095#1085#1091#1102
      #1064#1077#1089#1090#1085#1072#1076#1094#1072#1090#1077#1088#1080#1095#1085#1091#1102)
  end
  object Edit2: TEdit
    Left = 8
    Top = 128
    Width = 161
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object Button2: TButton
    Left = 176
    Top = 128
    Width = 25
    Height = 21
    Caption = '?'
    TabOrder = 4
    OnClick = Button2Click
  end
end
