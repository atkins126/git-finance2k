unit uFrmPrincipal;

interface

uses
  Winapi.Windows, uMD5, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics, uUtil, uVarGlobais, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Phys.ADSWrapper, FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.VCLUI.Wait, FireDAC.Phys, FireDAC.stan.Def, Registry, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.stan.Intf, uFrmRegistraBaseDados, FireDAC.Phys.ADS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Phys.IBWrapper, Vcl.Samples.Gauges, Vcl.ComCtrls,
  Vcl.Samples.Spin, wininet, Winsock, IdSSL, IdSSLOpenSSL, IdMessage, Organizacao, IdAttachmentFile, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, uLogin, IdTCPConnection, IdSMTP, jpeg, IdBaseComponent, IdComponent, IdHTTP, FireDAC.stan.Option, FireDAC.stan.Error, FireDAC.Phys.Intf, FireDAC.stan.Pool, FireDAC.stan.Async, FireDAC.stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, Vcl.Mask, VCLUnZip, VCLZip, FireDAC.Phys.FBDef,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, frxClass, udmConexao, uDMOrganizacao, udmMegaContabil, uDMUsuarioConsulta, ACBrBase, uDmExportaFinance, uDMContasPagar, Vcl.Imaging.pngimage, Vcl.Grids, Vcl.DBGrids, frxDBSet, uFrmManutencao, Vcl.Menus, uFrmBackup, uFrmRegistro, uFrmServidorEmail, System.ImageList, Vcl.ImgList, uFrmImportacao, uFrmRelatorios, uFrmExportacao, uFrmSincronizaMega, uFrmTeste, uFrmUpdate, udmCombos, RxDBCtrl, frxCrypt, UMostraErros,uFrmAlteraTituloPagar,uFrmAlteraTituloReceber,
  uFrameBDTables, udmManutencao, uFrmExtratoBancario, uFrameOrganizacoes, uFrameEstado, uFrmDeletaLoteContabil, uFrmCompensaCheque, uFrmMultiplosCheques,
  uFrameGeneric, uFrameCidade, uFrameEndereco, uFrameBairro, uDMServerMail,uFrmAlteraOrganizacao,uFrmSelecionaOrganizacao,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,uFrmSaldoContas,UfrmPosicaoFinanceira,
  uFramePeriodo, uDMParametros, uFrameHistorico, sSkinManager, cxGraphics, uFrmDemonstrativoRD, uFrmRelatoriosPagamentos,uFrmRelatorioPagamentosHistorico,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore, uFrmExtratoTesouraria,
  dxSkinsDefaultPainters, dxRibbonCustomizationForm, dxStatusBar, uFrmHistorico,
  dxRibbonStatusBar, cxClasses, dxRibbon, Vcl.PlatformDefaultStyleActnCtrls,uFrmLoteDeposito,
  System.Actions, Vcl.ActnList, Vcl.ActnMan, dxBar, cxButtons, ACBrCalculadora, uFrmTransferenciasEntreContas,
  dxBarApplicationMenu, cxCalendar, sMaskEdit, sCustomComboEdit, sCurrEdit,  uFrmTransfereBancoCaixa,uFrmTransfereCaixaBanco,
  cxCalc, dxDateTimeWheelPicker, cxBarEditItem, cxContainer, cxEdit, uFrmAjustaSkin, uFrmDepositoCheque,
  dxWheelPicker, dxNumericWheelPicker, cxDropDownEdit, ENumEd, uFrmEspelhoTP,
  uFrameCheque ;

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

    procedure FormCreate(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure acessoMenu(value: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxUsuarioChange(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure Zoom(Sender: TObject);

    procedure cbxUsuarioClick(Sender: TObject);

    procedure btn1Click(Sender: TObject);
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
    procedure dxBtnAlteraNumDocClick(Sender: TObject);
    procedure dxBtnEspelhoTPClick(Sender: TObject);
    procedure dxBtnRelCTPClick(Sender: TObject);
    procedure dxBtnRelTPHistoricoClick(Sender: TObject);
    procedure dxBtnConfigEmailClick(Sender: TObject);
    procedure dxBtnSerialClick(Sender: TObject);
    procedure dxBtnTRFBCOCAIXAClick(Sender: TObject);
    procedure dxBtnCompensarDiversosChsClick(Sender: TObject);
    procedure dxBtnCompensarChequeClick(Sender: TObject);
    procedure dxBtnRelExtratoBancarioClick(Sender: TObject);
    procedure dxBtnRelSDContasClick(Sender: TObject);
    procedure dxBarLargeButton2Click(Sender: TObject);
    procedure dxBarLargeButton3Click(Sender: TObject);
    procedure dxBtnTPProvisaoClick(Sender: TObject);
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


    ajustaFormLigado : Boolean;
    usuarioAdm :Integer;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure AjustaForm;
    procedure serverMail(pIdOrganizacao :string);
    procedure preenchePanelMain;
    function carregarDadosEmpresaMega(pCnpj: string): Boolean;
    procedure selectOrganizacao(pIdOrganizacao: string);
    procedure aDesenvolver;

  public
    { Public declarations }
    orgAtual: TOrganizacao;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  uDMRelatorioExportacaoMega, uFrmContasPagar;


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


procedure TFrmPrincipal.btn1Click(Sender: TObject);
var
aux :ShortInt;
begin

//frmEnd1.frmCidade1.createComboAll('CIDADE','CIDADE','CIDADE', frmEnd1.frmCidade1.cbbcombo , FsListaIdCidades );

end;

procedure TFrmPrincipal.btnLoginClick(Sender: TObject);
var
  loMostraErros: TFMostraErros;
  idOrgUser :string;
begin
  dmParametros.obterTodos;
  

    userValidado := dmUsuarioConsulta.validarLogin(StrToInt(pid), edtLogin.Text, edtPassword.Text);

    idOrgUser :=  dmUsuarioConsulta.qryValidarUsuario.FieldByName('ID_ORGANIZACAO').AsString;
    usuarioAdm := dmUsuarioConsulta.qryValidarUsuario.FieldByName('ADM').AsInteger;

  if  (userValidado) then
  begin
   if uutil.Empty(idOrgUser) then begin  //se o usuario nao tiver id_organizacao, abre a tela para escolher.

     try

        frmSelectOrganizacao := TfrmSelectOrganizacao.Create(Self);
        frmSelectOrganizacao.ShowModal;
        FreeAndNil(frmSelectOrganizacao);

    except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
    end;

    end
    else
    begin
      try
        selectOrganizacao(idOrgUser);
      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');

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


    if exibePanel>0 then begin


        if  not Assigned(frmPosicaoFinanceira)  then begin

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

              preenchePanelMain;



    pnlMain.Align := alClient;
//     lblHoraAcesso.Caption := TUserAtual.getNameUser + ' logou em : '+  horaInicioUSo ;
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
    ShowMessage('Login/Senha incorretos.');
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

     dmUsuarioConsulta.obterUsuarioPorID(StrToInt(pid));
     //libera os botoes de login e senha
      edtLogin.Enabled := True;
      edtPassword.Enabled := True;
      btnLogin.Enabled := True;

    end
    else
    begin
      ShowMessage('Usu�rio n�o localizado... Selecione um usu�rio...');
    end;

  end;

end;

procedure TFrmPrincipal.cbxUsuarioClick(Sender: TObject);
begin
if( cbxUsuario.ItemIndex < 0) then begin

   ShowMessage('Sele��o inv�lida!!!!');
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
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBarBtnExportMegaClick(Sender: TObject);
begin

  numberError := '1032';
  try
    frmExportacao := TfrmExportacao.Create(Self);
    frmExportacao.ShowModal;
    FreeAndNil(frmExportacao);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;



end;

procedure TFrmPrincipal.dxBarCancelExportClick(Sender: TObject);
begin

  numberError := '1046';

  try
    frmDeletaLoteContabil := TfrmDeletaLoteContabil.Create(Self);
    frmDeletaLoteContabil.ShowModal;
    FreeAndNil(frmDeletaLoteContabil);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBarLargeButton2Click(Sender: TObject);
begin

numberError := 'ALT-TR-1044';
  try
    frmAlteraNumDocTR := TfrmAlteraNumDocTR.Create(Self);
    frmAlteraNumDocTR.ShowModal;
    FreeAndNil(frmAlteraNumDocTR);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

end;

procedure TFrmPrincipal.dxBarLargeButton6Click(Sender: TObject);
begin
     try
      frmLoteDeposito := TFrmLoteDeposito.Create(Self);
      frmLoteDeposito.ShowModal;
      FreeAndNil(frmLoteDeposito);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
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
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;


end;

procedure TFrmPrincipal.dxBtnRelDemoCCClick(Sender: TObject);
begin

  try
      frmDemonstrativoRD := TFrmDemonstrativoRD.Create(Self);
      frmDemonstrativoRD.ShowModal;
      FreeAndNil(frmDemonstrativoRD);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;



end;

procedure TFrmPrincipal.dxBtbTrfCxDinClick(Sender: TObject);
begin

 try
     frmTransferenciasCaixaBanco:= TfrmTransferenciasCaixaBanco.Create(Self);
     frmTransferenciasCaixaBanco.ShowModal;
     FreeAndNil(frmTransferenciasCaixaBanco);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBtnAlteraNumDocClick(Sender: TObject);
begin

numberError := 'ALT-TP-1045';
  try
    frmAlteraNumDocTP := TfrmAlteraNumDocTP.Create(Self);
    frmAlteraNumDocTP.ShowModal;
    FreeAndNil(frmAlteraNumDocTP);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnAlteraSkinClick(Sender: TObject);
begin
  frmSkin := TfrmSkin.Create(Self);
  frmSkin.ShowModal;
  FreeAndNil(frmSkin);



end;

procedure TFrmPrincipal.dxBtnCadastroTPClick(Sender: TObject);
begin
  numberError := '1040';

  frmContasPagar := TfrmContasPagar.Create(Self);
  frmContasPagar.ShowModal;
  FreeAndNil(frmContasPagar);

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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.dxBtnEspelhoTPClick(Sender: TObject);
begin

  try
    formEspeloTP := TformEspeloTP.Create(Self);
    formEspeloTP.ShowModal;
    FreeAndNil(formEspeloTP);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.aDesenvolver();
begin
 ShowMessage('Estamos trabalhando para melhorar essa funcionalidade. Por favor, aguarde.');

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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;

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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;


end;

procedure TFrmPrincipal.dxBtnMegaSincronizarClick(Sender: TObject);
begin
 numberError := '1050';
  try
    frmSincronizaMega := TfrmSincronizaMega.Create(self);
    frmSincronizaMega.ShowModal;
    FreeAndNil(frmSincronizaMega);
  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
  end;
end;

procedure TFrmPrincipal.dxBtnRelCTPClick(Sender: TObject);
begin

  try
      frmRelatorioPagamentos := TfrmRelatorioPagamentos.Create(Self);
      frmRelatorioPagamentos.ShowModal;
      FreeAndNil(frmRelatorioPagamentos);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;


procedure TFrmPrincipal.dxBtnRelTPHistoricoClick(Sender: TObject);
begin

  try
      frmCTPHistorico := TfrmCTPHistorico.Create(Self);
      frmCTPHistorico.ShowModal;
      FreeAndNil(frmCTPHistorico);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

procedure TFrmPrincipal.dxBtnSerialClick(Sender: TObject);
begin
aDesenvolver;
end;

procedure TFrmPrincipal.dxBtnTPProvisaoClick(Sender: TObject);
begin
aDesenvolver;
end;

procedure TFrmPrincipal.dxBtnTRFBCOCAIXAClick(Sender: TObject);
begin

 try
     frmTransferenciasBancoCaixa:= TfrmTransferenciasBancoCaixa.Create(Self);
     frmTransferenciasBancoCaixa.ShowModal;
     FreeAndNil(frmTransferenciasBancoCaixa);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;



end;

procedure TFrmPrincipal.dxBtnTRProvisaoClick(Sender: TObject);
begin
aDesenvolver;
end;

procedure TFrmPrincipal.dxTRFBCOBCOClick(Sender: TObject);
begin

 try
     frmTransferenciasEntreContas := TfrmTransferenciasEntreContas.Create(Self);
     frmTransferenciasEntreContas.ShowModal;
     FreeAndNil(frmTransferenciasEntreContas);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;



end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
alignTop :Integer;
begin
  uUtil.LimpaTela(Self);
  stat1.Panels[0].Text := 'Vers�o: ' + GetVersionInfo(Application.ExeName);
  stat1.Panels[6].Text := 'Hora  : ' + horaInicioUSo;

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


  exibePanel := 1;
  //##definindo o skin padrao para iniciar
  skm.SkinDirectory := ExtractFilePath(Application.ExeName) + 'Skins';
     //Seta o endere�o dos skins para o lstSkin (TFileListBox)
  //  fllstSkin.Directory := skm.SkinDirectory; implementar tela p mudar o skin
  skm.SkinName := uUtil.obterSkinDefault('teste');
  skm.Active := True;
      //seta o skin definido no config.in

//  frmEstado1.createComboAll('ESTADO','DESCRICAO',frmEstado1.cbbcombo, FsListaIdEstados);

end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F10 then begin
  if not (Assigned(frmRegistraBaseDados)) then
         begin
             frmRegistraBaseDados := TfrmRegistraBaseDados.Create(Self);
             frmRegistraBaseDados.ShowModal;
             FreeAndNil(frmRegistraBaseDados);
          end;
  end;

  if Key = VK_F5 then begin
     try

        frmSelectOrganizacao := TfrmSelectOrganizacao.Create(Self);
        frmSelectOrganizacao.ShowModal;
        FreeAndNil(frmSelectOrganizacao);

        preenchePanelMain;

    except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
    end;

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

    end;

end;





procedure TFrmPrincipal.tmrrelogioTimer(Sender: TObject);
begin

 stat1.Panels[6].Text := DateTimeToStr(Now);
 //cxClock1.Time := DateTimeToStr(Now);

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
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + numberError);
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
      ShowMessage(' '+ e.Message);
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
   btnLogin.Left    := Trunc(cbxUsuario.Left + (cbxUsuario.Width + 4) )   ;

   lbl2.Top         := Trunc((alignTop +  65 ));
   lblLogin.Top         := Trunc((alignTop +  95 ));
   lbl3.Top         := Trunc((alignTop + 125 ));
   cbxUsuario.Top   := Trunc((alignTop +  65 ));
   edtLogin.Top     := lblLogin.Top;
   edtPassword.Top  := lbl3.Top;





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
begin
  try

        if (dmOrganizacao.carregarDadosOrganizacao(pIdOrganizacao)) then begin
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

            //tentando pegar o ID da empresa no MEGA e setando na organizacao
            if dmConexao.conectarMega then begin
             if carregarDadosEmpresaMega(cnpj) then begin
               uUtil.TOrgAtual.setIDSistemaContabil(IntToStr(qryDadosEmpresaMega.FieldByName('ID').AsInteger));
             end;
            end;

           // PostMessage(Self.Handle, WM_CLOSE, 0,0);

        end
        else
        begin
          MessageDlg('Erro ao carregar os dados da organiza��o...', mtWarning, [mbOK], 0);
        end;

  except
    on e: Exception do
      MessageDlg('Problemas ao selecionar uma empresa...', mtWarning, [mbOK], 0);
  end;
end;


function TFrmPrincipal.carregarDadosEmpresaMega(pCnpj: string): Boolean;
var
  x: string;
begin

  dmConexao.conectarMega;

 try
      qryDadosEmpresaMega.Close;
      qryDadosEmpresaMega.Connection := dmConexao.ConnMega;
      qryDadosEmpresaMega.ParamByName('pCnpj').AsString := pCnpj;
      qryDadosEmpresaMega.Open;
 except
    raise(Exception).Create('Erro ao tentar obter dados do MEGA');
 end;

  Result := not qryDadosEmpresaMega.IsEmpty;
end;



end.


