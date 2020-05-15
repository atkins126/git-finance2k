unit uFrmRelatorioPagamentosHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uUtil,  udmConexao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uDmRelTPHistorico, udmOrganizacao, frxClass,
  EFrmLab, frxDBSet, frxExportCSV, frxExportPDF, FireDAC.Stan.Intf,uContaContabilModel,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxExportBaseDialog, uFrameGeneric,
  uFrameHistorico, cxGraphics, cxControls, cxLookAndFeels, uCedenteDAO, uCedenteModel, uHistoricoDAO, uHistoricoModel,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxStatusBar,
  Vcl.ExtCtrls, cxClasses, dxBar, EMsgDlg, dxRibbonSkins,
  dxRibbonCustomizationForm, dxRibbon, dxBarExtItems;

type
  TfrmCTPHistorico = class(TForm)
    dbgTitulos: TDBGrid;
    frxDBCedente: TfrxDBDataset;
    frxRelTitulosPorCedente: TfrxReport;
    frxDBTitulosPorCedente: TfrxDBDataset;
    qryTitulosPorFornecedor: TFDQuery;
    dsPreencheGrid: TDataSource;
    qryObterCedentePorID: TFDQuery;
    qryComboFornecedor: TFDQuery;
    dxStatusBar: TdxStatusBar;
    Panel1: TPanel;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar5: TdxBar;
    dxBarBtnFechar: TdxBarLargeButton;
    dxBarBtnImprimir: TdxBarLargeButton;
    dxBarBtnPesquisa: TdxBarLargeButton;
    cbxFornecedor: TdxBarCombo;
    cbxHistorico: TdxBarCombo;
    dtDataInicial: TdxBarDateCombo;
    dtDataFinal: TdxBarDateCombo;
    dxBarManager1Bar6: TdxBar;
    cbxOrdem: TdxBarCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbgTitulosTitleClick(Column: TColumn);
    procedure dxBarBtnFecharClick(Sender: TObject);
    procedure dxBarBtnImprimirClick(Sender: TObject);
    procedure dxBarBtnPesquisaClick(Sender: TObject);
    procedure cbxHistoricoChange(Sender: TObject);
    procedure cbxFornecedorChange(Sender: TObject);

  private
    { Private declarations }
    FsListaIdFornecedor: TStringList;
   // FsListaIdCedente: TStringList;
    FsListaIdHistorico: TStringList;

     pIdHistorico,   idOrganizacao,  idCedente: String;
    pDataInicial, pDataFinal: TDate;

    codigoErro :string;
    cedenteModel :TCedenteModel;

   procedure msgStatusBar(pPosicao: Integer; msg: string);

    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    function retornarCaminhoRelatorio(tipo: Integer): string;
    function retornarCampoOrdenacao: string;
    function validarFormulario: boolean;
    procedure carregaComboCedente;
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdHistorico, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
    function obterCedentePorId(pIdOrganizacao, pIdCedente: String): Boolean;
    function preencheComboFornecedor(pIdOrganizacao: String): Boolean;
    procedure carregaComboHistorico;
    function obterHistoricosPorTipo(pIDOrganizacao, pTipoHistorico: string;  var combo: TdxBarCombo; var listaID: TStringList): boolean;

  public
    { Public declarations }
  end;

var
  frmCTPHistorico: TfrmCTPHistorico;

implementation

{$R *.dfm}

function TfrmCTPHistorico.preencheComboFornecedor(pIdOrganizacao: String): Boolean;

begin
  codigoErro := 'REL_PG_HST - COMBO CEDENTE ';
  Result := false;
 { cmd := 'SELECT C.NOME,C.ID_CEDENTE FROM CEDENTE C ' +
    ' WHERE ( C.ID_ORGANIZACAO = :pIdOrganizacao ) ' + ' ORDER BY C.NOME;';    }


   try
    qryComboFornecedor.Close;
    qryComboFornecedor.Connection := dmConexao.Conn;
    qryComboFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryComboFornecedor.Open;
    Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ' + codigoErro );
  end;

  Result := not qryComboFornecedor.IsEmpty;

