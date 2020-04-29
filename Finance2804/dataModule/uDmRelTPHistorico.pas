unit uDmRelTPHistorico;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmRelTPHistorico = class(TDataModule)
    qryTotalDebitoPorFornecedor: TFDQuery;
    qryTotalQuitadoPorFornecedor: TFDQuery;
    qryTitulosPorFornecedor: TFDQuery;
    qryObterTotalPorStatus: TFDQuery;
    qry1: TFDQuery;

  private
    { Private declarations }
    codigoErro :string;

  public
    { Public declarations }
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente,
      campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function dataSourceIsEmpty(var dts: TDataSource): Boolean;
    function obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;

  end;

var
  dmRelTPHistorico: TdmRelTPHistorico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmRelTPHistorico.obterTotalPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
    codigoErro := 'TP-06';
  try
  dmConexao.conectarBanco;
      qryTotalDebitoPorFornecedor.Connection := dmConexao.Conn;
      qryTotalDebitoPorFornecedor.Close;

      qryTotalDebitoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalDebitoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTotalDebitoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalDebitoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalDebitoPorFornecedor.Open;
  Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ' + codigoErro );
  end;

  Result := qryTotalDebitoPorFornecedor.Fields[0].AsCurrency;
end;

function TdmRelTPHistorico.obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
codigoErro := 'TP-07';

  try
    dmConexao.conectarBanco;
      qryObterTotalPorStatus.Connection := dmConexao.Conn;
      qryObterTotalPorStatus.Close;

      qryObterTotalPorStatus.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTotalPorStatus.ParamByName('PIDSTATUS').AsString := pIdStatus;
      qryObterTotalPorStatus.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryObterTotalPorStatus.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryObterTotalPorStatus.Open;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TOTAL_TP_STATUS ' + codigoErro);
  end;

  Result := qryObterTotalPorStatus.Fields[0].AsCurrency;
end;

function TdmRelTPHistorico.obterTotalQuitadoPorFornecedor(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
codigoErro := 'TP-08';

  try
    dmConexao.conectarBanco;
      qryTotalQuitadoPorFornecedor.Connection := dmConexao.Conn;
      qryTotalQuitadoPorFornecedor.Close;

      qryTotalQuitadoPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalQuitadoPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
      qryTotalQuitadoPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalQuitadoPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalQuitadoPorFornecedor.Open;

  Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TOTAL_TP_QUITADO ' + codigoErro);
  end;

  Result := qryTotalQuitadoPorFornecedor.Fields[0].AsCurrency;

end;


function TdmRelTPHistorico.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;


function TdmRelTPHistorico.obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
var
  cmd: string;
begin
  codigoErro := 'TP-05';

  cmd := 'SELECT * FROM  TITULO_PAGAR TP ' + ' WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' + '(TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' + '(TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' + '(TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' + ' ORDER BY ' + campoOrdem;

  try
    dmConexao.conectarBanco;
    qryTitulosPorFornecedor.Connection := dmConexao.Conn;
    qryTitulosPorFornecedor.Close;
    qryTitulosPorFornecedor.SQL.Clear;
    qryTitulosPorFornecedor.SQL.Add(cmd);

    qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;

    //qryTitulosPorFornecedor.ParamByName('PORDEM').AsString :=campoOrdem;

    qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
    qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

    qryTitulosPorFornecedor.Open;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : TP_FORN ' + codigoErro);
  end;

  Result := not qryTitulosPorFornecedor.IsEmpty;

end;

end.
