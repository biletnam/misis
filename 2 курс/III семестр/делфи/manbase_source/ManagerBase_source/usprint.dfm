object Form1: TForm1
  Left = 196
  Top = 129
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088#1082#1072
  ClientHeight = 608
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCC0
    000CCCC0000000000CCCC7777CCCCCCC0000CCCC00000000CCCC7777CCCCCCCC
    C0000CCCCCCCCCCCCCC7777CCCCC0CCCCC0000CCCCCCCCCCCC7777CCCCC700CC
    C00CCCC0000000000CCCC77CCC77000C0000CCCC00000000CCCC7777C7770000
    00000CCCC000000CCCC777777777C000C00000CCCC0000CCCC77777C777CCC00
    CC00000CCCCCCCCCC77777CC77CCCCC0CCC000CCCCC00CCCCC777CCC7CCCCCCC
    CCCC0CCCCCCCCCCCCCC7CCCCCCCCCCCC0CCCCCCCCCCCCCCCCCCCCCC7CCC70CCC
    00CCCCCCCC0CC0CCCCCCCC77CC7700CC000CCCCCC000000CCCCCC777CC7700CC
    0000CCCC00000000CCCC7777CC7700CC0000C0CCC000000CCC7C7777CC7700CC
    0000C0CCC000000CCC7C7777CC7700CC0000CCCC00000000CCCC7777CC7700CC
    000CCCCCC000000CCCCCC777CC7700CC00CCCCCCCC0CC0CCCCCCCC77CC770CCC
    0CCCCCCCCCCCCCCCCCCCCCC7CCC7CCCCCCCC0CCCCCCCCCCCCCC7CCCCCCCCCCC0
    CCC000CCCCC00CCCCC777CCC7CCCCC00CC00000CCCCCCCCCC77777CC77CCC000
    C00000CCCC0000CCCC77777C777C000000000CCCC000000CCCC777777777000C
    0000CCCC00000000CCCC7777C77700CCC00CCCC0000000000CCCC77CCC770CCC
    CC0000CCCCCCCCCCCC7777CCCCC7CCCCC0000CCCCCCCCCCCCCC7777CCCCCCCCC
    0000CCCC00000000CCCC7777CCCCCCC0000CCCC0000000000CCCC7777CCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object StringGrid1: TStringGrid
    Left = 0
    Top = 89
    Width = 1015
    Height = 519
    Align = alClient
    ColCount = 11
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    TabOrder = 2
    OnClick = StringGrid1Click
    OnDblClick = StringGrid1DblClick
    RowHeights = (
      24
      24)
  end
  object Button5: TButton
    Left = 792
    Top = 136
    Width = 209
    Height = 25
    Caption = 'Save to '#39'adsbaz.dat'#39
    TabOrder = 3
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 792
    Top = 216
    Width = 209
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083'...'
    TabOrder = 4
    Visible = False
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 792
    Top = 104
    Width = 209
    Height = 25
    Caption = 'Import to StringGrid from files...'
    TabOrder = 5
    Visible = False
    OnClick = Button7Click
  end
  object Button10: TButton
    Left = 792
    Top = 448
    Width = 209
    Height = 25
    Caption = #1055#1077#1088#1077#1076#1072#1090#1100' '#1074' Excel'
    TabOrder = 6
    Visible = False
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 792
    Top = 384
    Width = 209
    Height = 25
    Caption = #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' Excel'
    TabOrder = 7
    Visible = False
    OnClick = Button11Click
  end
  object Button1: TButton
    Left = 792
    Top = 296
    Width = 209
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 792
    Top = 328
    Width = 209
    Height = 25
    Caption = #1042' RichEdit'
    TabOrder = 1
    Visible = False
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1015
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 8
    object Label1: TLabel
      Left = 8
      Top = 56
      Width = 152
      Height = 16
      Caption = #1055#1086#1079#1080#1094#1080#1103' '#1076#1083#1103' '#1074#1099#1073#1086#1088#1082#1080':'
    end
    object Bevel1: TBevel
      Left = 632
      Top = 16
      Width = 9
      Height = 57
      Shape = bsLeftLine
    end
    object Bevel3: TBevel
      Left = 352
      Top = 16
      Width = 9
      Height = 57
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 864
      Top = 16
      Width = 9
      Height = 57
      Shape = bsLeftLine
    end
    object RichEdit1: TRichEdit
      Left = 656
      Top = 8
      Width = 185
      Height = 73
      PlainText = True
      ScrollBars = ssBoth
      TabOrder = 0
      Visible = False
    end
    object RichEdit2: TRichEdit
      Left = 360
      Top = 8
      Width = 265
      Height = 73
      PlainText = True
      ScrollBars = ssBoth
      TabOrder = 1
      Visible = False
    end
    object Button3: TButton
      Left = 8
      Top = 16
      Width = 153
      Height = 25
      Caption = #1042#1099#1073#1088#1072#1090#1100
      TabOrder = 2
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      Left = 176
      Top = 16
      Width = 161
      Height = 24
      ItemHeight = 16
      TabOrder = 3
      Text = #1042#1089#1077
      OnChange = ComboBox1Change
      Items.Strings = (
        #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        #1056#1077#1075#1080#1086#1085
        #1052#1077#1085#1077#1076#1078#1077#1088
        #1042#1089#1077)
    end
    object Button8: TButton
      Left = 368
      Top = 16
      Width = 249
      Height = 25
      Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1096#1080#1088#1080#1085#1072' '#1103#1095#1077#1077#1082
      Enabled = False
      TabOrder = 4
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 368
      Top = 48
      Width = 249
      Height = 25
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1073#1091#1092#1077#1088
      Enabled = False
      TabOrder = 5
      OnClick = Button9Click
    end
    object ComboBox2: TComboBox
      Left = 176
      Top = 48
      Width = 161
      Height = 24
      Enabled = False
      ItemHeight = 16
      TabOrder = 6
    end
    object Button4: TButton
      Left = 872
      Top = 32
      Width = 129
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 7
      OnClick = Button4Click
    end
    object Button12: TButton
      Left = 648
      Top = 32
      Width = 201
      Height = 25
      Caption = #1055#1077#1088#1077#1076#1072#1090#1100' '#1074' Excel'
      Enabled = False
      TabOrder = 8
      OnClick = Button12Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 960
    Top = 208
  end
  object XLApp: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 800
    Top = 440
  end
end
