unit uFrmManterCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel,
  uFrameContaContabil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,uCedenteModel,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg, dxBarBuiltInMenu, cxPC,
  uFrameBanco, uFrameGeneric, uFrameEstado, uFrameBairro, uFrameCidade,
  uFrameTipoCedente, EChkCNPJ;

type
  TfrmManterCedente = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    frmContaContabil1: TfrmContaContabil;
    dbgrd1: TDBGrid;
    dsCedente: TDataSource;
    edtCODREDUZ: TEdit;
    lbl1: TLabel;
    edtContaContabil: TEdit;
    lbl2: TLabel;
    edtNomeCedente: TEdit;
    edtCNPJCPF: TEdit;
    lblCPFCNPJ: TLabel;
    dxBarManager1Bar1: TdxBar;
    dxBtnEditar: TdxBarLargeButton;
    dxBarSalvar: TdxBar;
    dxBtnSalvar: TdxBarLargeButton;
    dxBarManager1Bar2: TdxBar;
    dxBtnNovo: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxBtnFechar: TdxBarLargeButton;
    dxBarManager1Bar4: TdxBar;
    dxBtnDeletar: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    cxbrdtmPesquisa: TcxBarEditItem;
    qryPreencheGrid: TFDQuery;
    cxpgcntrlPage: TcxPageControl;
    tbTransfereCedente: TcxTabSheet;
    tbTransfereEndereco: TcxTabSheet;
    tbTransfereContato: TcxTabSheet;
    tbTransfereContaBancaria: TcxTabSheet;
    tbTransfereContaContabil: TcxTabSheet;
    frmBanco1: TfrmBanco;
    edtAgencia: TEdit;
    edtConta: TEdit;
    lblAge: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtCelular: TEdit;
    edtDDDCEL: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    edt1: TEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    edt2: TEdit;
    edtEmail: TEdit;
    lbl12: TLabel;
    frmEstado1: TfrmEstado;
    frmCidade1: TfrmCidade;
    frmBairro1: TfrmBairro;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edtCEP: TEdit;
    lbl16: TLabel;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    frmTipoCedente1: TfrmTipoCedente;
    cbbPersonalidade: TComboBox;
    lbl5: TLabel;
    edtInscEstadual: TEdit;
    edtCGA: TEdit;
    edtInscMunicipal: TEdit;
    lbl22: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    dbgrdBanco: TDBGrid;
    lbl23: TLabel;
    dsBanco: TDataSource;
    qryGridBanco: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsCedenteDataChange(Sender: TObject; Field: TField);
    procedure frmContaContabil1cbbContaContabilChange(Sender: TObject);
    procedure dxBtnEditarClick(Sender: TObject);
    procedure dxBtnSalvarClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnNovoClick(Sender: TObject);
    procedure dxBtnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure edtCelularExit(Sender: TObject);
    procedure frmEstado1cbbcomboChange(Sender: TObject);
    procedure frmTipoCedente1cbbcomboChange(Sender: TObject);
    procedure frmCidade1cbbcomboChange(Sender: TObject);
    procedure frmBairro1cbbcomboChange(Sender: TObject);
    procedure edtCNPJCPFExit(Sender: TObject);
    procedure cbbPersonalidadeChange(Sender: TObject);
    procedure dsBancoDataChange(Sender: TObject; Field: TField);
    procedure dbgrdBancoTitleClick(Column: TColumn);
    procedure tbTransfereContaBancariaShow(Sender: TObject);
    procedure tbTransfereContaContabilShow(Sender: TObject);
    procedure tbTransfereContatoShow(Sender: TObject);
    procedure tbTransfereEnderecoShow(Sender: TObject);
    procedure tbTransfereCedenteShow(Sender: TObject);
  private
    { Private declarations }
   pIdContaContabil, pIdCedente,pIdTipo, pIdEndereco, pIdContato,  pIdOrganizacao, pIdUsuario :string;
  pIdBanco,  pIdCidade, pIdEstado,pIdBairro :string;

 FsListaPersonalidade,  FslistaTipo,    FsListaIdContas : TStringList;
   FslistaIdBanco,    FsListaIdEstado,FsListaIdCidade,FsListaIdBairro : TStringList;


    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure preencheComboTipo;
    function salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil,
      pTipo, pDescricao: string; pCodigo: Integer): Boolean;
    function qtdUso(pIdOrganizacao, pIdCedente: string): Integer;

    function deletar (cedenteModel :TCedenteModel): Boolean;
    procedure preencheComboPersonalidade;
    procedure preencheGrid(pIdOrganizacao :string);
    function obterPersonalidade(pPersonalidade: String): Integer;
    function obterTipoCedente(pTipo: String): Integer;
    procedure preecheGridBanco;
    function obterEnderecoPorId(pIdOrganizacao, pIdEndereco: string): TFDQuery;
    procedure preencheAbaEndereco(query: TFDQuery);
    procedure limparAba(aba: TcxTabSheet);


  public
    { Public declarations }


  end;