end;


function TfrmCTPHistorico.obterHistoricosPorTipo(pIDOrganizacao,  pTipoHistorico: string; var combo: TdxBarCombo; var listaID: TStringList): boolean;
var
qryObterPorTipo :TFDQuery;
sqlCmd : string;
begin
 dmConexao.conectarBanco;

 try

   sqlCmd :=  ' SELECT H.ID_HISTORICO, H.ID_ORGANIZACAO,  H.DESCRICAO AS DESCRICAO_HISTORICO, H.TIPO, '+
              ' H.CODIGO, H.DESCRICAO_REDUZIDA, CC.CONTA, CC.DESCRICAO AS DESCRICAO_CONTA, CC.CODREDUZ AS CODIGO_REDUZ '+
              ' FROM HISTORICO H '+
              ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
              ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (H.TIPO = :PTIPO) ORDER BY H.DESCRICAO ';


   qryObterPorTipo := TFDQuery.Create(Self);
   qryObterPorTipo.Close;
   qryObterPorTipo.Connection := dmConexao.conn;
   qryObterPorTipo.SQL.Clear;
   qryObterPorTipo.sql.Add(sqlCmd);


   qryObterPorTipo.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
   qryObterPorTipo.ParamByName('PTIPO').AsString := pTipoHistorico;
   qryObterPorTipo.Open;
   qryObterPorTipo.Last;
   //qryObterPorTipo.RecordCount;

   listaID := TStringList.Create;
    listaID.Clear;
   listaID.Add('Sem ID');
   combo.Items.Clear;
   combo.Items.Add('<<< Selecione  >>>');


   if not qryObterPorTipo.IsEmpty then begin
          qryObterPorTipo.First;

      while not qryObterPorTipo.Eof do
        begin
          combo.Items.Add(qryObterPorTipo.FieldByName('DESCRICAO_HISTORICO').AsString);
          listaID.Add(qryObterPorTipo.FieldByName('ID_HISTORICO').AsString);
          qryObterPorTipo.Next;
        end;
      qryObterPorTipo.Close;
      combo.ItemIndex := 0;

   end;


 except

 raise Exception.Create('Erro ao obter hist�ricos por tipo');

 end;


end;



function TfrmCTPHistorico.obterCedentePorId(pIdOrganizacao,  pIdCedente: String): Boolean;
var
cmd :string;

begin
  codigoErro := 'REL_PG_HST - CEDENTE ';
  Result := false;
  cmd := ' SELECT * FROM CEDENTE C ' +
         ' WHERE (C.ID_ORGANIZACAO = :pIdOrganizacao) ' + ' AND ' +
         ' (C.ID_CEDENTE = :pIdCedente)';

    try
        qryObterCedentePorID.Close;
        qryObterCedentePorID.Connection := dmConexao.Conn;
        qryObterCedentePorID.SQL.Clear;
        qryObterCedentePorID.SQL.Add(cmd);
        qryObterCedentePorID.ParamByName('pIdOrganizacao').AsString :=  pIdOrganizacao;
        qryObterCedentePorID.ParamByName('pIdCedente').AsString := pIdCedente;
        qryObterCedentePorID.Open;

    Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ' + codigoErro );
  end;
    Result := not qryObterCedentePorID.IsEmpty;
  end;


procedure TfrmCTPHistorico.carregaComboHistorico;
begin
  obterHistoricosPorTipo(idOrganizacao,'P',cbxHistorico, FsListaIdHistorico);

end;

procedure TfrmCTPHistorico.carregaComboCedente;
begin

  FsListaIdFornecedor := TStringList.Create;
  FsListaIdFornecedor.Clear;
  FsListaIdFornecedor.Add('Sem ID');
  cbxFornecedor.Items.Clear;
  cbxFornecedor.Items.Add('<<< Selecione  >>>');

  if preencheComboFornecedor(idOrganizacao) then begin
      qryComboFornecedor.First;

      while not qryComboFornecedor.Eof do
      begin
        cbxFornecedor.Items.Add(qryComboFornecedor.FieldByName('NOME').AsString);
        FsListaIdFornecedor.Add(qryComboFornecedor.FieldByName('ID_CEDENTE').AsString);
        qryComboFornecedor.Next;
      end;

      cbxFornecedor.ItemIndex := 0;
  end;

