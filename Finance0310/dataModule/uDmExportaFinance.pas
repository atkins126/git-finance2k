unit uDMExportaFinance;

interface

uses
  System.SysUtils, uDMMegaContabil, System.Classes, UMostraErros, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, uLancamentoCreditoModel,
  uLancamentoDebitoModel, uUtil, uListaLancamentosCredito, uListaLancamentosDebito, uListaLancamentos;

type
  TdmExportaFinance = class(TDataModule)
    qryGravarLoteContabil: TFDQuery;
    qryObterCentroCustoPorTitulo2: TFDQuery;
    qryObterCBTPERIODO: TFDQuery;
    qryObterCBCPERIODO: TFDQuery;
    qryObterCBDPERIODO: TFDQuery;
    qryObterTDPERIODO: TFDQuery;
    qryObterTCPERIODO: TFDQuery;
    qryObterPendentes: TFDQuery;
    qryInserePendente: TFDQuery;
    qryLimparPendentes: TFDQuery;
    qryObterValorDebitoGeneric: TFDQuery;
    qryUpdateGeneric: TFDQuery;
    qryHstSemCC: TFDQuery;
    qryBancoCaixa: TFDQuery;
    qryCaixaBanco: TFDQuery;
    qryTPPROVBASE: TFDQuery;
    qryTPPROVDB: TFDQuery;
    qryTPPROVCR: TFDQuery;
    qryCR: TFDQuery;
    qryObterValorTitulo: TFDQuery;
    qryTPB_PROV: TFDQuery;
    qryTRBAcrescimos: TFDQuery;
    qryTPBAcrescimos: TFDQuery;
    qryTPBDeducao: TFDQuery;
    qryTPBCaixa: TFDQuery;
    qryTPBCheque: TFDQuery;
    qryTPBInternet: TFDQuery;
    qryObterTodosLoteContabil: TFDQuery;
    qryDeletaLoteContabil: TFDQuery;
    qrytpprovbase_1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FsListaDebito: TListaLancamentoDebito;
    FsListaCredito: TListaLancamentoCredito;
    FsListaLancamentos: TListaLancamentos;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    function getListaForMega: TListaLancamentos;
    function obterTPProvCR(pIdOrganizacao, pRegistroProvisao: string): Boolean;
    function obterTPProvDB(pIdOrganizacao, pRegistroProvisao: string): Boolean;
    function obterTPBAC(pIdOrganizacao, pIdTPB: String): Boolean; //obtem acrescimos
    function obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBCAIXA(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCHEQUE(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBINTERNET(pIdOrganizacao, pIdTPB: String): Boolean;

      //obtem deducoes

    {  FormatDateTime('mm/dd/yyyy', pDataInicial);}


  public
    { Public declarations }
//  function obterTPProvisionados(pIdOrganizacao,pIdStatus :String ; pDataInicial, pDataFinal:TDate;pProvisao :Integer): Boolean;
    function obterListaHistoricoSemContaContabil(pIdOrganizacao: String): Boolean;

    function obterCBCPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
    function obterCBDPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
    function obterTCPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
    function obterTDPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;

    function inserePendente(pIdOrganizacao, pTIPO, pIDENTIFICACAO, pPENDENCIA: string; pVALOR: Currency): Boolean;

    function limpaPendentes(pIdOrganizacao: string): Boolean;
    function obterPendentesPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): Boolean;
    procedure validarLancamentos(pIdOrganizacao: string; plista: TListaLancamentos; pCodeEmpresa: Integer);
    function obterValorDebitoGeneric(pIdOrganizacao,pTable,pCampoSum, pCampoData :string; pDataInicial, pDataFinal: TDate ):Currency;
    function obterValorDebitoGenericTOB(pIdOrganizacao, pTable, pCampo, pTipo: string; pDataInicial, pDataFinal: TDate): Currency;
    function updateIDLoteContabilGeneric(pTable,pIdOrganizacao,pIdRegistro, pIdLote, registroProvisao :string): Boolean;
    function obterValorDebitoTitulo(pIdOrganizacao, pTable, pCampoSum, pCampoData: string; pDataInicial, pDataFinal: TDate; isProvisao :Integer): Currency;

    //exportacao para o mega
    function gravarLoteContabil(pIdLote, pIdOrganizacao, pLote, pDataInicial, pDataFinal: string; pLista :TListaLancamentos; pTable :string; qtdRegistros :Integer; valorDebito, valorCredito : Currency): Boolean;
    function convertTFDQueryToLancamentoMega(pIdOrganizacao, pAno: string; pCodEmpresa, pLote: Integer; query: TFDQuery): TListaLancamentos;
    function obterCBTPorPeriodo(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
    function obterTBTPorPeriodo(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
    function obterCaixaBancoPorPeriodo(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
    function obterTPPROVBase(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
    function obterTPB_PROV(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
    function obterValorDebitoTPB(pIdOrganizacao, pTable, pCampoSum,pCampoData: string; pDataInicial, pDataFinal: TDate; isProvisao :Integer): Currency;
    function obterValorDebitoTRB(pIdOrganizacao, pTable, pCampoSum,pCampoData: string; pDataInicial, pDataFinal: TDate; isProvisao :Integer): Currency;


    function convertTPROVToLancamentoMega(pTipoTitulo, pIdOrganizacao, pAno: string; pCodEmpresa, pLote: Integer; query: TFDQuery; var loMostraErros: TFMostraErros): TListaLancamentos;
    function convertTPB_PROVToLancamentoMega(pTipoTitulo,pIdOrganizacao, pAno: string; pCodEmpresa, pLote: Integer; query: TFDQuery; var loMostraErros: TFMostraErros): TListaLancamentos;
    function convertoTPB_PROVToLancamentoDebito(pCodEmpresa, pLote, pAno, pCodReduzDeb,pCodHist: Integer; pHistorico, pComple, pDgCodReduzDeb, pContaDeb, pDgDeb,  pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime) : TLancamentoDebitoModel;
    function convertoTPB_PROVToLancamentoCredito(pCodEmpresa, pLote, pAno, pCodReduzCre,pCodHist: Integer; pHistorico, pComple, pDgCodReduzCre, pContaCre, pDgCre,  pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime) : TLancamentoCreditoModel;
//LOTE CONTABIL
    function obterTodosLoteContabil(pIdOrganizacao : string; pDataInicial, pDataFinal: TDate) :boolean;
    function deletaLoteContabil(pIdOrganizacao, pIdLote : string ) :boolean;
    function preencheComboLoteContabil(pIdOrganizacao : string ) :boolean;

  //function listaExportacaoCBC(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
 //function listaExportacaoCBD(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;

  end;

var
  dmExportaFinance: TdmExportaFinance;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

procedure TdmExportaFinance.DataModuleCreate(Sender: TObject);
begin
inicializarDM(Self);
end;

function TdmExportaFinance.deletaLoteContabil(pIdOrganizacao,
  pIdLote: string): boolean;
begin
//coloca o lote como excluido

  try
    qryDeletaLoteContabil.Close;
    qryDeletaLoteContabil.Connection := dmConexao.Conn;
    qryDeletaLoteContabil.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryDeletaLoteContabil.ParamByName('PIDLOTE').AsString := pIdLote;

    qryDeletaLoteContabil.ExecSQL;
    dmConexao.Conn.CommitRetaining;
  except
  dmConexao.Conn.RollbackRetaining;
    raise(Exception).Create('Problemas ao deletar lote contabil ');

  end;

end;

procedure TdmExportaFinance.freeAndNilDM(Sender: TObject);
begin
  if not (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;
end;

function TdmExportaFinance.getListaForMega(): TListaLancamentos;
      //pegar todas as listas criadas e cria uma unica
      // OU seria melhor exportar por tipo de lancamento?
begin

  Result := FsListaLancamentos;
end;


{$R *.dfm}

function TdmExportaFinance.obterCBTPorPeriodo(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
begin
  try

    FsListaLancamentos := TListaLancamentos.Create;

        qryObterCBTPERIODO.Connection := dmConexao.Conn;
        qryObterCBTPERIODO.Close;
        qryObterCBTPERIODO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterCBTPERIODO.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
        qryObterCBTPERIODO.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);
        qryObterCBTPERIODO.Open;

    //convertendo para lista
    if not qryObterCBTPERIODO.IsEmpty then
    begin
      FsListaLancamentos := convertTFDQueryToLancamentoMega(pIdOrganizacao, pAno, pCodEmpresa, pLote, qryObterCBTPERIODO);
    end;
  except

    raise(Exception).Create('Problemas ao tentar exportar lan�amentos CBT');

  end;

  Result := FsListaLancamentos;
end;

function TdmExportaFinance.obterPendentesPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): Boolean;
begin
   try
        qryObterPendentes.Connection := dmConexao.Conn;
        qryObterPendentes.Close;
        qryObterPendentes.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterPendentes.Open;
   except

    raise(Exception).Create('Problemas ao tentar obter pendentes ...');

  end;

  Result := not qryObterPendentes.IsEmpty;

end;

function TdmExportaFinance.obterCBCPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
begin
  FsListaLancamentos := TListaLancamentos.Create;

  qryObterCBCPERIODO.Connection := dmConexao.Conn;
  qryObterCBCPERIODO.Close;
  qryObterCBCPERIODO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterCBCPERIODO.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
  qryObterCBCPERIODO.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

  qryObterCBCPERIODO.Open;

//  Result := not qryObterCBCPERIODO.IsEmpty;

  Result := FsListaLancamentos;
end;

function TdmExportaFinance.obterCBDPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
begin
  FsListaLancamentos := TListaLancamentos.Create;
  if not qryObterCBDPERIODO.Connection.Connected then
  begin
    qryObterCBDPERIODO.Connection := dmConexao.Conn;
  end;

  qryObterCBDPERIODO.Close;
  qryObterCBDPERIODO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterCBDPERIODO.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
  qryObterCBDPERIODO.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

  qryObterCBDPERIODO.Open;

  //Result := not qryObterCBDPERIODO.IsEmpty;
  Result := FsListaLancamentos;
end;

function TdmExportaFinance.obterTDPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
begin
  FsListaLancamentos := TListaLancamentos.Create;

        qryObterTDPERIODO.Connection := dmConexao.Conn;
        qryObterTDPERIODO.Close;
        qryObterTDPERIODO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterTDPERIODO.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
        qryObterTDPERIODO.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

        qryObterTDPERIODO.Open;

  Result := FsListaLancamentos;
end;


function TdmExportaFinance.obterTodosLoteContabil(pIdOrganizacao: string;
  pDataInicial, pDataFinal: TDate): boolean;
begin

  try
        qryObterTodosLoteContabil.Connection := dmConexao.Conn;
        qryObterTodosLoteContabil.Close;
        qryObterTodosLoteContabil.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterTodosLoteContabil.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
        qryObterTodosLoteContabil.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

        qryObterTodosLoteContabil.Open;

  except
    raise(Exception).Create('Problemas ao OBTER TODOS OS LOTES CONT�BEIS');
  end;

  Result := not qryObterTodosLoteContabil.IsEmpty;

end;

//obter valor do debito por tipo operacao bancaria
function TdmExportaFinance.obterValorDebitoGenericTOB(pIdOrganizacao, pTable, pCampo, pTipo: string; pDataInicial, pDataFinal: TDate): Currency;
  var
  comando : string;
begin
   //  pDataInicial := StrToDate(FormatDateTime('dd/mm/yyyy', pDataInicial));
    // pDataFinal := StrToDate(FormatDateTime('dd/mm/yyyy', pDataFinal));

  dmConexao.conectarBanco;
 comando :='SELECT Sum(' + pcampo +') as VALOR_DEBITO ' +
           'FROM ' + pTable + ' as TB '+
           'WHERE TB.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL '+
           'AND TB.ID_ORGANIZACAO=:PIDORGANIZACAO ' +
           'AND TB.ID_TIPO_OPERACAO_BANCARIA = :PTOB '+
           'AND TB.ID_LOTE_CONTABIL IS NULL ';

   try

            qryObterValorDebitoGeneric.Close;
            qryObterValorDebitoGeneric.Connection := dmConexao.Conn;
            qryObterValorDebitoGeneric.SQL.Clear;
            qryObterValorDebitoGeneric.SQL.Add(comando);
            qryObterValorDebitoGeneric.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
            qryObterValorDebitoGeneric.ParamByName('PTOB').AsString := pTipo;
            qryObterValorDebitoGeneric.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
            qryObterValorDebitoGeneric.ParamByName('DTDATAFINAL').AsDate := pDataFinal;

            qryObterValorDebitoGeneric.Open;

            Result := qryObterValorDebitoGeneric.FieldByName('VALOR_DEBITO').AsCurrency;

  except
    raise(Exception).Create('Problemas ao OBTER VALOR DEBITO POR TIPO OPERACAO BANCARIA');
  end;
end;





 function TdmExportaFinance.obterValorDebitoGeneric(pIdOrganizacao, pTable, pCampoSum, pCampoData: string; pDataInicial, pDataFinal: TDate): Currency;
  var
  comando : string;
begin
    // pDataInicial := StrToDate(FormatDateTime('dd/mm/yyyy', pDataInicial));
   //  pDataFinal := StrToDate(FormatDateTime('dd/mm/yyyy', pDataFinal));

 comando :='SELECT Sum(' + pCampoSum +') as VALOR_DEBITO ' +
           'FROM ' + pTable + ' as TB '+
           'WHERE TB.'+ pCampoData + '  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL '+
           'AND TB.ID_ORGANIZACAO=:PIDORGANIZACAO ' +
           'AND TB.ID_LOTE_CONTABIL IS NULL ';


    try
          qryObterValorDebitoGeneric.Close;
          qryObterValorDebitoGeneric.Connection := dmConexao.Conn;
          qryObterValorDebitoGeneric.SQL.Clear;
          qryObterValorDebitoGeneric.SQL.Add(comando);
          qryObterValorDebitoGeneric.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
          qryObterValorDebitoGeneric.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
          qryObterValorDebitoGeneric.ParamByName('DTDATAFINAL').AsDate := pDataFinal;


          qryObterValorDebitoGeneric.Open;

          Result := qryObterValorDebitoGeneric.FieldByName('VALOR_DEBITO').AsCurrency;

      except
        raise(Exception).Create('Problemas ao OBTER VALOR DEBITO GENERICO');
      end;





end;

function TdmExportaFinance.updateIDLoteContabilGeneric(pTable, pIdOrganizacao,  pIdRegistro, pIdLote, registroProvisao: string): Boolean;
var
  comando : string;
begin
  comando := ' UPDATE ' + pTable + ' SET  ID_LOTE_CONTABIL = ' + QuotedStr(pIdLote) +
             ' WHERE (ID_' + pTable + ' = ' + QuotedStr(pIdRegistro) + ') AND (ID_ORGANIZACAO = ' + QuotedStr(pIdOrganizacao) + ' )';


  if (pTable = 'TITULO_PAGAR') then begin

    comando := ' UPDATE ' + pTable + ' SET ID_LOTE_TPB = ' + QuotedStr(pIdLote) + ', ID_LOTE_CONTABIL = ' + QuotedStr(pIdLote) +
               ' WHERE ( REGISTRO_PROVISAO = ' + QuotedStr(registroProvisao) + ') AND (ID_ORGANIZACAO = ' + QuotedStr(pIdOrganizacao) + ' )';
  end;


  if (pTable = 'TITULO_RECEBER') then begin

    comando := ' UPDATE ' + pTable + ' SET  ID_LOTE_CONTABIL = ' + QuotedStr(pIdLote) +
               ' WHERE ( REGISTRO_PROVISAO = ' + QuotedStr(registroProvisao) + ') AND (ID_ORGANIZACAO = ' + QuotedStr(pIdOrganizacao) + ' )';
  end;


  try
    qryUpdateGeneric.Close;
    qryUpdateGeneric.Connection := dmConexao.Conn;
    qryUpdateGeneric.SQL.Clear;
    qryUpdateGeneric.SQL.Add(comando);

    qryUpdateGeneric.ExecSQL;
  except
    raise(Exception).Create('Problemas ao atualizar lote contabil generic.');

  end;

  Result := System.True;

end;

procedure TdmExportaFinance.validarLancamentos(pIdOrganizacao: string; plista: TListaLancamentos; pCodeEmpresa: Integer);
var
  I: Integer;
  historico, pendencia, contaCR, contaDB: string;
 pId, qtdPendencia, codreduzCR, codreduzDB: Integer;
  valorCR, valorDB: Currency;
begin
   qtdPendencia := 0;

   if limpaPendentes(pIdOrganizacao) then begin

   qtdPendencia := 0;

   end;

  if plista <> nil then
  begin

    for I := 0 to TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Count - 1 do
    begin
      historico := TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).Historico;
      contaCR :=    TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).ContaCredito;
      codreduzCR := TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).CodReduzCre;
      valorCR :=    TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).Valor;
      contaDB :=    TLancamentoDebitoModel(TListaLancamentoDebito(plista.ListaDebito[0]).FListaLancamentoDebito.Items[I]).ContaDebito;
      codreduzDB := TLancamentoDebitoModel(TListaLancamentoDebito(plista.ListaDebito[0]).FListaLancamentoDebito.Items[I]).CodReduzDeb;
      valorDB :=    TLancamentoDebitoModel(TListaLancamentoDebito(plista.ListaDebito[0]).FListaLancamentoDebito.Items[I]).Valor;
      pId     :=  dmMegaContabil.retornarIDPorTabela('');
      if valorCR <> valorDB then
      begin
        pendencia := pendencia + 'VALOR CREDITO <> DEBITO';
        qtdPendencia := qtdPendencia + 1;
      end;

      if not dmMegaContabil.locateContaContabil(pCodeEmpresa, contaCR) then
      begin
        pendencia := pendencia + ' /CTA CREDITO N�O EXISTE -> ' + contaCR;
        qtdPendencia := qtdPendencia + 1;
      end;

      if not dmMegaContabil.locateContaContabil(pCodeEmpresa, contaDB) then
      begin
        pendencia := pendencia + ' /CTA DEBITO N�O EXISTE -> ' + contaDB;
        qtdPendencia := qtdPendencia + 1;

      end;

      if qtdPendencia > 0 then
      begin
        inserePendente(pIdOrganizacao, historico, TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).FncIdentificacao, pendencia, TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).Valor);
      end;
    end;

  end;

