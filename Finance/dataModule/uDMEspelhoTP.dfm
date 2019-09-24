object dmEspelhoTP: TdmEspelhoTP
  OldCreateOrder = False
  Height = 516
  Width = 1022
  object frxDBTitulos: TfrxDBDataset
    UserName = 'TPPROVBASE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_NOMINAL=VALOR_NOMINAL'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DATA_EMISSAO=DATA_EMISSAO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'FORNECEDOR=FORNECEDOR'
      'TIPO=TIPO')
    DataSet = qryTPPROVBASE
    BCDToCurrency = False
    Left = 184
    Top = 40
  end
  object frxTPROVDB: TfrxDBDataset
    UserName = 'TPPROVDB'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_TOTAL=VALOR_TOTAL'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'HST_DSC=HST_DSC'
      'HST_CODIGO=HST_CODIGO'
      'CCD_DSC=CCD_DSC'
      'CONTA_DB=CONTA_DB'
      'DG_CONTA_DB=DG_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTPPROVDB
    BCDToCurrency = False
    Left = 184
    Top = 104
  end
  object qryTPPROVBASE: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      '   SELECT distinct'
      '              SUM(TP.VALOR_NOMINAL) AS VALOR_NOMINAL, '
      '              max(TP.descricao) as descricao, '
      '             -- MAX(position('#39'/'#39' in TP.parcela)) AS PARCELA,'
      '              COUNT(TP.REGISTRO_PROVISAO) AS PARCELA,'
      '              TP.REGISTRO_PROVISAO, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(tp.id_titulo_pagar) as id_titulo_pagar,'
      '              max(TP.data_emissao)as data_emissao,'
      '              max(TP.numero_documento) as NUMERO_DOCUMENTO,'
      '              max(CED.NOME) AS FORNECEDOR,'
      '             '#39'TPPROV'#39' as TIPO'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'JOIN CEDENTE CED ON (CED.ID_CEDENTE = TP.ID_CEDENTE) AND (CED.ID' +
        '_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.REGISTRO_PROVISAO IS NOT NULL ) AND'
      '      (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') AND '
      '      (TP.ID_LOTE_CONTABIL IS NULL) AND'
      '      (TP.ID_LOTE_TPB IS NULL)'
      ''
      ''
      ' GROUP BY TP.REGISTRO_PROVISAO'
      ''
      'ORDER BY DATA_EMISSAO ASC, VALOR_NOMINAL DESC;'
      '')
    Left = 32
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object frxTPPROVCR: TfrxDBDataset
    UserName = 'TPPROVCR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'VALOR_TOTAL=VALOR_TOTAL'
      'CCC_DSC=CCC_DSC'
      'CONTA_CR=CONTA_CR'
      'COD_RED_CR=COD_RED_CR'
      'COD_HIST=COD_HIST'
      'REGISTRO_PROVISAO=REGISTRO_PROVISAO'
      'DESCRICAO=DESCRICAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DT_EMISSAO=DT_EMISSAO'
      'NUM_DOC=NUM_DOC'
      'NOME_CED=NOME_CED')
    DataSet = qryTPPROVCR
    BCDToCurrency = False
    Left = 184
    Top = 192
  end
  object qryTPPROVCR: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT distinct sum(tp.valor_nominal) as valor_total,'
      '              max(CCC.DESCRICAO) AS CCC_DSC,'
      '              max(CCC.CONTA)  AS CONTA_CR,'
      '              max(CCC.CODREDUZ)  AS COD_RED_CR,'
      '              max(H.CODIGO) AS COD_HIST,'
      '              tp.registro_provisao, '
      '              max(tp.descricao) as descricao,               '
      '              max(tp.id_titulo_pagar) as ID_TITULO_PAGAR, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(TP.data_emissao)as dt_emissao,'
      '              max(TP.numero_documento) as num_doc,'
      '              max(CED.NOME) AS NOME_CED'
      ''
      'FROM '
      'TITULO_PAGAR TP'
      'INNER join CEDENTE CED ON (CED.id_cedente = TP.id_cedente)'
      
        'INNER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = TP.ID_' +
        'CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TP.ID_ORGANIZA' +
        'CAO)'
      
        'INNER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND' +
        ' (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TP.REGISTRO_PROVISAO = :PREGISTRO)'
      ''
      'GROUP BY TP.REGISTRO_PROVISAO')
    Left = 24
    Top = 176
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PREGISTRO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPPROVDB: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select'
      '   (C.VALOR_TOTAL) AS VALOR_TOTAL,'
      '    C.registro_provisao,'
      '    C.id_organizacao,'
      '    c.id_titulo_pagar,'
      '    C.HST_DSC,'
      '    C.HST_CODIGO,'
      '    C.CCD_DSC,'
      '    C.CONTA_DB,'
      '    C.DG_CONTA_DB,'
      '    C.COD_RED_DB'
      '  from ('
      '        select'
      
        '         IIF(B.POS <> 0, cast(trim(substring(B.parcela from (B.P' +
        'OS + 1) for 19)) as integer),'
      '                    cast(trim(B.parcela) AS INTEGER)) as qtd,'
      '          B.VALOR_TOTAL,'
      '          B.PARCELA,'
      '          B.registro_provisao,'
      '          B.id_organizacao,'
      '          B.id_titulo_pagar,'
      '          B.HST_DSC,'
      '          B.HST_CODIGO,'
      '          B.CCD_DSC,'
      '          B.CONTA_DB,'
      '          B.DG_CONTA_DB,'
      '          B.COD_RED_DB'
      ''
      'from ('
      '        select'
      '          position('#39'/'#39' in A.parcela) as POS,'
      '          A.PARCELA,'
      '          A.VALOR_TOTAL,'
      '          A.registro_provisao,'
      '          A.id_organizacao,'
      '          A.id_titulo_pagar,'
      '          A.HST_DSC,'
      '          A.HST_CODIGO,'
      '          A.CCD_DSC,'
      '          A.CONTA_DB,'
      '          A.DG_CONTA_DB,'
      '          A.COD_RED_DB'
      '        from ('
      '            select'
      ''
      '              TPH.id_historico,'
      '              SUM(TPH.valor) AS VALOR_TOTAL,'
      '              MAX(tp.registro_provisao) AS REGISTRO_PROVISAO,'
      '              MAX(TP.PARCELA) AS PARCELA,'
      '              MAX(tp.id_organizacao) AS ID_ORGANIZACAO,'
      '              MAX(tp.id_titulo_pagar) AS ID_TITULO_PAGAR,'
      '              MAX(H.descricao) AS HST_DSC,'
      '              MAX(H.CODIGO) AS HST_CODIGO,'
      '              MAX(CCD.DESCRICAO) AS CCD_DSC,'
      '              MAX(CCD.CONTA)  AS CONTA_DB,'
      '              MAX(CCD.DGVER)  AS DG_CONTA_DB,'
      '              MAX(CCD.CODREDUZ)  AS COD_RED_DB'
      ''
      ''
      '            FROM  titulo_pagar_historico tPH'
      
        '            LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAG' +
        'AR = TPH.ID_TITULO_PAGAR)'
      
        '            LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH' +
        '.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        '            LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_' +
        'CONTABIL = H.ID_CONTA_CONTABIL)'
      ''
      '            WHERE'
      '                (TP.REGISTRO_PROVISAO = :PREGISTRO) AND'
      '                (tp.id_organizacao = :PIDORGANIZACAO)'
      '            '
      '            GROUP BY TPH.id_historico'
      ''
      '            ) A'
      ''
      '       ) B'
      '       ) C')
    Left = 32
    Top = 104
    ParamData = <
      item
        Name = 'PREGISTRO'
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
  object dsDetalhesTP: TDataSource
    DataSet = qryTPPROVBASE
    Left = 104
    Top = 152
  end
  object frxDBTPQuitados: TfrxDBDataset
    UserName = 'TPQUITADOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR=VALOR'
      'NOME=NOME'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'TIPO=TIPO')
    DataSet = qryTPQuitados
    BCDToCurrency = False
    Left = 400
    Top = 160
  end
  object frxDBTPBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TESOURARIA_DEBITO=ID_TESOURARIA_DEBITO'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'OBSERVACAO=OBSERVACAO'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'HST_COD=HST_COD'
      'CONTA_CREDITO=CONTA_CREDITO'
      'DSC_CC=DSC_CC'
      'CODREDUZ=CODREDUZ')
    DataSet = qryBaixaTPCaixa
    BCDToCurrency = False
    Left = 926
    Top = 160
  end
  object frxTPBAcrescimo: TfrxDBDataset
    UserName = 'TPBAcrescimo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBAcrescimos
    BCDToCurrency = False
    Left = 595
    Top = 160
  end
  object frxTPBDeducao: TfrxDBDataset
    UserName = 'TPBDeducao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'ID_HISTORICO=ID_HISTORICO'
      'DSC_HIST=DSC_HIST'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CODIGO=CODIGO'
      'CONTA=CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryTPBDeducao
    BCDToCurrency = False
    Left = 710
    Top = 160
  end
  object frxDBTPB: TfrxDBDataset
    UserName = 'TPBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'VALOR_PAGO=VALOR_PAGO'
      'TIPO_BAIXA=TIPO_BAIXA'
      'DATA_EMISSAO=DATA_EMISSAO'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'NUMERO_DOCUMENTO=NUMERO_DOCUMENTO'
      'DESCRICAO=DESCRICAO'
      'PARCELA=PARCELA'
      'VALOR=VALOR'
      'NOME=NOME'
      'HST_COD=HST_COD'
      'DSC_HIST=DSC_HIST'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'DSC_CDD=DSC_CDD'
      'CONTA_DB=CONTA_DB'
      'COD_REDUZ_DB=COD_REDUZ_DB'
      'TIPO=TIPO')
    DataSet = qryObterTPBaixaPorTitulo
    BCDToCurrency = False
    Left = 496
    Top = 160
  end
  object frxTPBCheque: TfrxDBDataset
    UserName = 'TPBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_BAIXA_CHEQUE=ID_TITULO_PAGAR_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_CONTA_BANCARIA_CHEQUE=ID_CONTA_BANCARIA_CHEQUE'
      'ID_TITULO_PAGAR_BAIXA=ID_TITULO_PAGAR_BAIXA'
      'VALOR=VALOR'
      'CONTA_CONTABIL_CREDITO=CONTA_CONTABIL_CREDITO'
      'COD_REDUZ_CREDITO=COD_REDUZ_CREDITO'
      'DSC_CC_CREDITO=DSC_CC_CREDITO')
    DataSet = qryBaixaTPCheque
    BCDToCurrency = False
    Left = 918
    Top = 232
  end
  object qryTPQuitados: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_ORGANIZACAO,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL as VALOR,'
      '        C.NOME,'
      '        H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       '#39'TPB'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :pIdOrganizacao) '
      
        '       AND (TP.DATA_PAGAMENTO BETWEEN :pDataInicial AND :pDataFi' +
        'nal) '
      '       AND (TP.ID_TIPO_STATUS = :pIdStatus )'
      '       AND (TP.ID_LOTE_CONTABIL IS NULL) '
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 400
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsDetalhesTPB: TDataSource
    DataSet = qryTPQuitados
    Left = 552
    Top = 120
  end
  object qryObterTPBaixaPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM//YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--somente titulos que nao foram provisionados'
      ''
      'SELECT TPB.id_organizacao,'
      '       TPB.id_titulo_pagar_baixa,'
      '       TPB.id_titulo_pagar,'
      '       TPB.id_centro_custo,'
      '       TPB.valor_pago,'
      '       TPB.tipo_baixa,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.PARCELA,'
      '       TP.VALOR_NOMINAL as VALOR,'
      '       C.NOME,'
      '       H.CODIGO AS HST_COD,       '
      '       H.DESCRICAO as dsc_hist, H.DESCRICAO_REDUZIDA,'
      '       CCD.DESCRICAO AS DSC_CDD,'
      '       CCD.CONTA AS CONTA_DB,'
      '       CCD.CODREDUZ AS COD_REDUZ_DB,'
      '       '#39'TPB'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR_BAIXA TPB'
      ''
      
        'LEFT OUTER JOIN titulo_pagar TP ON (TP.ID_TITULO_PAGAR = TPB.ID_' +
        'TITULO_PAGAR)'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL) AND (CCD.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TPB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPB.id_titulo_pagar =:pIdtituloPagar) AND'
      '      (TPB.ID_LOTE_CONTABIL IS NULL)'
      '-- AND (TP.IS_PROVISAO = 0)'
      '  '
      ''
      ''
      'ORDER BY TP.DATA_PAGAMENTO ASC, TP.VALOR_NOMINAL DESC;')
    Left = 504
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTPCaixa: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      ' SELECT td.ID_TITULO_PAGAR_BAIXA,'
      '          td.id_organizacao,'
      '          td.id_tesouraria_debito, '
      '          td.data_movimento, '
      '          td.valor_nominal as VALOR,'
      '          td.observacao, '
      '          td.descricao, '
      '          h.id_historico,'
      '          h.descricao as DSC_HIST,'
      '          H.CODIGO AS HST_COD,'
      '          cc.conta as CONTA_CREDITO, '
      '          cc.descricao as DSC_CC,'
      '          cc.codreduz'
      '   FROM TESOURARIA_DEBITO TD'
      
        '   left outer join historico h on (h.id_historico = td.id_histor' +
        'ico) and (h.id_organizacao = td.id_organizacao)'
      
        '   left outer join conta_contabil cc on (cc.id_conta_contabil = ' +
        'H.id_conta_contabil) and (cc.id_organizacao = td.id_organizacao)'
      ''
      ' WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.id_titulo_pagar_baixa = :PIDTITULOPAGARBAIXA)')
    Left = 912
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTPCheque: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT  TPBC.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '        TPBC.ID_ORGANIZACAO,'
      '        TPBC.ID_CONTA_BANCARIA_CHEQUE,'
      '        TPBC.ID_TITULO_PAGAR_BAIXA,'
      '        TPBC.VALOR as VALOR,'
      '        CC.CONTA AS CONTA_CONTABIL_CREDITO,'
      '        CC.CODREDUZ AS COD_REDUZ_CREDITO,'
      '        CC.DESCRICAO AS DSC_CC_CREDITO'
      ''
      ''
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBC'
      
        'LEFT OUTER JOIN conta_bancaria_cheque CBC ON (CBC.ID_CONTA_BANCA' +
        'RIA_CHEQUE = TPBC.ID_CONTA_BANCARIA_CHEQUE)AND (CBC.ID_ORGANIZAC' +
        'AO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = CBC' +
        '.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBC.id_organizacao = :PIDORGANIZACAO) AND'
      '       (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA)AND'
      '       (CBC.data_compensacao is null)')
    Left = 974
    Top = 48
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBAcrescimos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_pagar_baixa, '
      '       TPBA.valor as VALOR, '
      '       TA.descricao,'
      '       TA.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil,'
      '       H.Codigo,'
      '       CC.conta, CC.codreduz'
      'FROM titulo_pagar_baixa_ac TPBA'
      ''
      
        'JOIN tipo_acrescimo TA ON (TA.id_tipo_acrescimo = TPBA.id_tipo_a' +
        'crescimo) AND (TA.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TA.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TA.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBA.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBA.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'order by TPBA.valor')
    Left = 616
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBDeducao: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.id_titulo_pagar_baixa, '
      '       TPBD.valor as VALOR, '
      '       TD.descricao,'
      '       TD.id_historico, '
      '       H.descricao as dsc_hist, '
      '       H.id_conta_contabil, '
      '       H.codigo,'
      '       CC.conta, '
      '       CC.codreduz'
      'FROM titulo_pagar_baixa_de TPBD'
      ''
      
        'JOIN tipo_deducao TD ON (TD.ID_TIPO_DEDUCAO = TPBD.ID_TIPO_DEDUC' +
        'AO) AND (TD.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TD.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CC ON (CC.id_conta_contabil = H.id_conta_con' +
        'tabil) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBD.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBD.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'ORDER BY TPBD.VALOR DESC')
    Left = 712
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBHistorico: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPH.id_titulo_pagar_historico,'
      '       TPH.id_organizacao,'
      '       TPH.id_historico,'
      '       TPH.id_titulo_pagar,'
      '       TPH.id_conta_contabil_debito,'
      '       TPH.valor,'
      '       H.DESCRICAO AS HST_DSC,'
      '       H.DESCRICAO_REDUZIDA AS HST_DSC_RED,'
      '       H.CODIGO AS HST_COD,'
      '       CD.conta AS CONTA_DB,'
      '       CD.DESCRICAO AS DSC_CONTA_DB,'
      '       CD.codreduz AS COD_RED_DB'
      ''
      'FROM TITULO_PAGAR_HISTORICO TPH'
      ''
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TPH.ID_HISTORIC' +
        'O) AND (H.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_contabil CD ON (CD.id_conta_contabil = H.i' +
        'd_conta_contabil) and (CD.ID_ORGANIZACAO = TPH.ID_ORGANIZACAO)'
      ''
      'WHERE  (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND '
      '       (TPH.id_titulo_pagar = :PIDTP)'
      ''
      'ORDER BY TPH.VALOR')
    Left = 820
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTP'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxTPBHistorico: TfrxDBDataset
    UserName = 'TPBHistorico'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_PAGAR_HISTORICO=ID_TITULO_PAGAR_HISTORICO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_HISTORICO=ID_HISTORICO'
      'ID_TITULO_PAGAR=ID_TITULO_PAGAR'
      'ID_CONTA_CONTABIL_DEBITO=ID_CONTA_CONTABIL_DEBITO'
      'VALOR=VALOR'
      'HST_DSC=HST_DSC'
      'HST_DSC_RED=HST_DSC_RED'
      'HST_COD=HST_COD'
      'CONTA_DB=CONTA_DB'
      'DSC_CONTA_DB=DSC_CONTA_DB'
      'COD_RED_DB=COD_RED_DB')
    DataSet = qryTPBHistorico
    BCDToCurrency = False
    Left = 824
    Top = 160
  end
  object frxEspelhoTP: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43732.841203518520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 88
    Top = 280
    Datasets = <
      item
        DataSetName = 'Cedente'
      end
      item
        DataSetName = 'Titulos'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 220.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 52.913385830000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 11.338590000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          Left = 117.283550000000000000
          Top = 11.338590000000000000
          Width = 449.764070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 572.433210000000000000
          Top = 11.338590000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          Left = 639.976810000000000000
          Top = 11.338590000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000010000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          Left = 117.283550000000000000
          Top = 34.015770000000010000
          Width = 449.764070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          Left = 639.976810000000000000
          Top = 34.015770000000010000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 570.709030000000000000
          Top = 34.015770000000010000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 793.701300000000000000
          Top = 37.795300000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          Left = 903.307670000000000000
          Top = 37.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Page: TfrxMemoView
          Left = 975.118740000000000000
          Top = 11.338590000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 925.984850000000000000
          Top = 11.338590000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
      end
      object GRPHTP_TIT: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897662200000000000
        Top = 302.362400000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        ReprintOnNewPage = True
        object Memo13: TfrxMemoView
          Left = 150.653609210000000000
          Top = 1.338590000000011000
          Width = 204.094620000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Left = 63.031540000000000000
          Top = 1.338590000000011000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 372.953000000000000000
          Top = 1.338590000000011000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DATA PAGTO')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo18: TfrxMemoView
          Left = 891.969080000000000000
          Top = 1.338590000000011000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo8: TfrxMemoView
          Left = 492.661720000000000000
          Top = 1.338590000000011000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo9: TfrxMemoView
          Left = 593.386210000000000000
          Top = 1.338590000000011000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo7: TfrxMemoView
          Left = -0.220470000000000000
          Top = 1.338590000000011000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object MD_CEDENTE: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 238.110390000000000000
        Width = 1046.929810000000000000
        DataSetName = 'Cedente'
        RowCount = 0
        object CedenteNOME: TfrxMemoView
          Left = 99.165430000000000000
          Top = 4.220469999999978000
          Width = 400.630180000000000000
          Height = 11.338590000000000000
          DataField = 'NOME'
          DataSetName = 'Cedente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[Cedente."NOME"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Top = 4.157480314960594000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR :')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object DT_TITULOS: TfrxDetailData
        FillType = ftBrush
        Height = 15.118110236220500000
        Top = 370.393940000000000000
        Width = 1046.929810000000000000
        DataSetName = 'Titulos'
        RowCount = 0
        object TitulosID_TIPO_STATUS: TfrxMemoView
          Left = 593.386210000000000000
          Top = 1.000000000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DataField = 'ID_TIPO_STATUS'
          DataSetName = 'Titulos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Titulos."ID_TIPO_STATUS"]')
          ParentFont = False
        end
        object TitulosNUMERO_DOCUMENTO: TfrxMemoView
          Left = 63.031540000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DataField = 'NUMERO_DOCUMENTO'
          DataSetName = 'Titulos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Titulos."NUMERO_DOCUMENTO"]')
          ParentFont = False
        end
        object TitulosVALOR_NOMINAL: TfrxMemoView
          Left = 891.969080000000000000
          Top = 1.000000000000000000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataField = 'VALOR_NOMINAL'
          DataSetName = 'Titulos'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Titulos."VALOR_NOMINAL"]')
          ParentFont = False
        end
        object TitulosDATA_EMISSAO: TfrxMemoView
          Left = -0.220470000000000000
          Top = 1.000000000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DataField = 'DATA_EMISSAO'
          DataSetName = 'Titulos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Titulos."DATA_EMISSAO"]')
          ParentFont = False
        end
        object TitulosDESCRICAO: TfrxMemoView
          Left = 150.653609210000000000
          Top = 1.000000000000000000
          Width = 204.094620000000000000
          Height = 11.338590000000000000
          DataField = 'DESCRICAO'
          DataSetName = 'Titulos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Titulos."DESCRICAO"]')
          ParentFont = False
        end
        object TitulosPARCELA: TfrxMemoView
          Left = 492.661720000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataField = 'PARCELA'
          DataSetName = 'Titulos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Titulos."PARCELA"]')
          ParentFont = False
        end
        object TitulosDATA_PAGAMENTO: TfrxMemoView
          Left = 372.953000000000000000
          Top = 1.000000000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSetName = 'Titulos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Titulos."DATA_PAGAMENTO"]')
          ParentFont = False
        end
      end
      object GRPHTP_PROV_HST: TfrxGroupHeader
        FillType = ftBrush
        Top = 279.685220000000000000
        Width = 1046.929810000000000000
        Condition = 'Cedente."ID_CEDENTE"'
      end
      object GRPHTP_MD_CEDENTE: TfrxGroupHeader
        FillType = ftBrush
        Top = 215.433210000000000000
        Width = 1046.929810000000000000
        Condition = 'Cedente."ID_CEDENTE"'
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 68.031496062992100000
        Top = 480.000310000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          Top = 3.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo22: TfrxMemoView
          Left = 655.740570000000000000
          Top = 10.338589999999900000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo7: TfrxSysMemoView
          Left = 891.969080000000000000
          Top = 10.338589999999900000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<Titulos."VALOR_NOMINAL">,DT_TITULOS)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Memo41: TfrxMemoView
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSetName = 'Titulos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.779527559055120000
        Top = 343.937230000000000000
        Width = 1046.929810000000000000
        Condition = 'Cedente."ID_TIPO_CEDENTE"'
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 570.709030000000000000
        Width = 1046.929810000000000000
        object Memo36: TfrxMemoView
          Left = -1.220470000000000000
          Top = 3.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          Left = 932.969080000000000000
          Top = 3.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          Left = 859.953310000000000000
          Top = 3.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          Left = 993.457330000000000000
          Top = 3.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 132.283550000000000000
        Width = 1046.929810000000000000
        object Memo11: TfrxMemoView
          Left = 7.559060000000000000
          Width = 559.370440000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELAT'#211'RIO DETALHADO POR FORNECEDOR')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 589.606680000000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PER'#205'ODO: ')
          ParentFont = False
        end
        object strPeriodo: TfrxMemoView
          Left = 695.433520000000000000
          Width = 317.480520000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[strPeriodo]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 408.189240000000000000
        Width = 1046.929810000000000000
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Top = 192.756030000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
      end
    end
  end
  object qryObterTPBBanco: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_PAGAR_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       CC.conta AS CONTA_CR,'
      '       CC.DESCRICAO AS DSC_CONTA_CR,'
      '       CC.codreduz AS COD_RED_CR'
      '        '
      'FROM TITULO_PAGAR_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TPB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = CB.' +
        'id_conta_contabil) AND (CC.ID_ORGANIZACAO = TPBI.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TPBI.ID_TITULO_PAGAR_BAIXA = :PIDTPB)'
      ''
      'ORDER BY TPBI.VALOR;')
    Left = 878
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTPB'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
