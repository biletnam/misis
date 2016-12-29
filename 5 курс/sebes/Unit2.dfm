object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1043#1083#1072#1074#1085#1072#1103
  ClientHeight = 614
  ClientWidth = 877
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    877
    614)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 861
    Height = 597
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #1055#1088#1086#1076#1091#1082#1094#1080#1103
      ExplicitHeight = 333
      DesignSize = (
        853
        569)
      object StringGrid1: TStringGrid
        Left = 16
        Top = 16
        Width = 825
        Height = 519
        Anchors = [akLeft, akTop, akRight, akBottom]
        DefaultRowHeight = 20
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 0
        ExplicitHeight = 283
      end
      object Button5: TButton
        Left = 678
        Top = 541
        Width = 163
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 1
        OnClick = Button5Click
        ExplicitTop = 305
      end
      object Button6: TButton
        Left = 509
        Top = 541
        Width = 163
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 2
        OnClick = Button6Click
        ExplicitTop = 305
      end
      object Button2: TButton
        Left = 352
        Top = 541
        Width = 151
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button7: TButton
        Left = 200
        Top = 541
        Width = 146
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072
        TabOrder = 4
        OnClick = Button7Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1056#1072#1073#1086#1090#1099
      ImageIndex = 1
      ExplicitHeight = 333
      DesignSize = (
        853
        569)
      object StringGrid2: TStringGrid
        Left = 16
        Top = 16
        Width = 825
        Height = 519
        Anchors = [akLeft, akTop, akRight, akBottom]
        DefaultRowHeight = 20
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 0
        ExplicitHeight = 283
      end
      object Button1: TButton
        Left = 681
        Top = 541
        Width = 160
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 1
        OnClick = Button1Click
        ExplicitTop = 305
      end
      object Button3: TButton
        Left = 328
        Top = 541
        Width = 160
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        TabOrder = 2
        OnClick = Button3Click
        ExplicitTop = 305
      end
      object Button4: TButton
        Left = 504
        Top = 541
        Width = 160
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 3
        OnClick = Button4Click
        ExplicitTop = 305
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1091#1102#1097#1080#1077
      ImageIndex = 2
      ExplicitHeight = 333
      DesignSize = (
        853
        569)
      object StringGrid3: TStringGrid
        Left = 16
        Top = 16
        Width = 825
        Height = 517
        Anchors = [akLeft, akTop, akRight, akBottom]
        DefaultRowHeight = 20
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 0
        ExplicitHeight = 281
      end
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 808
    Top = 288
  end
end