end;

function TdmExportaFinance.obterTCPorPeriodo(pIdOrganizacao: string; pDataInicial, pDataFinal: TDate): TListaLancamentos;
begin
  FsListaLancamentos := TListaLancamentos.Create;

  if not qryObterTCPERIODO.Connection.Connected then
  begin
    qryObterTCPERIODO.Connection := dmConexao.Conn;
  end;

  qryObterTCPERIODO.Close;
  qryObterTCPERIODO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterTCPERIODO.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', pDataInicial);
  qryObterTCPERIODO.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', pDataFinal);

  qryObterTCPERIODO.Open;

  //Result := not qryObterTCPERIODO.IsEmpty;
  Result := FsListaLancamentos;
end;


{
    ID_LOTE_CONTABIL  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO    VARCHAR(36) NOT NULL,
    LOTE              VARCHAR(30),
    STATUS            VARCHAR(30),   EXPORTADO
    ID_USUARIO        NUMERIC(5,0), 1
    DATA_REGISTRO     DATE,
    DATA_ATUALIZACAO  DATE NOT NULL,
    PERIODO_INICIAL   DATE,
    PERIODO_FINAL     DATE,
    TIPO_TABLE        VARCHAR(200) CHARACTER SET ISO8859_1,
    QTD_REGISTROS     SMALLINT     }

