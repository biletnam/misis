object Form1: TForm1
  Left = 219
  Top = 132
  Width = 931
  Height = 557
  Caption = #1052#1086#1076#1077#1083#1100' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 288
    Top = 8
    Width = 625
    Height = 513
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 379
    Height = 16
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1086#1076#1085#1086#1075#1086' '#1088#1077#1078#1080#1084#1072' '#1089#1074#1077#1090#1086#1092#1086#1088#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 385
    Height = 16
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1086#1076#1085#1086#1075#1086' '#1088#1077#1078#1080#1084#1072' '#1089#1074#1077#1090#1086#1092#1086#1088#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 80
    Width = 317
    Height = 16
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1084#1077#1078#1076#1091' '#1087#1086#1103#1074#1083#1077#1085#1080#1103#1084#1080' '#1084#1072#1096#1080#1085':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 112
    Width = 323
    Height = 16
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1084#1077#1078#1076#1091' '#1087#1086#1103#1074#1083#1077#1085#1080#1103#1084#1080' '#1084#1072#1096#1080#1085':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 176
    Width = 196
    Height = 16
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1084#1072#1096#1080#1085'('#1087#1080#1082#1089#1077#1083#1100'/'#1089#1077#1082'):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 144
    Width = 316
    Height = 16
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1084#1072#1096#1080#1085'('#1085#1077' '#1073#1086#1083#1077#1077' 199):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object start: TButton
    Left = 8
    Top = 496
    Width = 233
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Visible = False
    OnClick = startClick
  end
  object map: TButton
    Left = 8
    Top = 232
    Width = 617
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1082#1072#1088#1090#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = mapClick
  end
  object Edit1: TEdit
    Left = 408
    Top = 8
    Width = 217
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '1'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 408
    Top = 40
    Width = 217
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '3'
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 408
    Top = 72
    Width = 217
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = '2'
    OnKeyPress = Edit1KeyPress
  end
  object Edit4: TEdit
    Left = 408
    Top = 104
    Width = 217
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = '5'
    OnKeyPress = Edit2KeyPress
  end
  object Edit5: TEdit
    Left = 408
    Top = 168
    Width = 217
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = '5'
    OnKeyPress = Edit5KeyPress
  end
  object Edit6: TEdit
    Left = 408
    Top = 136
    Width = 217
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Text = '10'
    OnKeyPress = Edit6KeyPress
  end
  object Button1: TButton
    Left = 464
    Top = 200
    Width = 161
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1082#1072#1088#1090#1091' ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = Button1Click
  end
  object Edit7: TEdit
    Left = 8
    Top = 200
    Width = 449
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 472
    Top = 56
  end
  object OpenDialog1: TOpenDialog
    Left = 440
    Top = 56
  end
end
