object Form1: TForm1
  Left = 224
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Delphi Magazine'
  ClientHeight = 459
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 561
    Height = 459
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Magazines && Editors/Authors'
      ImageIndex = 1
      object Bevel1: TBevel
        Left = 0
        Top = 229
        Width = 553
        Height = 9
        Align = alTop
        Shape = bsTopLine
      end
      inline FrameMagazine1: TFrameMagazine
        Left = 0
        Top = 0
        Width = 553
        Height = 229
        Align = alTop
        TabOrder = 0
        inherited Label1: TLabel
          Left = 10
          Top = 10
        end
        inherited Label2: TLabel
          Left = 10
          Top = 59
        end
        inherited Label4: TLabel
          Left = 10
          Top = 118
        end
        inherited Label5: TLabel
          Left = 10
          Top = 167
        end
        inherited DBEdit3: TDBEdit
          Left = 10
          Top = 187
          Width = 534
        end
        inherited DBEdit1: TDBEdit
          Left = 10
          Top = 30
          Width = 128
        end
        inherited DBEdit2: TDBEdit
          Left = 10
          Top = 79
          Width = 534
        end
        inherited DBLookupComboBox1: TDBLookupComboBox
          Left = 10
          Top = 138
          Width = 534
        end
      end
      inline FrameAuthor1: TFrameAuthor
        Left = 0
        Top = 238
        Width = 553
        Height = 167
        Align = alTop
        TabOrder = 1
        inherited Label1: TLabel
          Left = 10
          Top = 10
        end
        inherited Label2: TLabel
          Left = 10
          Top = 59
        end
        inherited Label3: TLabel
          Left = 10
          Top = 108
        end
        inherited DBEdit1: TDBEdit
          Left = 10
          Top = 30
          Width = 128
        end
        inherited DBEdit2: TDBEdit
          Left = 10
          Top = 79
          Width = 535
        end
        inherited DBEdit3: TDBEdit
          Left = 10
          Top = 128
          Width = 535
        end
      end
      object DBNavigator1: TDBNavigator
        Left = 232
        Top = 30
        Width = 300
        Height = 30
        DataSource = DataModule1.dsMagazine
        TabOrder = 2
      end
      object DBNavigator2: TDBNavigator
        Left = 232
        Top = 266
        Width = 300
        Height = 31
        DataSource = DataModule1.dsEditor
        TabOrder = 3
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Issues && Articles'
      object Bevel2: TBevel
        Left = 0
        Top = 164
        Width = 553
        Height = 14
        Align = alTop
        Shape = bsTopLine
      end
      object Bevel3: TBevel
        Left = 0
        Top = 294
        Width = 553
        Height = 11
        Align = alTop
        Shape = bsTopLine
      end
      inline FrameIssue1: TFrameIssue
        Left = 0
        Top = 0
        Width = 553
        Height = 164
        Align = alTop
        TabOrder = 0
        inherited Label1: TLabel
          Left = 10
          Top = 10
        end
        inherited Label2: TLabel
          Left = 118
          Top = 10
        end
        inherited Label3: TLabel
          Left = 10
          Top = 59
        end
        inherited Label4: TLabel
          Left = 118
          Top = 59
        end
        inherited Label5: TLabel
          Left = 10
          Top = 108
        end
        inherited DBEdit1: TDBEdit
          Left = 10
          Top = 30
          Width = 91
        end
        inherited DBEdit2: TDBEdit
          Left = 118
          Top = 30
          Width = 91
        end
        inherited DBEdit3: TDBEdit
          Left = 10
          Top = 79
          Width = 91
        end
        inherited DBEdit4: TDBEdit
          Left = 118
          Top = 79
          Width = 91
        end
        inherited DBEdit5: TDBEdit
          Left = 10
          Top = 128
          Width = 91
        end
      end
      inline FrameArticle1: TFrameArticle
        Left = 0
        Top = 178
        Width = 553
        Height = 116
        Align = alTop
        TabOrder = 1
        inherited Label1: TLabel
          Left = 10
          Top = 10
        end
        inherited Label2: TLabel
          Left = 118
          Top = 10
        end
        inherited Label3: TLabel
          Left = 10
          Top = 59
        end
        inherited DBEdit1: TDBEdit
          Left = 10
          Top = 30
          Width = 91
        end
        inherited DBEdit2: TDBEdit
          Left = 118
          Top = 30
          Width = 91
        end
        inherited DBEdit3: TDBEdit
          Left = 10
          Top = 79
          Width = 534
        end
      end
      object DBNavigator3: TDBNavigator
        Left = 246
        Top = 30
        Width = 290
        Height = 30
        DataSource = DataModule1.dsIssue
        TabOrder = 2
      end
      object DBNavigator4: TDBNavigator
        Left = 246
        Top = 207
        Width = 290
        Height = 31
        DataSource = DataModule1.dsArticle
        TabOrder = 3
      end
      inline FrameArticleAuthor1: TFrameArticleAuthor
        Left = 0
        Top = 305
        Width = 553
        Height = 123
        Align = alClient
        TabOrder = 4
        inherited Label1: TLabel
          Left = 10
          Top = 10
        end
        inherited Label2: TLabel
          Left = 118
          Top = 10
        end
        inherited Label3: TLabel
          Left = 10
          Top = 69
        end
        inherited DBEdit1: TDBEdit
          Left = 10
          Top = 30
          Width = 91
        end
        inherited DBEdit2: TDBEdit
          Left = 118
          Top = 30
          Width = 91
        end
        inherited DBLookupComboBox1: TDBLookupComboBox
          Left = 10
          Top = 89
          Width = 534
        end
      end
      object DBNavigator5: TDBNavigator
        Left = 246
        Top = 335
        Width = 290
        Height = 31
        DataSource = DataModule1.dsArticleAuthor
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Overview'
      ImageIndex = 2
      object DBGrid2: TDBGrid
        Left = 10
        Top = 317
        Width = 535
        Height = 100
        DataSource = DataModule1.dsArticleAuthor
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'AuthorName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AuthorEmail'
            Width = 167
            Visible = True
          end>
      end
      object DBGrid3: TDBGrid
        Left = 10
        Top = 44
        Width = 535
        Height = 269
        DataSource = DataModule1.dsArticle
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IssueVolume'
            Title.Caption = 'Vol'
            Width = 32
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IssueNumber'
            Title.Caption = 'Nr'
            Width = 32
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IssueDate'
            Title.Caption = 'Date'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Title'
            Title.Caption = 'Article Title'
            Visible = True
          end>
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 10
        Top = 10
        Width = 535
        Height = 24
        KeyField = 'MagazineID'
        ListField = 'Title'
        ListSource = DataModule1.dsMagazine
        TabOrder = 2
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 164
    Top = 48
  end
end