function TdmExportaFinance.gravarLoteContabil(pIdLote, pIdOrganizacao, pLote, pDataInicial, pDataFinal: string; pLista :TListaLancamentos; pTable :string; qtdRegistros :Integer; valorDebito, valorCredito : Currency): Boolean;
var
 registroProvisao, pUsuario,pStatus,pDataRegistro,pDataAtualizacao, idRegistro, comando, station: string;
  I :Integer;
begin
  qtdRegistros := TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Count;
   // cada tipo de lancamento

  pUsuario := uUtil.TUserAtual.getUserId;
  pStatus := 'EXPORT/AUTO';
  station := Uutil.GetComputerNetName;
  pDataRegistro := FormatDateTime('dd/mm/yyyy', uUtil.getDataServer);
  pDataAtualizacao := FormatDateTime('dd/mm/yyyy', uUtil.getDataServer);

  comando := 'INSERT INTO LOTE_CONTABIL (ID_LOTE_CONTABIL,ID_ORGANIZACAO, LOTE, STATUS, '
           + 'ID_USUARIO, PERIODO_INICIAL, PERIODO_FINAL, DATA_REGISTRO, DATA_ATUALIZACAO, '
           + 'TIPO_TABLE, QTD_REGISTROS, VALOR_DB, VALOR_CR ) '
           + 'VALUES (:pIdLote, :pIdOrganizacao, :pLote, :pStatus, :pUsuario, '
           + ':pDataInicial,:pDataFinal,:pDataRegistro,:pDataAtualizacao, :pTable, :pQtdRegistros, :pValorDB, :pValorCR )';

  try
    qryGravarLoteContabil.Close;
    qryGravarLoteContabil.Connection := dmConexao.Conn;
    qryGravarLoteContabil.SQL.Clear;
    qryGravarLoteContabil.SQL.Add(comando);
    qryGravarLoteContabil.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryGravarLoteContabil.ParamByName('pIdLote').AsString := pIdLote;
    qryGravarLoteContabil.ParamByName('pLote').AsString := pLote;
    qryGravarLoteContabil.ParamByName('pStatus').AsString := pStatus;
    qryGravarLoteContabil.ParamByName('pUsuario').AsInteger := StrToInt(pUsuario);
    qryGravarLoteContabil.ParamByName('pDataRegistro').AsDate := StrToDate(pDataRegistro);
    qryGravarLoteContabil.ParamByName('pDataInicial').AsDate := StrToDate(pDataInicial);
    qryGravarLoteContabil.ParamByName('pDataFinal').AsDate := StrToDate(pDataFinal);
    qryGravarLoteContabil.ParamByName('pDataAtualizacao').AsDate := StrToDate(pDataAtualizacao);
    qryGravarLoteContabil.ParamByName('pTable').AsString := pTable;
    qryGravarLoteContabil.ParamByName('pQtdRegistros').AsInteger := qtdRegistros;
    qryGravarLoteContabil.ParamByName('pValorDB').AsCurrency := valorDebito;
    qryGravarLoteContabil.ParamByName('pValorCR').AsCurrency := valorCredito;



    qryGravarLoteContabil.ExecSQL;

  // pegar a lista e alterar os lancamentos para terem o id do lote marcado.

    if pLista <> nil then
    begin
        qtdRegistros := TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Count;
     //percorre Plista; pega o id do objeto e faz um update na tabela envolvida
      for I := 0 to qtdRegistros  - 1 do
      begin
        idRegistro       := TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).IdRegistroFinance;
        registroProvisao := TLancamentoCreditoModel(TListaLancamentoCredito(plista.ListaCredito[0]).FListaLancamentoCredito.Items[I]).RegistroProvisao;

        updateIDLoteContabilGeneric(pTable, pIdOrganizacao, idRegistro, pIdLote,registroProvisao );


      end;    //deleta o lote criado agora. Ou ver como fazer rolback

  end;



    Result := System.True;

  except
    raise(Exception).Create('Problemas ao GRAVAR LOTE CONTABIL FNC.');
  end;
end;

function TdmExportaFinance.inserePendente(pIdOrganizacao, pTIPO, pIDENTIFICACAO, pPENDENCIA: string; pVALOR: Currency): Boolean;
var
  pID, comando: string;
begin

  comando := ' INSERT INTO LANC_EXPORT_PEND (ID_ORGANIZACAO,ID, VALOR, TIPO, IDENTIFICACAO, PENDENCIA, DATA_REGISTRO) ' +
             ' VALUES (:PIDORGANIZACAO, :pID, :pVALOR, :pTIPO, :pIDENTIFICACAO, :pPENDENCIA, :pDATAREGISTRO) ';


   pID := Copy(PIDORGANIZACAO + pIDENTIFICACAO + pTIPO,1,34) ;
   pID := dmConexao.obterNewID;

  try
    qryInserePendente.Close;
    qryInserePendente.Connection := dmConexao.Conn;
    qryInserePendente.SQL.Clear;
    qryInserePendente.SQL.Add(comando);
    qryInserePendente.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryInserePendente.ParamByName('pID').AsString := pID;
    qryInserePendente.ParamByName('pTIPO').AsString := pTIPO;
    qryInserePendente.ParamByName('pVALOR').AsCurrency := pVALOR;
    qryInserePendente.ParamByName('pIDENTIFICACAO').AsString := pIDENTIFICACAO;
    qryInserePendente.ParamByName('pPENDENCIA').AsString := pPENDENCIA;
    qryInserePendente.ParamByName('pDATAREGISTRO').AsDate := Now;

    qryInserePendente.ExecSQL;
  except
    raise(Exception).Create('Problemas ao inserir lancamentos PENDENTES.');
  end;

  Result := System.True;

end;

function TdmExportaFinance.limpaPendentes(pIdOrganizacao: string): Boolean;
begin
       //deleta todos os registros existentes at� ontem. (current_date -1)
  try

    qryLimparPendentes.Connection := dmConexao.Conn;
    qryLimparPendentes.Close;
    qryLimparPendentes.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;

    qryLimparPendentes.ExecSQL;
    dmConexao.conn.CommitRetaining;


  except
    dmConexao.conn.RollbackRetaining;
    raise(Exception).Create('Problemas ao LIMPAR PENDENTES.');
  end;

  Result := System.True;

end;

procedure TdmExportaFinance.inicializarDM(Sender: TObject);
begin
 { if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
  end;   }

  dmConexao.conectarBanco;

  if not (Assigned(dmMegaContabil)) then
  begin
    dmMegaContabil := TdmMegaContabil.Create(Self);
    dmConexao.conectarMega;

  end;

end;

function TdmExportaFinance.convertTFDQueryToLancamentoMega(pIdOrganizacao, pAno: string; pCodEmpresa, pLote: Integer; query: TFDQuery): TListaLancamentos;
var
  aux: Integer;
  tempLancamentoCR: TLancamentoCreditoModel;
  tempLancamentoDB: TLancamentoDebitoModel;
  loMostraErros: TFMostraErros;
begin

  try
    FsListaLancamentos := TListaLancamentos.Create;
    FsListaCredito := TListaLancamentoCredito.Create;
    FsListaDebito := TListaLancamentoDebito.Create;