end;

procedure TfrmCTPHistorico.cbxFornecedorChange(Sender: TObject);

begin

   inicializarDM(Self);

  if cbxFornecedor.ItemIndex < 0 then
  begin
    cbxFornecedor.Text := '';
  end;

  if validarFormulario then
  begin
    if cbxFornecedor.ItemIndex > 0 then
    begin
      idCedente := FsListaIdFornecedor[cbxFornecedor.ItemIndex];
      dxBarBtnPesquisa.Enabled := True;

      obterCedentePorId(idOrganizacao, idCedente);
      cedenteModel := TCedenteModel.Create;
      cedenteModel.FIDorganizacao := idOrganizacao;
      cedenteModel.FID := idCedente;
      cedenteModel := TCedenteDAO.obterPorID(cedenteModel);

      if uUtil.Empty(cedenteModel.FID) then
      begin

        PempecMsg.MsgError('N�o foi poss�vel localizar o cedente. ');
        cbxFornecedor.ItemIndex := 0;
        dxBarBtnPesquisa.Enabled := False;

      end
      else
      begin

        dxRibbon1Tab1.Caption := cbxFornecedor.Text;
        cbxHistorico.Enabled := True;
        Panel1.Caption := ' Pesquisar  ' + cedenteModel.Fnome ;

      end;

    end else begin  PempecMsg.MsgWarning('O campo fornecedor � obrigat�rio.'); end;
  end;


end;

procedure TfrmCTPHistorico.cbxHistoricoChange(Sender: TObject);
var conta : TContaContabilModel;
 historicoModel : THistoricoModel;

begin

 // conta :=TContaContabilModel.Create;
  if cbxHistorico.ItemIndex >0  then begin
     pIdHistorico := FsListaIdHistorico[cbxHistorico.ItemIndex];
     dxBarBtnPesquisa.Enabled := True;

     historicoModel := THistoricoModel.Create;
     historicoModel.FIdOrganizacao := idOrganizacao;
     historicoModel.FID := pIdHistorico;

     historicoModel := THistoricoDAO.obterPorID(historicoModel);

     if not uutil.Empty(historicoModel.FID) then begin

       Panel1.Caption := ' Pesquisar  ' + cedenteModel.Fnome  + ' com hist�rico ' + historicoModel.FDescricao ;

     end else begin    Panel1.Caption := ''; end;




  end else begin

  pIdHistorico := '';

  end;
end;


procedure TfrmCTPHistorico.dbgTitulosTitleClick(Column: TColumn);
begin
  (dbgTitulos.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmCTPHistorico.dxBarBtnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmCTPHistorico.dxBarBtnImprimirClick(Sender: TObject);
begin
  dmOrganizacao.carregarDadosOrganizacaoFNC(idOrganizacao);
  if validarFormulario then
  begin

    if obterTitulosPorFornecedor(idOrganizacao, pIdHistorico, idCedente, retornarCampoOrdenacao, pDataInicial, pDataFinal) then
    begin
      dsPreencheGrid.DataSet := qryTitulosPorFornecedor;
      if not (dmRelTPHistorico.dataSourceIsEmpty(dsPreencheGrid)) then
      begin
          //tipo 1 = relTitulosPorCedenteDetalhado.fr3
        exibirRelatorio(1); //
      end;
    end;

  end;

  cbxHistorico.Enabled := False;
  dxBarBtnImprimir.Enabled := False;

end;

procedure TfrmCTPHistorico.dxBarBtnPesquisaClick(Sender: TObject);
var
  valorDebito, valorCredito: Currency;
begin

     pDataInicial :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataInicial.Date));
     pDataFinal :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataFinal.Date));

  if (cbxFornecedor.ItemIndex > (-1)) then
  begin
    if validarFormulario then
    begin
      valorDebito := dmRelTPHistorico.obterTotalPorFornecedor(idOrganizacao, idCedente, pDataInicial, pDataFinal);

      msgStatusBar(0, 'Valor devido : ');
      msgStatusBar(1, FormatCurr('R$ ' + '#,,0.00', valorDebito));

      valorCredito := dmRelTPHistorico.obterTotalQuitadoPorFornecedor(idOrganizacao, idCedente, pDataInicial, pDataFinal);
      msgStatusBar(2, 'Valor pago : ');
      msgStatusBar(3, FormatCurr('R$ ' +'#,,0.00', valorCredito));

      msgStatusBar(4, 'Saldo : ');
      msgStatusBar(5, FormatCurr('R$ ' +'#,,0.00', (valorDebito - valorCredito)));

      if cbxHistorico.ItemIndex > 0 then
      begin

        pIdHistorico := FsListaIdHistorico[cbxHistorico.ItemIndex];

      end;


      if obterTitulosPorFornecedor(idOrganizacao, pIdHistorico, idCedente, retornarCampoOrdenacao, pDataInicial,pDataFinal)
      then
      begin
         dsPreencheGrid.DataSet := qryTitulosPorFornecedor;
         dbgTitulos.DataSource := dsPreencheGrid;
         dxBarBtnImprimir.Enabled := True;

      end;

    end;
  end;

           cbxHistorico.Enabled := False;

