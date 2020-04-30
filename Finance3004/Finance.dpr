program Finance;

{$R *.dres}

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  udmConexao in 'dataModule\udmConexao.pas' {dmConexao: TDataModule},
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
  uFrmRelatoriosRecebimentos in 'uFrmRelatoriosRecebimentos.pas' {frmRelatorioRecebimentos},
  uDMContasReceber in 'dataModule\uDMContasReceber.pas' {dmContaBancoCRConsulta: TDataModule},
  uDMExportaFinanceDTS in 'dataModule\uDMExportaFinanceDTS.pas' {dmTPDTS: TDataModule},
  uDMRelatorioExportacaoMega in 'dataModule\uDMRelatorioExportacaoMega.pas' {dmRelExportacaoMega: TDataModule},
  uDMImport in 'dataModule\uDMImport.pas' {dmImport: TDataModule},
  uOrganizacaoModel in 'model\uOrganizacaoModel.pas',
  uFrmUpdate in 'uFrmUpdate.pas' {frmUpdate},
  uFrmRelatorioPagamentosHistorico in 'uFrmRelatorioPagamentosHistorico.pas' {frmCTPHistorico},
  uDMCombos in 'dataModule\uDMCombos.pas' {dmCombos: TDataModule},
  uDmRelTPHistorico in 'dataModule\uDmRelTPHistorico.pas' {dmRelTPHistorico: TDataModule},
  uDMCedenteConsulta in 'dataModule\uDMCedenteConsulta.pas' {dmCedenteConsulta: TDataModule},
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
  Vcl.Themes,
  Vcl.Styles,
  udmManutencao in 'dataModule\udmManutencao.pas' {dmManutencao: TDataModule},
  uFrameOrganizacoes in 'frames\uFrameOrganizacoes.pas' {frameOrg: TFrame},
  uFrmDeletaLoteContabil in 'uFrmDeletaLoteContabil.pas' {frmDeletaLoteContabil},
  uDMEspelhoTR in 'dataModule\uDMEspelhoTR.pas' {dmEspelhoTR: TDataModule},
  uDMRelatoriosRecebimentos in 'dataModule\uDMRelatoriosRecebimentos.pas' {dmRelRecebimentos: TDataModule},
  uDMContasPagar in 'dataModule\uDMContasPagar.pas' {dmContasPagar: TDataModule},
  uDMContasPagarDTS in 'dataModule\uDMContasPagarDTS.pas' {dmContasPagarDTS: TDataModule},
  uDMRD in 'dataModule\uDMRD.pas' {dmRD: TDataModule},
  uFrmDemonstrativoRD in 'uFrmDemonstrativoRD.pas' {frmDemonstrativoRD},
  uFrmSelecionaOrganizacao in 'uFrmSelecionaOrganizacao.pas' {frmSelectOrganizacao},
  uFrmEstornaCheque in 'uFrmEstornaCheque.pas' {frmEstornaCheque},
  uDMCompensarCheques in 'dataModule\uDMCompensarCheques.pas' {dmCompensarCheques: TDataModule},
  uFrmMultiplosCheques in 'uFrmMultiplosCheques.pas' {frmMultiplosCheques},
  uDMExtratoBancario in 'dataModule\uDMExtratoBancario.pas' {dmExtratoBancario: TDataModule},
  uFrmExtratoBancario in 'uFrmExtratoBancario.pas' {frmExtratoBancario},
  uDMDeletaLoteContabil in 'dataModule\uDMDeletaLoteContabil.pas' {dmDeletaLoteContabil: TDataModule},
  uFrmSaldoContas in 'uFrmSaldoContas.pas' {frmSaldoContas},
  UfrmPosicaoFinanceira in 'UfrmPosicaoFinanceira.pas' {frmPosicaoFinanceira},
  uHistoricoModel in 'model\uHistoricoModel.pas',
  uDMParametros in 'dataModule\uDMParametros.pas' {dmParametros: TDataModule},
  uFrmHistorico in 'uFrmHistorico.pas' {frmHistorico},
  uFrmAjustaSkin in 'uFrmAjustaSkin.pas' {frmSkin},
  uFrmTransferenciasEntreContas in 'uFrmTransferenciasEntreContas.pas' {frmTransferenciasEntreContas},
  uFrmRelatorioTransferencias in 'uFrmRelatorioTransferencias.pas' {frmRelatorioTransferencias},
  uFrmTransfereCaixaBanco in 'uFrmTransfereCaixaBanco.pas' {frmTransferenciasCaixaBanco},
  uDMTransfBancoCaixa in 'dataModule\uDMTransfBancoCaixa.pas' {dmTransfBancoCaixa: TDataModule},
  uDMTransfCaixaBanco in 'dataModule\uDMTransfCaixaBanco.pas' {dmTransfCaixaBanco: TDataModule},
  uFrmTransfereBancoCaixa in 'uFrmTransfereBancoCaixa.pas' {frmTransferenciasBancoCaixa},
  uFrmDepositoCheque in 'uFrmDepositoCheque.pas' {frmDepositoCheque},
  uDMExtratoTesouraria in 'dataModule\uDMExtratoTesouraria.pas' {dmExtratoTesouraria: TDataModule},
  uFrmExtratoTesouraria in 'uFrmExtratoTesouraria.pas' {frmExtratoTesouraria},
  uFrmManterTOB in 'uFrmManterTOB.pas' {frmManterTOB},
  uFrmLoteDeposito in 'uFrmLoteDeposito.pas' {frmLoteDeposito},
  uFrmManterContaBancaria in 'uFrmManterContaBancaria.pas' {frmManterContaBancaria},
  uFrmReciboTR in 'uFrmReciboTR.pas' {frmReciboTR},
  uFrmManterTipoCedente in 'uFrmManterTipoCedente.pas' {frmManterTipoCedente},
  uFrmManterTipoSacado in 'uFrmManterTipoSacado.pas' {frmManterTipoSacado},
  uFrmManterTipoCobranca in 'uFrmManterTipoCobranca.pas' {frmManterTipoCobranca},
  uFrmManterTipoNotaFiscal in 'uFrmManterTipoNotaFiscal.pas' {frmManterTipoNotaFiscal},
  uFrmManterSacado in 'uFrmManterSacado.pas' {frmManterSacado},
  uDMImobilizado in 'dataModule\uDMImobilizado.pas' {dmImobilizado: TDataModule},
  uFrmImobilizado in 'uFrmImobilizado.pas' {frmImobilizado},
  uCedenteModel in 'model\uCedenteModel.pas',
  uSacadoModel in 'model\uSacadoModel.pas',
  Organizacao in 'model\Organizacao.pas',
  uPatrimonioModel in 'model\uPatrimonioModel.pas',
  uFrmManterTipoAcrescimo in 'uFrmManterTipoAcrescimo.pas' {frmManterTipoAcrescimo},
  uEnderecoModel in 'model\uEnderecoModel.pas',
  uContatoModel in 'model\uContatoModel.pas',
  uFrmManterFuncionario in 'uFrmManterFuncionario.pas' {frmManterFuncionario},
  uFrmManterCartaoCredito in 'uFrmManterCartaoCredito.pas' {frmManterCartaoCredito},
  uFrmManterTipoDeducao in 'uFrmManterTipoDeducao.pas' {frmManterTipoDeducao},
  uFrmManterTipoStatus in 'uFrmManterTipoStatus.pas' {frmManterTipoStatus},
  uFrmManterUsuario in 'uFrmManterUsuario.pas' {frmManterUsuario},
  uCartaoCreditoModel in 'model\uCartaoCreditoModel.pas',
  uFrmMostraProcesso in 'uFrmMostraProcesso.pas' {frmMostraProcesso},
  uTipoCobrancaModel in 'model\uTipoCobrancaModel.pas',
  uTipoNotaFiscalModel in 'model\uTipoNotaFiscalModel.pas',
  uLocalPagamentoModel in 'model\uLocalPagamentoModel.pas',
  uFrameComboGenerico in 'frames\uFrameComboGenerico.pas' {FrameComboGenerico: TFrame},
  uCentroCustoModel in 'model\uCentroCustoModel.pas',
  uFormaPagamentoModel in 'model\uFormaPagamentoModel.pas',
  uFrmBaixaTRFP in 'uFrmBaixaTRFP.pas' {frmBaixaTRFP},
  uFrmTelaPagamentoTR in 'uFrmTelaPagamentoTR.pas' {frmRecebimentoTitulos},
  uFrmBaixaTRFPInternet in 'uFrmBaixaTRFPInternet.pas' {frmBaixaTRFPInternet},
  uFuncionarioModel in 'model\uFuncionarioModel.pas',
  uFrmReciboTP in 'uFrmReciboTP.pas' {frmReciboTP},
  uDMBaixaTP in 'dataModule\uDMBaixaTP.pas' {dmBaixaTP: TDataModule},
  uTPBaixaChequeModel in 'model\uTPBaixaChequeModel.pas',
  uTPBaixaModel in 'model\uTPBaixaModel.pas',
  uTPBaixaFPModel in 'model\uTPBaixaFPModel.pas',
  uContaBancariaModel in 'model\uContaBancariaModel.pas',
  uFrmGerarCheques in 'uFrmGerarCheques.pas' {frmGerarCheques},
  uLoteContabilModel in 'model\uLoteContabilModel.pas',
  uNotaFiscalEntradaModel in 'model\uNotaFiscalEntradaModel.pas',
  uTipoStatusModel in 'model\uTipoStatusModel.pas',
  uLotePagamentoModel in 'model\uLotePagamentoModel.pas',
  uTituloPagarModel in 'model\uTituloPagarModel.pas',
  uTipoOperacaoBancariaModel in 'model\uTipoOperacaoBancariaModel.pas',
  uContaBancariaChequeModel in 'model\uContaBancariaChequeModel.pas',
  uContaBancariaDBModel in 'model\uContaBancariaDBModel.pas',
  uUsuarioDAO in 'dao\uUsuarioDAO.pas',
  uTPBaixaFPDAO in 'dao\uTPBaixaFPDAO.pas',
  uTPBaixaDAO in 'dao\uTPBaixaDAO.pas',
  uTPBaixaChequeDAO in 'dao\uTPBaixaChequeDAO.pas',
  uTituloPagarDAO in 'dao\uTituloPagarDAO.pas',
  uLoteContabilDAO in 'dao\uLoteContabilDAO.pas',
  uFormaPagamentoDAO in 'dao\uFormaPagamentoDAO.pas',
  uContaContabilDAO in 'dao\uContaContabilDAO.pas',
  uContaBancariaDebitoDAO in 'dao\uContaBancariaDebitoDAO.pas',
  uContaBancariaDAO in 'dao\uContaBancariaDAO.pas',
  uContaBancariaChequeDAO in 'dao\uContaBancariaChequeDAO.pas',
  uUsuarioModel in 'model\uUsuarioModel.pas',
  uTipoOperacaoBancariaDAO in 'dao\uTipoOperacaoBancariaDAO.pas',
  uHistoricoDAO in 'dao\uHistoricoDAO.pas',
  uTipoDeducaoModel in 'model\uTipoDeducaoModel.pas',
  uTipoAcrescimoDAO in 'dao\uTipoAcrescimoDAO.pas',
  uTipoAcrescimoModel in 'model\uTipoAcrescimoModel.pas',
  uTipoDeducaoDAO in 'dao\uTipoDeducaoDAO.pas',
  uTPBaixaACModel in 'model\uTPBaixaACModel.pas',
  uTPBaixaDEModel in 'model\uTPBaixaDEModel.pas',
  uTPBaixaACDAO in 'dao\uTPBaixaACDAO.pas',
  uTPBaixaDEDAO in 'dao\uTPBaixaDEDAO.pas',
  uCedenteDAO in 'dao\uCedenteDAO.pas',
  uTesourariaDBModel in 'model\uTesourariaDBModel.pas',
  uTesourariaDBDAO in 'dao\uTesourariaDBDAO.pas',
  uTPBaixaInternetModel in 'model\uTPBaixaInternetModel.pas',
  uTPBaixaInternetDAO in 'dao\uTPBaixaInternetDAO.pas',
  uFrmBaixaTRFPCheque in 'uFrmBaixaTRFPCheque.pas' {frmBaixaTRFPCheque},
  uBancoModel in 'model\uBancoModel.pas',
  uBancoDAO in 'dao\uBancoDAO.pas',
  uFrameTipoDeducao in 'frames\uFrameTipoDeducao.pas' {frameTipoDeducao: TFrame},
  uFrameTipoAcrescimo in 'frames\uFrameTipoAcrescimo.pas' {frameTipoAcrescimo: TFrame},
  uFrameTipoCedente in 'frames\uFrameTipoCedente.pas' {frmTipoCedente: TFrame},
  uFrameBDTables in 'frames\uFrameBDTables.pas' {frmBDTables: TFrame},
  uFrameCheque in 'frames\uFrameCheque.pas' {frameCheque: TFrame},
  uFrameHistorico in 'frames\uFrameHistorico.pas' {frameHistorico: TFrame},
  uFrameContaContabil in 'frames\uFrameContaContabil.pas' {frmContaContabil: TFrame},
  uFrameFormaPagamento in 'frames\uFrameFormaPagamento.pas' {frmFormaPagto: TFrame},
  uFrameContaBancaria in 'frames\uFrameContaBancaria.pas' {frmContaBancaria: TFrame},
  uFrameTR in 'frames\uFrameTR.pas' {frameTR: TFrame},
  uFrameResponsavel in 'frames\uFrameResponsavel.pas' {frameResponsavel: TFrame},
  uFrameCentroCusto in 'frames\uFrameCentroCusto.pas' {frameCentroCusto: TFrame},
  uFrameContato in 'frames\uFrameContato.pas' {frameContato: TFrame},
  uFrameImobilizado in 'frames\uFrameImobilizado.pas' {frameImobilizado: TFrame},
  uFrameLocalPagamento in 'frames\uFrameLocalPagamento.pas' {frmLocalPagto: TFrame},
  uFrameTipoNotaFiscal in 'frames\uFrameTipoNotaFiscal.pas' {frmTipoNF: TFrame},
  uFrameTipoCobranca in 'frames\uFrameTipoCobranca.pas' {frmTipoCobranca: TFrame},
  uFrameCartaoCredito in 'frames\uFrameCartaoCredito.pas' {frmCartaoCredito: TFrame},
  uFrameEstado in 'frames\uFrameEstado.pas' {frmEstado: TFrame},
  uFrameTipoSacado in 'frames\uFrameTipoSacado.pas' {frmTipoSacado: TFrame},
  uFrameProgressBar in 'frames\uFrameProgressBar.pas' {framePB: TFrame},
  uFrameNotaFiscal in 'frames\uFrameNotaFiscal.pas' {frmNotafiscal: TFrame},
  uFrameEndereco in 'frames\uFrameEndereco.pas' {frmEnd: TFrame},
  uFrameCidade in 'frames\uFrameCidade.pas' {frmCidade: TFrame},
  uFrameBairro in 'frames\uFrameBairro.pas' {frmBairro: TFrame},
  uFrameBanco in 'frames\uFrameBanco.pas' {frmBanco: TFrame},
  uFrameGeneric in 'frames\uFrameGeneric.pas' {frameGeneric: TFrame},
  uFramePeriodo in 'frames\uFramePeriodo.pas' {frmPeriodo: TFrame},
  uTituloPagarCentroCustoModel in 'model\uTituloPagarCentroCustoModel.pas',
  uTituloPagarHistoricoDAO in 'dao\uTituloPagarHistoricoDAO.pas',
  uTituloPagarCentroCustoDAO in 'dao\uTituloPagarCentroCustoDAO.pas',
  uCentroCustoDAO in 'dao\uCentroCustoDAO.pas',
  uFrmTituloReceberClone in 'uFrmTituloReceberClone.pas' {frmTituloPagarClone},
  uLotePagamentoDAO in 'dao\uLotePagamentoDAO.pas',
  uFrmTelaImpressaoLotePagamento in 'uFrmTelaImpressaoLotePagamento.pas' {fmTelaImpressaoLotePagamento},
  uFrmManterTituloReceber in 'uFrmManterTituloReceber.pas' {frmManterTituloReceber},
  uFuncionarioDAO in 'dao\uFuncionarioDAO.pas',
  uTipoStatusDAO in 'dao\uTipoStatusDAO.pas',
  uFrmEspelhoTR in 'uFrmEspelhoTR.pas' {formEspelhoTR},
  uCartaoCreditoDAO in 'dao\uCartaoCreditoDAO.pas',
  uTipoNotaFiscalDAO in 'dao\uTipoNotaFiscalDAO.pas',
  uNotaFiscalEntradaDAO in 'dao\uNotaFiscalEntradaDAO.pas',
  uContaBancariaCRModel in 'model\uContaBancariaCRModel.pas',
  uContaBancariaCreditoDAO in 'dao\uContaBancariaCreditoDAO.pas',
  uTituloReceberModel in 'model\uTituloReceberModel.pas',
  uTituloReceberDAO in 'dao\uTituloReceberDAO.pas',
  uFrmTituloReceberParcelado in 'uFrmTituloReceberParcelado.pas' {frmTituloReceberParcelado},
  uOrganizacaoDAO in 'dao\uOrganizacaoDAO.pas',
  uTituloPagarParceladoModel in 'model\uTituloPagarParceladoModel.pas',
  uContatoDAO in 'dao\uContatoDAO.pas',
  uEnderecoDAO in 'dao\uEnderecoDAO.pas',
  uEstadoModel in 'model\uEstadoModel.pas',
  uCidadeModel in 'model\uCidadeModel.pas',
  uBairroModel in 'model\uBairroModel.pas',
  uEstadoDAO in 'dao\uEstadoDAO.pas',
  uCidadeDAO in 'dao\uCidadeDAO.pas',
  uBairroDAO in 'dao\uBairroDAO.pas',
  uFrmManterCedente in 'uFrmManterCedente.pas' {frmManterCedente},
  uContaBancariaTRFModel in 'model\uContaBancariaTRFModel.pas',
  uContaBancariaTRFDAO in 'dao\uContaBancariaTRFDAO.pas',
  uTipoCedenteModel in 'model\uTipoCedenteModel.pas',
  uTipoSacadoModel in 'model\uTipoSacadoModel.pas',
  uTipoSacadoDAO in 'dao\uTipoSacadoDAO.pas',
  uTipoCedenteDAO in 'dao\uTipoCedenteDAO.pas',
  uSacadoDAO in 'dao\uSacadoDAO.pas',
  uTituloReceberHistoricoModel in 'model\uTituloReceberHistoricoModel.pas',
  uTituloReceberHistoricoDAO in 'dao\uTituloReceberHistoricoDAO.pas',
  uTituloReceberCentroCustoModel in 'model\uTituloReceberCentroCustoModel.pas',
  uTituloReceberCentroCustoDAO in 'dao\uTituloReceberCentroCustoDAO.pas',
  uTituloReceberParceladoModel in 'model\uTituloReceberParceladoModel.pas',
  uLocalPagamentoDAO in 'dao\uLocalPagamentoDAO.pas',
  uTipoCobrancaDAO in 'dao\uTipoCobrancaDAO.pas',
  uFrameCedente in 'frames\uFrameCedente.pas' {frameCedente: TFrame},
  uFrameSacado in 'frames\uFrameSacado.pas' {frameSacado: TFrame},
  uFrameTP in 'frames\uFrameTP.pas' {frameTP: TFrame},
  uFrmManterTituloPagar in 'uFrmManterTituloPagar.pas' {frmManterTituloPagar},
  uTRBaixaACModel in 'model\uTRBaixaACModel.pas',
  uTRBaixaDEModel in 'model\uTRBaixaDEModel.pas',
  uTRBaixaFPModel in 'model\uTRBaixaFPModel.pas',
  uTRBaixaModel in 'model\uTRBaixaModel.pas',
  uTRBaixaChequeModel in 'model\uTRBaixaChequeModel.pas',
  uTRBaixaInternetModel in 'model\uTRBaixaInternetModel.pas',
  uTRBaixaDEDAO in 'dao\uTRBaixaDEDAO.pas',
  uTRBaixaACDAO in 'dao\uTRBaixaACDAO.pas',
  uTRBaixaInternetDAO in 'dao\uTRBaixaInternetDAO.pas',
  uTRBaixaChequeDAO in 'dao\uTRBaixaChequeDAO.pas',
  uDMEspelhoTP in 'dataModule\uDMEspelhoTP.pas' {dmEspelhoTP: TDataModule},
  uFrmEspelhoTP in 'uFrmEspelhoTP.pas' {formEspelhoTP},
  uTesourariaCRDAO in 'dao\uTesourariaCRDAO.pas',
  uTesourariaCRModel in 'model\uTesourariaCRModel.pas',
  uTRBaixaDAO in 'dao\uTRBaixaDAO.pas',
  uTRBaixaFPDAO in 'dao\uTRBaixaFPDAO.pas',
  uFrmTituloPagarParcelado in 'uFrmTituloPagarParcelado.pas' {frmTituloPagarParcelado},
  uFrmTelaPagamentoTP in 'uFrmTelaPagamentoTP.pas' {frmPagamentoTitulos},
  uFrmBaixaFP in 'uFrmBaixaFP.pas' {frmBaixaFP},
  uFrmTelaPagamentoLoteTP in 'uFrmTelaPagamentoLoteTP.pas' {frmPagamentoLoteTitulos},
  uFrmBaixaTPLoteFP in 'uFrmBaixaTPLoteFP.pas' {frmBaixaTPLoteFP},
  MDModel in 'model\MDModel.pas',
  MDDAO in 'dao\MDDAO.pas',
  uFrmManterHistorico in 'uFrmManterHistorico.pas' {frmManterHistorico},
  uFrmCompensaCheque in 'uFrmCompensaCheque.pas' {frmCompensaCheque},
  uFrmInfoUpdate in 'uFrmInfoUpdate.pas' {frmInfoUpdate},
  uLoteDepositoModel in 'model\uLoteDepositoModel.pas',
  uLoteDepositoDAO in 'dao\uLoteDepositoDAO.pas',
  uFrmRelatoriosPagamentos in 'uFrmRelatoriosPagamentos.pas' {frmRelatorioPagamentos},
  uDMRelatoriosPagamentos in 'dataModule\uDMRelatoriosPagamentos.pas' {dmRelPagamentos: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Silver');
  Application.Title := 'Enterprise Pempec Finance';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmUsuarioConsulta, dmUsuarioConsulta);
  Application.CreateForm(TFMostraErros, FMostraErros);
  Application.Run;
end.