//obtendo lancamentos de lista de creditos
    query.First;
    while (not query.Eof) do
    begin

      tempLancamentoDB := TLancamentoDebitoModel.Create;
      tempLancamentoCR := TLancamentoCreditoModel.Create;
    //linha do credito
    // tempLancamentoCR.SetIdLancamento(); gerado antes de inserir
    // tempLancamentoCR.SetLinha();gerado antes de inserir
      tempLancamentoCR.SetAno(pAno);
      tempLancamentoCR.SetLote(pLote);
      tempLancamentoCR.SetIdEmpresa(pCodEmpresa);
      tempLancamentoCR.SetFilial(0);
      tempLancamentoCR.SetCentroCusto(0);
      tempLancamentoCR.SetDataLanc(uUtil.getDataServer);
      tempLancamentoCR.SetValor(query.FieldByName('VALOR').AsCurrency);
      tempLancamentoCR.SetData(query.FieldByName('DATA').AsDateTime);
      tempLancamentoCR.SetContaCredito(query.FieldByName('CONTA_CRE').AsString);
      tempLancamentoCR.SetDgContaCredito(query.FieldByName('DGCRE').AsString);
      tempLancamentoCR.SetCodReduzCre(query.FieldByName('CDREDUZCRE').AsInteger);
      tempLancamentoCR.SetDgCodReduzCre(query.FieldByName('DGREDUZCRE').AsString);
      tempLancamentoCR.SetCodHistorico(query.FieldByName('CDHIST').AsInteger);
      tempLancamentoCR.SetComplemento(query.FieldByName('COMPL').AsString);
      tempLancamentoCR.SetHistorico(query.FieldByName('HISTORICO').AsString);
      tempLancamentoCR.SetIdRegistroFinance(query.FieldByName('ID').AsString);
      tempLancamentoCR.SetFncIdentificacao(query.FieldByName('IDENTIFCRE').AsString);
      tempLancamentoCR.SetTipo('2');  //1 - DEBITO  - 2 - CREDITO
      tempLancamentoCR.SetExecTrigger('S'); //S sempre

      FsListaCredito.Adicionar(tempLancamentoCR);

    //linha do debito

      // tempLancamentoCR.SetIdLancamento(); gerado antes de inserir
     //  tempLancamentoCR.SetLinha();gerado antes de inserir
      tempLancamentoDB.SetAno(pAno);
      tempLancamentoDB.SetLote(pLote);
      tempLancamentoDB.SetIdEmpresa(pCodEmpresa);
      tempLancamentoDB.SetFilial(0);
      tempLancamentoDB.SetCentroCusto(0);
      tempLancamentoDB.SetDataLanc(uUtil.getDataServer);
      tempLancamentoDB.SetValor(query.FieldByName('VALOR').AsCurrency);
      tempLancamentoDB.SetData(query.FieldByName('DATA').AsDateTime);
      tempLancamentoDB.SetContaDebito(query.FieldByName('CONTA_DEB').AsString);
      tempLancamentoDB.SetDgContaDebito(query.FieldByName('DGDEB').AsString);
      tempLancamentoDB.SetCodReduzDeb(query.FieldByName('CDREDUZDEB').AsInteger);
      tempLancamentoDB.SetDgCodReduzDeb(query.FieldByName('DGREDUZDEB').AsString);
      tempLancamentoDB.SetCodHistorico(query.FieldByName('CDHIST').AsInteger);
      tempLancamentoDB.SetComplemento(query.FieldByName('COMPL').AsString);
      tempLancamentoDB.SetHistorico(query.FieldByName('HISTORICO').AsString);
      tempLancamentoDB.SetIdRegistroFinance(query.FieldByName('ID').AsString);
      tempLancamentoDB.SetFncIdentificacao(query.FieldByName('IDENTIFDEB').AsString);
      tempLancamentoDB.SetTipo('1');   //1 - DEBITO  - 2 - CREDITO
      tempLancamentoDB.SetExecTrigger('S'); //S sempre


      FsListaDebito.Adicionar(tempLancamentoDB);

      query.Next;
    end;

    FsListaLancamentos.AdicionarCredito(FsListaCredito);
    FsListaLancamentos.AdicionarDebito(FsListaDebito);

  except
    raise(Exception).Create(' Problemas ao converter lancamentos. ');
//    on E: Exception do
//    E.Message ;
  end;

  //validar as duas listas
  //1- garantir que o valor de credito e de debito sao iguais
  //2- garantir que a conta contabil exista no MEGA
  //3- garantir que a conta reduzida exista no MEGA
 //suspendo em 03/10 para verifica��o
 //  validarLancamentos(pIdOrganizacao, FsListaLancamentos, pCodEmpresa);

  Result := FsListaLancamentos;

end;



function TdmExportaFinance.convertTPROVToLancamentoMega(pTipoTitulo,pIdOrganizacao, pAno: string; pCodEmpresa, pLote: Integer; query: TFDQuery; var loMostraErros: TFMostraErros): TListaLancamentos;
var
 qtdParcelas, aux: Integer;
  tempLancamentoCR: TLancamentoCreditoModel;
  tempLancamentoDB: TLancamentoDebitoModel;
//  loMostraErros: TFMostraErros;
 pRegistroProvisao, pID, pID_ORG, cmd :string;
  //campos necessarios para preencher o credito
  VALOR: Currency; fData: TDate;
   CDHIST,CDREDUZDEB, CDREDUZCRE: Integer;
  IDENTIFCRE, ID,HISTORICO, COMPL,DGREDUZCRE, DGCRE,CONTA_CRE :string;
  IDENTIFDEB, DGREDUZDEB ,DGDEB, CONTA_DEB :string;
   
  // query contem os titulos pagos/recebidos que foram provisionados apenas
  // no caso do TITULO A PAGAR
  // a consulta deve trazer todos os titulos pagos ou nao
  // conta credito fica no cedente
  //conta debito fica no rateio de historicos (tabela titulo_pagar_historico)


