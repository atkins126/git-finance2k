unit uFrmSincronizaMega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, RxCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  uFrameProgressBar;

type
  TfrmSincronizaMega = class(TForm)
    lbl1: TLabel;
    panelMega: TRxPanel;
    lbl2: TLabel;
    lblEmpresa: TLabel;
    lbl3: TLabel;
    lblCnpj: TLabel;
    btnBuscarPlanoMega: TBitBtn;
    dbgPlanoMega: TDBGrid;
    btnBuscarContasContabeis: TBitBtn;
    lblNotSinc: TLabel;
    btnBuscarPlanos: TBitBtn;
    btnVerificar: TBitBtn;
    dbgrdContasFinance: TDBGrid;
    lbl4: TLabel;
    lbl5: TLabel;
    memo: TMemo;
    framePB1: TframePB;
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarPlanoMegaClick(Sender: TObject);
    procedure btnBuscarContasContabeisClick(Sender: TObject);
    procedure btnBuscarPlanosClick(Sender: TObject);
    procedure btnVerificarClick(Sender: TObject);
    function verificarSeContaExiste(pIdOrganizacao, pValue, pCampo: string): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  btnBuscarPlanoMega.Click;
  btnBuscarContasContabeis.Click;

  if sincAllow >1 then begin
    btnVerificar.Enabled := True
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

procedure TfrmSincronizaMega.btnVerificarClick(Sender: TObject);
var
  CONTAMEGA, idContaFin, contaFin: string;
 qtdPlanoMega, qtd: Integer;
var
  ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string;
begin
  qtdPlanoMega := dbgPlanoMega.DataSource.DataSet.RecordCount;
  memo.Lines.Clear;

  if (dbgPlanoMega.DataSource.DataSet.RecordCount > 0) then
  begin
    dbgPlanoMega.DataSource.DataSet.First;

    while not (dbgPlanoMega.DataSource.DataSet.eof) do
    begin

      CODREDUZ := IntToStr(dbgPlanoMega.DataSource.DataSet.FieldByName('CODREDUZ').AsInteger);
      CONTAMEGA := dbgPlanoMega.DataSource.DataSet.FieldByName('CONTA').AsString;
      ID_ORGANIZACAO := TOrgAtual.getId;
      DESCRICAO := dbgPlanoMega.DataSource.DataSet.FieldByName('NMCONTA').AsString;
      DGVER := dbgPlanoMega.DataSource.DataSet.FieldByName('DGVER').AsString;
      DGREDUZ := dbgPlanoMega.DataSource.DataSet.FieldByName('DGREDUZ').AsString;
      TIPO := dbgPlanoMega.DataSource.DataSet.FieldByName('TIPO').AsString;

      //verifica se o codigo reduzido  existe
      //VERIFICA SE A CONTA DO MEGA EXISTE NO FINANCE.
      //se existir, atualiza.

      if not verificarSeContaExiste(TOrgAtual.getId, CONTAMEGA, 'CONTA') then
      begin
        //verificar se existe o codigo reduzido. se existir, informar e nao cadastrar.
        if not verificarSeContaExiste(TOrgAtual.getId, CODREDUZ, 'CODREDUZ') then
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
          memo.Lines.Add('Tentativa sem sucesso de inserir a conta  : ' + CONTAMEGA + ' Codigo reduzido. ' + CODREDUZ + ' localizado. Contate o suporte. ');
        end;
      end
      else
      begin
      // se existir atualiza  no FINANCE
        idContaFin := dmContaContabil.qryObterPorConta.FieldByName('ID_CONTA_CONTABIL').AsString;
        ID_ORGANIZACAO := TOrgAtual.getId;

        if (dmContaContabil.atualizaDescricaoContaContabil(idContaFin, ID_ORGANIZACAO, DESCRICAO, CONTAMEGA, DGVER, CODREDUZ, DGREDUZ, TIPO)) then
        begin
          memo.Lines.Add('Conta : ' + CONTAMEGA + '  ATUALIZADA no Finance');
          memo.Lines.Add('----------------------------------------------------------------------------------');
          Application.ProcessMessages;
        end
      end;

      dbgPlanoMega.DataSource.DataSet.Next;
      dbgrdContasFinance.DataSource.DataSet.Next;
      framePB1.lblProgressBar.Visible :=False;
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

  dbgPlanoMega.DataSource.DataSet.Refresh;
  dbgrdContasFinance.DataSource.DataSet.Refresh;
  btnBuscarPlanoMegaClick(self);
  memo.Lines.Clear;
  btnVerificar.Enabled := False;
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
  btnVerificar.Enabled := False;
  sincAllow :=0;

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

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    BDConectado :=False;
  end;

    try
    BDConectado := dmConexao.conectarBanco;

    except
     on E: Exception do
      ShowMessage(' '+ e.Message);
     end;

    try
        dmConexao.conectarMega;

    except
     on E: Exception do
      ShowMessage(' '+ e.Message);
    end;


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