end;

function TfrmCTPHistorico.retornarCampoOrdenacao: string;
begin
  case cbxOrdem.ItemIndex of
    0:
      Result := 'TP.VALOR_NOMINAL';
    1:
      Result := 'TP.DATA_VENCIMENTO';
    2:
      Result := 'TP.DATA_PAGAMENTO';

  end;
end;

procedure TfrmCTPHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freeAndNilDM(Self);
  Action := caFree;
end;

procedure TfrmCTPHistorico.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
  carregaComboCedente;
  carregaComboHistorico;
  cbxOrdem.ItemIndex := 0;
  dtDataInicial.Date := now;
  dtDataFinal.Date := now;
  dxBarBtnPesquisa.Enabled := False;
  cbxHistorico.Enabled := False;
  dxBarBtnImprimir.Enabled := False;
  Panel1.Caption := '';

//frameHistorico1.obterTodos(idOrganizacao,frameHistorico1.cbbcombo, FsListaIdHistorico );

end;


procedure TfrmCTPHistorico.freeAndNilDM(Sender: TObject);
begin
     dmConexao.conectarBanco;

  if (Assigned(dmRelTPHistorico)) then
  begin
    FreeAndNil(dmRelTPHistorico);
  end;

end;

procedure TfrmCTPHistorico.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not(Assigned(dmRelTPHistorico)) then
  begin
    dmRelTPHistorico := TdmRelTPHistorico.Create(Self);
  end;

  idOrganizacao := TOrgAtual.getId;

  Panel1.Caption := ' ';

end;

function TfrmCTPHistorico.retornarCaminhoRelatorio(tipo: Integer): string;
begin

  case tipo of

    0:  Result := uUtil.TPathRelatorio.getPagtoCedenteDetalhado;
    1:  Result := uUtil.TPathRelatorio.getPagtoCedenteDetalhado;

  end;

end;

function TfrmCTPHistorico.validarFormulario: boolean;
var
  valido: boolean;
begin
  valido := false;
  dxBarBtnImprimir.Enabled := True;

  if not(idOrganizacao = '') then
  begin
    valido := true;
  end;

  if cbxFornecedor.ItemIndex = 0 then begin

     valido := False;
      dxBarBtnImprimir.Enabled := False;
  end;


  Result := valido;
end;


procedure TfrmCTPHistorico.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxRelTitulosPorCedente.Variables do
  begin
    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=    QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));
    Variables['strTipoStatus'] := 'TODOS';

  end;
end;

procedure TfrmCTPHistorico.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

