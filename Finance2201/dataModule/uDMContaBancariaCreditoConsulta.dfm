object dmCBCConsulta: TdmCBCConsulta
  OldCreateOrder = False
  Height = 402
  Width = 591
  object qryObterPorTituloReceber: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      ''
      'SELECT  CBC.ID_CONTA_BANCARIA,'
      '        CBC.VALOR,'
      '        CBC.DATA_MOVIMENTO,'
      '        CBC.DESCRICAO AS DSC_BAIXA,'
      '        CC.CONTA,'
      '        CC.DESCRICAO AS DSC_CC,'
      '        CC.CODREDUZ'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.' +
        'ID_CONTA_CONTABIL)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (CBC.ID_TITULO_RECEBER = :PIDTITULORECEBER) AND'
      '         (CBC.ID_LOTE_CONTABIL IS NULL);'
      '')
    Left = 87
    Top = 32
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBER'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorTipoOperacao: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.ID_CONTA_BANCARIA,'
      '       CBC.ID_TIPO_OPERACAO_BANCARIA,'
      '       CBC.VALOR, CBC.DESCRICAO,'
      '       CBC.DATA_MOVIMENTO,'
      '       CBC.IDENTIFICACAO,'
      '       CONTA.CONTA AS CONTA_CORRENTE_CREDITO,'
      '       CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '       CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '       '#39'CBT'#39' AS TIPO'
      ''
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CONTA ON (CONTA.ID_CONTA_BANCARIA' +
        ' = CBC.ID_CONTA_BANCARIA)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CON' +
        'TA.ID_CONTA_CONTABIL)'
      ''
      'WHERE (CBC.ID_LOTE_CONTABIL IS NULL) AND'
      '(CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '(CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) AND'
      '(CBC.ID_TIPO_OPERACAO_BANCARIA = :PIDTIPOOPERACAO)')
    Left = 80
    Top = 96
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDTIPOOPERACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorId: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.ID_CONTA_BANCARIA,'
      '       CBC.ID_TIPO_OPERACAO_BANCARIA,'
      '       CBC.VALOR, CBC.DESCRICAO,'
      '       CBC.DATA_MOVIMENTO,'
      '       CBC.IDENTIFICACAO,'
      '       CONTA.CONTA AS CONTA_CORRENTE_CREDITO,'
      '       CONTA.AGENCIA,'
      '       CONTA.TITULAR,'
      '       B.codigo_banco, '
      '       B.sigla_banco,'
      '       B.nome_banco,'
      '       CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '       CC.CODREDUZ AS COD_REDUZ_CREDITO'
      ''
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CONTA ON (CONTA.ID_CONTA_BANCARIA' +
        ' = CBC.ID_CONTA_BANCARIA)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CON' +
        'TA.ID_CONTA_CONTABIL)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CONTA.ID_BANCO)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (CBC.ID_CONTA_BANCARIA_CREDITO = :PIDCONTABANCARIACREDITO)')
    Left = 64
    Top = 184
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCARIACREDITO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTransfTesourariaBancoPeriodo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT CBC.ID_CONTA_BANCARIA_CREDITO,'
      'CBC.DESCRICAO,'
      '        CBC.VALOR,'
      '        CBC.DATA_MOVIMENTO,'
      '        CBC.IDENTIFICACAO,'
      '        CB.CONTA,'
      '        CB.AGENCIA,'
      '        B.CODIGO_BANCO,'
      '        B.NOME_BANCO,'
      '        B.SIGLA_BANCO,'
      '        CC.CONTA AS CONTA_CONTABIL_DEBITO,'
      '        CC.CODREDUZ AS COD_REDUZ_DEBITO,'
      '        CC.DESCRICAO AS DSC_CC_DEBITO,'
      '        '#39'CBC'#39' as TIPO'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CB.ID_BANCO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.' +
        'ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      
        '      (CBC.ID_TIPO_OPERACAO_BANCARIA = '#39'DEPOSITO TESOURARIA/BANC' +
        'O'#39') AND'
      '      (CBC.ID_LOTE_CONTABIL IS NULL)'
      ''
      '')
    Left = 96
    Top = 272
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryObterQtdLancamentosPeriodo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select count(*) from conta_bancaria_credito cbc '
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND '
      '(CBC.DATA_REGISTRO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)'
      '         '
      '')
    Left = 423
    Top = 88
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
end
