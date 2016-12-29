object Form1: TForm1
  Left = 253
  Top = 148
  BorderStyle = bsSingle
  Caption = #1042#1072#1088#1080#1072#1085#1090' '#1050'-'#1048#1057'-1-2-16'
  ClientHeight = 409
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 120
    Width = 29
    Height = 19
    Caption = 'R = '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 8
    Height = 95
    Caption = '1'#13#10'2'#13#10'3'#13#10'4'#13#10'5'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 312
    Width = 105
    Height = 19
    Caption = 'R '#1084#1077#1085#1103#1077#1090#1089#1103' '#1086#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 160
    Top = 312
    Width = 16
    Height = 19
    Caption = #1076#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 328
    Width = 57
    Height = 19
    Caption = #1089' '#1096#1072#1075#1086#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 72
    Top = 350
    Width = 168
    Height = 19
    Caption = #1087#1088#1080' '#1082#1072#1082#1080#1093' '#1079#1085#1072#1095#1077#1085#1080#1103#1093' R'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 368
    Width = 193
    Height = 38
    Caption = #1082#1086#1088#1077#1085#1100' z '#1083#1077#1078#1080#1090' '#1074' '#1087#1088#1077#1076#1077#1083#1072#1093#13#10' -2.47<z<-0.29'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 200
    Top = 112
    Width = 65
    Height = 25
    Caption = #1056#1077#1096#1080#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object OutWindow: TMemo
    Left = 8
    Top = 144
    Width = 257
    Height = 153
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 40
    Top = 120
    Width = 33
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object Edit2: TEdit
    Left = 120
    Top = 312
    Width = 33
    Height = 21
    TabOrder = 3
    Text = '-5'
  end
  object Edit3: TEdit
    Left = 184
    Top = 312
    Width = 33
    Height = 21
    TabOrder = 4
    Text = '5'
  end
  object Edit4: TEdit
    Left = 72
    Top = 328
    Width = 33
    Height = 21
    TabOrder = 5
    Text = '0,1'
  end
  object Button3: TButton
    Left = 8
    Top = 344
    Width = 57
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object XPManifest: TXPManifest
    Left = 232
    Top = 376
  end
end