function TfrmCTPHistorico.obterTitulosPorFornecedor(pIdOrganizacao, pIdHistorico, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
  var cmd :string;
  auxCmd :Integer;
begin

 auxCmd :=0;
 //somente cedente
cmd := ' SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.VALOR_NOMINAL, TP.NUMERO_DOCUMENTO, TP.DATA_EMISSAO, '+
       ' TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DESCRICAO, TP.PARCELA, TP.ID_TIPO_STATUS, H.descricao AS HISTORICO, CC.descricao AS CENTRO_C ' +
       ' FROM  TITULO_PAGAR TP ' +
       ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.id_organizacao = TP.id_organizacao) ' +
       ' LEFT OUTER JOIN centro_custo CC ON (CC.ID_CENTRO_CUSTO = TP.id_centro_custo) AND ( CC.id_organizacao = TP.id_organizacao) ' +
       ' WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' +
       ' (TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' +
       ' (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
       ' (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' +
       ' ORDER BY ' + campoOrdem;

   if not uUtil.Empty(pIdHistorico) then begin
       auxCmd :=1;


        //historico e cedente
        cmd := ' SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.VALOR_NOMINAL, TP.NUMERO_DOCUMENTO, TP.DATA_EMISSAO, '+
       ' TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DESCRICAO, TP.PARCELA, TP.ID_TIPO_STATUS, H.descricao AS HISTORICO, CC.descricao AS CENTRO_C ' +
       ' FROM  TITULO_PAGAR TP ' +
       ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.id_organizacao = TP.id_organizacao) ' +
       ' LEFT OUTER JOIN centro_custo CC ON (CC.ID_CENTRO_CUSTO = TP.id_centro_custo) AND ( CC.id_organizacao = TP.id_organizacao) ' +
       ' WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' +
       ' (TP.ID_HISTORICO = :PIDHISTORICO) AND ' +
       ' (TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' +
       ' (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
       ' (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' +
       ' ORDER BY ' + campoOrdem;

       //s� historico
      if uutil.Empty(idCedente) then begin
         auxCmd :=2;

        cmd := ' SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.VALOR_NOMINAL, TP.NUMERO_DOCUMENTO, TP.DATA_EMISSAO, '+
       ' TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DESCRICAO, TP.PARCELA, TP.ID_TIPO_STATUS, H.descricao AS HISTORICO, CC.descricao AS CENTRO_C ' +
       ' FROM  TITULO_PAGAR TP ' +
       ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.id_organizacao = TP.id_organizacao) ' +
       ' LEFT OUTER JOIN centro_custo CC ON (CC.ID_CENTRO_CUSTO = TP.id_centro_custo) AND ( CC.id_organizacao = TP.id_organizacao) ' +
       ' WHERE ' +
       ' (TP.ID_HISTORICO = :PIDHISTORICO) AND ' +
       ' (TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' +
       ' (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
       ' (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' +
       ' ORDER BY ' + campoOrdem;

      end;




   end;


 try

    qryTitulosPorFornecedor.Close;
    qryTitulosPorFornecedor.Connection := dmConexao.Conn;
    qryTitulosPorFornecedor.SQL.Clear;
    qryTitulosPorFornecedor.SQL.Add(cmd);
    qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsDate    :=   pDataInicial;
    qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsDate      :=   pDataFinal;

    if auxCmd = 0  then begin   //s� cedente
    qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString     := pIdCedente;
    end;


    if auxCmd = 1 then
    begin   //cedente com historico
      qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTitulosPorFornecedor.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
    end;

    if auxCmd = 2 then
    begin //s� historico
      qryTitulosPorFornecedor.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
    end;
    qryTitulosPorFornecedor.Open;

  except
    raise Exception.Create('Erro ao tentar Obter TPFornecedor ');

  end;


  Result := not qryTitulosPorFornecedor.IsEmpty;
end;

procedure TfrmCTPHistorico.exibirRelatorio(tipo: Integer);
begin
  frxRelTitulosPorCedente.Clear;
  if not(frxRelTitulosPorCedente.LoadFromFile(retornarCaminhoRelatorio(tipo)))
  then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(pDataInicial, pDataFinal);
    frxRelTitulosPorCedente.OldStyleProgress := true;
    frxRelTitulosPorCedente.ShowProgress := true;
    frxRelTitulosPorCedente.ShowReport;

  end;
end;

end.