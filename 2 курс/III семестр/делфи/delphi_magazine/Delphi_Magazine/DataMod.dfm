object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 452
  Top = 368
  Height = 334
  Width = 221
  object cdsMagazine: TClientDataSet
    Aggregates = <>
    FileName = 'Magazine.xml'
    IndexFieldNames = 'MagazineID'
    Params = <>
    Left = 48
    Top = 16
    object cdsMagazineMagazineID: TIntegerField
      FieldName = 'MagazineID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsMagazineTitle: TStringField
      FieldName = 'Title'
      Size = 64
    end
    object cdsMagazineEditorID: TIntegerField
      FieldName = 'EditorID'
    end
    object cdsMagazineEditorName: TStringField
      FieldKind = fkLookup
      FieldName = 'EditorName'
      LookupDataSet = cdsAuthor
      LookupKeyFields = 'AuthorID'
      LookupResultField = 'Name'
      KeyFields = 'EditorID'
      Size = 42
      Lookup = True
    end
    object cdsMagazineEditorEmail: TStringField
      FieldKind = fkLookup
      FieldName = 'EditorEmail'
      LookupDataSet = cdsAuthor
      LookupKeyFields = 'AuthorID'
      LookupResultField = 'Email'
      KeyFields = 'EditorID'
      Size = 42
      Lookup = True
    end
  end
  object cdsIssue: TClientDataSet
    Aggregates = <>
    FileName = 'Issue.xml'
    IndexFieldNames = 'IssueID'
    Params = <>
    BeforeInsert = cdsIssueBeforeInsert
    AfterInsert = cdsIssueAfterInsert
    Left = 48
    Top = 72
    object cdsIssueIssueID: TIntegerField
      FieldName = 'IssueID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsIssueMagazineID: TIntegerField
      FieldName = 'MagazineID'
    end
    object cdsIssueVolume: TIntegerField
      FieldName = 'Volume'
    end
    object cdsIssueNumber: TIntegerField
      FieldName = 'Number'
    end
    object cdsIssueDate: TStringField
      FieldName = 'Date'
      Size = 7
    end
  end
  object cdsArticle: TClientDataSet
    Aggregates = <>
    FileName = 'Article.xml'
    IndexFieldNames = 'MagazineID;ArticleID'
    MasterFields = 'MagazineID'
    MasterSource = dsMagazine
    PacketRecords = 0
    Params = <>
    BeforeInsert = cdsArticleBeforeInsert
    AfterInsert = cdsArticleAfterInsert
    Left = 48
    Top = 128
    object cdsArticleArticleID: TIntegerField
      FieldName = 'ArticleID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsArticleMagazineID: TIntegerField
      FieldName = 'MagazineID'
    end
    object cdsArticleIssueID: TIntegerField
      FieldName = 'IssueID'
    end
    object cdsArticleTitle: TStringField
      FieldName = 'Title'
      Size = 128
    end
    object cdsArticleIssueVolume: TIntegerField
      FieldKind = fkLookup
      FieldName = 'IssueVolume'
      LookupDataSet = cdsIssue
      LookupKeyFields = 'IssueID'
      LookupResultField = 'Volume'
      KeyFields = 'IssueID'
      Lookup = True
    end
    object cdsArticleIssueNumber: TIntegerField
      FieldKind = fkLookup
      FieldName = 'IssueNumber'
      LookupDataSet = cdsIssue
      LookupKeyFields = 'IssueID'
      LookupResultField = 'Number'
      KeyFields = 'IssueID'
      Lookup = True
    end
    object cdsArticleIssueDate: TStringField
      FieldKind = fkLookup
      FieldName = 'IssueDate'
      LookupDataSet = cdsIssue
      LookupKeyFields = 'IssueID'
      LookupResultField = 'Date'
      KeyFields = 'IssueID'
      Size = 7
      Lookup = True
    end
  end
  object cdsArticleAuthor: TClientDataSet
    Aggregates = <>
    FileName = 'ArticleAuthor.xml'
    IndexFieldNames = 'ArticleID;AuthorID'
    MasterFields = 'ArticleID'
    MasterSource = dsArticle
    PacketRecords = 0
    Params = <>
    AfterInsert = cdsArticleAuthorAfterInsert
    Left = 48
    Top = 184
    object cdsArticleAuthorArticleID: TIntegerField
      FieldName = 'ArticleID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsArticleAuthorAuthorID: TIntegerField
      FieldName = 'AuthorID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsArticleAuthorAuthorName: TStringField
      FieldKind = fkLookup
      FieldName = 'AuthorName'
      LookupDataSet = cdsAuthor
      LookupKeyFields = 'AuthorID'
      LookupResultField = 'Name'
      KeyFields = 'AuthorID'
      Size = 42
      Lookup = True
    end
    object cdsArticleAuthorAuthorEmail: TStringField
      FieldKind = fkLookup
      FieldName = 'AuthorEmail'
      LookupDataSet = cdsAuthor
      LookupKeyFields = 'AuthorID'
      LookupResultField = 'Email'
      KeyFields = 'AuthorID'
      Size = 42
      Lookup = True
    end
  end
  object cdsAuthor: TClientDataSet
    Aggregates = <>
    FileName = 'Author.xml'
    IndexFieldNames = 'AuthorID'
    Params = <>
    Left = 48
    Top = 240
    object cdsAuthorAuthorID: TIntegerField
      FieldName = 'AuthorID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsAuthorName: TStringField
      FieldName = 'Name'
      Size = 42
    end
    object cdsAuthorEmail: TStringField
      FieldName = 'Email'
      Size = 42
    end
  end
  object dsMagazine: TDataSource
    DataSet = cdsMagazine
    Left = 128
    Top = 16
  end
  object dsEditor: TDataSource
    DataSet = cdsAuthor
    Left = 120
    Top = 240
  end
  object dsIssue: TDataSource
    DataSet = cdsIssue
    Left = 128
    Top = 72
  end
  object dsArticle: TDataSource
    DataSet = cdsArticle
    Left = 128
    Top = 128
  end
  object dsArticleAuthor: TDataSource
    DataSet = cdsArticleAuthor
    Left = 128
    Top = 184
  end
end
