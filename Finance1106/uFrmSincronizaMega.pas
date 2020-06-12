unit uFrmSincronizaMega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, RxCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  uFrameProgressBar, dxSkinsCore, dxSkinsDefaultPainters, EMsgDlg, cxClasses,
  dxBar, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon, Vcl.ComCtrls;

type
  TfrmSincronizaMega = class(TForm)
    panelMega: TRxPanel;
    lblEmpresa: TLabel;
    lblCnpj: TLabel;
    btnBuscarPlanoMega: TBitBtn;
    dbgPlanoMega: TDBGrid;
    btnBuscarContasContabeis: TBitBtn;
    lblNotSinc: TLabel;
    btnBuscarPlanos: TBitBtn;
    dbgrdContasFinance: TDBGrid;
    lbl4: TLabel;
    lbl5: TLabel;
    memo: TMemo;
    framePB1: TframePB;
    dxBarManager1: TdxBarManager;
    PempecMsg: TEvMsgDlg;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarBtnFechar: TdxBarLargeButton;
    dxBarBtnSincronizar: TdxBarLargeButton;
    dxBarBtnLoadPlanos: TdxBarLargeButton;
    lbl3: TLabel;
    RichEdit1: TRichEdit;
    RxPanel1: TRxPanel;
    Label3: TLabel;
    RxPanel2: TRxPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarPlanoMegaClick(Sender: TObject);
    procedure btnBuscarContasContabeisClick(Sender: TObject);
    procedure btnBuscarPlanosClick(Sender: TObject);
  //  procedure btnVerificarClick(Sender: TObject);
    function verificarSeContaExiste(pIdOrganizacao, pValue, pCampo: string): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure dxBarBtnFecharClick(Sender: TObject);
    procedure dxBarBtnSincronizarClick(Sender: TObject);
    procedure dxBarBtnLoadPlanosClick(Sender: TObject);
  private
    { Private declarations }
   sincAllow, idEmpresa: Integer;
    BDConectado : Boolean;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure obterDadosEmpresaMega();
    function permiteSincronizar(): Boolean;
  public
    { Public declarations }
  end;

var
  frmSincronizaMega: TfrmSincronizaMega;

implementation

uses
  udmConexao, uUtil, uDMMegaContabil, uDMContaContabil;

const
  INDICE_DEFAULT = 'DEFAULT_ORDER';
  GRID_COR_INDICE_TITULO = clCream;

{$R *.dfm}

procedure TfrmSincronizaMega.btnBuscarContasContabeisClick(Sender: TObject);
begin

  if (dmContaContabil.obterListaContaContabil(TOrgAtual.getId)) then
   begin
     sincAllow := sincAllow +1;
   end;

end;

procedure TfrmSincronizaMega.btnBuscarPlanoMegaClick(Sender: TObject);
begin

 if  dmMegaContabil.obterPlanoContas(idEmpresa) then
  begin
      sincAllow := sincAllow +1;
      framePB1.Visible :=True;
      framePB1.progressBar(0,100);
 end;

end;

procedure TfrmSincronizaMega.btnBuscarPlanosClick(Sender: TObject);
begin
 dmConexao.conectarBanco;
 dmConexao.conectarMega;

  btnBuscarPlanoMega.Click;
  btnBuscarContasContabeis.Click;

  if sincAllow >1 then begin
    dxBarBtnSincronizar.Enabled := True
  end;
  framePB1.Visible :=True;
  framePB1.progressBar(0,100);



//if not (permiteSincronizar) then begin retirado para testes com Imap em 23/11
  if (permiteSincronizar) then
  begin
    lblNotSinc.Visible := True;
    lblNotSinc.Caption := 'O plano de contas local possue contas que n�o est�o no plano de contas oficial. ';
//  ShowMessage('Imposs�vel sincronizar');
  end;

end;



function TfrmSincronizaMega.verificarSeContaExiste(pIdOrganizacao, pValue, pCampo: string): Boolean;
var
  existConta: Boolean;
begin
  existConta := False;
   //ID ORGANIZACAO, A CONTA DO MEGA E O PARAMETRO A SER PESQUISADO

  if (pCampo.Equals('CONTA')) then
  begin

    if dmContaContabil.obterContaPorFiltro(pIdOrganizacao, pValue, pCampo) then
    begin
      existConta := True;
    end;
  end;

  if (pCampo.Equals('CODREDUZ')) then
  begin
    if dmContaContabil.obterContaPorCodigoReduzido(pIdOrganizacao, pValue, pCampo) then
    begin
      existConta := True;
    end;
  end;

  Result := existConta;