var
  frmManterCedente: TfrmManterCedente;

implementation

{$R *.dfm}

procedure TfrmManterCedente.cbbPersonalidadeChange(Sender: TObject);
begin
if cbbPersonalidade.ItemIndex >0 then
 edtCNPJCPF.Enabled := true;
end;

procedure TfrmManterCedente.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('NOME',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterCedente.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmManterCedente.dbgrdBancoTitleClick(Column: TColumn);
begin
 (dbgrdBanco.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

function TfrmManterCedente.deletar (cedenteModel :TCedenteModel): Boolean;
var cmd :string;
qryDel :TFDQuery;
begin

try

  if not (uutil.Empty( cedenteModel.FID)) then begin


      cmd := ' DELETE FROM CEDENTE  WHERE  (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_CEDENTE = :PID) ';

      qryDel := TFDQuery.Create(Self);
      qryDel.Close;
      qryDel.Connection := dmConexao.conn;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(cmd);
      qryDel.ParamByName('PIDORGANIZACAO').AsString := cedenteModel.FIDorganizacao;
      qryDel.ParamByName('PID').AsString := cedenteModel.FID;
      qryDel.ExecSQL;

  end;


  dmConexao.conn.CommitRetaining;

except
  dmConexao.conn.RollbackRetaining;
  Result := System.False;
raise Exception.Create(' N�o foi poss�vel deletar o Cedente. Inform ao suporte.');

end;
  limparPanel;
  Result := System.True;
end;

procedure TfrmManterCedente.dsBancoDataChange(Sender: TObject; Field: TField);
var
indice :Integer;
  I: Integer;
begin
  indice :=0;
  pIdBanco := qryGridBanco.FieldByName('ID_BANCO').AsString;

  for I := 0 to FslistaIdBanco.Count -1 do begin
     if FslistaIdBanco[I].Equals(pIdBanco) then begin
        indice := I;
     end;
  end;

  frmBanco1.cbbBanco.ItemIndex := indice;

end;

procedure TfrmManterCedente.dsCedenteDataChange(Sender: TObject;
  Field: TField);
  var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;


begin

    edtNomeCedente.Text :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('NOME').AsString;
    cbbPersonalidade.ItemIndex := obterPersonalidade( (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('PERSONALIDADE').AsString);
    frmTipoCedente1.cbbcombo.ItemIndex := obterTipoCedente((dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_TIPO_CEDENTE').AsString);

     if cbbPersonalidade.ItemIndex = 1 then begin
       //cpf
       edtCNPJCPF.Text := uutil.TFormat.formacpf((dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CPFCNPJ').AsString);
     end;

      if cbbPersonalidade.ItemIndex = 2 then begin
       //cnpj
       edtCNPJCPF.Text := uutil.TFormat.formacnpj((dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CPFCNPJ').AsString);
     end;

     edtCGA.Text            := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CGA').AsString;
     edtInscEstadual.Text   := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('INSCRICAO_ESTADUAL').AsString;
     edtInscMunicipal.Text  := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('INSCRICAO_MUNICIPAL').AsString;
     pIdCedente             := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CEDENTE').AsString;
     idContaContabil        := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTA_CONTABIL').AsString;
     pIdEndereco            := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_ENDERECO').AsString;

     //OBTER ENDERECO
         preencheAbaEndereco( obterEnderecoPorId(pIdOrganizacao,pIdEndereco));




    //  OBTER CONTATO



   // OBTER CONTA CONTABIL
    if not uUtil.Empty(idContaContabil) then
  begin

    for I := 0 to FsListaIdContas.Count -1 do begin
         if FsListaIdContas[I].Equals(idContaContabil) then begin
             frmContaContabil1.cbbContaContabil.ItemIndex := I;
            conta := TContaContabilModel.Create;
            conta := frmContaContabil1.obterPorID(pIdOrganizacao, idContaContabil);

            if not uUtil.Empty(conta.FCodigoReduzido)  then begin

              // edtDescricaoConta.Text := conta.FDescricao;
               edtCODREDUZ.Text := conta.FCodigoReduzido;
               edtContaContabil.Text :=conta.FConta;
            end;

         end;
    end;

  end
  else
  begin
    frmContaContabil1.cbbContaContabil.ItemIndex := 0;
   // edtDescricaoConta.Clear;
    edtCODREDUZ.Clear;
    edtContaContabil.Clear;
  end;

  //VERIFICA SE PODE DELETAR
    if qtdUso(pIdOrganizacao, pIdCedente) = 0 then
    begin
      dxBtnDeletar.Enabled := True;
    end
    else
    begin
      dxBtnDeletar.Enabled := False;
    end;

end;

procedure TfrmManterCedente.dxBtnDeletarClick(Sender: TObject);
var
cedenteModel :TCedenteModel;
begin

  cedenteModel := TCedenteModel.Create;
  cedenteModel.FIDorganizacao := pIdOrganizacao;
  cedenteModel.FID := pIdCedente;





 if deletar(cedenteModel) then begin
  ShowMessage('Cedente deletado com sucesso.');
 end;

end;

procedure TfrmManterCedente.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled :=False;
  frmContaContabil1.cbbContaContabil.Enabled :=True;
  cxbrdtmPesquisa.Enabled :=False;

  pIdCedente :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CEDENTE').AsString;
  pIdContaContabil := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTA_CONTABIL').AsString;
  dxBtnSalvar.Enabled :=true ;
  dxBtnNovo.Enabled :=False;

end;

procedure TfrmManterCedente.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterCedente.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;

  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;

  frmContaContabil1.cbbContaContabil.Enabled :=True;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;


  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;

  pIdCedente :='';
  cxbrdtmPesquisa.Enabled :=False;




end;

procedure TfrmManterCedente.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 pDescricao, pTipo :string;
 pCodigo :Integer;

begin
  if frmContaContabil1.cbbContaContabil.ItemIndex >0 then begin
    conta := TContaContabilModel.Create;
    pIdContaContabil := FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
    conta := TContaContabilModel.Create;
    conta := frmContaContabil1.obterPorID(pIdOrganizacao, pIdContaContabil);
  end;

 if not uUtil.Empty(pIdCedente) then begin
        pIdCedente :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CEDENTE').AsString;
 end;
{

  pDescricao   := UpperCase(edtHistorico.Text);
  pCodigo      := StrToInt(edtCodHistPadrao.Text);
  pTipo        := FslistaTipo[cbbTipo.ItemIndex];

  if salvarHistorico(pIdOrganizacao, pIdHistorico,pIdContaContabil,pTipo,pDescricao,pCodigo) then begin

      ShowMessage('Cedente salvo com sucesso.');

   end;   }

   limparPanel;

end;

procedure TfrmManterCedente.edtCelularExit(Sender: TObject);
begin
edtCelular.Text := uutil.FormatarTelefone (edtCelular.Text);
end;

procedure TfrmManterCedente.edtCNPJCPFExit(Sender: TObject);
begin
 if cbbPersonalidade.ItemIndex = 1 then begin
  //1 = cpf e 2 = cnpj
  lblCPFCNPJ.Caption := 'CPF';
  edtCNPJCPF.Text := uUtil.TFormat.formacpf(edtCNPJCPF.Text);
 end else
 begin
  lblCPFCNPJ.Caption := 'CNPJ';
  edtCNPJCPF.Text := uUtil.TFormat.formacnpj(edtCNPJCPF.Text);
 end;

end;

procedure TfrmManterCedente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterCedente.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmManterCedente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterCedente.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterCedente.frmBairro1cbbcomboChange(Sender: TObject);
begin
  pIdBairro := FsListaIdBairro[frmBairro1.cbbcombo.ItemIndex];
end;

procedure TfrmManterCedente.frmCidade1cbbcomboChange(Sender: TObject);
begin
 pIdCidade := FsListaIdCidade[frmCidade1.cbbcombo.ItemIndex];
 frmBairro1.obterTodosPorCidade(pIdCidade, frmBairro1.cbbcombo, FsListaIdBairro);
end;

procedure TfrmManterCedente.frmContaContabil1cbbContaContabilChange(
  Sender: TObject);
  var
  conta : TContaContabilModel;
begin
  if frmContaContabil1.cbbContaContabil.ItemIndex > 0 then
  begin
    pIdContaContabil := FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
    conta := TContaContabilModel.Create;
    conta := frmContaContabil1.obterPorID(pIdOrganizacao, pIdContaContabil);

    if not uUtil.Empty(conta.FCodigoReduzido) then
    begin
      edtCODREDUZ.Text := conta.FCodigoReduzido;
      edtContaContabil.Text := conta.FConta;
      pIdContaContabil :=conta.FIdContaContabil;
    end;

  end;

end;

procedure TfrmManterCedente.frmEstado1cbbcomboChange(Sender: TObject);
begin
 pIdEstado := FsListaIdEstado[frmEstado1.cbbcombo.ItemIndex];
 frmCidade1.obterPorEstado(pIdEstado,frmCidade1.cbbcombo, FsListaIdCidade);

end;

procedure TfrmManterCedente.frmTipoCedente1cbbcomboChange(Sender: TObject);
begin
 if frmTipoCedente1.cbbcombo.ItemIndex  >0 then begin

   pIdTipo := FslistaTipo[frmTipoCedente1.cbbcombo.ItemIndex];
 end;

end;

procedure TfrmManterCedente.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;

end;

procedure TfrmManterCedente.limparPanel();
begin
 uutil.LimpaTela(Self);
 limpaStatusBar;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

 frmBanco1.obterTodos(pIdOrganizacao, frmBanco1.cbbBanco, FslistaIdBanco);
 frmContaContabil1.obterTodos(pIdOrganizacao, frmContaContabil1.cbbContaContabil,FsListaIdContas);
 frmEstado1.obterTodos(frmEstado1.cbbcombo, FsListaIdEstado);

 preencheComboTipo();
 preencheComboPersonalidade;
 preencheGrid(pIdOrganizacao);
 preecheGridBanco;

 //botao editar muda
  dbgrd1.Enabled :=True;
  edtCODREDUZ.Clear;
  edtContaContabil.Clear;


  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := True;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;
  cxbrdtmPesquisa.Enabled :=True;

  frmContaContabil1.cbbContaContabil.ItemIndex :=0;

  //desabilitados
  edtCNPJCPF.Enabled := False; //cbPersonalidade quem libera

   cxpgcntrlPage.ActivePageIndex :=0;
end;

procedure TfrmManterCedente.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterCedente.preencheGrid(pIdOrganizacao: string);
var
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := ' SELECT C.ID_CEDENTE, C.ID_ORGANIZACAO,' +
                     ' C.ID_TIPO_CEDENTE, TC.DESCRICAO AS TIPO,  C.ID_ENDERECO,' +
                     ' C.ID_CONTATO, C.NOME, C.CPFCNPJ,' +
                     ' C.PERSONALIDADE, C.CONTA_BANCARIA,' +
                     ' C.AGENCIA, C.ID_BANCO, C.CGA,' +
                     ' C.INSCRICAO_ESTADUAL,  C.ID_CONTA_CONTABIL,' +
                     ' C.INSCRICAO_MUNICIPAL, C.ID_CARTAO_CREDITO,' +
                     ' C.DATA_REGISTRO, C.SACADO, C.STATUS, ' +
                     ' C.DATA_ULTIMA_ATUALIZACAO, C.CODIGO' +
             ' FROM CEDENTE C ' +
             ' INNER JOIN TIPO_CEDENTE TC ON (TC.ID_TIPO_CEDENTE = C.ID_TIPO_CEDENTE) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO) '+
             ' WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO ) ORDER BY C.NOME  ' ;
  try

        //qryPreencheGrid := TFDQuery.Create(Self);
        qryPreencheGrid.Close;
        qryPreencheGrid.SQL.Clear;
        qryPreencheGrid.SQL.Add(cmdSql);
        qryPreencheGrid.Connection := dmConexao.conn;
        qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryPreencheGrid.Open;

   { (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First; }

   except

   raise Exception.Create('Erro preencher grid');

  end;


end;

function TfrmManterCedente.qtdUso(pIdOrganizacao, pIdCedente: string): Integer;
  var
qryTP, qryTR : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
  qtd := 0;

  try

    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_PAGAR  FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_CEDENTE = :PID) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PID').AsString := pIdCedente;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_DEBITO FROM TESOURARIA_DEBITO TP '+
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_CEDENTE = :PID) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PID').AsString := pIdCedente;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;


  except
    raise Exception.Create('Erro ao buscar uso dos CEDENTES ');

  end;

  Result := qtd;

end;

procedure TfrmManterCedente.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function TfrmManterCedente.obterPersonalidade(pPersonalidade :String) :Integer;
var
  posicao: Integer;
  I: Integer;
begin
  posicao := 0;

  for I := 0 to FsListaPersonalidade.Count -1 do begin
       if FsListaPersonalidade[I].Equals(pPersonalidade) then begin
         posicao := I;
       end;
  end;

  Result := posicao;
end;

function TfrmManterCedente.obterTipoCedente(pTipo :String) :Integer;
var
  posicao: Integer;
  I: Integer;
begin
  posicao := 0;

  for I := 0 to FslistaTipo.Count -1 do begin
       if FslistaTipo[I].Equals(pTipo) then begin
         posicao := I;
       end;
  end;

  Result := posicao;
end;




procedure TfrmManterCedente.preencheComboTipo;
begin
frmTipoCedente1.obterTodos(pIdOrganizacao,frmTipoCedente1.cbbcombo, FslistaTipo);
end;


function  TfrmManterCedente.salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil, pTipo, pDescricao :string; pCodigo :Integer) :Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

   cmdSalvar := ' UPDATE HISTORICO  SET DESCRICAO = :PDESCRICAO ,  TIPO = :PTIPO, '+
                ' ID_CONTA_CONTABIL = :PIDCONTA , CODIGO = :PCODIGO, ' +
                ' DESCRICAO_REDUZIDA = :PDESCREDUZ ' +
                ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_HISTORICO = :PIDHISTORICO) ';



   if UUTIL.Empty(pIdHistorico) then begin

     pIdHistorico := dmConexao.obterNewID;


   cmdSalvar := ' INSERT  INTO HISTORICO (ID_HISTORICO, ID_ORGANIZACAO, ' +
                ' DESCRICAO, TIPO, CODIGO, ID_CONTA_CONTABIL, DESCRICAO_REDUZIDA  ) ' +
                ' VALUES (:PIDHISTORICO, :PIDORGANIZACAO, :PDESCRICAO, :PTIPO, :PCODIGO, :PIDCONTA, :PDESCREDUZ)' ;
   end;

    if not uUtil.Empty(pIdHistorico) then
    begin

      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySalvar.ParamByName('PDESCRICAO').AsString := UpperCase(pDescricao);
      qrySalvar.ParamByName('PDESCREDUZ').AsString := UpperCase(pDescricao);
      qrySalvar.ParamByName('PTIPO').AsString := UpperCase(pTipo);
      qrySalvar.ParamByName('PIDCONTA').AsString := pIdContaContabil;
      qrySalvar.ParamByName('PCODIGO').AsInteger := pCodigo;
      qrySalvar.ExecSQL;

      dmConexao.conn.CommitRetaining;
    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o historico.');
 end;

  Result :=True;
end;

procedure TfrmManterCedente.tbTransfereCedenteShow(Sender: TObject);
begin
 dbgrd1.Visible :=True;
  msgStatusBar(1,' Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ');

end;

procedure TfrmManterCedente.tbTransfereContaBancariaShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
 msgStatusBar(1,'Dados da conta banc�ria');

end;

procedure TfrmManterCedente.tbTransfereContaContabilShow(Sender: TObject);
begin
  dbgrd1.Visible :=False;
   msgStatusBar(1,'Dados da conta cont�bil');
end;

procedure TfrmManterCedente.tbTransfereContatoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Contatos cadastrados');
end;

procedure TfrmManterCedente.tbTransfereEnderecoShow(Sender: TObject);
begin
 dbgrd1.Visible :=False;
  msgStatusBar(1,'Dados do endere�o');
end;

procedure TfrmManterCedente.preencheComboPersonalidade;
begin

  FsListaPersonalidade :=TStringList.Create;
  FsListaPersonalidade.Clear;
  FsListaPersonalidade.Add('0');
  FsListaPersonalidade.Add('PF');
  FsListaPersonalidade.Add('PJ');


  cbbPersonalidade.Clear;
  cbbPersonalidade.Items.Add(' >>Selecione<<');
  cbbPersonalidade.Items.Add('P. Fisica');
  cbbPersonalidade.Items.Add('P. Juridica');

  cbbPersonalidade.ItemIndex :=0;


end;


procedure TfrmManterCedente.preecheGridBanco;
begin

 dmConexao.conectarBanco;
 try

   qryGridBanco.Close;
   qryGridBanco.Connection := dmConexao.conn;
   qryGridBanco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryGridBanco.Open;

 except
 raise Exception.Create('Erro ao obter lista de bancos');

 end;

end;

function TfrmManterCedente.obterEnderecoPorId(pIdOrganizacao, pIdEndereco :string) :TFDQuery;
var
qryEndereco :TFDQuery;
sqlEnd :string;
begin
dmConexao.conectarBanco;

qryEndereco := TFDQuery.Create(Self);

sqlEnd := ' SELECT E.ID_ENDERECO, E.ID_ORGANIZACAO, ' +
          ' E.ID_ESTADO, E.LOGRADOURO, E.COMPLEMENTO,' +
          ' E.ID_BAIRRO, E.NUMERO, E.CEP, E.ID_CIDADE' +
          ' FROM ENDERECO E  ' +
          ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
          '  AND  (E.ID_ENDERECO = :PIDENDERECO) ';
 try
     qryEndereco.Close;
     qryEndereco.Connection := dmConexao.conn;
     qryEndereco.SQL.Clear;
     qryEndereco.SQL.Add(sqlEnd);
     qryEndereco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryEndereco.ParamByName('PIDENDERECO').AsString := pIdEndereco;
     qryEndereco.Open;
 except

  raise Exception.Create('Erro ao obter endere�o ');

 end;

 Result := qryEndereco;

end;

procedure TfrmManterCedente.preencheAbaEndereco( query :TFDQuery);
var
  I,J,F: Integer;
begin
  if not query.IsEmpty then begin

    pIdEndereco := query.FieldByName('ID_ENDERECO').AsString;
    pIdEstado   := query.FieldByName('ID_ESTADO').AsString;
    pIdCidade   := query.FieldByName('ID_CIDADE').AsString;
    pIdBairro   := query.FieldByName('ID_BAIRRO').AsString;


    edtLogradouro.Text  := query.FieldByName('LOGRADOURO').AsString;
    edtNumero.Text      := query.FieldByName('NUMERO').AsString;
    edtCEP.Text         := query.FieldByName('CEP').AsString;
    edtComplemento.Text := query.FieldByName('COMPLEMENTO').AsString;

    for I := 0 to FsListaIdEstado.Count -1 do begin
          if FsListaIdEstado[I].Equals(pIdEstado) then begin
          frmEstado1.cbbcombo.ItemIndex := I ;
          Break
          end
    end;

    if frmEstado1.cbbcombo.ItemIndex >0 then begin
       frmCidade1.obterPorEstado(pIdEstado, frmCidade1.cbbcombo, FsListaIdCidade);
    end;


     for J := 0 to FsListaIdCidade.Count -1 do begin
          if FsListaIdCidade[J].Equals(pIdCidade) then begin
          frmCidade1.cbbcombo.ItemIndex := J ;
          Break
          end
    end;

    if frmCidade1.cbbcombo.ItemIndex >0 then begin

      frmBairro1.obterTodosPorCidade(pIdCidade, frmBairro1.cbbcombo, FsListaIdBairro);

    end;


      for F := 0 to FsListaIdBairro.Count -1 do begin
          if FsListaIdBairro[F].Equals(pIdBairro) then begin
          frmBairro1.cbbcombo.ItemIndex := F ;
          Break
          end
    end;


  end else begin

    limparAba(tbTransfereEndereco);
     frmEstado1.limpaFrame;

   // frmEstado1.cbbcombo.ItemIndex := 0;
    frmCidade1.cbbcombo.ItemIndex := 0;
    frmBairro1.cbbcombo.ItemIndex := 0;

  end;

end;

procedure TfrmManterCedente.limparAba(aba :TcxTabSheet );
var
 j, i: Integer;
begin
 // limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
       if TCustomEdit(Components[i]).Parent = aba then
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Parent = aba then
         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin
    if TComboBox(Components[i]).Parent = aba then
      TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;


end;




end.
