object dmTransfCaixaBanco: TdmTransfCaixaBanco
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 403
  Width = 918
  object qryObterContaBancaria: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CB.ID_CONTA_BANCARIA,'
      '       CB.ID_ORGANIZACAO,'
      '       CB.ID_CONTA_CONTABIL, '
      '       CB.ID_BANCO, B.CODIGO_BANCO,'
      '       CB.CONTA,'
      '       CB.AGENCIA,'
      '       CB.TITULAR'
      ''
      'FROM CONTA_BANCARIA CB'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CB.ID_BANCO)'
      
        'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CB.ID_CONTA_BAN' +
        'CARIA = :PIDCONTA)')
    Left = 128
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTOB: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TOB.id_tipo_operacao_bancaria,'
      '       tob.id_organizacao,'
      '       tob.descricao,'
      '       tob.tipo,'
      '       tob.codigo,'
      '       tob.id_conta_contabil,'
      '       CC.conta,'
      '       CC.codreduz'
      'FROM tipo_operacao_bancaria TOB'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = TOB' +
        '.id_conta_contabil) AND (CC.id_organizacao = TOB.id_organizacao)'
      'WHERE (TOB.id_organizacao = :PIDORGANIZACAO)'
      'AND   (TOB.id_tipo_operacao_bancaria = :PIDTOB)'
      '')
    Left = 32
    Top = 32
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTOB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterCBC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ' SELECT CBC.ID_CONTA_BANCARIA_CREDITO as IDCBC,'
      '             CBC.ID_ORGANIZACAO,'
      '             CBC.ID_CONTA_BANCARIA,'
      '             CBC.ID_TIPO_OPERACAO_BANCARIA,'
      '             CBC.ID_RESPONSAVEL,'
      '             CBC.TIPO_LANCAMENTO,'
      '             CBC.OBSERVACAO,'
      '             CBC.DESCRICAO,'
      '             CBC.VALOR,'
      '             CBC.DATA_REGISTRO,'
      '             CBC.DATA_MOVIMENTO,'
      '             CBC.IDENTIFICACAO,'
      '             CBC.ID_LOTE_CONTABIL,'
      '             CBC.ID_LOTE_DEPOSITO,'
      '             CB.CONTA'
      ''
      '      FROM CONTA_BANCARIA_CREDITO CBC'
      
        '      LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA' +
        ' = CBC.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANI' +
        'ZACAO)'
      '      '
      'WHERE  (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      '      AND (CBC.ID_CONTA_BANCARIA_CREDITO = :PIDCBC)'
      
        '      AND (CBC.ID_TIPO_OPERACAO_BANCARIA = '#39'DEPOSITO TESOURARIA/' +
        'BANCO'#39')'
      ''
      '')
    Left = 120
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCBC'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TD.ID_TESOURARIA_DEBITO as IDTD,'
      '             TD.ID_ORGANIZACAO,'
      '             TD.DATA_CONTABIL,'
      '             TD.DATA_MOVIMENTO,'
      '             TD.VALOR_NOMINAL,'
      '             TD.OBSERVACAO,'
      '             TD.NUMERO_DOCUMENTO,'
      '             TD.DESCRICAO,'
      '             TD.TIPO_LANCAMENTO,'
      '             TD.ID_CONTA_BANCARIA_CREDITO as IDCBC,'
      '             CB.CONTA'
      ''
      ''
      'FROM TESOURARIA_DEBITO TD'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBC ON (CBC.ID_CONTA_BANC' +
        'ARIA_CREDITO = TD.ID_CONTA_BANCARIA_CREDITO) AND (CBC.ID_ORGANIZ' +
        'ACAO = TD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA ) AND (CB.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ' AND (TD.DATA_MOVIMENTO BETWEEN :PDTINICIAL AND :PDTFINAL)'
      ' AND (TD.ID_HISTORICO = :PIDHISTORICO)'
      ''
      'ORDER BY TD.DATA_MOVIMENTO DESC, TD.VALOR_NOMINAL DESC')
    Left = 40
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDTINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDTFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDHISTORICO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryUpdateCheque: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ''
      'UPDATE CONTA_BANCARIA_CHEQUE'
      'SET'
      '    ID_TIPO_STATUS = '#39'BLOQUEADO'#39','
      '    DATA_EMISSAO = null,'
      '    DATA_COMPENSACAO = null,'
      '    VALOR = 0,'
      '    OBSERVACAO = '#39#39','
      '    PORTADOR = '#39#39','
      '    DATA_PREVISAO_COMPENSACAO = null,'
      '    DATA_ESTORNO = null,'
      '    ID_USUARIO = 43'
      ''
      
        'WHERE  (ID_CONTA_BANCARIA = :PIDCONTA) AND (ID_CONTA_BANCARIA_CH' +
        'EQUE = :PIDCHEQUE) AND (ID_ORGANIZACAO = :PIDORGANIZACAO );'
      ''
      ''
      '')
    Left = 216
    Top = 232
    ParamData = <
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryChequePorID: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT *  FROM conta_bancaria_cheque cbc'
      ''
      ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO)'
      '   AND (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      '   AND (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)'
      ''
      ''
      ''
      '')
    Left = 200
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryDeletaTD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'DELETE FROM TESOURARIA_DEBITO TD'
      ''
      'WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      '  AND (TD.ID_TESOURARIA_DEBITO = :PIDTD)'
      ''
      '  AND ( TD.ID_CONTA_BANCARIA_CREDITO = :PIDCBC)'
      ''
      '')
    Left = 40
    Top = 232
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTD'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCBC'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryDeletaCBC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        ' DELETE FROM CONTA_BANCARIA_CREDITO CBC  WHERE (CBC.ID_ORGANIZAC' +
        'AO = :PIDORGANIZACAO) AND ( CBC.ID_CONTA_BANCARIA_CREDITO = :PID' +
        'CBC)')
    Left = 128
    Top = 232
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCBC'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterLoteDeposito: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT L.ID_LOTE_DEPOSITO,'
      '    L.ID_ORGANIZACAO,'
      '    L.LOTE,'
      '    L.DATA_REGISTRO,    '
      '    L.STATUS,'
      '    L.QTD_CHQ,'
      '    L.ID_CONTA_BANCARIA,'
      '    L.TOTAL_DEPOSITO'
      ''
      'FROM LOTE_DEPOSITO L'
      
        'WHERE (L.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (L.ID_LOTE_DEPOSI' +
        'TO = :PIDLOTE)')
    Left = 320
    Top = 48
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