end;

{
procedure TfrmSincronizaMega.btnVerificarClick(Sender: TObject);
var
  CONTAMEGA, idContaFin, contaFin: string;
 qtdPlanoMega, qtd: Integer;
var
  ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string;
  DATA_REGISTRO :TDate;
begin
 dmConexao.conectarBanco;
 dmConexao.conectarMega;

  qtdPlanoMega :=  dmMegaContabil.qryObterPlanoContas.RecordCount;
  memo.Lines.Clear;
  framePB1.progressBar(0,0);
  framePB1.lblProgressBar.Caption :=' Progresso da sincroniza��o ';

  if (qtdPlanoMega > 0) then
  begin
    btnFechar.Enabled := False;
    btnVerificar.Enabled := False;

    dmMegaContabil.qryObterPlanoContas.First;

    while not (dmMegaContabil.qryObterPlanoContas.eof) do
    begin
      ID_ORGANIZACAO := TOrgAtual.getId;
      CODREDUZ       := IntToStr(dmMegaContabil.qryObterPlanoContas.FieldByName('CODREDUZ').AsInteger);
      CONTAMEGA      := dmMegaContabil.qryObterPlanoContas.FieldByName('CONTA').AsString;
      DESCRICAO      := dmMegaContabil.qryObterPlanoContas.FieldByName('NMCONTA').AsString;
      DGVER          := dmMegaContabil.qryObterPlanoContas.FieldByName('DGVER').AsString;
      DGREDUZ        := dmMegaContabil.qryObterPlanoContas.FieldByName('DGREDUZ').AsString;
      TIPO           := dmMegaContabil.qryObterPlanoContas.FieldByName('TIPO').AsString;

      //verifica se o codigo reduzido  existe no FINANCE
      //se existir, atualiza.

      if not verificarSeContaExiste(ID_ORGANIZACAO, CODREDUZ, 'CODREDUZ') then
      begin

          qtd := qtd + 1;
          memo.Lines.Add('N�o encontrada no Finance : ' + CONTAMEGA + ' CODIGO REDUZ ' + CODREDUZ);
        //insere a conta nova no finance
          if (dmContaContabil.insereContaContabil(ID_ORGANIZACAO, DESCRICAO, CONTAMEGA, DGVER, CODREDUZ, DGREDUZ, TIPO)) then
          begin  //AQUI ERRO
            memo.Lines.Add('Conta Nova : ' + CONTAMEGA + ' INSERIDA no Finance');
          end
          else
          begin
            memo.Lines.Add('Conta Nova : ' + CONTAMEGA + 'FALHA ao inserir no Finance');
          end;

      end
      else
      begin
      // se existir atualiza  no FINANCE
        idContaFin := dmContaContabil.qryObterPorCodigoReduzido.FieldByName('ID_CONTA_CONTABIL').AsString;

        if (dmContaContabil.atualizaDescricaoContaContabil(idContaFin, ID_ORGANIZACAO, DESCRICAO, CONTAMEGA, DGVER, CODREDUZ, DGREDUZ, TIPO)) then
        begin
          memo.Lines.Add('Conta : ' + CONTAMEGA + '  ATUALIZADA no Finance');
          memo.Lines.Add('----------------------------------------------------------------------------------');
          Application.ProcessMessages;
        end
      end;

      dbgPlanoMega.DataSource.DataSet.Next;
      dbgrdContasFinance.DataSource.DataSet.Next;
//      framePB1.lblProgressBar.Visible :=False;
      framePB1.progressBar(1 ,Trunc(qtdPlanoMega));
      Application.ProcessMessages;
    end;

  end;

  if (qtd > 0) then
  begin
    ShowMessage('Existe(m) ' + IntToStr(qtd) + ' conta(s) para ser(em) cadastra(s) no Finance.');

  end
  else
  begin
    ShowMessage('N�o existem contas a serem importadas.');
  end;

  framePB1.progressBar(0 ,0);
  framePB1.lblProgressBar.Caption := ' Sincronizar contas cont�beis... ' ;
  dbgPlanoMega.DataSource.DataSet.Refresh;
  dbgrdContasFinance.DataSource.DataSet.Refresh;
  btnBuscarPlanoMegaClick(self);
  memo.Lines.Clear;
  btnVerificar.Enabled := False;
  btnFechar.Enabled := True;
  framePB1.Visible := False;
  Application.ProcessMessages;

end;

}
procedure TfrmSincronizaMega.dxBarBtnFecharClick(Sender: TObject);
begin
PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmSincronizaMega.dxBarBtnLoadPlanosClick(Sender: TObject);
begin

 dmConexao.conectarBanco;
 dmConexao.conectarMega;

  btnBuscarPlanoMega.Click;
  btnBuscarContasContabeis.Click;

  if Not uUtil.Empty(uutil.TOrgAtual.getSistemaContabil) then begin

      lbl4.Caption := 'Plano de contas oficial : -- > '+uutil.TOrgAtual.getSistemaContabil;
  end;


  if sincAllow >1 then begin
    dxBarBtnSincronizar.Enabled := True
  end;
  framePB1.Visible :=True;
  framePB1.progressBar(0,100);

