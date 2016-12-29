object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 235
  Top = 279
  Height = 166
  Width = 421
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=SchoolDataBase.mdb;' +
      'Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 64
  end
  object StudentTable: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = StudentTableAfterOpen
    TableName = #1059#1095#1077#1085#1080#1082#1080
    Left = 120
    Top = 8
    object StudentTableKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object StudentTableDSDesigner: TWideStringField
      DisplayWidth = 21
      FieldName = #1060#1072#1084#1080#1083#1080#1103
      Size = 50
    end
    object StudentTableDSDesigner2: TWideStringField
      DisplayWidth = 25
      FieldName = #1048#1084#1103
      Size = 50
    end
    object StudentTableDSDesigner3: TWideStringField
      DisplayWidth = 10
      FieldName = #1050#1083#1072#1089#1089
      Size = 50
    end
    object StudentTableDSDesigner4: TWideStringField
      DisplayWidth = 30
      FieldName = #1040#1076#1088#1077#1089
      Size = 50
    end
    object StudentTableDSDesigner5: TWideStringField
      DisplayWidth = 17
      FieldName = #1058#1077#1083#1077#1092#1086#1085
      Size = 50
    end
  end
  object StudentDataSource: TDataSource
    DataSet = StudentTable
    Left = 40
    Top = 8
  end
  object PrepodDataSource: TDataSource
    DataSet = PrepodTable
    Left = 120
    Top = 72
  end
  object PrepodTable: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = PrepodTableAfterOpen
    TableName = #1055#1088#1077#1087#1086#1076#1072#1074#1072#1090#1077#1083#1080
    Left = 192
    Top = 8
    object PrepodTableKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object PrepodTableDSDesigner: TWideStringField
      DisplayWidth = 20
      FieldName = #1060#1072#1084#1080#1083#1080#1103
      Size = 50
    end
    object PrepodTableDSDesigner2: TWideStringField
      DisplayWidth = 23
      FieldName = #1048#1084#1103
      Size = 50
    end
    object PrepodTableDSDesigner3: TWideStringField
      DisplayWidth = 20
      FieldName = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Size = 50
    end
    object PrepodTableDSDesigner4: TWideStringField
      DisplayWidth = 25
      FieldName = #1040#1076#1088#1077#1089
      Size = 50
    end
    object PrepodTableDSDesigner5: TWideStringField
      DisplayWidth = 15
      FieldName = #1058#1077#1083#1077#1092#1086#1085
      Size = 50
    end
  end
  object UsersDataSource: TDataSource
    DataSet = UsersTable
    Left = 232
    Top = 88
  end
  object PersonalTable: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = PersonalTableAfterOpen
    TableName = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1087#1077#1088#1089#1086#1085#1072#1083
    Left = 320
    Top = 24
    object PersonalTableKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object PersonalTableDSDesigner: TWideStringField
      DisplayWidth = 20
      FieldName = #1060#1072#1084#1080#1083#1080#1103
      Size = 50
    end
    object PersonalTableDSDesigner2: TWideStringField
      DisplayWidth = 23
      FieldName = #1048#1084#1103
      Size = 50
    end
    object PersonalTableDSDesigner3: TWideStringField
      DisplayWidth = 20
      FieldName = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Size = 50
    end
    object PersonalTableDSDesigner4: TWideStringField
      DisplayWidth = 25
      FieldName = #1040#1076#1088#1077#1089
      Size = 50
    end
    object PersonalTableDSDesigner5: TWideStringField
      DisplayWidth = 15
      FieldName = #1058#1077#1083#1077#1092#1086#1085
      Size = 50
    end
  end
  object PersonalDataSource: TDataSource
    DataSet = PersonalTable
    Left = 320
    Top = 80
  end
  object UsersTable: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
    Left = 248
    Top = 40
    object UsersTableKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object UsersTableDSDesigner: TWideStringField
      DisplayWidth = 30
      FieldName = #1051#1086#1075#1080#1085
      Size = 50
    end
    object UsersTableDSDesigner2: TWideStringField
      DisplayWidth = 30
      FieldName = #1055#1072#1088#1086#1083#1100
      Size = 50
    end
    object UsersTableDSDesigner3: TBooleanField
      FieldName = #1044#1086#1089#1090#1091#1087
      DisplayValues = #1044#1072';'#1053#1077#1090
    end
  end
end
