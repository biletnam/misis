object FrameIssue: TFrameIssue
  Left = 0
  Top = 0
  Width = 178
  Height = 133
  TabOrder = 0
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 36
    Height = 13
    Caption = 'IssueID'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 96
    Top = 8
    Width = 57
    Height = 13
    Caption = 'MagazineID'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 35
    Height = 13
    Caption = 'Volume'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 96
    Top = 48
    Width = 37
    Height = 13
    Caption = 'Number'
    FocusControl = DBEdit4
  end
  object Label5: TLabel
    Left = 8
    Top = 88
    Width = 23
    Height = 13
    Caption = 'Date'
    FocusControl = DBEdit5
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 74
    Height = 21
    DataField = 'IssueID'
    DataSource = DataModule1.dsIssue
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 96
    Top = 24
    Width = 74
    Height = 21
    DataField = 'MagazineID'
    DataSource = DataModule1.dsIssue
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 64
    Width = 74
    Height = 21
    DataField = 'Volume'
    DataSource = DataModule1.dsIssue
    TabOrder = 2
  end
  object DBEdit4: TDBEdit
    Left = 96
    Top = 64
    Width = 74
    Height = 21
    DataField = 'Number'
    DataSource = DataModule1.dsIssue
    TabOrder = 3
  end
  object DBEdit5: TDBEdit
    Left = 8
    Top = 104
    Width = 74
    Height = 21
    DataField = 'Date'
    DataSource = DataModule1.dsIssue
    TabOrder = 4
  end
end