//if not (permiteSincronizar) then begin retirado para testes com Imap em 23/11
  if (permiteSincronizar) then
  begin
    lblNotSinc.Visible := True;
    lblNotSinc.Caption := 'O plano de contas local possue contas que n�o est�o no plano de contas oficial. ';
//  ShowMessage('Imposs�vel sincronizar');
  end;


end;

procedure TfrmSincronizaMega.dxBarBtnSincronizarClick(Sender: TObject);
var
  CONTAMEGA, idContaFin, contaFin: string;
 qtdPlanoMega, qtd: Integer;
var
  ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string;
  DATA_REGISTRO :TDate;
begin
 dmConexao.conectarBanco;
 dmConexao.conectarMega;

  qtdPlanoMega :=  dmMegaContabil.qryObterPlanoContas.RecordCount;
  memo.Lines.Clear;
  framePB1.progressBar(0,0);
  framePB1.lblProgressBar.Caption :=' Progresso da sincroniza��o ';

  if (qtdPlanoMega > 0) then
  begin
    dxBarBtnFechar.Enabled := False;
    dxBarBtnSincronizar.Enabled := False;

    dmMegaContabil.qryObterPlanoContas.First;

    while not (dmMegaContabil.qryObterPlanoContas.eof) do
    begin
      ID_ORGANIZACAO := TOrgAtual.getId;
      CODREDUZ       := IntToStr(dmMegaContabil.qryObterPlanoContas.FieldByName('CODREDUZ').AsInteger);
      CONTAMEGA      := dmMegaContabil.qryObterPlanoContas.FieldByName('CONTA').AsString;
      DESCRICAO      := dmMegaContabil.qryObterPlanoContas.FieldByName('NMCONTA').AsString;
      DGVER          := dmMegaContabil.qryObterPlanoContas.FieldByName('DGVER').AsString;
      DGREDUZ        := dmMegaContabil.qryObterPlanoContas.FieldByName('DGREDUZ').AsString;
      TIPO           := dmMegaContabil.qryObterPlanoContas.FieldByName('TIPO').AsString;

      //verifica se o codigo reduzido  existe no FINANCE
      //se existir, atualiza.

      if not verificarSeContaExiste(ID_ORGANIZACAO, CODREDUZ, 'CODREDUZ') then
      begin

          qtd := qtd + 1;
          memo.Lines.Add('N�o encontrada no Finance : ' + CONTAMEGA + ' CODIGO REDUZ ' + CODREDUZ);
        //insere a conta nova no finance
          if (dmContaContabil.insereContaContabil(ID_ORGANIZACAO, DESCRICAO, CONTAMEGA, DGVER, CODREDUZ, DGREDUZ, TIPO)) then
          begin  //AQUI ERRO
            memo.Lines.Add('Conta Nova : ' + CONTAMEGA + ' INSERIDA no Finance');
          end
          else
          begin
            memo.Lines.Add('Conta Nova : ' + CONTAMEGA + 'FALHA ao inserir no Finance');
          end;

      end
      else
      begin
      // se existir atualiza  no FINANCE
        idContaFin := dmContaContabil.qryObterPorCodigoReduzido.FieldByName('ID_CONTA_CONTABIL').AsString;

        if (dmContaContabil.atualizaDescricaoContaContabil(idContaFin, ID_ORGANIZACAO, DESCRICAO, CONTAMEGA, DGVER, CODREDUZ, DGREDUZ, TIPO)) then
        begin
          memo.Lines.Add('Conta : ' + CONTAMEGA + '  ATUALIZADA no Finance');
          memo.Lines.Add('----------------------------------------------------------------------------------');
          Application.ProcessMessages;
        end
      end;

      dbgPlanoMega.DataSource.DataSet.Next;
      dbgrdContasFinance.DataSource.DataSet.Next;
