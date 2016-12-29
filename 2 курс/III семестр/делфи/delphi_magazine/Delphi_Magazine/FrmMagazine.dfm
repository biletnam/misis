object FrameMagazine: TFrameMagazine
  Left = 0
  Top = 0
  Width = 451
  Height = 186
  TabOrder = 0
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Magazine ID:'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 23
    Height = 13
    Caption = 'Title:'
    FocusControl = DBEdit2
  end
  object Label4: TLabel
    Left = 8
    Top = 96
    Width = 61
    Height = 13
    Caption = 'Editor Name:'
    FocusControl = DBLookupComboBox1
  end
  object Label5: TLabel
    Left = 8
    Top = 136
    Width = 58
    Height = 13
    Caption = 'Editor Email:'
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 152
    Width = 434
    Height = 21
    DataField = 'EditorEmail'
    DataSource = DataModule1.dsMagazine
    ReadOnly = True
    TabOrder = 3
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 104
    Height = 21
    DataField = 'MagazineID'
    DataSource = DataModule1.dsMagazine
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 64
    Width = 434
    Height = 21
    DataField = 'Title'
    DataSource = DataModule1.dsMagazine
    TabOrder = 1
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 8
    Top = 112
    Width = 434
    Height = 21
    DataField = 'EditorName'
    DataSource = DataModule1.dsMagazine
    TabOrder = 2
  end
end
