object frmMain: TfrmMain
  Left = 160
  Top = 81
  Width = 679
  Height = 586
  Caption = #1043#1088#1072#1092#1086#1084#1080#1085#1080#1084#1080#1079#1072#1090#1086#1088
  Color = clBtnFace
  DockSite = True
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object bvlBevel: TBevel
    Left = 0
    Top = 54
    Width = 445
    Height = 387
    Align = alClient
  end
  object pbOut: TPaintBox
    Left = 0
    Top = 54
    Width = 445
    Height = 387
    Align = alClient
    Color = clBtnHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Topography'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnMouseDown = pbOutMouseDown
    OnMouseMove = pbOutMouseMove
    OnMouseUp = pbOutMouseUp
    OnPaint = pbOutPaint
  end
  object splSplitter: TSplitter
    Left = 0
    Top = 441
    Width = 671
    Height = 7
    Cursor = crVSplit
    Hint = #1069#1090#1080#1084' '#1084#1086#1078#1085#1086' '#1080#1079#1084#1077#1085#1103#1090#1100' '#1088#1072#1079#1084#1077#1088#1099' '#1087#1086#1083#1103' '#1080' '#1090#1072#1073#1083#1080#1094#1099' '#1080#1090#1077#1088#1072#1094#1080#1081
    Align = alBottom
    AutoSnap = False
    Beveled = True
    ResizeStyle = rsUpdate
  end
  object Splitter1: TSplitter
    Left = 445
    Top = 54
    Width = 7
    Height = 387
    Cursor = crHSplit
    Hint = #1048#1079#1084#1077#1085#1103#1081#1090#1077' '#1096#1080#1088#1080#1085#1091' '#1087#1086#1083#1103
    Align = alRight
    AutoSnap = False
    Beveled = True
    ResizeStyle = rsUpdate
  end
  object gbControls: TGroupBox
    Left = 452
    Top = 54
    Width = 219
    Height = 387
    Align = alRight
    Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
    TabOrder = 0
    object lblRadius: TLabel
      Left = 16
      Top = 344
      Width = 69
      Height = 13
      Caption = #1056#1072#1076#1080#1091#1089' '#1090#1086#1095#1082#1080
    end
    object lblRestart: TLabel
      Left = 16
      Top = 368
      Width = 73
      Height = 13
      Caption = #1056#1077#1089#1090#1072#1088#1090' '#1087#1086#1089#1083#1077
    end
    object lblPx: TLabel
      Left = 160
      Top = 344
      Width = 12
      Height = 13
      Caption = 'px'
    end
    object lblIter: TLabel
      Left = 160
      Top = 368
      Width = 48
      Height = 13
      Caption = #1080#1090#1077#1088#1072#1094#1080#1081
    end
    object gbLines: TGroupBox
      Left = 8
      Top = 16
      Width = 201
      Height = 89
      Caption = #1051#1080#1085#1080#1080' '#1091#1088#1086#1074#1085#1103
      TabOrder = 0
      object lblPrec: TLabel
        Left = 8
        Top = 24
        Width = 47
        Height = 13
        Caption = '&'#1058#1086#1095#1085#1086#1089#1090#1100
        FocusControl = nePrec
      end
      object lblCount: TLabel
        Left = 8
        Top = 60
        Width = 63
        Height = 13
        Caption = '&'#1063#1080#1089#1083#1086' '#1083#1080#1085#1080#1081
        FocusControl = neCount
      end
      object neCount: TNumberEdit
        Left = 148
        Top = 56
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '70'
        EnableRealNumbers = False
        DecimalPoint = dpComma
      end
      object nePrec: TNumberEdit
        Left = 116
        Top = 20
        Width = 73
        Height = 21
        TabOrder = 1
        Text = '0.1'
        EnableRealNumbers = True
        DecimalPoint = dpPoint
      end
    end
    object gbMin: TGroupBox
      Left = 8
      Top = 105
      Width = 201
      Height = 232
      Caption = #1052#1080#1085#1080#1084#1080#1079#1072#1094#1080#1103
      TabOrder = 1
      object lbfPrec: TLabel
        Left = 40
        Top = 20
        Width = 47
        Height = 13
        Caption = #1058#1086#1095#1085#1086#1089#1090#1100
      end
      object nefPrec: TNumberEdit
        Left = 104
        Top = 16
        Width = 65
        Height = 21
        TabOrder = 0
        Text = '0.001'
        EnableRealNumbers = True
        DecimalPoint = dpPoint
      end
      object gbWorldCoord: TGroupBox
        Left = 8
        Top = 40
        Width = 185
        Height = 129
        Caption = #1052#1080#1088#1086#1074#1099#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1099
        TabOrder = 1
        object lblLx: TLabel
          Left = 8
          Top = 28
          Width = 12
          Height = 13
          Caption = '&x0'
          FocusControl = neLx
        end
        object lblLy: TLabel
          Left = 8
          Top = 60
          Width = 12
          Height = 13
          Caption = '&y0'
          FocusControl = neLy
        end
        object lblRx: TLabel
          Left = 112
          Top = 28
          Width = 16
          Height = 13
          Caption = 'x,&1'
          FocusControl = neRx
        end
        object lblRy: TLabel
          Left = 112
          Top = 60
          Width = 16
          Height = 13
          Caption = 'y&,1'
          FocusControl = neRy
        end
        object neLx: TNumberEdit
          Left = 32
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '-6'
          EnableRealNumbers = True
          DecimalPoint = dpPoint
        end
        object neLy: TNumberEdit
          Left = 32
          Top = 56
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '-6'
          EnableRealNumbers = True
          DecimalPoint = dpPoint
        end
        object neRx: TNumberEdit
          Left = 136
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 2
          Text = '6'
          EnableRealNumbers = True
          DecimalPoint = dpPoint
        end
        object neRy: TNumberEdit
          Left = 136
          Top = 56
          Width = 41
          Height = 21
          TabOrder = 3
          Text = '6'
          EnableRealNumbers = True
          DecimalPoint = dpPoint
        end
        object cboHistory: TComboBox
          Left = 8
          Top = 80
          Width = 169
          Height = 21
          ItemHeight = 13
          TabOrder = 4
          OnClick = cboHistoryClick
        end
      end
      object gbBeginPoint: TGroupBox
        Left = 8
        Top = 169
        Width = 185
        Height = 53
        Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1090#1086#1095#1082#1072
        TabOrder = 2
        object lblY: TLabel
          Left = 112
          Top = 28
          Width = 12
          Height = 13
          Caption = 'y&*'
          FocusControl = neY
        end
        object lblX: TLabel
          Left = 8
          Top = 28
          Width = 14
          Height = 13
          Caption = 'x&#'
          FocusControl = neX
        end
        object neY: TNumberEdit
          Left = 136
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '4.4721359549'
          EnableRealNumbers = True
          DecimalPoint = dpPoint
        end
        object neX: TNumberEdit
          Left = 32
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '0'
          EnableRealNumbers = True
          DecimalPoint = dpPoint
        end
      end
    end
    object neRestart: TNumberEdit
      Left = 116
      Top = 364
      Width = 41
      Height = 21
      MaxLength = 2
      TabOrder = 2
      Text = '99'
      EnableRealNumbers = False
      DecimalPoint = dpComma
    end
    object neRadius: TNumberEdit
      Left = 116
      Top = 340
      Width = 41
      Height = 21
      MaxLength = 2
      TabOrder = 3
      Text = '2'
      EnableRealNumbers = False
      DecimalPoint = dpComma
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 520
    Width = 671
    Height = 20
    AutoHint = True
    Panels = <
      item
        Text = 'Position:'
        Width = 350
      end
      item
        Text = #1057#1090#1072#1090#1091#1089':'
        Width = 150
      end
      item
        Text = #1052#1077#1090#1086#1076':'
        Width = 50
      end>
    SimplePanel = False
  end
  object lstOut: TListView
    Left = 0
    Top = 448
    Width = 671
    Height = 72
    Hint = #1058#1072#1073#1083#1080#1094#1072' '#1080#1090#1077#1088#1072#1094#1080#1081
    Align = alBottom
    BevelInner = bvNone
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderStyle = bsNone
    BorderWidth = 2
    Columns = <
      item
        Caption = 'N '#1080#1090#1077#1088#1072#1094#1080#1080
        Width = 100
      end
      item
        Caption = '(x,y)'
        Width = 100
      end
      item
        Caption = 'f(x,y)'
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = 'cappa'
      end
      item
        Caption = #1053#1086#1088#1084#1072' '#1075#1088#1072#1076#1080#1077#1085#1090#1072
        Width = 120
      end>
    FlatScrollBars = True
    GridLines = True
    IconOptions.WrapText = False
    ReadOnly = True
    RowSelect = True
    ParentBiDiMode = False
    TabOrder = 2
    ViewStyle = vsReport
  end
  object tlbButtons: TToolBar
    Left = 0
    Top = 0
    Width = 671
    Height = 54
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 168
    Caption = 'tlbButtons'
    Color = clWhite
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Flat = True
    ParentColor = False
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 3
    Transparent = True
    object btnLevels: TToolButton
      Left = 0
      Top = 0
      Hint = #1057#1090#1088#1086#1080#1090' '#1083#1080#1085#1080#1080' '#1091#1088#1086#1074#1085#1103
      AutoSize = True
      Caption = #1051#1080#1085#1080#1080' '#1091#1088#1086#1074#1085#1103
      ImageIndex = 0
      OnClick = btnLevelsClick
    end
    object btnMin: TToolButton
      Left = 81
      Top = 0
      Hint = 
        #1052#1080#1085#1080#1084#1080#1079#1080#1088#1091#1077#1090' '#1092#1091#1085#1082#1094#1080#1102' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1089#1087#1086#1089#1086#1073#1086#1084' ('#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' - '#1075#1088#1072#1076#1080#1077#1085#1090#1085 +
        #1099#1084')'
      AutoSize = True
      Caption = #1052#1080#1085#1080#1084#1080#1079#1080#1088#1086#1074#1072#1090#1100' - (F9)'
      ImageIndex = 1
      OnClick = btnMinClick
    end
    object Separator: TToolButton
      Left = 207
      Top = 0
      Width = 8
      Caption = 'Separator'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btnScale: TToolButton
      Left = 215
      Top = 0
      Hint = #1055#1086' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1080' '#1076#1077#1083#1072#1077#1090' '#1087#1086#1083#1077' '#1074#1099#1074#1086#1076#1072' '#1082#1074#1072#1076#1088#1072#1090#1085#1099#1084
      AutoSize = True
      Caption = #1055#1086#1076#1075#1086#1085#1103#1090#1100' '#1082' '#1088#1072#1074#1085#1086#1084#1091' '#1084#1072#1089#1096#1090#1072#1073#1091
      Down = True
      ImageIndex = 2
      Style = tbsCheck
    end
    object ToolButton2: TToolButton
      Left = 0
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 4
      Wrap = True
      Style = tbsSeparator
    end
    object btnMethod: TToolButton
      Left = 0
      Top = 29
      AllowAllUp = True
      AutoSize = True
      Caption = '&'#1052#1077#1090#1086#1076
      MenuItem = mnuMethod
      ParentShowHint = False
      ShowHint = True
      Style = tbsDropDown
      OnClick = btnMethodClick
    end
    object Separator1: TToolButton
      Left = 57
      Top = 29
      Width = 8
      Caption = 'Separator1'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object btnSaveRep: TToolButton
      Left = 65
      Top = 29
      Hint = #1057#1086#1093#1088#1072#1085#1103#1077#1090' '#1090#1072#1073#1083#1080#1094#1091' '#1080#1090#1077#1088#1072#1094#1080#1081' '#1074' '#1092#1072#1081#1083' table.txt'
      AllowAllUp = True
      AutoSize = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1090#1095#1077#1090
      ImageIndex = 0
      OnClick = btnSaveRepClick
    end
    object btnSavePicture: TToolButton
      Left = 164
      Top = 29
      Hint = #1057#1086#1093#1088#1072#1085#1103#1077#1090' '#1087#1086#1083#1077' '#1074#1099#1074#1086#1076#1072' '#1074' '#1092#1072#1081#1083' level.bmp'
      AllowAllUp = True
      AutoSize = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1088#1090#1080#1085#1082#1091
      ImageIndex = 1
      OnClick = btnSavePictureClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 344
    Top = 280
    object mnuReport: TMenuItem
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
      object mnuSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
        ShortCut = 16466
        OnClick = mnuSaveClick
      end
      object mnuSavePicture: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1088#1090#1080#1085#1082#1091
        ShortCut = 16464
        OnClick = mnuSavePictureClick
      end
    end
    object mnuMethod: TMenuItem
      Caption = '&'#1052#1077#1090#1086#1076
      object mnuCrackingStep: TMenuItem
        AutoCheck = True
        Caption = #1043#1088#1072#1076#1080#1077#1085#1090#1085#1086#1075#1086' '#1089#1087#1091#1089#1082#1072' '#1089' '#1076#1088#1086#1073#1083#1077#1085#1080#1077#1084' '#1096#1072#1075#1072
        Checked = True
        Hint = #1043#1088#1072#1076#1080#1077#1085#1090#1085#1086#1075#1086' '#1089#1087#1091#1089#1082#1072' '#1089' '#1076#1088#1086#1073#1083#1077#1085#1080#1077#1084' '#1096#1072#1075#1072
        RadioItem = True
        ShortCut = 16496
        OnClick = mnuCrackingStepClick
      end
      object mnuQuickestDescent: TMenuItem
        Caption = #1053#1072#1080#1089#1082#1086#1088#1077#1081#1096#1077#1075#1086' '#1089#1087#1091#1089#1082#1072
        Hint = #1052#1077#1090#1086#1076' '#1085#1072#1080#1089#1082#1086#1088#1077#1081#1096#1077#1075#1086' '#1089#1087#1091#1089#1082#1072
        RadioItem = True
        ShortCut = 16497
        OnClick = mnuQuickestDescentClick
      end
      object mnuConj: TMenuItem
        Caption = #1057#1086#1087#1088#1103#1078#1077#1085#1085#1099#1093' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1081
        Hint = #1057#1086#1087#1088#1103#1078#1077#1085#1085#1099#1093' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1081
        RadioItem = True
        ShortCut = 16498
        OnClick = mnuConjClick
      end
      object mnuQuasi: TMenuItem
        Caption = #1044#1060#1055
        Hint = #1044#1072#1074#1080#1076#1086#1085#1072'-'#1060#1083#1077#1090#1095#1077#1088#1072'-'#1055#1072#1091#1101#1083#1083#1072
        RadioItem = True
        ShortCut = 16499
        OnClick = mnuQuasiClick
      end
      object N2: TMenuItem
        AutoLineReduction = maManual
        Caption = '-'
      end
      object mnuCycle: TMenuItem
        Caption = #1062#1080#1082#1083#1080#1095#1077#1089#1082#1086#1075#1086' '#1087#1086#1082#1086#1086#1088#1076#1080#1085#1072#1090#1085#1086#1075#1086' '#1089#1087#1091#1089#1082#1072
        RadioItem = True
        ShortCut = 16500
        OnClick = mnuCycleClick
      end
      object mnuHookJeavse: TMenuItem
        Caption = #1061#1091#1082#1072'-'#1044#1078#1080#1074#1089#1072
        Hint = #1053#1091#1083#1077#1074#1086#1075#1086' '#1087#1086#1088#1103#1076#1082#1072': '#1061#1091#1082#1072'-'#1044#1078#1080#1074#1089#1072
        RadioItem = True
        ShortCut = 16501
        OnClick = mnuHookJeavseClick
      end
      object mnuRosenbrooks: TMenuItem
        Caption = #1056#1086#1079#1077#1085#1073#1088#1086#1082#1072
        Hint = #1053#1091#1083#1077#1074#1086#1075#1086' '#1087#1086#1088#1103#1076#1082#1072': '#1056#1086#1079#1077#1085#1073#1088#1086#1082#1072
        RadioItem = True
        ShortCut = 16502
        OnClick = mnuRosenbrooksClick
      end
      object mnuPawell: TMenuItem
        Caption = #1055#1072#1091#1101#1083#1083#1072
        Hint = #1053#1091#1083#1077#1074#1086#1075#1086' '#1087#1086#1088#1103#1076#1082#1072': '#1055#1072#1091#1101#1083#1083#1072
        RadioItem = True
        ShortCut = 16503
        OnClick = mnuPawellClick
      end
      object N1: TMenuItem
        AutoLineReduction = maAutomatic
        Caption = '-'
      end
      object mnuNelderMid: TMenuItem
        Caption = #1053#1077#1083#1076#1077#1088#1072'-'#1052#1080#1076#1072
        Hint = #1055#1086#1080#1089#1082' '#1087#1088#1080' '#1087#1086#1084#1086#1097#1080' '#1085#1077#1088#1077#1075#1091#1083#1103#1088#1085#1086#1075#1086' '#1089#1080#1084#1087#1083#1077#1082#1089#1072
        RadioItem = True
        ShortCut = 16505
        OnClick = mnuNelderMidClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuCondGrad: TMenuItem
        Caption = #1059#1089#1083#1086#1074#1085#1086#1075#1086' '#1075#1088#1072#1076#1080#1077#1085#1090#1072
        Hint = #1052#1077#1090#1086#1076#1099' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1084#1080#1085#1080#1084#1080#1079#1072#1094#1080#1080': '#1091#1089#1083#1086#1074#1085#1086#1075#1086' '#1075#1088#1072#1076#1080#1077#1085#1090#1072
        RadioItem = True
        ShortCut = 8304
        OnClick = mnuCondGradClick
      end
      object mnuAntigradPrj: TMenuItem
        Caption = #1055#1088#1086#1077#1082#1094#1080#1080' '#1072#1085#1090#1080#1075#1088#1072#1076#1080#1077#1085#1090#1072
        Hint = #1052#1077#1090#1086#1076#1099' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1084#1080#1085#1080#1084#1080#1079#1072#1094#1080#1080': '#1087#1088#1086#1077#1082#1094#1080#1080' '#1072#1085#1090#1080#1075#1088#1072#1076#1080#1077#1085#1090#1072
        RadioItem = True
        ShortCut = 8305
        OnClick = mnuAntigradPrjClick
      end
    end
  end
end
