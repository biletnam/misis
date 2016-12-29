object FrameArticle: TFrameArticle
  Left = 0
  Top = 0
  Width = 447
  Height = 94
  TabOrder = 0
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 40
    Height = 13
    Caption = 'ArticleID'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 96
    Top = 8
    Width = 36
    Height = 13
    Caption = 'IssueID'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 20
    Height = 13
    Caption = 'Title'
    FocusControl = DBEdit3
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 74
    Height = 21
    DataField = 'ArticleID'
    DataSource = DataModule1.dsArticle
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 96
    Top = 24
    Width = 74
    Height = 21
    DataField = 'IssueID'
    DataSource = DataModule1.dsArticle
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 64
    Width = 434
    Height = 21
    DataField = 'Title'
    DataSource = DataModule1.dsArticle
    TabOrder = 2
  end
end