begin

  try
    FsListaLancamentos := TListaLancamentos.Create;
    FsListaCredito := TListaLancamentoCredito.Create;
    FsListaDebito := TListaLancamentoDebito.Create;


    query.First; //contem alguns dados do TITULO
    //precisa consultar os creditos e debitos
    while (not query.Eof) do
       begin
             pID               := query.FieldByName('ID').AsString;
             pID_ORG           := query.FieldByName('ID_ORGANIZACAO').AsString;
           //  qtdParcelas       := query.FieldByName('QTD').AsInteger;
             fData             := query.FieldByName('DATA_EMISSAO').AsDateTime;
             pRegistroProvisao := query.FieldByName('REGISTRO_PROVISAO').AsString;
             
          if(pTipoTitulo.Equals('TP')) then begin
              //CREDITO = CONTA CONTABIL DO CEDENTE
            try
                qryTPPROVCR.Close;
                qryTPPROVCR.Connection := dmConexao.Conn;
                qryTPPROVCR.ParamByName('PIDORGANIZACAO').AsString := pID_ORG;
                qryTPPROVCR.ParamByName('pID').AsString := pID;            
                qryTPPROVCR.Open;                

                if not qryTPPROVCR.IsEmpty then begin
                //enquanto essa qry nao for vazia
                   while not qryTPPROVCR.Eof do
                   begin
                         //preencher as variaveis aqui
                          VALOR       := qryTPPROVCR.FieldByName('VALOR').AsCurrency;  // (qtdParcelas * (qryTPPROVCR.FieldByName('VALOR').AsCurrency));

                          CDREDUZCRE  :=0;
                          IF  NOT (qryTPPROVCR.FieldByName('CDREDUZCRE').AsString = string.Empty ) then begin
                              CDREDUZCRE  := StrToInt(qryTPPROVCR.FieldByName('CDREDUZCRE').AsString);
                          end;

                          IDENTIFCRE  := qryTPPROVCR.FieldByName('IDENTIFCRE').AsString;
                          ID          := qryTPPROVCR.FieldByName('ID').AsString;
                          HISTORICO   := qryTPPROVCR.FieldByName('HISTORICO').AsString;
                          COMPL       := qryTPPROVCR.FieldByName('COMPL').AsString;
                          CDHIST      := qryTPPROVCR.FieldByName('CDHIST').AsInteger;
                          DGREDUZCRE  := qryTPPROVCR.FieldByName('DGREDUZCRE').AsString;
                          DGCRE       := qryTPPROVCR.FieldByName('DGCRE').AsString;
                          CONTA_CRE   := qryTPPROVCR.FieldByName('CONTA_CRE').AsString;

                          IDENTIFDEB  := IDENTIFCRE;
                           
                          tempLancamentoCR := TLancamentoCreditoModel.Create;
                          tempLancamentoCR.SetAno(pAno);
                          tempLancamentoCR.SetLote(pLote);
                          tempLancamentoCR.SetIdEmpresa(pCodEmpresa);
                          tempLancamentoCR.SetFilial(0);
                          tempLancamentoCR.SetCentroCusto(0);
                          tempLancamentoCR.SetDataLanc(uUtil.getDataServer);
                          tempLancamentoCR.SetValor(VALOR);
                          tempLancamentoCR.SetData(fData);
                          tempLancamentoCR.SetContaCredito(CONTA_CRE) ;
                          tempLancamentoCR.SetDgContaCredito(DGCRE);
                          tempLancamentoCR.SetCodReduzCre(CDREDUZCRE);
                          tempLancamentoCR.SetDgCodReduzCre(DGREDUZCRE);
                          tempLancamentoCR.SetCodHistorico(CDHIST);
                          tempLancamentoCR.SetComplemento(COMPL);
                          tempLancamentoCR.SetHistorico(HISTORICO);
                          tempLancamentoCR.SetIdRegistroFinance(ID);
                          tempLancamentoCR.SetRegistroProvisao(pRegistroProvisao);
                          tempLancamentoCR.SetFncIdentificacao(IDENTIFCRE);
                          tempLancamentoCR.SetTipo('2');  //1 - DEBITO  - 2 - CREDITO
                          tempLancamentoCR.SetExecTrigger('S'); //S sempre

                      FsListaCredito.Adicionar(tempLancamentoCR);

                    qryTPPROVCR.Next;
                   end;                  
                end;                        
             except
              raise(Exception).Create('Problemas ao consultar cr�ditos do TP.  ' + pID);
             end;
          end;
         //obtendo os creditos  


    //linha do debito

              TRY
                qryTPPROVDB.Close;
                qryTPPROVDB.Connection := dmConexao.Conn;
                qryTPPROVDB.ParamByName('PIDORGANIZACAO').AsString := pID_ORG;
                qryTPPROVDB.ParamByName('pID').AsString := pID;
                qryTPPROVDB.Open;
              except

              raise(Exception).Create('Problemas ao consultar d�bitos do TP.');

              end;

         if not qryTPPROVDB.IsEmpty then begin

                 VALOR       := qryTPPROVDB.FieldByName('VALOR').AsCurrency; //(qtdParcelas * (qryTPPROVDB.FieldByName('VALOR').AsCurrency));
                 ID          := qryTPPROVDB.FieldByName('ID').AsString;
                 HISTORICO   := qryTPPROVDB.FieldByName('HISTORICO').AsString;
                 COMPL       := qryTPPROVDB.FieldByName('COMPL').AsString;
                 CDHIST      := qryTPPROVDB.FieldByName('CDHIST').AsInteger;

                 CDREDUZDEB  :=0;
                          IF  NOT (qryTPPROVDB.FieldByName('CDREDUZDEB').AsString = string.Empty ) then begin
                              CDREDUZDEB  := StrToInt(qryTPPROVDB.FieldByName('CDREDUZDEB').AsString);
                          end;

                 DGREDUZDEB  := qryTPPROVDB.FieldByName('DGREDUZDEB').AsString;
                 DGDEB       := qryTPPROVDB.FieldByName('DGDEB').AsString;
                 CONTA_DEB   := qryTPPROVDB.FieldByName('CONTA_DEB').AsString;


                tempLancamentoDB := TLancamentoDebitoModel.Create;
                tempLancamentoDB.SetAno(pAno);
                tempLancamentoDB.SetLote(pLote);
                tempLancamentoDB.SetIdEmpresa(pCodEmpresa);
                tempLancamentoDB.SetFilial(0);
                tempLancamentoDB.SetCentroCusto(0);
                tempLancamentoDB.SetDataLanc(uUtil.getDataServer);
                tempLancamentoDB.SetValor(VALOR);
                tempLancamentoDB.SetData(fData);
                tempLancamentoDB.SetContaDebito(CONTA_DEB);
                tempLancamentoDB.SetDgContaDebito(DGDEB);
                tempLancamentoDB.SetCodReduzDeb(CDREDUZDEB);
                tempLancamentoDB.SetDgCodReduzDeb(DGREDUZDEB);
                tempLancamentoDB.SetCodHistorico(CDHIST);
                tempLancamentoDB.SetComplemento(COMPL);
                tempLancamentoDB.SetHistorico(HISTORICO);
                tempLancamentoDB.SetIdRegistroFinance(ID);
                tempLancamentoDB.SetFncIdentificacao(IDENTIFDEB);
                tempLancamentoDB.SetTipo('1');   //1 - DEBITO  - 2 - CREDITO
                tempLancamentoDB.SetExecTrigger('S'); //S sempre

              FsListaDebito.Adicionar(tempLancamentoDB);

              qryTPPROVDB.Next;

         end;

      query.Next;
    end;

    FsListaLancamentos.AdicionarCredito(FsListaCredito);
    FsListaLancamentos.AdicionarDebito(FsListaDebito);

  except
    raise(Exception).Create('Problemas ao converter lancamentos.');
//    on E: Exception do
//    E.Message ;
  end;

  //validar as duas listas
  //1- garantir que o valor de credito e de debito sao iguais
  //2- garantir que a conta contabil exista no MEGA
  //3- garantir que a conta reduzida exista no MEGA
   validarLancamentos(pIdOrganizacao, FsListaLancamentos, pCodEmpresa);

  Result := FsListaLancamentos;

end;




function TdmExportaFinance.obterListaHistoricoSemContaContabil(pIdOrganizacao: String): Boolean;
begin
  Result := False;
  //inicializarDM(Self);
  if dmConexao.conectarBanco then
  begin
    qryHstSemCC.Close;
    qryHstSemCC.Connection := dmConexao.Conn;
    qryHstSemCC.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryHstSemCC.Open;

    Result := not qryHstSemCC.IsEmpty;

  end;
end;

