object FrameArticleAuthor: TFrameArticleAuthor
  Left = 0
  Top = 0
  Width = 451
  Height = 103
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
    Width = 42
    Height = 13
    Caption = 'AuthorID'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 59
    Height = 13
    Caption = 'AuthorName'
    FocusControl = DBLookupComboBox1
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 74
    Height = 21
    DataField = 'ArticleID'
    DataSource = DataModule1.dsArticleAuthor
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 96
    Top = 24
    Width = 74
    Height = 21
    DataField = 'AuthorID'
    DataSource = DataModule1.dsArticleAuthor
    TabOrder = 1
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 8
    Top = 72
    Width = 434
    Height = 21
    DataField = 'AuthorName'
    DataSource = DataModule1.dsArticleAuthor
    TabOrder = 2
  end
end
