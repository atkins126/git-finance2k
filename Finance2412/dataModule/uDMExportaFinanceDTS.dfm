object dmTPDTS: TdmTPDTS
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 693
  Width = 969
  object dtsTituloReceber: TDataSource
    DataSet = dmExportFinanceTR.qryTRProvisionados
    OnDataChange = dtsTituloReceberDataChange
    Left = 64
    Top = 24
  end
  object dtsTituloPagar: TDataSource
    DataSet = dmExportFinanceTP.qryTPPROVBASE
    OnDataChange = dtsTituloPagarDataChange
    Left = 64
    Top = 416
  end
  object dtsCentroCusto: TDataSource
    Left = 64
    Top = 504
  end
  object dtsHistoricoTR: TDataSource
    AutoEdit = False
    DataSet = dmTRHistoricoConsulta.qryObterTRHistoricoPorTR
    Left = 64
    Top = 80
  end
  object dtsCentroCustoTR: TDataSource
    AutoEdit = False
    DataSet = dmTRHistoricoConsulta.qryObterTRHistoricoPorTR
    Left = 64
    Top = 136
  end
  object dtsHistorico: TDataSource
    Left = 64
    Top = 584
  end
  object dtsTituloPagarBaixa: TDataSource
    DataSet = dmExportFinanceTPB.qryObterBaixaPorTitulo
    Left = 264
    Top = 584
  end
  object dtsTitulosQuitados: TDataSource
    DataSet = dmExportFinanceTP.qryTitulosQuitados
    OnDataChange = dtsTitulosQuitadosDataChange
    Left = 152
    Top = 584
  end
  object dtsTesourariaPorTPB: TDataSource
    DataSet = dmExportFinanceTPB.qryObterBaixaPorTitulo
    Left = 392
    Top = 584
  end
  object dtsBancoPorTPB: TDataSource
    DataSet = dmCBDConsulta.qryObterPorTituloPagar
    Left = 504
    Top = 584
  end
  object dtsHistoricoTPB: TDataSource
    Left = 696
    Top = 584
  end
  object dtsTPBAcrescimo: TDataSource
    DataSet = dmTPBAcrescimo.qryObterPorTPB
    Left = 776
    Top = 584
  end
  object dtsTPBDeducao: TDataSource
    DataSet = dmTPBDeducao.qryObterPorTPB
    Left = 888
    Top = 584
  end
  object dtsTRQuitados: TDataSource
    DataSet = dmExportFinanceTR.qryTitulosQuitados
    OnDataChange = dtsTRQuitadosDataChange
    Left = 184
    Top = 24
  end
  object dtsTituloReceberBaixa: TDataSource
    DataSet = dmExportFinanceTRB.qryObterBaixaPorTitulo
    Left = 280
    Top = 24
  end
  object dtsBancoPorTRB: TDataSource
    DataSet = dmCBCConsulta.qryObterPorTituloReceber
    Left = 496
    Top = 24
  end
  object dtsTesourariaPorTRB: TDataSource
    DataSet = dmTCConsulta.qryObterPorTituloReceberBaixa
    Left = 400
    Top = 24
  end
  object dtsChequePorTPB: TDataSource
    DataSet = dmTPBCheque.qryObterPorTPB
    Left = 608
    Top = 584
  end
  object dtsChequePorTRB: TDataSource
    DataSet = dmTRBCheque.qryObterPorTRB
    Left = 608
    Top = 24
  end
  object dtsTRBFormaPagto: TDataSource
    DataSet = dmTRBFP.qryObterPorTRB
    Left = 704
    Top = 24
  end
  object dtsTRBAcrescimo: TDataSource
    Left = 792
    Top = 24
  end
  object dtsTRBDeducao: TDataSource
    Left = 896
    Top = 24
  end
  object dtsCBTCredito: TDataSource
    DataSet = dmCBCConsulta.qryObterPorId
    Left = 184
    Top = 272
  end
  object dtsCBTDebito: TDataSource
    DataSet = dmCBDConsulta.qryObterPorId
    Left = 184
    Top = 344
  end
  object dtsCBT: TDataSource
    DataSet = dmCBT.qryObterPorPeriodo
    OnDataChange = dtsCBTDataChange
    Left = 184
    Top = 184
  end
  object dtsTransfBancoTesourariaDebito: TDataSource
    DataSet = dmCBDConsulta.qryObterTransfBancoTesourariaPeriodo
    OnDataChange = dtsTransfBancoTesourariaDebitoDataChange
    Left = 320
    Top = 184
  end
  object dtsCreditoTesourariaPorTransferencia: TDataSource
    DataSet = dmTCConsulta.qryObterPorContaBancariaDebito
    Left = 320
    Top = 296
  end
  object dtsTransfTesourariaBancoCredito: TDataSource
    DataSet = dmCBCConsulta.qryObterTransfTesourariaBancoPeriodo
    OnDataChange = dtsTransfTesourariaBancoCreditoDataChange
    Left = 520
    Top = 184
  end
  object dtsDebitoTesourariaPorTransferencia: TDataSource
    DataSet = dmTDConsulta.qryObterPorContaBancariaCredito
    Left = 536
    Top = 296
  end
end
