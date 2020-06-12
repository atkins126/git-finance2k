unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, uFrmEspelhoCheques,
  System.Variants, System.Classes, Vcl.Graphics, uUtil, uVarGlobais, uFrmManterCentroCusto,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Registry, uFrmRegistraBaseDados,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, wininet, Winsock, IdSSL,
  IdSSLOpenSSL, Organizacao, IdTCPClient, IdTCPConnection, jpeg, IdBaseComponent,
  IdHTTP, FireDAC.stan.Param, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  Vcl.IdAntiFreeze, udmConexao, uDMOrganizacao, udmMegaContabil,
  uDMUsuarioConsulta, uDmExportaFinance, uDMContasPagar, uFrmManutencao,
  uFrmBackup, uFrmRegistro, uFrmServidorEmail, uFrmImportacao, uFrmExportacao,
  uFrmSincronizaMega, uFrmTeste, uFrmUpdate, udmCombos, UMostraErros,
  uFrmAlteraTituloReceber, udmManutencao, uFrmExtratoBancario,
  uFrmDeletaLoteContabil, uFrmCompensaCheque, uFrmMultiplosCheques,
  uDMServerMail, uFrmSelecionaOrganizacao, uFrmSaldoContas,
  UfrmPosicaoFinanceira, uDMParametros, sSkinManager, cxGraphics,
  uFrmDemonstrativoRD, uFrmRelatoriosPagamentos,
  uFrmRelatorioPagamentosHistorico, cxControls, uFrmExtratoTesouraria,
  uFrmTelaImpressaoLotePagamento, dxStatusBar, uFrmHistorico,
  uFrmManterHistorico, uFrmManterContaBancaria, cxClasses, dxRibbon,
  uFrmLoteDeposito, uFrmManterTipoStatus, Vcl.ActnMan, dxBar,
  uFrmTransferenciasEntreContas, System.DateUtils, uFrmTransfereBancoCaixa,
  uFrmTransfereCaixaBanco, dxDateTimeWheelPicker, cxBarEditItem, uFrmAjustaSkin,
  uFrmDepositoCheque, uFrmGerarCheques, uFrmManterFuncionario,
  uFrmManterTipoCedente, uFrmManterTipoSacado, uFrmManterTipoNotaFiscal,
  uFrmManterTipoCobranca, uFrmManterTOB, uFrmManterCartaoCredito, uFrmEspelhoTP,
  uFrmManterCedente, uFrmManterSacado, uFrmManterTipoDeducao,
  uFrmManterTipoAcrescimo, uFrmReciboTP, uFrmReciboTR, uFrmTelaPagamentoTP,
  uFrmManterTituloReceber, uFrmManterTituloPagar, uUsuarioModel, uUsuarioDAO,
  uFrmTelaPagamentoTR, uFrmTelaPagamentoLoteTP, EMsgDlg, uOrganizacaoDAO,
  uOrganizacaoModel, uFrmManterUsuario, uFrmEstornaCheque, uMostrarLogErro,
  dxBarExtItems, uFrmInfoUpdate, System.RegularExpressions,
  uFrmRelatoriosRecebimentos, uPempecExceptions, Vcl.AppEvnts, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore, dxSkinsDefaultPainters,
  dxRibbonCustomizationForm, cxContainer, cxEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, cxCalc, cxCalendar,
  IdComponent, dxBarApplicationMenu, Vcl.PlatformDefaultStyleActnCtrls,
  System.Actions, Vcl.ActnList, IdAntiFreezeBase, dxWheelPicker, uFrmDemonstrativoDespesasCC,
  dxNumericWheelPicker, Vcl.Imaging.pngimage, cxTextEdit, cxRadioGroup,
  cxCheckGroup, cxCheckBox, cxButtonEdit, dxSparkline;

