object dmOrganizacao: TdmOrganizacao
  OldCreateOrder = False
  Height = 392
  Width = 699
  object qryDadosEmpresa: TFDQuery
    Connection = dmConexao.Conn
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckDynamic
    SQL.Strings = (
      'SELECT'
      '  O.RAZAO_SOCIAL,'
      '  O.CNPJ,'
      
        '  TRIM(O.LOGRADOURO) || '#39' '#39' || TRIM(O.NUMERO) || IIF(TRIM(O.COMP' +
        'LEMENTO)='#39#39','#39#39','#39' '#39' ||TRIM(O.COMPLEMENTO)) || '#39' - '#39' || TRIM(B.BAI' +
        'RRO) AS ENDERECO,'
      '  O.CEP,'
      '  C.CIDADE,'
      '  O.ID_ORGANIZACAO,'
      '  O.CODINOME,'
      '  O.LICENCA, '
      '  O.SERIAL_CLIENTE, '
      '  O.SISTEMA_CONTABIL,'
      '  O.CODIGO_WEB,'
      '  O.IPSERVERBD,'
      '  E.SIGLA AS UF'
      'FROM'
      '  ORGANIZACAO O'
      '  JOIN BAIRRO B ON (O.ID_BAIRRO = B.ID_BAIRRO)'
      '  JOIN CIDADE C ON (B.ID_CIDADE = C.ID_CIDADE)'
      '  JOIN ESTADO E ON (C.ID_ESTADO = E.ID_ESTADO)'
      'WHERE'
      '  (O.ID_ORGANIZACAO = :PIDORGANIZACAO)')
    Left = 304
    Top = 72
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryLoadOrgs: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT * FROM ORGANIZACAO WHERE 1=1'
      'ORDER BY SIGLA DESC')
    Left = 64
    Top = 72
  end
  object qryOrganizacoes: TFDQuery
    Connection = dmConexao.Conn
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckDynamic
    SQL.Strings = (
      'SELECT'
      '  O.ID_ORGANIZACAO,'
      
        '  RPAD(O.RAZAO_SOCIAL, T.QTDE) ||  '#39' | '#39' || TRIM(O.CNPJ) AS NOME' +
        ','
      'O.RAZAO_SOCIAL'
      'FROM'
      '  ORGANIZACAO O,'
      
        '  (SELECT MAX(CHAR_LENGTH(O2.RAZAO_SOCIAL)) AS QTDE FROM ORGANIZ' +
        'ACAO O2) AS T'
      'ORDER BY'
      '  O.RAZAO_SOCIAL DESC')
    Left = 168
    Top = 72
  end
  object qryServidorEmail: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT * FROM SERVIDOR_EMAIL WHERE 1=1'
      '  '
      '')
    Left = 72
    Top = 184
  end
  object qryValidaLogin: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      ''
      'SELECT U.nome,U.id_organizacao'
      'FROM USUARIO U'
      'WHERE U.login =:pLogin AND'
      '      U.senha =:psenha')
    Left = 168
    Top = 192
    ParamData = <
      item
        Name = 'PLOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end
      item
        Name = 'PSENHA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
