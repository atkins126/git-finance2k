program Finance;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  udmConexao in 'dataModule\udmConexao.pas' {dmConexao: TDataModule},
  uDMContasPagar in 'dataModule\uDMContasPagar.pas' {dmContasPagar: TDataModule},
  uDmExportaFinance in 'dataModule\uDmExportaFinance.pas' {dmExportaFinance: TDataModule},
  uDMMegaContabil in 'dataModule\uDMMegaContabil.pas' {dmMegaContabil: TDataModule},
  uDMOrganizacao in 'dataModule\uDMOrganizacao.pas' {dmOrganizacao: TDataModule},
  UCriptografia in 'lib\UCriptografia.pas',
  uMensagens in 'lib\uMensagens.pas',
  uUtil in 'lib\uUtil.pas',
  UVarGlobais in 'lib\UVarGlobais.pas',
  uFrmBackup in 'uFrmBackup.pas' {frmBackup},
  uBrowseForFolderU in '..\Utilitarios\Backup\uBrowseForFolderU.pas',
  uFrmRegistro in 'uFrmRegistro.pas' {frmRegistro},
  uFrmServidorEmail in 'uFrmServidorEmail.pas' {frmServidorEmail},
  uDMServerMail in 'dataModule\uDMServerMail.pas' {dmServerMail: TDataModule},
  uFrmExportacao in 'uFrmExportacao.pas' {frmExportacao},
  uFrmImportacao in 'uFrmImportacao.pas' {frmImportar},
  uFrmPendentes in 'uFrmPendentes.pas' {frmPendentes},
  uFrmRelatorios in 'uFrmRelatorios.pas' {frmRelatorios},
  uFrmRelatoriosPagamentos in 'uFrmRelatoriosPagamentos.pas' {frmRelatorioPagamentos},
  uDMContasReceber in 'dataModule\uDMContasReceber.pas' {dmContaBancoCRConsulta: TDataModule},
  uDMExportaFinanceDTS in 'dataModule\uDMExportaFinanceDTS.pas' {dmTPDTS: TDataModule},
  uDMRelatorioExportacaoMega in 'dataModule\uDMRelatorioExportacaoMega.pas' {dmRelExportacaoMega: TDataModule},
  uDMImport in 'dataModule\uDMImport.pas' {dmImport: TDataModule},
  Organizacao in 'model\Organizacao.pas',
  uFrmUpdate in 'uFrmUpdate.pas' {frmUpdate},
  uFrmRelatorioPagamentosHistorico in 'uFrmRelatorioPagamentosHistorico.pas' {frmCTPHistorico},
  uDMCombos in 'dataModule\uDMCombos.pas' {dmCombos: TDataModule},
  uDmRelTPHistorico in 'dataModule\uDmRelTPHistorico.pas' {dmRelTPHistorico: TDataModule},
  uDMCedenteConsulta in 'dataModule\uDMCedenteConsulta.pas' {dmCedenteConsulta: TDataModule},
  uDMRelatorioPagamentoHistorico in 'dataModule\uDMRelatorioPagamentoHistorico.pas' {dmRelTPDetalhado: TDataModule},
  uDMExportaFinanceTP in 'dataModule\uDMExportaFinanceTP.pas' {dmExportFinanceTP: TDataModule},
  uDMExportaFinanceTR in 'dataModule\uDMExportaFinanceTR.pas' {dmExportFinanceTR: TDataModule},
  uDMExportaFinanceManter in 'dataModule\uDMExportaFinanceManter.pas' {dmExdportFinanceManter: TDataModule},
  uDMHistoricoConsulta in 'dataModule\uDMHistoricoConsulta.pas' {dmHistoricoConsulta: TDataModule},
  uDMTituloPagarHistoricoConsulta in 'dataModule\uDMTituloPagarHistoricoConsulta.pas' {dmTPHistoricoConsulta: TDataModule},
  uFrmRegistraBaseDados in 'uFrmRegistraBaseDados.pas' {frmRegistraBaseDados},
  uDMTituloPagarCentroCustoConsulta in 'dataModule\uDMTituloPagarCentroCustoConsulta.pas' {dmTPCentroCustoConsulta: TDataModule},
  uDMTituloReceberCentroCustoConsulta in 'dataModule\uDMTituloReceberCentroCustoConsulta.pas' {dmTRCentroCustoConsulta: TDataModule},
  uDMTituloReceberHistoricoConsulta in 'dataModule\uDMTituloReceberHistoricoConsulta.pas' {dmTRHistoricoConsulta: TDataModule},
  uDMExportaFinanceTPB in 'dataModule\uDMExportaFinanceTPB.pas' {dmExportFinanceTPB: TDataModule},
  uDMTesourariaDebitoConsulta in 'dataModule\uDMTesourariaDebitoConsulta.pas' {dmTDConsulta: TDataModule},
  uDMContaBancariaDebitoConsulta in 'dataModule\uDMContaBancariaDebitoConsulta.pas' {dmCBDConsulta: TDataModule},
  uDMTituloPagarBaixaDeducao in 'dataModule\uDMTituloPagarBaixaDeducao.pas' {dmTPBDeducao: TDataModule},
  UDMTituloPagarBaixaAcrescimo in 'dataModule\UDMTituloPagarBaixaAcrescimo.pas' {dmTPBAcrescimo: TDataModule},
  uDMContaBancariaCreditoConsulta in 'dataModule\uDMContaBancariaCreditoConsulta.pas' {dmCBCConsulta: TDataModule},
  uDMTesourariaCreditoConsulta in 'dataModule\uDMTesourariaCreditoConsulta.pas' {dmTCConsulta: TDataModule},
  uDMExportaFinanceTRB in 'dataModule\uDMExportaFinanceTRB.pas' {dmExportFinanceTRB: TDataModule},
  uDMTituloPagarBaixaCheque in 'dataModule\uDMTituloPagarBaixaCheque.pas' {dmTPBCheque: TDataModule},
  uDMTitulorReceberBaixaCheque in 'dataModule\uDMTitulorReceberBaixaCheque.pas' {dmTRBCheque: TDataModule},
  uDMTituloReceberBaixaFP in 'dataModule\uDMTituloReceberBaixaFP.pas' {dmTRBFP: TDataModule},
  UDMTituloReceberBaixaAcrescimo in 'dataModule\UDMTituloReceberBaixaAcrescimo.pas' {dmTRBAcrescimo: TDataModule},
  UDMTituloReceberBaixaDeducao in 'dataModule\UDMTituloReceberBaixaDeducao.pas' {dmTRBDeducao: TDataModule},
  uDMContaBancariaTransferencia in 'dataModule\uDMContaBancariaTransferencia.pas' {dmCBT: TDataModule},
  uDMContasPagarManter in 'dataModule\uDMContasPagarManter.pas' {dmContasPagarManter: TDataModule},
  uFrmManutencao in 'uFrmManutencao.pas' {frmManutencao},
  uFrmContasPagar in 'uFrmContasPagar.pas' {frmContasPagar},
  uDMContasPagarDTS in 'dataModule\uDMContasPagarDTS.pas' {dmContasPagarDTS: TDataModule},
  uFrmSincronizaMega in 'uFrmSincronizaMega.pas' {frmSincronizaMega},
  uDMContaContabil in 'dataModule\uDMContaContabil.pas' {dmContaContabil: TDataModule},
  uListaLancamentosCredito in 'exportacao\uListaLancamentosCredito.pas',
  uLancamentoCreditoModel in 'exportacao\uLancamentoCreditoModel.pas',
  uContaContabilModel in 'model\uContaContabilModel.pas',
  uLancamentoDebitoModel in 'exportacao\uLancamentoDebitoModel.pas',
  uListaLancamentosDebito in 'exportacao\uListaLancamentosDebito.pas',
  uListaLancamentos in 'exportacao\uListaLancamentos.pas',
  uTituloPagarHistoricoModel in 'model\uTituloPagarHistoricoModel.pas',
  uDMUsuarioConsulta in 'dataModule\uDMUsuarioConsulta.pas' {dmUsuarioConsulta: TDataModule},
  uMD5 in 'lib\uMD5.pas',
  UMostraErros in 'lib\UMostraErros.pas' {FMostraErros},
  uFrmAlteraTituloPagar in 'uFrmAlteraTituloPagar.pas' {frmAlteraNumDocTP},
  uFrmAlteraTituloReceber in 'uFrmAlteraTituloReceber.pas' {frmAlteraNumDocTR},
  Vcl.Themes,
  Vcl.Styles,
  udmManutencao in 'dataModule\udmManutencao.pas' {dmManutencao: TDataModule},
  uFrameBDTables in 'frames\uFrameBDTables.pas' {frmBDTables: TFrame},
  uFrameOrganizacoes in 'frames\uFrameOrganizacoes.pas' {frameOrg: TFrame},
  uFrameEndereco in 'frames\uFrameEndereco.pas' {frmEnd: TFrame},
  uFrameGeneric in 'frames\uFrameGeneric.pas' {frameGeneric: TFrame},
  uFrameCidade in 'frames\uFrameCidade.pas' {frmCidade: TFrame},
  uFrameEstado in 'frames\uFrameEstado.pas' {frmEstado: TFrame},
  uFrameBairro in 'frames\uFrameBairro.pas' {frmBairro: TFrame},
  uFrameProgressBar in 'frames\uFrameProgressBar.pas' {framePB: TFrame},
  uFrmDeletaLoteContabil in 'uFrmDeletaLoteContabil.pas' {frmDeletaLoteContabil},
  uDMEspelhoTP in 'dataModule\uDMEspelhoTP.pas' {dmEspelhoTP: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.Title := 'Enterprise Pempec Finance';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmUsuarioConsulta, dmUsuarioConsulta);
  Application.CreateForm(TFMostraErros, FMostraErros);
  Application.CreateForm(TdmEspelhoTP, dmEspelhoTP);
  Application.Run;
end.