type
  TFrmPrincipal = class(TForm)
    IdAntiFreeze1: TIdAntiFreeze;
    stat1: TStatusBar;
    edtLogin: TEdit;
    lbl2: TLabel;
    edtPassword: TEdit;
    lbl3: TLabel;
    btnLogin: TBitBtn;
    cbxUsuario: TComboBox;
    img1: TImage;
    tmrrelogio: TTimer;
    qryDadosEmpresaMega: TFDQuery;
    skm: TsSkinManager;
    actmgr1: TActionManager;
    dxBarManager1: TdxBarManager;
    menuCTP: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab2: TdxRibbonTab;
    menuSistema: TdxRibbonTab;
    menuContaBancaria: TdxRibbonTab;
    dxBarApplicationMenu1: TdxBarApplicationMenu;
    dxBarManager1Bar1: TdxBar;
    dxBarBackup: TdxBarLargeButton;
    dxBarRegistro: TdxBarLargeButton;
    pnlMain: TPanel;
    lblHoraAcesso: TLabel;
    btnZoom: TBitBtn;
    lblPathSGBD: TLabel;
    dxBarManager1Bar3: TdxBar;
    dxBarSubExport: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarBtnExportMega: TdxBarLargeButton;
    dxBarButton1: TdxBarButton;
    dxBarCancelExport: TdxBarLargeButton;
    dxBarManutencao: TdxBarLargeButton;
    dxBtnImport: TdxBarLargeButton;
    dxBarManager1Bar2: TdxBar;
    dxBtnMegaSincronizar: TdxBarLargeButton;
    dxBarLargeButton1: TdxBarLargeButton;
    cxBarEditItem1: TcxBarEditItem;
    cxBarEditItem2: TcxBarEditItem;
    cxBarEditItem3: TcxBarEditItem;
    dxDateTimeWheelPicker2: TdxDateTimeWheelPicker;
    dxBarManager1Bar4: TdxBar;
    dxBtnCadastroTP: TdxBarLargeButton;
    dxBtnAlteraNumDoc: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    dxBtnEspelhoTP: TdxBarLargeButton;
    dxBtnRelCTP: TdxBarLargeButton;
    dxBtnRelTPHistorico: TdxBarLargeButton;
    dxBtnRelDemoCentroCusto: TdxBarLargeButton;
    dxBarManager1Bar6: TdxBar;
    dxBtnConfigEmail: TdxBarLargeButton;
    dxBtnSerial: TdxBarLargeButton;
    dxBarManager1Bar7: TdxBar;
    dxBtnTRFBCOCAIXA: TdxBarLargeButton;
    dxTRFBCOBCO: TdxBarLargeButton;
    dxBarManager1Bar8: TdxBar;
    dxBtnCompensarDiversosChs: TdxBarLargeButton;
    dxBtnCompensarCheque: TdxBarLargeButton;
    dxBarManager1Bar9: TdxBar;
    dxBtnRelExtratoBancario: TdxBarLargeButton;
    dxBtnRelSDContas: TdxBarLargeButton;
    dxBarManager1Bar10: TdxBar;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBtnTPProvisao: TdxBarLargeButton;
    dxBtnTRProvisao: TdxBarLargeButton;
    dxBarManager1Bar11: TdxBar;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBtnAlteraSkin: TdxBarLargeButton;
    dxStatusBar1: TdxStatusBar;
    dxRibbonRel: TdxRibbonTab;
    dxBarManager1Bar12: TdxBar;
    dxBarLargeButton5: TdxBarLargeButton;
    lblLogin: TLabel;
    dxBarManager1Bar13: TdxBar;
    dxBtnRelDemoCC: TdxBarLargeButton;
    dxRibbon1Tab1: TdxRibbonTab;
    dxBarManager1Bar14: TdxBar;
    dxBarRelCaixa: TdxBar;
    dxBtbTrfCxDin: TdxBarLargeButton;
    dxBtbTrfCxChq: TdxBarLargeButton;
    dxBarManager1Bar16: TdxBar;
    dxBarLargeButton6: TdxBarLargeButton;
    dxBarLargeButton7: TdxBarLargeButton;
    dxBarLargeButton8: TdxBarLargeButton;
    menuParametros: TdxRibbonTab;
    menuTipos: TdxBar;
    menuBarContaBancaria: TdxBar;
    dxBtnTipoStatus: TdxBarLargeButton;
    dxBtnTipoTOB: TdxBarLargeButton;
    dxBtnTipoAcrescimos: TdxBarLargeButton;
    dxBtnTipoDeducoes: TdxBarLargeButton;
    dxBtnTipoSacado: TdxBarLargeButton;
    dxBtnTipoCedente: TdxBarLargeButton;
    dxBtnTipoCobranca: TdxBarLargeButton;
    dxBtnTipoNF: TdxBarLargeButton;
    dxBtnContasBancarias: TdxBarLargeButton;
    dxBtnHistorico: TdxBarLargeButton;
    dxBarLargeButton10: TdxBarLargeButton;
    dxBarLargeButton9: TdxBarLargeButton;
    dxBarManager1Bar18: TdxBar;
    dxBtrnCedente: TdxBarLargeButton;
    dxBtrnSacado: TdxBarLargeButton;
    dxBtnReciboTP: TdxBarLargeButton;
    dxBarValidador: TdxBarLargeButton;
    dxBarManager1Bar19: TdxBar;
    dxBtnReciboTR: TdxBarLargeButton;
    dxBtnCartaoCredito: TdxBarLargeButton;
    dxBtnBaixaTP: TdxBarLargeButton;
    dxBtnGeraCheque: TdxBarLargeButton;
    dxBtnRelLotePagamento: TdxBarLargeButton;
    dxBtnBaixaLoteTP: TdxBarLargeButton;
    dxBtnFuncionario: TdxBarLargeButton;
    dxBtnBaixaTR: TdxBarLargeButton;
    PempecMsg: TEvMsgDlg;
    chkSavePass: TCheckBox;
    dxBtnUsuario: TdxBarLargeButton;
    dxBarManager1Bar20: TdxBar;
    dxBarBtnLotePagamento: TdxBarLargeButton;
    dxBarBtnEstorna: TdxBarLargeButton;
    IdHTTP1: TIdHTTP;
    dxBarAbout: TdxBar;
    dxBarLargeButton11: TdxBarLargeButton;
    dxBarLargeButton12: TdxBarLargeButton;
    dxBarImageCombo1: TdxBarImageCombo;
    dxBarBtnRelCTR: TdxBarLargeButton;
    ApplicationEvents: TApplicationEvents;
    dxBarBtnLogErro: TdxBarLargeButton;
    dxBtnDemoDespesas: TdxBarLargeButton;
    dxBarBtnGerarCH: TdxBarLargeButton;
    dxBarBtnGerarCH2: TdxBarLargeButton;
    dxBarBtnEspelhoCH: TdxBarLargeButton;
    dxBarBtnListarCH: TdxBarLargeButton;
    dxBtnCentroCusto: TdxBarLargeButton;
    dxEdtVersaoWeb: TdxBarEdit;
    dxBarImageCombo2: TdxBarImageCombo;
    dxBarStatic1: TdxBarStatic;

    procedure FormCreate(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure acessoMenu(value: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxUsuarioChange(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure Zoom(Sender: TObject);

    procedure cbxUsuarioClick(Sender: TObject);

    procedure alignPanelLogin(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrrelogioTimer(Sender: TObject);

    procedure dxBarBackupClick(Sender: TObject);
    procedure dxBarRegistroClick(Sender: TObject);
    procedure dxBarBtnExportMegaClick(Sender: TObject);
    procedure dxBarCancelExportClick(Sender: TObject);
    procedure dxBarManutencaoClick(Sender: TObject);
    procedure dxBtnImportClick(Sender: TObject);
    procedure dxBtnMegaSincronizarClick(Sender: TObject);
    procedure dxBtnCadastroTPClick(Sender: TObject);
    procedure dxBtnEspelhoTPClick(Sender: TObject);
    procedure dxBtnRelCTPClick(Sender: TObject);
    procedure dxBtnRelTPHistoricoClick(Sender: TObject);
    procedure dxBtnConfigEmailClick(Sender: TObject);
    procedure dxBtnTRFBCOCAIXAClick(Sender: TObject);
    procedure dxBtnCompensarDiversosChsClick(Sender: TObject);
    procedure dxBtnCompensarChequeClick(Sender: TObject);
    procedure dxBtnRelExtratoBancarioClick(Sender: TObject);
    procedure dxBtnRelSDContasClick(Sender: TObject);
    procedure dxBarLargeButton2Click(Sender: TObject);
    procedure dxBarLargeButton3Click(Sender: TObject);
    procedure dxBtnTRProvisaoClick(Sender: TObject);
    procedure dxBarLargeButton4Click(Sender: TObject);
    procedure dxBtnAlteraSkinClick(Sender: TObject);
    procedure dxBarLargeButton5Click(Sender: TObject);
    procedure dxBtnRelDemoCCClick(Sender: TObject);
    procedure dxTRFBCOBCOClick(Sender: TObject);
    procedure dxBtbTrfCxDinClick(Sender: TObject);
    procedure dxBtbTrfCxChqClick(Sender: TObject);
    procedure dxBarLargeButton8Click(Sender: TObject);
    procedure dxBarLargeButton6Click(Sender: TObject);
    procedure dxBarLargeButton7Click(Sender: TObject);
    procedure dxBtnTipoStatusClick(Sender: TObject);
    procedure dxBtnTipoAcrescimosClick(Sender: TObject);
    procedure dxBtnTipoDeducoesClick(Sender: TObject);
    procedure dxBtnTipoSacadoClick(Sender: TObject);
    procedure dxBtnTipoCedenteClick(Sender: TObject);
    procedure dxBtnTipoCobrancaClick(Sender: TObject);
    procedure dxBtnTipoNFClick(Sender: TObject);
    procedure dxBtnTipoTOBClick(Sender: TObject);
    procedure dxBtnContasBancariasClick(Sender: TObject);
    procedure dxBarLargeButton10Click(Sender: TObject);
    procedure dxBtnHistoricoClick(Sender: TObject);
    procedure dxBarLargeButton9Click(Sender: TObject);
    procedure dxBtrnCedenteClick(Sender: TObject);
    procedure dxBtrnSacadoClick(Sender: TObject);
    procedure dxBtnReciboTPClick(Sender: TObject);
    procedure dxBarValidadorClick(Sender: TObject);
    procedure dxBtnReciboTRClick(Sender: TObject);
    procedure dxBtnCartaoCreditoClick(Sender: TObject);
    procedure dxBtnBaixaTPClick(Sender: TObject);
    procedure dxBtnGeraChequeClick(Sender: TObject);
    procedure dxBtnFuncionarioClick(Sender: TObject);
    procedure dxBtnBaixaLoteTPClick(Sender: TObject);
    procedure dxBtnBaixaTRClick(Sender: TObject);
    procedure dxBtnUsuarioClick(Sender: TObject);
    procedure dxBarBtnLotePagamentoClick(Sender: TObject);
    procedure dxBarBtnEstornaClick(Sender: TObject);
    procedure dxBarLargeButton11Click(Sender: TObject);
    procedure dxBarBtnRelCTRClick(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure dxBarBtnLogErroClick(Sender: TObject);
    procedure dxBtnDemoDespesasClick(Sender: TObject);
    procedure dxBarBtnGerarCH2Click(Sender: TObject);
    procedure dxBarBtnEspelhoCHClick(Sender: TObject);
    procedure dxBarBtnListarCHClick(Sender: TObject);
    procedure dxBtnCentroCustoClick(Sender: TObject);



  private
    { Private declarations }
    numberError: string;
    pid: string;
    BDConectado, userValidado: Boolean;
    FsListaIdOrganizacoes: TStringList;
    FsListaIdUsuarios: TStringList;
    FsListaIdEstados: TStringList;
    FsListaIdCidades: TStringList;
    FsListaIdBairros: TStringList;
    horaInicioUSo :string;
    horaAtual: string;
    exibePanel :Integer;
    versaoWeb :string;
    ajustaFormLigado : Boolean;
    usuarioAdm :Integer;
    idOrgUser :string;
    usuario  : TUsuarioModel;
    Isdebug :Boolean;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure AjustaForm;
    procedure serverMail(pIdOrganizacao :string);
    procedure preenchePanelMain;
    function carregarDadosEmpresaMega(pCnpj: string): Boolean;
    procedure selectOrganizacao(pIdOrganizacao: string);
    procedure aDesenvolver;
    procedure preencheBarraDados;
    procedure loginAutomatico;
    function getIPs: Tstrings;
    function TIPreal: String;
    procedure atualizar;
    procedure atualizarVersaoBD;
    function getVersaoWEB: string;

  public
    { Public declarations }
    orgAtual: TOrganizacao;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}




procedure TFrmPrincipal.acessoMenu(value: Boolean);
var
  poItem: TdxRibbonTab;
  I: Integer;
begin
  begin
      for I := 0 to dxRibbon1.TabCount -1 do begin
       dxRibbon1.Tabs[I].Visible := value;
      end;
  end;

  dxRibbon1.TabOrder :=0;

end;

procedure TFrmPrincipal.btnLoginClick(Sender: TObject);
var
  loMostraErros: TFMostraErros;


  aux : Integer;
begin
  aux := 0;

  if chkSavePass.Checked then
  begin
    if not PempecMsg.MsgConfirmation('Voc� tem certeza que gostaria de salvar seus dados de login neste computador? ' + #13 + ' Caso aceite, sua decis�o poder� ser revertida em Par�metros->Usuario .') = 6 then
    begin
      chkSavePass.Checked := False;
    end;
  end;

 if not userValidado then //vai processar o login normal
  begin

    if not uUtil.Empty(usuario.Flogin) then
    begin
      usuario := TUsuarioDAO.obterPorID(usuario);
       usuario.FloginAutomatico := False;
    end;
    usuario.Flogin := edtLogin.Text;
    usuario.Fsenha := edtPassword.Text;

    if not uutil.Empty(usuario.Flogin) then
    begin
      if not uutil.Empty(usuario.Fsenha) then
      begin
        if TUsuarioDAO.validarLogin(usuario) then
        begin
          usuario := TUsuarioDAO.obterPorID(usuario);
           usuario.FloginAutomatico := False;

          if not uUtil.Empty(usuario.Flogin) then
          begin

            userValidado := True;
            idOrgUser := usuario.FIDorganizacao;
            usuarioAdm := usuario.Fadmin;


            uUtil.TUserAtual.setId(IntToStr(usuario.FID));
            uUtil.TUserAtual.setLogin(usuario.Flogin);
            uUtil.TUserAtual.setNameUser(usuario.Fnome);

            if not IsToday(TUsuarioDAO.obterUltimoAcesso(usuario)) then
            begin

              usuario.FipHost := uutil.GetIp;
              usuario.FnameHost := uutil.GetComputerNetName;
              usuario.FuserWindows := uutil.GetUserFromWindows;
              usuario.FloginAutomatico := chkSavePass.Checked;

              TUsuarioDAO.registrarAcesso(usuario);

            end;

            //salvando a decisao do usuario em LA
            if chkSavePass.Checked then begin
               usuario.FipHost := uutil.GetIp;
              usuario.FnameHost := uutil.GetComputerNetName;
              usuario.FuserWindows := uutil.GetUserFromWindows;
              usuario.FloginAutomatico := chkSavePass.Checked;
              TUsuarioDAO.registrarAcesso(usuario);
            end;



          end;
        end;
      end;

    end;
  end;


   // idOrgUser :=  dmUsuarioConsulta.qryValidarUsuario.FieldByName('ID_ORGANIZACAO').AsString;
   // usuarioAdm := dmUsuarioConsulta.qryValidarUsuario.FieldByName('ADM').AsInteger;


  if  (userValidado) then
  begin
   if uutil.Empty(idOrgUser) then begin  //se o usuario nao tiver id_organizacao, abre a tela para escolher.

      try

        frmSelectOrganizacao := TfrmSelectOrganizacao.Create(Self);
        frmSelectOrganizacao.ShowModal;

        if not uUtil.Empty(frmSelectOrganizacao.getOrganizacao.FID) then
        begin
          uutil.TOrgAtual.setOrganizacao(frmSelectOrganizacao.getOrganizacao);
          uutil.setDataServer(uVarGlobais.GetDataHoraServidorBD(dmConexao.conn));



          uutil.getDataServer;

        end;

        FreeAndNil(frmSelectOrganizacao);

    except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
    end;

    end
    else
    begin
      try
        selectOrganizacao(idOrgUser);

      except
        on e: Exception do
          PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');

      end;

    end;

    dmOrganizacao.obterDataServidor;  // seta a data atual originada do server de banco de dados



    edtLogin.Enabled := False;
    edtPassword.Enabled := False;
    edtLogin.Text := '';
    edtPassword.Text := '';

      //setando os dados para envio de email
        serverMail(uUtil.TOrgAtual.getId);


    //    PreencheGridPanel;
    exibePanel := dmParametros.obterStatusTela('TA011');


    if exibePanel > 0 then begin


        if not Assigned(frmPosicaoFinanceira)  then begin
         frmPosicaoFinanceira := TfrmPosicaoFinanceira.Create(Self);
          frmPosicaoFinanceira.ShowModal;
          FreeAndNil(frmPosicaoFinanceira)

        end;
    end;  
        //esconde o login
              pnlMain.Visible := true;
              img1.Visible := False;
              lblLogin.Visible := False;
              lbl2.Visible := False;
              lbl3.Visible := False;
              chkSavePass.Visible := False;

              preenchePanelMain;



    pnlMain.Align := alClient;
//     lblHoraAcesso.Caption := TUserAtual.getNameUser + ' logou em : '+  horaInicioUSo ;

     preencheBarraDados;
      dxStatusBar1.Panels[0].Text := TUserAtual.getNameUser + ' logou em : ' + horaInicioUSo;
     if usuarioAdm > 0 then begin
//     lblHoraAcesso.Caption := TUserAtual.getNameUser + ' logou em : '+  horaInicioUSo  + '  Administrador ';
      dxStatusBar1.Panels[0].Text := TUserAtual.getNameUser + ' logou em : ' + horaInicioUSo;
      dxStatusBar1.Panels[1].Text := 'Administrador';

     end;

  end
  else
  begin
   // cbxOrganizacoes.Enabled := False;
    //lblSelectOrg.Visible := False;
   // lblBoasVindas.Visible := False;
      edtPassword.Text := '';
    //PempecMsg.MsgInformation('Login/Senha incorretos.');
   // if Assigned(usuario) then begin FreeAndNil(usuario); end;
    //usuario := TUsuarioModel.Create;
    PempecMsg.MsgInformation('Login/Senha incorretos.' );

  end;



end;



procedure TFrmPrincipal.Zoom(Sender: TObject);
begin
  if not ajustaFormLigado then
  begin
    ajustaFormLigado := True;
    AjustaForm;
    btnZoom.Caption := 'Ligado';
  end
  else
  begin
    ajustaFormLigado := False;
     AjustaForm;
    btnZoom.Caption := 'Desligado';
  end;
end;


procedure TFrmPrincipal.cbxUsuarioChange(Sender: TObject);
var
  cnpj: string;
  indice: Integer;
begin
    //desenvolver
  acessoMenu(false);
  uUtil.TUserAtual.setId('');
  userValidado := False;
  btnLogin.Enabled := False;

  if (cbxUsuario.ItemIndex > (-1)) then
  begin
    //obter usuario selecionado
    indice := (cbxUsuario.ItemIndex);
    pid := FsListaIdUsuarios[indice];

    if not (indice = 0 ) then begin

     usuario := TUsuarioModel.Create;
     usuario.FID :=  StrToInt(pid);
     usuario :=  TUsuarioDAO.obterPorID(usuario);

          // dmUsuarioConsulta.obterUsuarioPorID(StrToInt(pid));
     //libera os botoes de login e senha
      edtLogin.Enabled := True;
      edtPassword.Enabled := True;
      btnLogin.Enabled := True;

    end
    else
    begin
      PempecMsg.MsgInformation('Usu�rio n�o localizado... Selecione um usu�rio...');
    end;

  end;

end;

procedure TFrmPrincipal.cbxUsuarioClick(Sender: TObject);
begin
if( cbxUsuario.ItemIndex < 0) then begin

   PempecMsg.MsgInformation('Sele��o inv�lida!!!!');
end;
end;



procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//freeAndNilDM(Self);
//Action := Cafree;
//lblPathSGBD.Caption := '';
  uUtil.LimpaTela(Self);

end;


procedure TFrmPrincipal.dxBarBackupClick(Sender: TObject);
begin

 try

    frmBackup := TFrmBackup.Create(Self);
    frmBackup.ShowModal;
    FreeAndNil(frmBackup);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBarBtnEspelhoCHClick(Sender: TObject);
begin
//tela mostra os dados de um cheque
//memo apresenta o campo observa��o do cheque
// o espelho tem impressao do espelho

  frmEspelhoCheques := TfrmEspelhoCheques.Create(Self);
  frmEspelhoCheques.ShowModal;
  FreeAndNil(frmEspelhoCheques);


// PempecMsg.MsgInformation('Desculpe! Funcionalidade n�o dispon�vel.');



end;

procedure TFrmPrincipal.dxBarBtnEstornaClick(Sender: TObject);
begin

  numberError := '1404-EstornaCH';

  try
    frmEstornaCheque := TFrmEstornaCheque.Create(Self);
    frmEstornaCheque.ShowModal;
    FreeAndNil(frmEstornaCheque);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;



end;

procedure TFrmPrincipal.dxBarBtnExportMegaClick(Sender: TObject);
begin
 //verifica se tem vers�o nova.
  numberError := '1032';

  if uUtil.IsInternetConected then
  begin
   dxEdtVersaoWeb.Text := getVersaoWEB;

    if not uutil.TOrgAtual.isAtualizar then
    begin

      try

        frmExportacao := TfrmExportacao.Create(Self);
        frmExportacao.ShowModal;
        FreeAndNil(frmExportacao);

      except
        on e: Exception do
          PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
      end;

    end else begin PempecMsg.MsgInformation('O sistema precisa ser atualizado primeiro.'); end;

  end else begin PempecMsg.MsgInformation('Verifique suas conex�es com a internet.'); end;
end;

procedure TFrmPrincipal.dxBarBtnGerarCH2Click(Sender: TObject);
begin

try
    frmGerarCheques := TFrmGerarCheques.Create(Self);
    frmGerarCheques.ShowModal;
    FreeAndNil(frmGerarCheques);
except

on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: GERADOR CHEQUES') ;
end;




end;

procedure TFrmPrincipal.dxBarBtnListarCHClick(Sender: TObject);
begin
//montar script
//pede a conta bancaria ou todas.
//pede o status ou todos
//status default 'EMITIDO'
//data de inicio e fim para o per�odo
//fazer o FR3

PempecMsg.MsgInformation('Desculpe! Funcionalidade n�o dispon�vel.');


end;

procedure TFrmPrincipal.dxBarBtnLogErroClick(Sender: TObject);
begin

   try

    frmMostrarLogErro := TfrmMostrarLogErro.Create(Self);
    frmMostrarLogErro.ShowModal;
    FreeAndNil(frmMostrarLogErro);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;



end;

procedure TFrmPrincipal.dxBarBtnLotePagamentoClick(Sender: TObject);
begin
atualizar;
 numberError := 'REL-LOTE_Pag-1';
  try
    fmTelaImpressaoLotePagamento := TfmTelaImpressaoLotePagamento.Create(Self,'');
    fmTelaImpressaoLotePagamento.ShowModal;
    FreeAndNil(fmTelaImpressaoLotePagamento);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBarBtnRelCTRClick(Sender: TObject);
begin

  numberError := '2020 - REL_TR';

  try
    frmRelatorioRecebimentos := TfrmRelatorioRecebimentos.Create(Self);
    frmRelatorioRecebimentos.ShowModal;
    FreeAndNil(frmRelatorioRecebimentos);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;






end;

procedure TFrmPrincipal.dxBarCancelExportClick(Sender: TObject);
begin

  numberError := '1046';
  dxEdtVersaoWeb.Text := getVersaoWEB;

  try
    frmDeletaLoteContabil := TfrmDeletaLoteContabil.Create(Self);
    frmDeletaLoteContabil.ShowModal;
    FreeAndNil(frmDeletaLoteContabil);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBarLargeButton10Click(Sender: TObject);
begin
 numberError := 'FrmHist-01';
  try

    frmHistorico:= TfrmHistorico.Create(Self);
    frmHistorico.ShowModal;
    FreeAndNil(frmHistorico);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBarLargeButton11Click(Sender: TObject);
var msgPadrao :string;

org : TOrganizacaoModel;
begin
  msgPadrao := 'N�o foi poss�vel obter as informa��es. ' + #13 + ' Por favor, tente novamente mais tarde. ' ;

  org := TOrganizacaoModel.Create;
  org.FID := uutil.TOrgAtual.getId;

  org := TOrganizacaoDAO.obterPorID(org);

  if not uUtil.Empty(org.FID) then begin

   uutil.TOrgAtual.setOrganizacao(org);

  end;



  if uutil.IsInternetConected then

  begin


    msgPadrao := 'Sistema atualizado';

    if uutil.TOrgAtual.isAtualizar then

    begin
      msgPadrao := 'Existem novas atualiza��es. ' + #13 + ' Acesse o site www.pempec.com.br para baixar. ';

      try
        frmInfoUpdate := TfrmInfoUpdate.Create(Self);
        frmInfoUpdate.ShowModal;
        FreeAndNil(frmInfoUpdate);

      except
        on e: Exception do
          PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
      end;

    end
    else
    begin
      PempecMsg.MsgWarning(msgPadrao);
    end;
  end;

end;

procedure TFrmPrincipal.dxBarLargeButton2Click(Sender: TObject);
begin

numberError := 'MANTER_TR-1044';

  try
    frmManterTituloReceber := TFrmManterTituloReceber.Create(Self);
    frmManterTituloReceber.ShowModal;
    FreeAndNil(frmManterTituloReceber);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.dxBarLargeButton3Click(Sender: TObject);
begin

  numberError := 'ALT-TR-1044';
  try
    frmAlteraNumDocTR := TfrmAlteraNumDocTR.Create(Self);
    frmAlteraNumDocTR.ShowModal;
    FreeAndNil(frmAlteraNumDocTR);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.dxBarLargeButton4Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TFrmPrincipal.dxBarLargeButton5Click(Sender: TObject);
begin
  numberError := 'FrmHist-01';
  try
    frmHistorico:= TfrmHistorico.Create(Self);
    frmHistorico.ShowModal;
    FreeAndNil(frmHistorico);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBarLargeButton6Click(Sender: TObject);
begin
  try
      frmLoteDeposito := TFrmLoteDeposito.Create(Self);
      frmLoteDeposito.ShowModal;
      FreeAndNil(frmLoteDeposito);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;

procedure TFrmPrincipal.dxBarLargeButton7Click(Sender: TObject);
begin
 aDesenvolver;
end;

procedure TFrmPrincipal.dxBarLargeButton8Click(Sender: TObject);
begin
     try
      frmExtratoTesouraria := TfrmExtratoTesouraria.Create(Self);
      frmExtratoTesouraria.ShowModal;
      FreeAndNil(frmExtratoTesouraria);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TFrmPrincipal.dxBarLargeButton9Click(Sender: TObject);
begin

aDesenvolver;
{
  try
      frmImobilizado := TFrmImobilizado.Create(Self);
      frmImobilizado.ShowModal;
      FreeAndNil(frmImobilizado);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;
         }

end;

procedure TFrmPrincipal.dxBtnRelDemoCCClick(Sender: TObject);
begin

  try
      frmDemonstrativoRD := TFrmDemonstrativoRD.Create(Self);
      frmDemonstrativoRD.ShowModal;
      FreeAndNil(frmDemonstrativoRD);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;

procedure TFrmPrincipal.dxBtnRelExtratoBancarioClick(Sender: TObject);
begin
  numberError := '1049';
  try
    frmExtratoBancario := TfrmExtratoBancario.Create(Self);
    frmExtratoBancario.ShowModal;
    FreeAndNil(frmExtratoBancario);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;



procedure TFrmPrincipal.dxBtnRelSDContasClick(Sender: TObject);
begin

numberError := 'SD-BCO-10';
  try
    frmSaldoContas := TfrmSaldoContas.Create(Self);
    frmSaldoContas.ShowModal;
    FreeAndNil(frmSaldoContas);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnCompensarChequeClick(Sender: TObject);
begin
 // compensar cheques de uma determinada conta
  numberError := '1047';
  try
    frmCompensaCheque := TfrmCompensaCheque.Create(Self);
    frmCompensaCheque.ShowModal;
    FreeAndNil(frmCompensaCheque);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtbTrfCxChqClick(Sender: TObject);
begin

//deposito em cheques da tesouraria

 try
     frmDepositoCheque:= TfrmDepositoCheque.Create(Self);
     frmDepositoCheque.ShowModal;
     FreeAndNil(frmDepositoCheque);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;



end;

procedure TFrmPrincipal.dxBtbTrfCxDinClick(Sender: TObject);
begin

 try
     frmTransferenciasCaixaBanco:= TfrmTransferenciasCaixaBanco.Create(Self);
     frmTransferenciasCaixaBanco.ShowModal;
     FreeAndNil(frmTransferenciasCaixaBanco);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBtnTipoAcrescimosClick(Sender: TObject);
begin
  numberError := 'TIPO_ACR - 104098';
  Try
    frmManterTipoAcrescimo := TfrmManterTipoAcrescimo.Create(Self);
    frmManterTipoAcrescimo.ShowModal;
    FreeAndNil(frmManterTipoAcrescimo);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnTipoCedenteClick(Sender: TObject);
begin

 numberError := 'TP_CEDENTE-1045';
  try
    frmManterTipoCedente := TfrmManterTipoCedente.Create(Self);
    frmManterTipoCedente.ShowModal;
    FreeAndNil(frmManterTipoCedente);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnTipoCobrancaClick(Sender: TObject);
begin

 numberError := 'TP_COBRANCA - 1045';
  try
    frmManterTipoCobranca := TfrmManterTipoCobranca.Create(Self);
    frmManterTipoCobranca.ShowModal;
    FreeAndNil(frmManterTipoCobranca);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnTipoDeducoesClick(Sender: TObject);
begin
  numberError := 'TIPO_DED - 10408';
  try
    frmManterTipoDeducao := TfrmManterTipoDeducao.Create(Self);
    frmManterTipoDeducao.ShowModal;
    FreeAndNil(frmManterTipoDeducao);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnTipoNFClick(Sender: TObject);
begin
numberError := 'TP_NF - 10401';
  try
    frmManterTipoNotaFiscal := TfrmManterTipoNotaFiscal.Create(Self);
    frmManterTipoNotaFiscal.ShowModal;
    FreeAndNil(frmManterTipoNotaFiscal);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;


procedure TFrmPrincipal.dxBtnAlteraSkinClick(Sender: TObject);
begin
  frmSkin := TfrmSkin.Create(Self);
  frmSkin.ShowModal;
  FreeAndNil(frmSkin);

end;

procedure TFrmPrincipal.dxBtnBaixaLoteTPClick(Sender: TObject);
begin

   numberError := 'BX-TP-LOTE-1';
  try
    frmPagamentoLoteTitulos := TfrmPagamentoLoteTitulos.Create(Self);
    frmPagamentoLoteTitulos.ShowModal;
    FreeAndNil(frmPagamentoLoteTitulos);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;



end;

procedure TFrmPrincipal.dxBtnBaixaTPClick(Sender: TObject);
begin

  numberError := 'BX-TP-1049';
  try
    frmPagamentoTitulos := TfrmPagamentoTitulos.Create(Self);
    frmPagamentoTitulos.ShowModal;
    FreeAndNil(frmPagamentoTitulos);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnBaixaTRClick(Sender: TObject);
begin
    //baia de titulos a receber
  numberError := 'BX-TR-1';
  try
    frmRecebimentoTitulos := TfrmRecebimentoTitulos.Create(Self);
    frmRecebimentoTitulos.ShowModal;
    FreeAndNil(frmRecebimentoTitulos);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnCadastroTPClick(Sender: TObject);
begin
  numberError := '1040';

  frmManterTituloPagar := TfrmManterTituloPagar.Create(Self);
  frmManterTituloPagar.ShowModal;
  FreeAndNil(frmManterTituloPagar);

end;

procedure TFrmPrincipal.dxBtnCartaoCreditoClick(Sender: TObject);
begin
  try
    frmManterCartaoCredito := TfrmManterCartaoCredito.Create(Self);
    frmManterCartaoCredito.ShowModal;
    FreeAndNil(frmManterCartaoCredito);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnCentroCustoClick(Sender: TObject);
begin
numberError := 'MANTER-CC_01';

  try
    frmManterCentroCusto := TfrmManterCentroCusto.Create(Self);
    frmManterCentroCusto.ShowModal;
    FreeAndNil(frmManterCentroCusto);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnCompensarDiversosChsClick(Sender: TObject);
begin
 numberError := 'COMP-MULT-CH-1048';

//tela de multipplos cheques

    try
    frmMultiplosCheques := TfrmMultiplosCheques.Create(Self);
    frmMultiplosCheques.ShowModal;
    FreeAndNil(frmMultiplosCheques);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnConfigEmailClick(Sender: TObject);
begin
 numberError := '1036';
  try
    frmServidorEmail := TfrmServidorEmail.Create(Self);
    frmServidorEmail.ShowModal;
    FreeAndNil(frmServidorEmail);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.dxBtnContasBancariasClick(Sender: TObject);
begin
  numberError := 'ManterCB_01';

  try
    frmManterContaBancaria := TFrmManterContaBancaria.Create(Self);
    frmManterContaBancaria.ShowModal;
    FreeAndNil(frmManterContaBancaria);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBtnDemoDespesasClick(Sender: TObject);
begin

 try
    frmDemonstrativoDespesasCC := TfrmDemonstrativoDespesasCC.Create(Self);
    frmDemonstrativoDespesasCC.ShowModal;
    FreeAndNil(frmDemonstrativoDespesasCC);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;



end;

procedure TFrmPrincipal.dxBtnEspelhoTPClick(Sender: TObject);
begin
 numberError := 'ESPELHO_01';


  try
    formEspelhoTP := TformEspelhoTP.Create(Self,'0');
    formEspelhoTP.ShowModal;
    FreeAndNil(formEspelhoTP);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

 atualizar;

end;

procedure TFrmPrincipal.dxBtnFuncionarioClick(Sender: TObject);
begin

try
    frmManterFuncionario := TFrmManterFuncionario.Create(Self);
    frmManterFuncionario.ShowModal;
    FreeAndNil(frmManterFuncionario);
except

on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: MANTER FUNC ');
end;
end;

procedure TFrmPrincipal.dxBtnGeraChequeClick(Sender: TObject);
begin


try
    frmGerarCheques := TFrmGerarCheques.Create(Self);
    frmGerarCheques.ShowModal;
    FreeAndNil(frmGerarCheques);
except

on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: GERADOR CHEQUES') ;
end;




end;

procedure TFrmPrincipal.dxBtnHistoricoClick(Sender: TObject);
begin

try
    frmManterHistorico := TfrmManterHistorico.Create(Self);
    frmManterHistorico.ShowModal;
    FreeAndNil(frmManterHistorico);
except

on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: MANTER_HIST ') ;
end;

end;

procedure TFrmPrincipal.aDesenvolver();
begin
 PempecMsg.MsgInformation('Estamos trabalhando para melhorar essa funcionalidade. Por favor, aguarde.');
end;

procedure TFrmPrincipal.dxBarManutencaoClick(Sender: TObject);
begin
 numberError := '1038';

  try
    frmManutencao := TfrmManutencao.Create(Self);
    frmManutencao.ShowModal;
    FreeAndNil(frmManutencao);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBarRegistroClick(Sender: TObject);
begin

 numberError := '1035';
  try
    frmRegistro := TfrmRegistro.Create(Self);
    frmRegistro.ShowModal;
    FreeAndNil(frmRegistro);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBarValidadorClick(Sender: TObject);
begin
 PempecMsg.MsgInformation('Em desenvolvimento');
end;

procedure TFrmPrincipal.dxBtnImportClick(Sender: TObject);
begin
  numberError := '1033';
  try
    frmImportar := TfrmImportar.Create(Self);
    frmImportar.ShowModal;
    FreeAndNil(frmImportar);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnMegaSincronizarClick(Sender: TObject);
begin
 numberError := '1050';
  try
   dxEdtVersaoWeb.Text := getVersaoWEB;

    atualizar;
    frmSincronizaMega := TfrmSincronizaMega.Create(self);
    frmSincronizaMega.ShowModal;
    FreeAndNil(frmSincronizaMega);
  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.dxBtnReciboTPClick(Sender: TObject);
begin

  try
      frmReciboTP := TFrmReciboTP.Create(Self);
      frmReciboTP.ShowModal;
      FreeAndNil(frmReciboTP);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TFrmPrincipal.dxBtnReciboTRClick(Sender: TObject);
begin


  try
      frmReciboTR := TFrmReciboTR.Create(Self);
      frmReciboTR.ShowModal;
      FreeAndNil(frmReciboTR);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TFrmPrincipal.dxBtnRelCTPClick(Sender: TObject);
begin

  try
      frmRelatorioPagamentos := TfrmRelatorioPagamentos.Create(Self);
      frmRelatorioPagamentos.ShowModal;
      FreeAndNil(frmRelatorioPagamentos);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;


procedure TFrmPrincipal.dxBtnRelTPHistoricoClick(Sender: TObject);
begin

  try
      frmCTPHistorico := TfrmCTPHistorico.Create(Self);
      frmCTPHistorico.ShowModal;
      FreeAndNil(frmCTPHistorico);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;



procedure TFrmPrincipal.dxBtnTipoSacadoClick(Sender: TObject);
begin


numberError := 'TP_SACADO-1045';
  try
    frmManterTipoSacado := TfrmManterTipoSacado.Create(Self);
    frmManterTipoSacado.ShowModal;
    FreeAndNil(frmManterTipoSacado);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;



end;

procedure TFrmPrincipal.dxBtnTipoStatusClick(Sender: TObject);
begin

   try
     frmManterTipoStatus:= TfrmManterTipoStatus.Create(Self);
     frmManterTipoStatus.ShowModal;
     FreeAndNil(frmManterTipoStatus);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;




end;

procedure TFrmPrincipal.dxBtnTipoTOBClick(Sender: TObject);
begin


 try
     frmManterTOB:= TfrmManterTOB.Create(Self);
     frmManterTOB.ShowModal;
     FreeAndNil(frmManterTOB);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBtnTRFBCOCAIXAClick(Sender: TObject);
begin

 try
     frmTransferenciasBancoCaixa:= TfrmTransferenciasBancoCaixa.Create(Self);
     frmTransferenciasBancoCaixa.ShowModal;
     FreeAndNil(frmTransferenciasBancoCaixa);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TFrmPrincipal.dxBtnTRProvisaoClick(Sender: TObject);
begin
aDesenvolver;
end;

procedure TFrmPrincipal.dxBtnUsuarioClick(Sender: TObject);
begin
 try
     frmManterUsuario := TfrmManterUsuario.Create(Self);
     frmManterUsuario.ShowModal;
     FreeAndNil(frmManterUsuario);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBtrnCedenteClick(Sender: TObject);
begin

 try
     frmManterCedente := TfrmManterCedente.Create(Self);
     frmManterCedente.ShowModal;
     FreeAndNil(frmManterCedente);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBtrnSacadoClick(Sender: TObject);
begin

 try
     frmManterSacado := TfrmManterSacado.Create(Self);
     frmManterSacado.ShowModal;
     FreeAndNil(frmManterSacado);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;



end;

procedure TFrmPrincipal.dxTRFBCOBCOClick(Sender: TObject);
begin

 try
     frmTransferenciasEntreContas := TfrmTransferenciasEntreContas.Create(Self);
     frmTransferenciasEntreContas.ShowModal;
     FreeAndNil(frmTransferenciasEntreContas);

  except on e: Exception do
    PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
  end;



end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
alignTop :Integer;
begin
  Isdebug :=False;
{$IFDEF DEBUG}
 // ReportMemoryLeaksOnShutDown := IsDebuggerPresent();
   Isdebug :=True;

{$ENDIF}

  uUtil.LimpaTela(Self);
  stat1.Panels[0].Text := 'Vers�o: ' + GetVersionInfo(Application.ExeName);
  stat1.Panels[6].Text := 'Hora  : ' + horaInicioUSo;
  dxEdtVersaoWeb.Text := '';
  ajustaFormLigado :=False;
  inicializarDM(Self);
//  acessoMenu(false);
  edtLogin.Enabled := False;
  edtPassword.Enabled := False;
  lblPathSGBD.Caption := '';
  lbl2.Caption := 'Usu�rio';
  lblLogin.Caption := 'Login';
  lbl3.Caption := 'Senha';
  acessoMenu(false);
  btnZoom.Visible := False;
  pnlMain.Visible := false;
  alignPanelLogin(Self);

  horaInicioUSo := DateTimeToStr(now);
  //lblHoraAcesso.Caption := TUserAtual.getNameUser + ' logou em : '+  horaInicioUSo ;
  dxStatusBar1.Panels[0].Text := TUserAtual.getNameUser + ' logou em : ' + horaInicioUSo;
  dxStatusBar1.Panels[2].Text :=  'IP ' + uutil.GetIp;

  skm.SkinDirectory :='';
  exibePanel := 1;

  //##definindo o skin padrao para iniciar
  skm.SkinDirectory := ExtractFilePath(Application.ExeName) + 'Skins';
  skm.SkinName := uUtil.obterSkinDefault(skm.SkinDirectory);
     //Seta o endere�o dos skins para o lstSkin (TFileListBox)
  //  fllstSkin.Directory := skm.SkinDirectory; implementar tela p mudar o skin

  if uutil.Empty(skm.SkinName) then begin
   skm.SkinName := uUtil.obterSkinDefault('C:\Windows\schemas\Skins');
  end;

  if uutil.Empty(skm.SkinName) then begin
   skm.SkinName := uUtil.obterSkinDefault('D:\Windows\schemas\Skins');
  end;

  if uutil.Empty(skm.SkinName) then begin
   skm.SkinName := uUtil.obterSkinDefault('D:\Skins');
  end;
   skm.Active := True;
   skm.SkinnedPopups := False ; //libera menu sem skin
      //seta o skin definido no config.in

 application.icon.loadfromfile(ExtractFilePath(Application.ExeName)+'Finance_Icon.ico');
 loginAutomatico;


end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if ((Shift = [ssCtrl]) and (Key = VK_F10)) then
  begin
    if not (Assigned(frmRegistraBaseDados)) then
    begin
      frmRegistraBaseDados := TfrmRegistraBaseDados.Create(Self);
      frmRegistraBaseDados.ShowModal;
      FreeAndNil(frmRegistraBaseDados);
    end;
  end;

  if Key = VK_F5 then
  begin
    try

      frmSelectOrganizacao := TfrmSelectOrganizacao.Create(Self);
      frmSelectOrganizacao.ShowModal;
      FreeAndNil(frmSelectOrganizacao);

      preenchePanelMain;

    except
      on e: Exception do
        PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o administrador!');
    end;

  end;

  if Key = VK_RETURN then
  begin
    btnLogin.Click;
  end;

end;



procedure TFrmPrincipal.serverMail(pIdOrganizacao: string);
var
conta, senha, host, porta, autentica :string;

begin
// Added by adm 23/09/2019 11:51:54
    dmServerMail.obterDadosServidorEmail(pIdOrganizacao);

    if not dmServerMail.qryObterDadosMail.IsEmpty then begin

      conta     := dmServerMail.qryObterDadosMail.FieldByName('LOGIN').AsString;
      senha     := dmServerMail.qryObterDadosMail.FieldByName('SENHA').AsString;
      host      := dmServerMail.qryObterDadosMail.FieldByName('HOST').AsString;
      porta     := dmServerMail.qryObterDadosMail.FieldByName('PORTA').AsString;
      autentica := IntToStr(dmServerMail.qryObterDadosMail.FieldByName('REQUER_AUTENTICACAO').AsInteger);

      // inicializa as variaveis do host do email a ser enviado.
         uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);
         uUtil.TOrgAtual.getOrganizacao.FemailSuporte := 'suporte@pempec.com.br';

    end;


end;

procedure TFrmPrincipal.tmrrelogioTimer(Sender: TObject);
begin

 stat1.Panels[6].Text := DateTimeToStr(Now);


end;

procedure TFrmPrincipal.Atualizar1Click(Sender: TObject);
begin
  numberError := '1037';
  try
    frmUpdate := TfrmUpdate.Create(Self);
    frmUpdate.ShowModal;
    FreeAndNil(frmUpdate);

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.inicializarDM(Sender: TObject);
begin

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    BDConectado :=False;

    try
    BDConectado := dmConexao.conectarBanco;

    except
     on E: Exception do
      PempecMsg.MsgInformation(' '+ e.Message);
     end;
  end;


   if not BDConectado then begin
      if not (Assigned(frmRegistraBaseDados)) then
         begin
             frmRegistraBaseDados := TfrmRegistraBaseDados.Create(Self);
             frmRegistraBaseDados.ShowModal;
             FreeAndNil(frmRegistraBaseDados);
         end;

   end;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;
  if not (Assigned(dmManutencao)) then
  begin
    dmManutencao := TdmManutencao.Create(Self);
  end;

  if not (Assigned(dmCombos)) then
  begin
    dmCombos := TdmCombos.Create(Self);
  end;

  if not (Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end;

  if not (Assigned(dmUsuarioConsulta)) then
  begin
    dmUsuarioConsulta := TdmUsuarioConsulta.Create(Self);
  end;

  if not (Assigned(dmServerMail)) then
  begin
    dmServerMail := TdmServerMail.Create(Self);
  end;


  if BDConectado then
  begin

    if dmUsuarioConsulta.carregarUsuarios then
    begin
      dmCombos.listaUsuario(cbxUsuario, FsListaIdUsuarios);
    end;
  end ;


   if not (Assigned(dmParametros)) then
  begin
    dmParametros := TdmParametros.Create(Self);
  end;

   if not(Assigned(frmCTPHistorico)) then
  begin
    frmCTPHistorico := TfrmCTPHistorico.Create(Self);
  end;


  if not(Assigned(frmRelatorioPagamentos)) then
  begin
    frmRelatorioPagamentos := TfrmRelatorioPagamentos.Create(Self);
  end;


  if not(Assigned(frmDemonstrativoRD)) then
  begin
    frmDemonstrativoRD := TfrmDemonstrativoRD.Create(Self);
  end;



  //fim




end;



procedure TFrmPrincipal.loginAutomatico;
var
usuarioModel :TUsuarioModel;
begin
   userValidado := False;
   usuarioModel := TUsuarioModel.Create;
  // usuarioModel.FloginAutomatico := False;

   usuarioModel.FipHost := uutil.GetIp;
   usuarioModel.FnameHost := uutil.GetComputerNetName;
   usuarioModel.FuserWindows := uutil.GetUserFromWindows;


    usuario := TUsuarioDAO.validarLoginAutomatico(usuarioModel);


  if usuario.Fativo > 0 then
    begin

    if usuario.FloginAutomatico then
    begin

      userValidado := True;
      usuarioAdm := usuario.Fadmin;
      idOrgUser := usuario.FIDorganizacao;

      uUtil.TUserAtual.setId(IntToStr(usuario.FID));
      uUtil.TUserAtual.setLogin(usuario.Flogin);
      uUtil.TUserAtual.setNameUser(usuario.Fnome);

      usuario.FipHost := uutil.GetIp;
      usuario.FnameHost := uutil.GetComputerNetName;
      usuario.FuserWindows := uutil.GetUserFromWindows;

      if not usuario.FloginAutomatico then
      begin
        usuario.FipHost := '';
        usuario.FnameHost := '';
        usuario.FuserWindows := '';
      end;

      TUsuarioDAO.registrarAcesso(usuario);

      cbxUsuario.Clear;

      FsListaIdUsuarios := TStringList.Create;
      FsListaIdUsuarios.Clear;
      FsListaIdUsuarios.Add(IntToStr(usuario.FID));

      cbxUsuario.Items.Add(UpperCase(usuario.Fnome));
      cbxUsuario.ItemIndex := 0;
      btnLogin.Click;

    end else begin usuario.FloginAutomatico := False; end ;



  end else begin  usuario.FloginAutomatico := False; end;


end;

procedure TFrmPrincipal.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmConexao)) then
  begin
    FreeAndNil(dmConexao);
  end;

  if (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

  if (Assigned(dmOrganizacao)) then
  begin
    FreeAndNil(dmOrganizacao);
  end;

  if (Assigned(dmUsuarioConsulta)) then
  begin
    FreeAndNil(dmUsuarioConsulta);
  end;

  if (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;

  if (Assigned(dmExportaFinance)) then
  begin
    FreeAndNil(dmExportaFinance);
  end;

  if (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

  if (Assigned(frmTeste)) then
  begin
    FreeAndNil(frmTeste);
  end;

  if (Assigned(dmCombos)) then
  begin
    FreeAndNil(dmCombos);
  end;

   if (Assigned(frmCTPHistorico)) then
  begin
    FreeAndNil(frmCTPHistorico);
  end;

  if (Assigned(frmRelatorioPagamentos)) then
  begin
    FreeAndNil(frmRelatorioPagamentos);
  end;





end;


procedure TFrmPrincipal.AjustaForm;
Const
nTamOriginal = 1024; // Ser� o 100% da escala
Var
nEscala : Double; // Vai me dar o percentual de Transforma��o escalar
nPorcento : Integer; // Vai me dar em percentual inteiro o valor
begin
With FrmPrincipal do
begin
      if nTamOriginal <> Screen.Width then
      begin
        nEscala := ((Screen.Width-nTamOriginal)/nTamOriginal);
        nPorcento := Round((nEscala*100) + 100);
        Self.Width := Round(Self.Width * (nEscala+1));
        Self.Height := Round(Self.Height * (nEscala+1));
        Self.ScaleBy(nPorcento,100);
      end;
end;
end;

procedure TFrmPrincipal.alignPanelLogin(Sender: TObject);
var
alignTop :Integer;
begin
   alignTop         := Trunc((Self.Height - img1.Height)/2);
   btnZoom.Left     := Trunc(img1.Width/2);
   img1.Left        := Trunc((Self.Width - img1.Width)/2);
   img1.Top         := Trunc((Self.Height - img1.Height)/2);
   btnLogin.Top     := Trunc((alignTop + 65 ));

   lblLogin.Left        := Trunc(img1.Left + 90);
   lbl2.Left        := Trunc(img1.Left + 90);
   lbl3.Left        := Trunc(img1.Left + 90);
   cbxUsuario.Left  := Trunc(lblLogin.Left + lblLogin.Width + 20);
   edtLogin.Left    := Trunc(lblLogin.Left + lblLogin.Width + 20);
   edtPassword.Left := Trunc(lblLogin.Left + lblLogin.Width + 20);
   chkSavePass.Left := Trunc(lblLogin.Left + lblLogin.Width + 20);
   btnLogin.Left    := Trunc(cbxUsuario.Left + (cbxUsuario.Width + 4) )   ;

   lbl2.Top         := Trunc((alignTop +  65 ));
   lblLogin.Top     := Trunc((alignTop +  95 ));
   lbl3.Top         := Trunc((alignTop + 125 ));
   cbxUsuario.Top   := Trunc((alignTop +  65 ));
   edtLogin.Top     := lblLogin.Top;
   edtPassword.Top  := lbl3.Top;
   chkSavePass.Top  := edtPassword.Top + 50;





end;



procedure TFrmPrincipal.ApplicationEventsException(Sender: TObject;
  E: Exception);
var
  CapturaExcecoes: TPempecExceptions;
begin
  // Cria a classe de captura de exce��es
  CapturaExcecoes := TPempecExceptions.Create;
  try
    // Invoca o m�todo de captura, informando os par�metros
    CapturaExcecoes.CapturarExcecao(Sender, E);

    // Carrega novamente o arquivo de log no Memo
   // Memo.Lines.LoadFromFile(GetCurrentDir + '\LogExcecoes.txt');

    // Navega para o final do Memo para mostrar a exce��o mais recente
   // SendMessage(Memo.Handle, EM_LINESCROLL, 0,Memo.Lines.Count);
  finally
    CapturaExcecoes.Free;
  end;
end;

procedure TFrmPrincipal.preenchePanelMain();
begin

//    lblPathSGBD.Caption := 'PATH BANCO ' + uUtil.TOrgAtual.getPathSGBD;
        stat1.Panels[1].Text := 'USER : > ' + TUserAtual.getNameUser;
        stat1.Panels[2].Text := 'ORG  : > ' + uUtil.TOrgAtual.getFantasia ;
        stat1.Panels[4].Text := 'BANCO DE DADOS : > ' + uUtil.TOrgAtual.getPathSGBD ;
        stat1.Panels[5].Text := '';


        if not (uUtil.TOrgAtual.getSistemaContabil = '') then begin
            stat1.Panels[5].Text := 'SISTEMA CONT�BIL : > ' + uUtil.TOrgAtual.getSistemaContabil;
        end;


        if not (uUtil.TOrgAtual.getId = '') then
        begin
          acessoMenu(true); // libera o menu principal
        end
        else
        begin
          acessoMenu(false);
          stat1.Panels[1].Text := '';
          stat1.Panels[2].Text := ' ';
          stat1.Panels[3].Text := '';
          stat1.Panels[4].Text := '';
          stat1.Panels[5].Text := '';
          stat1.Panels[6].Text := horaInicioUSo;

        end;

end;

procedure TFrmPrincipal.selectOrganizacao(pIdOrganizacao :string);
var
  cnpj, fantasia, razao, contabil : string;
  organizacaoModel : TOrganizacaoModel;
begin
     organizacaoModel := TOrganizacaoModel.Create;
  try

        if (dmOrganizacao.carregarDadosOrganizacaoFNC(pIdOrganizacao)) then begin
            cnpj :=Trim(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
            fantasia :=dmOrganizacao.qryDadosEmpresa.FieldByName('FANTASIA').AsString;
            razao :=dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString;
            contabil :=dmOrganizacao.qryDadosEmpresa.FieldByName('SISTEMA_CONTABIL').AsString;

            uUtil.TOrgAtual.setId(pIdOrganizacao);
            uUtil.TOrgAtual.setCNPJ(cnpj);
            uUtil.TOrgAtual.setFantasia(fantasia);
            uUtil.TOrgAtual.setRazaoSocial(razao);
            uUtil.TOrgAtual.setSistemaContabil(contabil);
            uUtil.TOrgAtual.setIDSistemaContabil('0'); // 0 = nao tem empresa vinculada

            organizacaoModel.FID := pIdOrganizacao;
            organizacaoModel := TOrganizacaoDAO.obterPorID(organizacaoModel);

            if not uUtil.Empty(organizacaoModel.FID) then
            begin
              uutil.TOrgAtual.setOrganizacao(organizacaoModel);
            end;

                  //tentando pegar o ID da empresa no MEGA e setando na organizacao
            try
            if dmConexao.conectarMega then begin
             if carregarDadosEmpresaMega(cnpj) then begin
               uUtil.TOrgAtual.setIDSistemaContabil(IntToStr(qryDadosEmpresaMega.FieldByName('ID').AsInteger));
             end;
            end;

         except
          on e: Exception do
                PempecMsg.MsgInformation('Problemas ao tentar conectar com o sistema cont�bil...')

         end;

           // PostMessage(Self.Handle, WM_CLOSE, 0,0);

        end
        else
        begin
          PempecMsg.MsgInformation('Erro ao carregar os dados da organiza��o...');
        end;

  except
    on e: Exception do
      PempecMsg.MsgInformation('Problemas ao selecionar uma empresa...');
  end;



end;


function TFrmPrincipal.carregarDadosEmpresaMega(pCnpj: string): Boolean;
begin

  dmConexao.conectarMega;

 try
      qryDadosEmpresaMega.Close;
      qryDadosEmpresaMega.Connection := dmConexao.ConnMega;
      qryDadosEmpresaMega.ParamByName('pCnpj').AsString := pCnpj;
      qryDadosEmpresaMega.Open;
 except
    raise(Exception).Create('Erro ao tentar obter dados do Sistema Cont�bil.');
 end;

  Result := not qryDadosEmpresaMega.IsEmpty;
end;


procedure TFrmPrincipal.preencheBarraDados;
var
IPExterno  : string;
Id_HandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
IPExterno := '';
// posicao 0 informa o usuario logado
// posicao 1 informa se � administrador
//posicao 2 informa o ip
 atualizarVersaoBD;

dxStatusBar1.Panels[3].Text := 'Vers�o: ' + GetVersionInfo(Application.ExeName);
dxStatusBar1.Panels[4].Text := 'PC: ' + uutil.GetComputerNetName;
dxStatusBar1.Panels[5].Text := 'User : ' + uutil.GetUserFromWindows;
dxStatusBar1.Panels[6].Text := 'Internet : Sem conex�o.  ' +  'Vers�o licenciada : ' + uUtil.TOrgAtual.getFFLICENCA;

 versaoWeb := GetVersionInfo(Application.ExeName);

 if not Isdebug then   begin
 //if 1=1 then   begin

    dxStatusBar1.Panels[6].Text := 'Internet : Sem conex�o.  ' +  'Vers�o licenciada : ' + uUtil.TOrgAtual.getFFLICENCA;

    if uutil.IsInternetConected then
    begin
      IPExterno := TIPreal;

      dxStatusBar1.Panels[6].Text := ' Status Internet : ' + 'Conectada.  ' + ' IP : -> ' + IPExterno;

      versaoWeb := getVersaoWEB;

    end;

  end;

  uUtil.setVersaoWeb(versaoWeb);

end;



 function TFrmPrincipal.getVersaoWEB() : string;
var
webVersion : string;
Id_HandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
 begin
  webVersion := '0';

    if uutil.IsInternetConected then
    begin

        if not Assigned(IdHTTP1) then
        begin

          IdHTTP1 := TIdHTTP.Create(Self);

        end;

    IdHTTP1.Request.BasicAuthentication := False;
    IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
    Id_HandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP1);
    Id_HandlerSocket.SSLOptions.Mode := sslmClient;
    Id_HandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdHTTP1.IOHandler := Id_HandlerSocket;

    try
      webVersion := IdHTTP1.Get('https://pempec.com.br/validator/obterversao.php?sistema=finance');
      uUtil.setVersaoWeb(webVersion);

    except
      webVersion := '0';

    end;


    end;

   Result := webVersion;
 end;
//s� traz  o IP interno
function TFrmPrincipal.getIPs: Tstrings;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of Ansichar;
  I: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := TstringList.Create;
  Result.Clear;
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I    := 0;
  while pPtr^[I] <> nil do
  begin
    Result.Add(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
end;

function TFrmPrincipal.TIPreal: string;
var
  bot, IPExterno: string;
begin
  bot := 'http://meuip.com/api/meuip.php';
  IPExterno := '';
  if uUtil.IsInternetConected then
  begin
    with TIdHTTP.Create(nil) do

    try
      IPExterno := Get(bot);
      bot := 'http://checkip.dyndns.org)';

      if IPExterno = EmptyStr then
      begin
        IPExterno := Get(bot);
        IPExterno := Copy(IPExterno, Pos('Current IP Address: ', IPExterno) + 20, 15);
      end;

      //IPExterno := Copy(IPExterno, 1, Pos('<', IPExterno) - 1);

    except
      on E: Exception do
        IPExterno := E.Message;
    end;
  end;

  Result := IPExterno;

end;


procedure TFrmPrincipal.atualizar();
begin

  if uUtil.IsInternetConected then
  begin

    if uutil.TOrgAtual.isAtualizar then
    begin

     // PempecMsg.MsgWarning('Existem novas atualiza��es. ' + #13 + ' Acesse o site www.pempec.com.br para baixar. ');

        frmInfoUpdate := TfrmInfoUpdate.Create(Self);
        frmInfoUpdate.ShowModal;
        FreeAndNil(frmInfoUpdate);




    end;

  end;
end;


procedure TFrmPrincipal.atualizarVersaoBD;
var vLocal, vNova :Integer;
isNew : Boolean;
orgBD : TOrganizacaoModel;
begin
  isNew := False;
  orgBD := TOrganizacaoModel.Create;
  orgBD.FID := uutil.TOrgAtual.getId;
  orgBD := TOrganizacaoDAO.obterPorID(orgBD);

  if not uutil.Empty(orgBD.FID) then
  begin
    if not GetVersionInfo(Application.ExeName).Equals(uUtil.TOrgAtual.getVersao) then
    begin

        vLocal := StrToInt(TRegEx.Replace(uUtil.TOrgAtual.getVersao, '\D', ''));
        vNova := StrToInt(TRegEx.Replace(GetVersionInfo(Application.ExeName), '\D', ''));

      if (vNova > vLocal) then
      begin
        isNew := True;
      end;

      if isNew then
      begin

         orgBD.FVersao := GetVersionInfo(Application.ExeName);

         TOrganizacaoDAO.ajustarVersaoBD(orgBD);

         uutil.TOrgAtual.setOrganizacao(orgBD);

      end;

      FreeAndNil(orgBD);
    end
  end;

end;







end.


