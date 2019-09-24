unit uDMContasPagar;

interface

uses
  // System.SysUtils, System.Classes,uDM, Data.DB;
  System.SysUtils, System.Variants, Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, UDMOrganizacao, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, udmConexao, FireDAC.Stan.Util, FireDAC.Comp.Script,
  System.Classes;

type
  TdmContasPagar = class(TDataModule)
    DSPreencheGridMain: TDataSource;
    qryRelPagamentos: TFDQuery;
    qryCentroCusto: TFDQuery;
    sqlScriptContainer: TFDScript;
    qryObterTPHistoricoPorTitulo: TFDQuery;
    qryObterCentroCustoPorTitulo: TFDQuery;
    qryTotalDebitoPorFornecedor: TFDQuery;
    qryTotalQuitadoPorFornecedor: TFDQuery;
    dtsTitulosPagarAll: TDataSource;
    qryTitulosPorFornecedor: TFDQuery;
    qryObterTodos: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    qryTitulosExcel: TFDQuery;
    dtsTitulosExcel: TDataSource;
    dtsTituloPagarExcel: TDataSource;
    qryObterTotalPorStatus: TFDQuery;
    procedure DSPreencheGridMainDataChange(Sender: TObject; Field: TField);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function dataSourceIsEmpty(var dts: TDataSource): Boolean;
    function obterTodos(pIdOrganizacao: string): Boolean;
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTitulosExcel(pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;


    //TP PRovisionado
    function obterTPProBase(pIdOrganizacao : string; pDataInicial, pDataFinal: TDate ): Boolean;
    function obterTPProvCR(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
    function obterTPProvDB(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
//TP BAIXA
    function obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterTPBaixaPorTitulo(pIdOrganizacao, pIdtituloPagar: String): Boolean;
    function obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBHistorico(pIdorganizacao, tituloPagarQuitado : string): Boolean;



  end;

var
  dmContasPagar: TdmContasPagar;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TdmContasPagar.DataModuleCreate(Sender: TObject);
begin
 qryRelPagamentos.Open();

end;

function TdmContasPagar.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;

procedure TdmContasPagar.DSPreencheGridMainDataChange(Sender: TObject; Field: TField);
begin
  // carrega os historicos
  qryObterTPHistoricoPorTitulo.Close;
  qryObterTPHistoricoPorTitulo.ParamByName('pId_TITULO_PAGAR').AsString := qryRelPagamentos.FieldByName('ID_TITULO_PAGAR').AsString;

  qryObterTPHistoricoPorTitulo.ParamByName('pIdOrganizacao').AsString := qryRelPagamentos.FieldByName('ID_ORGANIZACAO').AsString;
  qryObterTPHistoricoPorTitulo.Open();

  // carrega os centros de custos .. sv jrg
  qryObterCentroCustoPorTitulo.Close;
  qryObterCentroCustoPorTitulo.ParamByName('pId_TITULO_PAGAR').AsString := qryRelPagamentos.FieldByName('ID_TITULO_PAGAR').AsString;
  qryObterCentroCustoPorTitulo.ParamByName('pIdOrganizacao').AsString := qryRelPagamentos.FieldByName('ID_ORGANIZACAO').AsString;
  qryObterCentroCustoPorTitulo.Open();

end;

function TdmContasPagar.obterTitulosExcel(pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
begin

  if not qryTitulosExcel.Connection.Connected then
  begin
    qryTitulosExcel.Connection := dmConexao.Conn;
  end;

//  [QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataInicial.Date)), QuotedStr(FormatDateTime('dd.mm.yyyy', dtDataFinal.Date

  qryTitulosExcel.Close;
  qryTitulosExcel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTitulosExcel.ParamByName('DTDATAINICIAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataInicial));   //ver pq pega com hora
  qryTitulosExcel.ParamByName('DTDATAFINAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataFinal));
  qryTitulosExcel.Open();

  //qryTitulosExcel.SQL.SaveToFile('c:\finance\debug.log');

  Result := not qryTitulosExcel.IsEmpty;

end;

function TdmContasPagar.obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
var
  cmd: string;
begin
  cmd := 'SELECT * FROM  TITULO_PAGAR TP ' + 'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' + '(TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' + '(TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' + '(TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' + ' ORDER BY ' + campoOrdem;

  if not qryTitulosPorFornecedor.Connection.Connected then
  begin
    qryTitulosPorFornecedor.Connection := dmConexao.Conn;
  end;

  qryTitulosPorFornecedor.Close;
  qryTitulosPorFornecedor.SQL.Clear;
  qryTitulosPorFornecedor.SQL.Add(cmd);

  qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;

  //qryTitulosPorFornecedor.ParamByName('PORDEM').AsString :=campoOrdem;

  qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
  qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

  qryTitulosPorFornecedor.Open;

  Result := not qryTitulosPorFornecedor.IsEmpty;

end;

function TdmContasPagar.obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin

  if not qryTotalDebitoPorFornecedor.Connection.Connected then
  begin
    qryTotalDebitoPorFornecedor.Connection := dmConexao.Conn;
  end;

  qryTotalDebitoPorFornecedor.Close;
  qryTotalDebitoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTotalDebitoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
  qryTotalDebitoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
  qryTotalDebitoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

  qryTotalDebitoPorFornecedor.Open;

  Result := qryTotalDebitoPorFornecedor.Fields[0].AsCurrency;
end;

function TdmContasPagar.obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin

  if not qryObterTotalPorStatus.Connection.Connected then
  begin
    qryObterTotalPorStatus.Connection := dmConexao.Conn;
  end;

  qryObterTotalPorStatus.Close;
  qryObterTotalPorStatus.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterTotalPorStatus.ParamByName('PIDSTATUS').AsString := pIdStatus;
  qryObterTotalPorStatus.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
  qryObterTotalPorStatus.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

  qryObterTotalPorStatus.Open;

  Result := qryObterTotalPorStatus.Fields[0].AsCurrency;
end;

function TdmContasPagar.obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin

  if not qryTotalQuitadoPorFornecedor.Connection.Connected then
  begin
    qryTotalQuitadoPorFornecedor.Connection := dmConexao.Conn;
  end;

  qryTotalQuitadoPorFornecedor.Close;
  qryTotalQuitadoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTotalQuitadoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
  qryTotalQuitadoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
  qryTotalQuitadoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

  qryTotalQuitadoPorFornecedor.Open;

  Result := qryTotalQuitadoPorFornecedor.Fields[0].AsCurrency;

end;


function TdmContasPagar.obterTPBAC(pIdOrganizacao, pIdTPB: String): Boolean;
begin

end;

function TdmContasPagar.obterTPBaixaPorTitulo(pIdOrganizacao,
  pIdtituloPagar: String): Boolean;
begin

end;

function TdmContasPagar.obterTPBBanco(pIdOrganizacao, pIdTPB: String): Boolean;
begin

end;

function TdmContasPagar.obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
begin

end;

function TdmContasPagar.obterTPBCheque(pIdOrganizacao, pIdTPB: String): Boolean;
begin

end;

function TdmContasPagar.obterTPBDE(pIdOrganizacao, pIdTPB: String): Boolean;
begin

end;

function TdmContasPagar.obterTPBHistorico(pIdorganizacao,
  tituloPagarQuitado: string): Boolean;
begin

end;

function TdmContasPagar.obterTPProBase(pIdOrganizacao: string; pDataInicial,
  pDataFinal: TDate): Boolean;
begin

end;

function TdmContasPagar.obterTPProvCR(pIdOrganizacao,
  pRegistroProvisao: string): Boolean;
begin

end;

function TdmContasPagar.obterTPProvDB(pIdOrganizacao,
  pRegistroProvisao: string): Boolean;
begin

end;

function TdmContasPagar.obterTPQuitados(pIdOrganizacao, pIdStatus: string;
  pDataInicial, pDataFinal: TDate): Boolean;
begin

end;

function TdmContasPagar.obterTodos(pIdOrganizacao: string): Boolean;
begin

  qryObterTodos.Close;
  qryObterTodos.Connection := dmConexao.Conn;
  qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  //qryObterTodos.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
  //qryObterTodos.ParamByName('DTDATAFINAL').AsString :=  FormatDateTime('mm/dd/yyyy', dtDataFinal);

  qryObterTodos.Open;

  Result := not qryObterTodos.IsEmpty;
end;

function TdmContasPagar.obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
begin

  if not qryObterPorNumeroDocumento.Connection.Connected then
  begin
    qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
  end;

  qryObterPorNumeroDocumento.Close;
  qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

  qryObterPorNumeroDocumento.Open;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;

end.