//Transferencia da tesouraria para o banco
function TdmExportaFinance.obterCaixaBancoPorPeriodo(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
begin
   //'DEPOSITO TESOURARIA/BANCO

   try

    FsListaLancamentos := TListaLancamentos.Create;

    if not qryCaixaBanco .Connection.Connected then
    begin
      qryCaixaBanco.Connection := dmConexao.Conn;
    end;

    qryCaixaBanco.Close;
    qryCaixaBanco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryCaixaBanco.ParamByName('DTDATAINICIAL').AsDate    := pDataFinal;
    qryCaixaBanco.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
    qryCaixaBanco.Open;

    //convertendo para lista
    if not qryCaixaBanco.IsEmpty then
    begin
      FsListaLancamentos := convertTFDQueryToLancamentoMega(pIdOrganizacao, pAno, pCodEmpresa, pLote, qryCaixaBanco);
    end;
  except

    raise(Exception).Create('Problemas ao tentar exportar lan�amentos Transf. Tesouraria para o Banco');

  end;

  Result := FsListaLancamentos;
end;


//Transferencia do banco para a tesouraria
function TdmExportaFinance.obterTBTPorPeriodo(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
  begin
  try

    FsListaLancamentos := TListaLancamentos.Create;

    if not qryBancoCaixa.Connection.Connected then
    begin
      qryBancoCaixa.Connection := dmConexao.Conn;
    end;

    qryBancoCaixa.Close;
    qryBancoCaixa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryBancoCaixa.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
    qryBancoCaixa.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
    qryBancoCaixa.Open;

    //convertendo para lista
    if not qryBancoCaixa.IsEmpty then
    begin
      FsListaLancamentos := convertTFDQueryToLancamentoMega(pIdOrganizacao, pAno, pCodEmpresa, pLote, qryBancoCaixa);
    end;
  except

    raise(Exception).Create('Problemas ao tentar exportar lan�amentos Transf. Banco Tesouraria');

  end;

  Result := FsListaLancamentos;
end;

//titulos a pagar provisao para exportar


function TdmExportaFinance.obterTPProvCR(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
begin
  Result := false;


  if not qryTPPROVCR.Connection.Connected then
  begin
    qryTPPROVCR.Connection := dmConexao.Conn;
  end;

  qryTPPROVCR.Close;
  qryTPPROVCR.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPPROVCR.ParamByName('pregistro').AsString := pRegistroProvisao;
  qryTPPROVCR.Open;

  Result := not qryTPPROVCR.IsEmpty;

end;



function TdmExportaFinance.obterTPProvDB(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
begin
  Result := false;


  if not qryTPPROVDB.Connection.Connected then
  begin
    qryTPPROVDB.Connection := dmConexao.Conn;
  end;

  qryTPPROVDB.Close;
  qryTPPROVDB.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPPROVDB.ParamByName('pregistro').AsString := pRegistroProvisao;
  qryTPPROVDB.Open;

  Result := not qryTPPROVDB.IsEmpty;

end;


function TdmExportaFinance.obterTPPROVBase(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
var
aux :Integer;
begin
 try

          qryTPPROVBASE.Close;
          qryTPPROVBASE.Connection := dmConexao.Conn;
          qryTPPROVBASE.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
          qryTPPROVBASE.ParamByName('pDataInicial').AsDate := pDataInicial;
          qryTPPROVBASE.ParamByName('pDataFinal').AsDate := pDataFinal;
          qryTPPROVBASE.Open;

          qryTPPROVBASE.SQL;

       //convertendo para lista
          if not qryTPPROVBASE.IsEmpty then
          begin
            FsListaLancamentos := convertTPROVToLancamentoMega('TP',pIdOrganizacao, pAno, pCodEmpresa, pLote, qryTPPROVBASE, loMostraErros);
          end;

  except

    raise(Exception).Create('Problemas ao tentar exportar TITULOS A PAGAR PROVISIONADOS');

  end;

  Result := FsListaLancamentos;

end;

 function TdmExportaFinance.obterValorDebitoTPB(pIdOrganizacao, pTable, pCampoSum, pCampoData: string;
                                                pDataInicial, pDataFinal: TDate;isProvisao :Integer ): Currency;
  var
  comando : string;
begin
dmConexao.conectarBanco;

comando := ' SELECT SUM(TP.valor_nominal) AS VALOR_DEBITO  FROM  titulo_pagar TP ' +
           ' WHERE TP.data_pagamento  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL ' +
           ' AND TP.ID_ORGANIZACAO = :PIDORGANIZACAO ' +
           ' AND TP.id_tipo_status = ''QUITADO'' or (TP.id_tipo_status = ''PARCIAL'') ' +
           ' AND TP.id_lote_contabil IS null ' ;
        //consulta todos os titulos pagos no periodo . organizacao e nao tenha sido exportado



    try
          qryObterValorTitulo.Close;
          qryObterValorTitulo.Connection := dmConexao.Conn;
          qryObterValorTitulo.SQL.Clear;
          qryObterValorTitulo.SQL.Add(comando);
          qryObterValorTitulo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
          qryObterValorTitulo.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
          qryObterValorTitulo.ParamByName('DTDATAFINAL').AsDate := pDataFinal;

          qryObterValorTitulo.Open;


      except
        raise(Exception).Create('Problemas ao OBTER VALOR DEBITO TPB');
      end;

       Result := qryObterValorTitulo.FieldByName('VALOR_DEBITO').AsCurrency;

end;


 function TdmExportaFinance.obterValorDebitoTitulo(pIdOrganizacao, pTable, pCampoSum, pCampoData: string; pDataInicial, pDataFinal: TDate; isProvisao :Integer): Currency;
  var
  comando : string;
begin
dmConexao.conectarBanco;
    // pegar o valor do debito dos titulos.
    // a pTable pode ser PAGAR e RECBER
    // os titulos podem ser provisionados ou nao. Is_provisao 1 para provisionado e 0 para nao provisinado
     comando :='SELECT Sum(' + pCampoSum +') as VALOR_DEBITO ' +
           'FROM ' + pTable + ' as TB '+
           'WHERE TB.'+ pCampoData + '  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL '+
           'AND TB.ID_ORGANIZACAO = :PIDORGANIZACAO  ' +
           'AND TB.ID_TIPO_STATUS <> :PIDSTATUS ' +
           'AND TB.ID_LOTE_CONTABIL IS NULL ';


      if isProvisao = 1 then begin

       //caso do titulo a pagar

          if pTable.Equals('TITULO_PAGAR') then begin

             comando :='SELECT Sum(' + pCampoSum +') as VALOR_DEBITO ' +
                       'FROM ' + pTable + ' as TB '+
                       'WHERE TB.'+ pCampoData + '  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL '+
                       'AND TB.ID_ORGANIZACAO = :PIDORGANIZACAO  ' +
                       'AND TB.ID_TIPO_STATUS <> :PIDSTATUS ' +
                       'AND TB.ID_LOTE_TPB IS NULL ' +
                       'AND TB.REGISTRO_PROVISAO IS NOT NULL ' +
                       'AND TB.ID_LOTE_CONTABIL IS NULL ';
          end;

      end;


    try
          qryObterValorTitulo.Close;
          qryObterValorTitulo.Connection := dmConexao.Conn;
          qryObterValorTitulo.SQL.Clear;
          qryObterValorTitulo.SQL.Add(comando);
          qryObterValorTitulo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
          qryObterValorTitulo.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
          qryObterValorTitulo.ParamByName('DTDATAFINAL').AsDate := pDataFinal;
          //qryObterValorTitulo.ParamByName('PROVISAO').AsInteger := isProvisao;
          qryObterValorTitulo.ParamByName('PIDSTATUS').AsString := 'EXCLUIDO';

          qryObterValorTitulo.Open;

          Result := qryObterValorTitulo.FieldByName('VALOR_DEBITO').AsCurrency;

      except
        raise(Exception).Create('Problemas ao OBTER VALOR DEBITO GENERICO');
      end;





end;


function TdmExportaFinance.obterTPB_PROV(pIdOrganizacao, pAno: string; pDataInicial, pDataFinal: TDate; pCodEmpresa, pLote: Integer; var loMostraErros: TFMostraErros): TListaLancamentos;
var
aux :Integer;
begin
 try
          qryTPB_PROV.Close;
          qryTPB_PROV.Connection := dmConexao.Conn;
          qryTPB_PROV.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
          qryTPB_PROV.ParamByName('pDataInicial').AsDate := pDataInicial;
          qryTPB_PROV.ParamByName('pDataFinal').AsDate := pDataFinal;
          qryTPB_PROV.Open;

       //convertendo para lista
          if not qryTPB_PROV.IsEmpty then
          begin
            FsListaLancamentos := convertTPB_PROVToLancamentoMega('TPB_PROV',pIdOrganizacao, pAno, pCodEmpresa, pLote, qryTPB_PROV, loMostraErros);
          end;

  except

    raise(Exception).Create('Problemas ao tentar exportar TITULOS A PAGAR PROVISIONADOS');

  end;

  Result := FsListaLancamentos;

end;


function TdmExportaFinance.convertTPB_PROVToLancamentoMega(pTipoTitulo,pIdOrganizacao, pAno: string; pCodEmpresa, pLote: Integer; query: TFDQuery; var loMostraErros: TFMostraErros): TListaLancamentos;
var
    qtdParcelas, aux: Integer;
    tempLancamentoCR: TLancamentoCreditoModel;
    tempLancamentoDB: TLancamentoDebitoModel;

pIDTPB, pRegistroProvisao, pID, pID_ORG, cmd :string;
  VALOR: Currency; fData: TDate;
   CDHIST,CDREDUZDEB, CDREDUZCRE: Integer;
  IDENTIFCRE, ID,HISTORICO, COMPL,DGREDUZCRE, DGCRE,CONTA_CRE :string;
 auxCD, IDENTIFDEB, DGREDUZDEB ,DGDEB, CONTA_DEB :string;

  // query contem os titulos pagos/recebidos que foram provisionados
  // a consulta deve trazer todos os titulos pagos ou nao
  // conta credito fica no cedente
  //conta debito fica no rateio de historicos (tabela titulo_pagar_historico)

begin
  try
    FsListaLancamentos := TListaLancamentos.Create;
    FsListaCredito := TListaLancamentoCredito.Create;
    FsListaDebito := TListaLancamentoDebito.Create;

    query.First; //contem alguns dados do TITULO
    //precisa consultar os creditos e debitos
    while (not query.Eof) do
       begin
             pID               := query.FieldByName('ID').AsString;
             pIDTPB            := query.FieldByName('IDTPB').AsString;
             pID_ORG           := query.FieldByName('ID_ORGANIZACAO').AsString;
            // qtdParcelas       := query.FieldByName('QTD').AsInteger;
             fData             := query.FieldByName('DATA_PAGAMENTO').AsDateTime;
             pRegistroProvisao := query.FieldByName('REGISTRO_PROVISAO').AsString;
             IDENTIFCRE        := query.FieldByName('NUMERO_DOCUMENTO').AsString;
             IDENTIFDEB        := query.FieldByName('NUMERO_DOCUMENTO').AsString;


          if(pTipoTitulo.Equals('TPB_PROV')) then begin
            //conta devbito principal fica no TP PROV.

            try
              //CONTAS DE DEBITO
              //QRY PRINCIPAL E ACRESCIMOS
              //ACRESCIMOS CONSULTA POR  pIDTPB
                 VALOR       := query.FieldByName('VALOR').AsCurrency;
                 ID          := query.FieldByName('ID').AsString;

                 HISTORICO   := query.FieldByName('HISTORICO').AsString;
                 CDHIST      := query.FieldByName('CDHIST').AsInteger;
                 COMPL       := query.FieldByName('COMPL').AsString;

                 CDREDUZDEB  := uUtil.convertStrToInt(query.FieldByName('CDREDUZDEB').AsString);

                 DGREDUZDEB  := query.FieldByName('DGREDUZDEB').AsString;
                 DGDEB       := query.FieldByName('DGDEB').AsString;
                 CONTA_DEB   := query.FieldByName('CONTA_DEB').AsString;

                FsListaDebito.Adicionar(convertoTPB_PROVToLancamentoDebito(pCodEmpresa,pLote,StrToInt(pAno),
                                                                           CDREDUZDEB,CDHIST,HISTORICO,COMPL,
                                                                           DGREDUZDEB,CONTA_DEB,DGDEB,'1',ID,IDENTIFDEB,VALOR,fData));
              try
                // VERIFICAR SE EXISTEM LANCAMENTOS EM ACRESCIMOS
                //

                 if (obterTPBAC(pID_ORG,pIDTPB)) then begin

                  //existem acrescimos  do TP

                  while not qryTPBAcrescimos.Eof do
                      begin

                           VALOR       := qryTPBAcrescimos.FieldByName('VALOR').AsCurrency;
                           ID          := query.FieldByName('ID').AsString;
                           HISTORICO   := qryTPBAcrescimos.FieldByName('HISTORICO').AsString;
                           CDHIST      := qryTPBAcrescimos.FieldByName('CDHIST').AsInteger;
                           COMPL       := qryTPBAcrescimos.FieldByName('COMPL').AsString;
                           CDREDUZDEB  := uUtil.convertStrToInt(qryTPBAcrescimos.FieldByName('CDREDUZDEB').AsString);
                           DGREDUZDEB  := qryTPBAcrescimos.FieldByName('DGREDUZDEB').AsString;
                           DGDEB       := qryTPBAcrescimos.FieldByName('DGDEB').AsString;
                           CONTA_DEB   := qryTPBAcrescimos.FieldByName('CONTA_DEB').AsString;

                          FsListaDebito.Adicionar(convertoTPB_PROVToLancamentoDebito(pCodEmpresa,pLote,StrToInt(pAno),
                                                                           CDREDUZDEB,CDHIST,HISTORICO,COMPL,
                                                                           DGREDUZDEB,CONTA_DEB,DGDEB,'1',ID,IDENTIFDEB,VALOR,fData));
                          qryTPBAcrescimos.Next;
                       end;
                end;

             except
              raise(Exception).Create('Problemas ao obter dados dos acr�scimos');
             end;
                 //FIM DA PARTE DO DEBITO
                 // consultar os creditos
                 // pega as deducoes
                 // formas de pagamento

                 try
                 // obtendo as DEDUC��ES
                  if (obterTPBDE(pID_ORG,pIDTPB)) then begin
                   //pegando as deducoes
                      while not qryTPBDeducao.Eof do begin

                          VALOR       := qryTPBDeducao.FieldByName('VALOR').AsCurrency;
                          CDREDUZCRE  := uUtil.convertStrToInt(qryTPBDeducao.FieldByName('CDREDUZCRE').AsString);
                          ID          := qryTPBDeducao.FieldByName('ID').AsString;
                          HISTORICO   := qryTPBDeducao.FieldByName('HISTORICO').AsString;
                          COMPL       := qryTPBDeducao.FieldByName('COMPL').AsString;
                          CDHIST      := qryTPBDeducao.FieldByName('CDHIST').AsInteger;
                          DGREDUZCRE  := qryTPBDeducao.FieldByName('DGREDUZCRE').AsString;
                          DGCRE       := qryTPBDeducao.FieldByName('DGCRE').AsString;
                          CONTA_CRE   := qryTPBDeducao.FieldByName('CONTA_CRE').AsString;

                          FsListaCredito.Adicionar(convertoTPB_PROVToLancamentoCredito(pCodEmpresa,pLote,StrToInt(pAno),
                                                                           CDREDUZCRE,CDHIST,HISTORICO,COMPL,
                                                                           DGREDUZCRE,CONTA_CRE,DGCRE,'2',ID,IDENTIFCRE,VALOR,fData));
                          qryTPBDeducao.Next;

                      end;
                  end;
             except
              raise(Exception).Create('Problemas ao obter dados das dedu��es ');
             end;
               try
                  //OBTER FORMA DE PAGAMENTO CAIXA
                    if (obterTPBCAIXA(pID_ORG,pIDTPB)) then begin
                   //pegando as deducoes
                      while not qryTPBCaixa.Eof do begin

                          VALOR       := qryTPBCaixa.FieldByName('VALOR').AsCurrency;
                          CDREDUZCRE  := uUtil.convertStrToInt(qryTPBCaixa.FieldByName('CDREDUZCRE').AsString);
                          ID          := qryTPBCaixa.FieldByName('ID').AsString;
                          HISTORICO   := qryTPBCaixa.FieldByName('HISTORICO').AsString;
                          COMPL       := qryTPBCaixa.FieldByName('COMPL').AsString;
                          CDHIST      := qryTPBCaixa.FieldByName('CDHIST').AsInteger;
                          DGREDUZCRE  := qryTPBCaixa.FieldByName('DGREDUZCRE').AsString;
                          DGCRE       := qryTPBCaixa.FieldByName('DGCRE').AsString;
                          CONTA_CRE   := qryTPBCaixa.FieldByName('CONTA_CRE').AsString;

                          FsListaCredito.Adicionar(convertoTPB_PROVToLancamentoCredito(pCodEmpresa,pLote,StrToInt(pAno),
                                                                           CDREDUZCRE,CDHIST,HISTORICO,COMPL,
                                                                           DGREDUZCRE,CONTA_CRE,DGCRE,'2',ID,IDENTIFCRE,VALOR,fData));
                          qryTPBCaixa.Next;

                      end;
                  end;


             except
              raise(Exception).Create('Problemas ao obter dados da baixa por tesouraria ');
             end;
                 try
                   //OBTER FORMA DE PAGAMENTO EM CHERQUE
                    if (obterTPBCHEQUE(pID_ORG,pIDTPB)) then begin
                   //pegando as deducoes
                      while not qryTPBCheque.Eof do begin

                          VALOR       := qryTPBCheque.FieldByName('VALOR').AsCurrency;
                          CDREDUZCRE  := uUtil.convertStrToInt(qryTPBCheque.FieldByName('CDREDUZCRE').AsString);
                          ID          := qryTPBCheque.FieldByName('ID').AsString;
                          HISTORICO   := qryTPBCheque.FieldByName('HISTORICO').AsString;
                          COMPL       := qryTPBCheque.FieldByName('COMPL').AsString;
                          CDHIST      := qryTPBCheque.FieldByName('CDHIST').AsInteger;
                          DGREDUZCRE  := qryTPBCheque.FieldByName('DGREDUZCRE').AsString;
                          DGCRE       := qryTPBCheque.FieldByName('DGCRE').AsString;
                          CONTA_CRE   := qryTPBCheque.FieldByName('CONTA_CRE').AsString;

                          FsListaCredito.Adicionar(convertoTPB_PROVToLancamentoCredito(pCodEmpresa,pLote,StrToInt(pAno),
                                                                           CDREDUZCRE,CDHIST,HISTORICO,COMPL,
                                                                           DGREDUZCRE,CONTA_CRE,DGCRE,'2',ID,IDENTIFCRE,VALOR,fData));
                          qryTPBCheque.Next;
                      end;
                  end;
             except
              raise(Exception).Create('Problemas ao obter dados da baixa por cheque');
             end;
                  try
                     //OBTER FORMA DE PAGAMENTO EM INTERNET
                    if (obterTPBINTERNET(pID_ORG,pIDTPB)) then begin
                   //pegando as deducoes
                      while not qryTPBCheque.Eof do begin

                          VALOR       := qryTPBInternet.FieldByName('VALOR').AsCurrency;
                          CDREDUZCRE  := uUtil.convertStrToInt(qryTPBInternet.FieldByName('CDREDUZCRE').AsString);
                          ID          := qryTPBInternet.FieldByName('ID').AsString;
                          HISTORICO   := qryTPBInternet.FieldByName('HISTORICO').AsString;
                          COMPL       := qryTPBInternet.FieldByName('COMPL').AsString;
                          CDHIST      := qryTPBInternet.FieldByName('CDHIST').AsInteger;
                          DGREDUZCRE  := qryTPBInternet.FieldByName('DGREDUZCRE').AsString;
                          DGCRE       := qryTPBInternet.FieldByName('DGCRE').AsString;
                          CONTA_CRE   := qryTPBInternet.FieldByName('CONTA_CRE').AsString;

                          FsListaCredito.Adicionar(convertoTPB_PROVToLancamentoCredito(pCodEmpresa,pLote,StrToInt(pAno),
                                                                           CDREDUZCRE,CDHIST,HISTORICO,COMPL,
                                                                           DGREDUZCRE,CONTA_CRE,DGCRE,'2',ID,IDENTIFCRE,VALOR,fData));
                          qryTPBInternet.Next;

                      end;
                  end;
             except
              raise(Exception).Create('Problemas ao obter dados da baixa internet');
             end;

             except
              raise(Exception).Create('Problemas ao obter dados da baixa');
             end;
          end;

      query.Next;
    end;

    FsListaLancamentos.AdicionarCredito(FsListaCredito);
    FsListaLancamentos.AdicionarDebito(FsListaDebito);

  except
    raise(Exception).Create('Problemas ao converter lancamentos.');
//    on E: Exception do
//    E.Message ;
  end;

  //validar as duas listas
  //1- garantir que o valor de credito e de debito sao iguais
  //2- garantir que a conta contabil exista no MEGA
  //3- garantir que a conta reduzida exista no MEGA
  // validarLancamentos(pIdOrganizacao, FsListaLancamentos, pCodEmpresa);

  Result := FsListaLancamentos;

end;

  function TdmExportaFinance.obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  if not qryTPBAcrescimos.Connection.Connected then
  begin
    qryTPBAcrescimos.Connection := dmConexao.Conn;
  end;

  qryTPBAcrescimos.Close;

  qryTPBAcrescimos.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBAcrescimos.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBAcrescimos.Open;

  Result := not qryTPBAcrescimos.IsEmpty;
end;

function TdmExportaFinance.convertoTPB_PROVToLancamentoCredito(pCodEmpresa, pLote, pAno, pCodReduzCre,pCodHist: Integer; pHistorico, pComple, pDgCodReduzCre, pContaCre, pDgCre,  pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime) : TLancamentoCreditoModel;
var
 tempLancamentoCR : TLancamentoCreditoModel;
begin
      tempLancamentoCR := TLancamentoCreditoModel.Create;
                          tempLancamentoCR.SetAno(IntToStr(pAno));
                          tempLancamentoCR.SetLote(pLote);
                          tempLancamentoCR.SetIdEmpresa(pCodEmpresa);
                          tempLancamentoCR.SetFilial(0);
                          tempLancamentoCR.SetCentroCusto(0);
                          tempLancamentoCR.SetDataLanc(uUtil.getDataServer);
                          tempLancamentoCR.SetValor(pValor);
                          tempLancamentoCR.SetData(pData);
                          tempLancamentoCR.SetContaCredito(pContaCre) ;
                          tempLancamentoCR.SetDgContaCredito(pDgCre);
                          tempLancamentoCR.SetCodReduzCre(pCodReduzCre);
                          tempLancamentoCR.SetDgCodReduzCre(pDgCodReduzCre);
                          tempLancamentoCR.SetCodHistorico(pCodHist);
                          tempLancamentoCR.SetComplemento(pComple);
                          tempLancamentoCR.SetHistorico(pHistorico);
                          tempLancamentoCR.SetIdRegistroFinance(pIdFinance);
                          tempLancamentoCR.SetRegistroProvisao('0');
                          tempLancamentoCR.SetFncIdentificacao(pIdentFnc);
                          tempLancamentoCR.SetTipo('2');  //1 - DEBITO  - 2 - CREDITO
                          tempLancamentoCR.SetExecTrigger('S'); //S sempre


     Result := tempLancamentoCR;

end;

function TdmExportaFinance.convertoTPB_PROVToLancamentoDebito(pCodEmpresa, pLote, pAno,  pCodReduzDeb,pCodHist: Integer; pHistorico,
                                                              pComple, pDgCodReduzDeb, pContaDeb, pDgDeb,  pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime) : TLancamentoDebitoModel;
var
 tempLancamentoDB : TLancamentoDebitoModel;
begin

  tempLancamentoDB := TLancamentoDebitoModel.Create;
                      tempLancamentoDB.SetAno(IntToStr(pAno));
                      tempLancamentoDB.SetLote(pLote);
                      tempLancamentoDB.SetIdEmpresa(pCodEmpresa);
                      tempLancamentoDB.SetFilial(0);
                      tempLancamentoDB.SetCentroCusto(0);
                      tempLancamentoDB.SetDataLanc(uUtil.getDataServer);
                      tempLancamentoDB.SetValor(pValor);
                      tempLancamentoDB.SetData(pData);
                      tempLancamentoDB.SetContaDebito(pContaDeb);
                      tempLancamentoDB.SetDgContaDebito(pDgDeb);
                      tempLancamentoDB.SetCodReduzDeb(pCodReduzDeb);
                      tempLancamentoDB.SetDgCodReduzDeb(pDgCodReduzDeb);
                      tempLancamentoDB.SetCodHistorico(pCodHist);
                      tempLancamentoDB.SetComplemento(pComple);
                      tempLancamentoDB.SetHistorico(pHistorico);
                      tempLancamentoDB.SetIdRegistroFinance(pIdFinance);
                      tempLancamentoDB.SetFncIdentificacao(pIdentFnc);
                      tempLancamentoDB.SetTipo('1');   //1 - DEBITO  - 2 - CREDITO
                      tempLancamentoDB.SetExecTrigger('S'); //S sempre


     Result := tempLancamentoDB;

end;

 function TdmExportaFinance.obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  if not qryTPBDeducao.Connection.Connected then
  begin
    qryTPBDeducao.Connection := dmConexao.Conn;
  end;

  qryTPBDeducao.Close;

  qryTPBDeducao.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBDeducao.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBDeducao.Open;

  Result := not qryTPBDeducao.IsEmpty;
end;

function TdmExportaFinance.obterTPBCAIXA(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  if not qryTPBCaixa .Connection.Connected then
  begin
    qryTPBCaixa.Connection := dmConexao.Conn;
  end;

  qryTPBCaixa.Close;

  qryTPBCaixa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTPBCaixa.ParamByName('PIDTITULOPAGARBAIXA').AsString :=
    pIdTPB;
  qryTPBCaixa.Open;

  Result := not qryTPBCaixa.IsEmpty;
end;


function TdmExportaFinance.obterTPBCHEQUE(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  if not qryTPBCheque .Connection.Connected then
  begin
    qryTPBCheque.Connection := dmConexao.Conn;
  end;

  qryTPBCheque.Close;

  qryTPBCheque.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTPBCheque.ParamByName('PIDTITULOPAGARBAIXA').AsString :=
    pIdTPB;
  qryTPBCheque.Open;

  Result := not qryTPBCheque.IsEmpty;
end;


function TdmExportaFinance.obterTPBINTERNET(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  if not qryTPBInternet.Connection.Connected then
  begin
    qryTPBInternet.Connection := dmConexao.Conn;
  end;

  qryTPBInternet.Close;

  qryTPBInternet.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTPBInternet.ParamByName('PIDTITULOPAGARBAIXA').AsString :=
    pIdTPB;
  qryTPBInternet.Open;

  Result := not qryTPBInternet.IsEmpty;
end;


function TdmExportaFinance.obterValorDebitoTRB(pIdOrganizacao, pTable, pCampoSum, pCampoData: string;
                                                pDataInicial, pDataFinal: TDate;isProvisao :Integer ): Currency;
  var
  comando : string;
begin
dmConexao.conectarBanco;

comando := ' SELECT SUM(TR.valor_nominal) AS VALOR_DEBITO  FROM  TITULO_RECEBER TR ' +
           ' WHERE TR.data_pagamento  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL ' +
           ' AND TR.ID_ORGANIZACAO = :PIDORGANIZACAO ' +
           ' AND TR.id_tipo_status = ''QUITADO'' or (TR.id_tipo_status = ''PARCIAL'') ' +
           ' and TR.id_lote_contabil IS null ' ;
        //consulta todos os titulos recebidos no periodo . organizacao e nao tenha sido exportado

    try
          qryObterValorTitulo.Close;
          qryObterValorTitulo.Connection := dmConexao.Conn;
          qryObterValorTitulo.SQL.Clear;
          qryObterValorTitulo.SQL.Add(comando);
          qryObterValorTitulo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
          qryObterValorTitulo.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
          qryObterValorTitulo.ParamByName('DTDATAFINAL').AsDate := pDataFinal;

          qryObterValorTitulo.Open;


      except
        raise(Exception).Create('Problemas ao OBTER VALOR DEBITO TRB');
      end;

       Result := qryObterValorTitulo.FieldByName('VALOR_DEBITO').AsCurrency;

end;

function TdmExportaFinance.preencheComboLoteContabil(pIdOrganizacao : string ) :boolean;
var
ano, cmd :string;
pDataInicial, pDataFinal, dataServer :TDateTime;

begin
  dataServer := uUtil.getDataServer;
  ano := FormatDateTime('yyyy', dataServer );
  pDataInicial := StrToDateTime('01/01/'+ano);

  Result := false;
  cmd :=  ' SELECT  LC.ID_LOTE_CONTABIL, LC.LOTE '+
          ' FROM LOTE_CONTABIL LC ' +
          ' WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
          ' (LC.DATA_REGISTRO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) AND ' +
          ' LC.STATUS <> ''EXCLUIDO'' ' +
          ' ORDER BY LC.LOTE ' ;


  if dmConexao.conectarBanco then
  begin

    qryObterTodosLoteContabil.Close;
    if not qryObterTodosLoteContabil.Connection.Connected then
    begin
      qryObterTodosLoteContabil.Connection := dmConexao.Conn;
    end;
    qryObterTodosLoteContabil.SQL.Clear;
    qryObterTodosLoteContabil.SQL.Add(cmd);
    qryObterTodosLoteContabil.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterTodosLoteContabil.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
    qryObterTodosLoteContabil.ParamByName('DTDATAFINAL').AsDate := dataServer;
    qryObterTodosLoteContabil.Open;

    Result := not qryObterTodosLoteContabil.IsEmpty;
  end;
end;

end.


