object dmMegaContabil: TdmMegaContabil
  OldCreateOrder = False
  Height = 437
  Width = 751
  object qryDadosEmpresaMega: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT'
      '  *'
      ''
      'FROM'
      '  CADASTRO C'
      ''
      'WHERE'
      '  (C.INSCMF = :pCnpj)')
    Left = 152
    Top = 168
    ParamData = <
      item
        Name = 'PCNPJ'
        ParamType = ptInput
      end>
  end
  object qryExistLote: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT '
      '  L.ID,'
      '  L.EMPRESA,'
      '  L.ANO, '
      '  L.LOTE'
      ''
      'FROM'
      '  CLOTES L'
      ''
      'WHERE'
      '  (L.EMPRESA = :pIDEmpresa) AND'
      '  (L.ANO = :pAno) AND'
      '  (L.LOTE = :pLote)')
    Left = 168
    Top = 40
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        ParamType = ptInput
      end
      item
        Name = 'PANO'
        ParamType = ptInput
      end
      item
        Name = 'PLOTE'
        ParamType = ptInput
      end>
  end
  object qryGenIdClotes: TFDQuery
    SQL.Strings = (
      'select gen_id(gen_id_clotes,1) from rdb$database')
    Left = 248
    Top = 40
  end
  object qryVerificaFechamento: TFDQuery
    Connection = dmConexao.ConnMega
    SQL.Strings = (
      'SELECT '
      '  L.ID'
      ''
      'FROM'
      '  CLANCAMENTOS L'
      ''
      'WHERE'
      '  (L.EMPRESA = :pIDEmpresa) AND'
      '  ((L.CDHIST = 65) OR (L.CDHIST = 66) OR'
      '   (L.CDHIST = 75) OR (L.CDHIST = 76)) AND'
      '(L.DATA BETWEEN :pDataInicial AND '#39'31.12.2020'#39')'
      ''
      '')
    Left = 328
    Top = 40
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        ParamType = ptInput
      end
      item
        Name = 'PDATAINICIAL'
        ParamType = ptInput
      end>
  end
  object qryGravaLote: TFDQuery
    Left = 432
    Top = 40
  end
end
