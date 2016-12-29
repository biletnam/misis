object FrameAuthor: TFrameAuthor
  Left = 0
  Top = 0
  Width = 440
  Height = 136
  TabOrder = 0
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 42
    Height = 13
    Caption = 'AuthorID'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 28
    Height = 13
    Caption = 'Name'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 25
    Height = 13
    Caption = 'Email'
    FocusControl = DBEdit3
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 104
    Height = 21
    DataField = 'AuthorID'
    DataSource = DataModule1.dsEditor
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 64
    Width = 424
    Height = 21
    DataField = 'Name'
    DataSource = DataModule1.dsEditor
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 104
    Width = 424
    Height = 21
    DataField = 'Email'
    DataSource = DataModule1.dsEditor
    TabOrder = 2
  end
end