//      framePB1.lblProgressBar.Visible :=False;
      framePB1.progressBar(1 ,Trunc(qtdPlanoMega));
      Application.ProcessMessages;
    end;

  end;

  if (qtd > 0) then
  begin
    PempecMsg.MsgInformation('Existe(m) ' + IntToStr(qtd) + ' conta(s) para ser(em) cadastra(s) no Finance.');

  end
  else
  begin
    PempecMsg.MsgInformation('N�o existem contas a serem importadas.');
  end;

  framePB1.progressBar(0 ,0);
  framePB1.lblProgressBar.Caption := ' Sincronizar contas cont�beis... ' ;
  dbgPlanoMega.DataSource.DataSet.Refresh;
  dbgrdContasFinance.DataSource.DataSet.Refresh;
  btnBuscarPlanoMegaClick(self);
  memo.Lines.Clear;
  dxBarBtnSincronizar.Enabled := False;
  dxBarBtnFechar.Enabled := True;
  framePB1.Visible := False;
  Application.ProcessMessages;

end;

procedure TfrmSincronizaMega.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  memo.Lines.Clear;
  freeAndNilDM(Self);
  Action := caFree;
end;

procedure TfrmSincronizaMega.FormCreate(Sender: TObject);
begin
  lblNotSinc.Visible := False;
  btnBuscarPlanoMega.Visible := False;
  btnBuscarContasContabeis.Visible := False;
  dxBarBtnSincronizar.Enabled := False;
  dxBarBtnFechar.Enabled := True;
  sincAllow :=0;
  framePB1.progressBar(0,0);
  framePB1.lblProgressBar.Caption :=' Progresso da sincroniza��o ';

  inicializarDM(self);
  obterDadosEmpresaMega;


end;

procedure TfrmSincronizaMega.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;
  if (Assigned(dmContaContabil)) then
  begin
    FreeAndNil(dmContaContabil);
  end;

end;

procedure TfrmSincronizaMega.inicializarDM(Sender: TObject);
begin


 dmConexao.conectarBanco;
 dmConexao.conectarMega;


 if not (Assigned(dmMegaContabil)) then
  begin
    dmMegaContabil := TdmMegaContabil.Create(Self);
  end;

 if not (Assigned(dmContaContabil)) then
  begin
    dmContaContabil := TdmContaContabil.Create(Self);
  end;
end;

procedure TfrmSincronizaMega.obterDadosEmpresaMega;
begin
  if (dmMegaContabil.carregarDadosEmpresaMega(TOrgAtual.getCNPJ)) then
  begin

    idEmpresa := dmMegaContabil.qryDadosEmpresaMega.FieldByName('ID').AsInteger;
    lblEmpresa.Caption := dmMegaContabil.qryDadosEmpresaMega.FieldByName('NOME').AsString;
    lblCnpj.Caption := dmMegaContabil.qryDadosEmpresaMega.FieldByName('INSCMF').AsString;
  end;
end;

function TfrmSincronizaMega.permiteSincronizar: Boolean;
var
  qtdCcMega, qtdCCFinance: Integer;
  sincronize: Boolean;
begin
  sincronize := False;

  qtdCcMega := dmMegaContabil.dtsPlanoContas.DataSet.RecordCount;
  qtdCCFinance := dmContaContabil.dtsPlanoContas.DataSet.RecordCount;

  if qtdCCFinance <= qtdCcMega then
  begin
    sincronize := True;
  end;

  Result := sincronize;
end;

procedure ordenarDbGrid(Column: TColumn);
var
  strColumn: string;
  x: integer;
  JaEstaEmUso: Boolean;
  idOptions: TIndexOptions;
  dbgrGrid: TDbGrid;
begin
  dbgrGrid := TDbGrid(Column.Grid);
  with dbgrGrid.DataSource.DataSet do
  begin
    strColumn := INDICE_DEFAULT;
  end;
end;

end.


