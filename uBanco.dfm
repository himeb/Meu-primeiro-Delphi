object Banco: TBanco
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 329
  Width = 280
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=bancoSQL'
      'User_Name=root'
      'Server=127.0.0.1'
      'Password=147'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object tbSQL: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = Conexao
    TableName = 'Cadastro'
    Left = 120
    Top = 16
    object tbSQLid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tbSQLnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
    object tbSQLidade: TIntegerField
      FieldName = 'idade'
      Origin = 'idade'
      Required = True
    end
    object tbSQLendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 50
    end
    object tbSQLnumero: TIntegerField
      FieldName = 'numero'
      Origin = 'numero'
      Required = True
    end
    object tbSQLtelefone: TStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 13
    end
    object tbSQLcelular: TStringField
      FieldName = 'celular'
      Origin = 'celular'
      Required = True
      Size = 14
    end
    object tbSQLsexo: TStringField
      FieldName = 'sexo'
      Origin = 'sexo'
      Size = 1
    end
    object tbSQLnotificacao: TBooleanField
      FieldName = 'notificacao'
      Origin = 'notificacao'
      Required = True
    end
  end
  object qrySelect: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select nome, celular from Cadastro'
      ''
      'where'
      'nome like :nome')
    Left = 32
    Top = 152
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end>
  end
  object qryUpdate: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'update Cadastro set '
      'nome = :nome,'
      'idade = :idade,'
      'endereco = :endereco,'
      'numero = :numero,'
      'telefone = :telefone,'
      'celular = :celular,'
      'sexo = :sexo,'
      'notificacao = :notificacao'
      'where id = :id')
    Left = 160
    Top = 152
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'IDADE'
        ParamType = ptInput
      end
      item
        Name = 'ENDERECO'
        ParamType = ptInput
      end
      item
        Name = 'NUMERO'
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        ParamType = ptInput
      end
      item
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        Name = 'SEXO'
        ParamType = ptInput
      end
      item
        Name = 'NOTIFICACAO'
        ParamType = ptInput
      end
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object qryDelete: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'delete from Cadastro'
      'where id = :id')
    Left = 96
    Top = 152
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object qryInsert: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'insert into Cadastro'
      
        '(nome, idade, endereco, numero, telefone, celular, sexo, notific' +
        'acao)'
      'values '
      
        '(:nome, :idade, :endereco, :numero, :telefone, :celular, :sexo, ' +
        ':notificacao)')
    Left = 224
    Top = 152
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'IDADE'
        ParamType = ptInput
      end
      item
        Name = 'ENDERECO'
        ParamType = ptInput
      end
      item
        Name = 'NUMERO'
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        ParamType = ptInput
      end
      item
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        Name = 'SEXO'
        ParamType = ptInput
      end
      item
        Name = 'NOTIFICACAO'
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 264
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 176
    Top = 264
  end
  object dsSQL: TDataSource
    DataSet = tbSQL
    Enabled = False
    Left = 200
    Top = 16
  end
  object dsSQL1: TDataSource
    DataSet = tbSQL
    Left = 200
    Top = 64
  end
  object dsSQL2: TDataSource
    DataSet = tbSQL
    Left = 200
    Top = 112
  end
end
