unit uTituloReceberModel;

interface
 {table

    ID_TITULO_RECEBER              VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                 VARCHAR(36) NOT NULL,
    ID_HISTORICO                   VARCHAR(36),
    ID_SACADO                      VARCHAR(36),
    ID_TIPO_COBRANCA               VARCHAR(36),
    ID_RESPONSAVEL                 VARCHAR(36),
    ID_LOCAL_PAGAMENTO             VARCHAR(36),
    ID_TIPO_STATUS                 VARCHAR(36),
    ID_CENTRO_CUSTO                VARCHAR(36),
    ID_TITULO_GERADOR              VARCHAR(36),
    ID_LOTE_CONTABIL               VARCHAR(36),
    ID_NOTA_FISCAL_EMITIDA         VARCHAR(36),
    ID_CONTA_CONTABIL_CREDITO      VARCHAR(36),
    ID_LOTE_TRB                    VARCHAR(36),
    ID_CONTA_CONTABIL_DEBITO       VARCHAR(36),
    ID_USUARIO                     NUMERIC(5,0),
    DATA_REGISTRO                  DATE,
    DATA_EMISSAO                   DATE,
    DATA_PROTOCOLO                 DATE,
    DATA_VENCIMENTO                DATE,
    DATA_PAGAMENTO                 DATE,
    PREVISAO_CARTORIO              DATE,
    DATA_ULTIMA_ATUALIZACAO        DATE,
    VALOR_NOMINAL                  NUMERIC(10,2),
    VALOR_ANTECIPADO               NUMERIC(10,2),
    IS_PROVISAO                    SMALLINT,
    NUMERO_DOCUMENTO               VARCHAR(50),
    DESCRICAO                      VARCHAR(80),
    REGISTRO_PROVISAO              VARCHAR(36),
    MOEDA                          VARCHAR(5),
    CARTEIRA                       VARCHAR(30),
    CODIGO_BARRAS                  VARCHAR(60),
    CONTRATO                       VARCHAR(20),
    PARCELA                        VARCHAR(20) NOT NULL,
    OBSERVACAO                     VARCHAR(200)

);


 }

uses
  Windows, Messages, Classes, SysUtils,uContaContabilModel, uHistoricoModel,uTipoCobrancaModel,System.Generics.Collections,
   uFuncionarioModel, uLocalPagamentoModel,uLotePagamentoModel, uTipoStatusModel, uCentroCustoModel, uNotaFiscalEntradaModel,
   uLoteContabilModel,uUsuarioModel, uContaBancariaChequeModel,uSacadoModel, uOrganizacaoModel,
     uTituloPagarHistoricoModel, uTituloPagarHistoricoDAO, uTituloPagarCentroCustoModel,uTituloPagarCentroCustoDAO;

type
  TTituloReceberModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDLoteTRB : string;
    FFIDHistorico: string;
    FFIDSacado: string;
    FFIDTipoCobranca: string;
    FFIDResponsavel: string;
    FFIDLocalPagamento: string;
    FFIDTipoStatus: string;
    FFIDCentroCusto: string;
    FFIDNotaFiscalEmitida: string;
    FFIDUsuario: string;
    FFIDTituloGerador: string;
    FFIDLoteContabil: string;
    FFIDContaContabilDebito: string;
    FFIDContaContabilCredito: string;
    FFnumeroDocumento: string;
    FFregistroProvisao: string;
    FFdescricao: string;
    FFmoeda: string;
    FFcarteira: string;
    FFcodigoBarras: string;
    FFcontrato: string;
    FFparcela: string;
    FFobservacao: string;

    FFdataRegistro: TDateTime;
    FFdataVencimento: TDateTime;
    FFdataEmissao: TDateTime;
    FFdataProtocolo: TDateTime;
    FFdataUltimaAtualizacao: TDateTime;
    FFprevisaoCartorio: TDateTime;
    FFdataPagamento: TDateTime;

    FFvalorNominal: Currency;
    FFvalorAntecipado: Currency;


    //objetos
     FFOrganizacao        : TOrganizacaoModel;
     FFHistorico          : THistoricoModel;
     FFSacado            : TSacadoModel;
     FFTipoCobranca       : TTipoCobrancaModel;
     FFResponsavel        : TFuncionarioModel;
     FFLocalPagamento     : TLocalPagamentoModel;
     FFLotePagamento      : TLotePagamentoModel;
     FFTipoStatus         : TTipoStatusModel;
     FFCentroCustos       : TCentroCustoModel;
     FFTituloGerador      : TTituloReceberModel; //titulo gerado
//     FFNotaFiscalEmitida  :
     FFLoteContabil       : TLoteContabilModel;
     FFUsuario            : TUsuarioModel;



     //cole�oes
    // exemplo FListaFormasPagto: TObjectList<TTPBaixaFPModel>; //rateio de formas
    FSlistaHistorico    : TObjectList<TTituloPagarHistoricoModel>;
    FSlistaCustos       : TObjectList<TTituloPagarCentroCustoModel>;
    FFIDNotaFiscalEntrada: string;
    FFIDCBChequeVinculado: string;
    FFIDTituloPagarAnterior: string;
    FFIDLotePagamento: string;
    procedure SetFFcarteira(const Value: string);
    procedure SetFFCentroCustos(const Value: TCentroCustoModel);
    procedure SetFFcodigoBarras(const Value: string);
    procedure SetFFcontrato(const Value: string);
    procedure SetFFdataEmissao(const Value: TDateTime);
    procedure SetFFdataPagamento(const Value: TDateTime);
    procedure SetFFdataProtocolo(const Value: TDateTime);
    procedure SetFFdataRegistro(const Value: TDateTime);
    procedure SetFFdataUltimaAtualizacao(const Value: TDateTime);
    procedure SetFFdataVencimento(const Value: TDateTime);
    procedure SetFFdescricao(const Value: string);
    procedure SetFFHistorico(const Value: THistoricoModel);
    procedure SetFFID(const Value: string);
    procedure SetFFIDCBChequeVinculado(const Value: string);
    procedure SetFFIDCentroCusto(const Value: string);
    procedure SetFFIDContaContabilCredito(const Value: string);
    procedure SetFFIDContaContabilDebito(const Value: string);
    procedure SetFFIDHistorico(const Value: string);
    procedure SetFFIDLocalPagamento(const Value: string);
    procedure SetFFIDLoteContabil(const Value: string);
    procedure SetFFIDLotePagamento(const Value: string);
    procedure SetFFIDLoteTRB(const Value: string);
    procedure SetFFIDNotaFiscalEntrada(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDResponsavel(const Value: string);
    procedure SetFFIDSacado(const Value: string);
    procedure SetFFIDTipoCobranca(const Value: string);
    procedure SetFFIDTipoStatus(const Value: string);
    procedure SetFFIDTituloPagarAnterior(const Value: string);
    procedure SetFFIDUsuario(const Value: string);
    procedure SetFFLocalPagamento(const Value: TLocalPagamentoModel);
    procedure SetFFLoteContabil(const Value: TLoteContabilModel);
    procedure SetFFLotePagamento(const Value: TLotePagamentoModel);
    procedure SetFFmoeda(const Value: string);
    procedure SetFFnumeroDocumento(const Value: string);
    procedure SetFFobservacao(const Value: string);
    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFparcela(const Value: string);
    procedure SetFFprevisaoCartorio(const Value: TDateTime);
    procedure SetFFregistroProvisao(const Value: string);
    procedure SetFFResponsavel(const Value: TFuncionarioModel);
    procedure SetFFSacado(const Value: TSacadoModel);
    procedure SetFFTipoCobranca(const Value: TTipoCobrancaModel);
    procedure SetFFTipoStatus(const Value: TTipoStatusModel);
    procedure SetFFTituloGerador(const Value: TTituloReceberModel);
    procedure SetFFUsuario(const Value: TUsuarioModel);
    procedure SetFFvalorAntecipado(const Value: currency);
    procedure SetFFvalorNominal(const Value: currency);


  public


 property FID:string read FFID  write SetFFID ;
 property FIDLoteTRB:string read FFIDLoteTRB  write SetFFIDLoteTRB ;
 property FIDorganizacao:string read FFIDorganizacao  write SetFFIDorganizacao ;
 property FIDHistorico:string read FFIDHistorico  write SetFFIDHistorico ;
 property FIDSacado:string read FFIDSacado  write SetFFIDSacado ;
 property FIDTipoCobranca:string read FFIDTipoCobranca  write SetFFIDTipoCobranca ;
 property FIDResponsavel:string read FFIDResponsavel  write SetFFIDResponsavel ;
 property FIDLocalPagamento:string read FFIDLocalPagamento  write SetFFIDLocalPagamento ;
 property FIDTipoStatus:string read FFIDTipoStatus  write SetFFIDTipoStatus ;
 property FIDCentroCusto:string read FFIDCentroCusto  write SetFFIDCentroCusto ;
 property FIDNotaFiscalEntrada:string read FFIDNotaFiscalEntrada  write SetFFIDNotaFiscalEntrada ;
 property FIDUsuario:string read FFIDUsuario  write SetFFIDUsuario ;
 property FIDTituloPagarAnterior:string read FFIDTituloPagarAnterior  write SetFFIDTituloPagarAnterior ;
 property FIDLoteContabil:string read FFIDLoteContabil  write SetFFIDLoteContabil ;
 property FIDLotePagamento:string read FFIDLotePagamento  write SetFFIDLotePagamento ;
 property FIDContaContabilDebito:string read FFIDContaContabilDebito  write SetFFIDContaContabilDebito ;
 property FIDContaContabilCredito:string read FFIDContaContabilCredito  write SetFFIDContaContabilCredito ;
 property FIDCBChequeVinculado:string read FFIDCBChequeVinculado  write SetFFIDCBChequeVinculado ;
 property FnumeroDocumento:string read FFnumeroDocumento  write SetFFnumeroDocumento ;
 property FregistroProvisao:string read FFregistroProvisao  write SetFFregistroProvisao ;
 property Fdescricao:string read FFdescricao  write SetFFdescricao ;
 property Fmoeda:string read FFmoeda  write SetFFmoeda ;
 property Fcarteira:string read FFcarteira  write SetFFcarteira ;
 property FcodigoBarras:string read FFcodigoBarras  write SetFFcodigoBarras ;
 property Fcontrato:string read FFcontrato  write SetFFcontrato ;
 property Fparcela:string read FFparcela  write SetFFparcela ;
 property Fobservacao:string read FFobservacao  write SetFFobservacao ;
 property FdataRegistro:TDateTime read FFdataRegistro  write SetFFdataRegistro ;
 property FdataVencimento:TDateTime read FFdataVencimento  write SetFFdataVencimento ;
 property FdataEmissao:TDateTime read FFdataEmissao  write SetFFdataEmissao ;
 property FdataProtocolo:TDateTime read FFdataProtocolo  write SetFFdataProtocolo ;
 property FdataUltimaAtualizacao:TDateTime read FFdataUltimaAtualizacao  write SetFFdataUltimaAtualizacao ;
 property FprevisaoCartorio:TDateTime read FFprevisaoCartorio  write SetFFprevisaoCartorio ;
 property FdataPagamento:TDateTime read FFdataPagamento  write SetFFdataPagamento ;

 property FvalorNominal:currency read FFvalorNominal  write SetFFvalorNominal ;
 property FvalorAntecipado:currency read FFvalorAntecipado  write SetFFvalorAntecipado ;

 //objetos
    property Forganizacao: TOrganizacaoModel read FFOrganizacao write SetFForganizacao;

    property FSacado: TSacadoModel read FFSacado write SetFFSacado;
    property FTipoCobranca: TTipoCobrancaModel read FFTipoCobranca write SetFFTipoCobranca;
    property FResponsavel: TFuncionarioModel read FFResponsavel write SetFFResponsavel;
    property FLocalPagamento: TLocalPagamentoModel read FFLocalPagamento write SetFFLocalPagamento;
    property FLotePagamento: TLotePagamentoModel read FFLotePagamento write SetFFLotePagamento;
    property FTipoStatus: TTipoStatusModel read FFTipoStatus write SetFFTipoStatus;
    property FCentroCustos: TCentroCustoModel read FFCentroCustos write SetFFCentroCustos;
    property FTituloGerador: TTituloReceberModel read FFTituloGerador write SetFFTituloGerador;
    property FLoteContabil: TLoteContabilModel read FFLoteContabil write SetFFLoteContabil;
    property FUsuario: TUsuarioModel read FFUsuario write SetFFUsuario;

     property FHistorico: THistoricoModel read FFHistorico write SetFFHistorico;


  //  property listaHistorico   : TObjectList<TTituloPagarHistoricoModel> read FSlistaHistorico  write FSlistaHistorico;
  //  property listaCustos      : TObjectList<TTituloPagarCentroCustoModel> read FSlistaCustos      write FSlistaCustos;

   // procedure AdicionarHST(pHistorico: TTituloPagarHistoricoModel);
  //  procedure AdicionarCC (pCentroCusto: TTituloPagarCentroCustoModel);

    constructor Create;
    destructor Destroy; override;


  end;

implementation


{
procedure TTituloPagarModel.AdicionarCC(pCentroCusto: TTituloPagarCentroCustoModel);
// TITULO_PAGAR_RATEIO_CC
 var
 I: Integer;
 begin
  FSlistaCustos.Add(TTituloPagarCentroCustoModel.Create);
  I := FSlistaCustos.Count -1;
  FSlistaCustos[I].FID            := pCentroCusto.FID;
  FSlistaCustos[I].FIDorganizacao := pCentroCusto.FIDorganizacao;
  FSlistaCustos[I].FIDCentroCusto := pCentroCusto.FIDCentroCusto;
  FSlistaCustos[I].FIDTP          := pCentroCusto.FIDTP;
  FSlistaCustos[I].FValor         := pCentroCusto.FValor;
end;

procedure TTituloPagarModel.AdicionarHST( pHistorico: TTituloPagarHistoricoModel);
//TITULO_PAGAR_HISTORICO
var
 I: Integer;
 begin

  FSlistaHistorico.Add(TTituloPagarHistoricoModel.Create);
  I := FSlistaHistorico.Count -1;
  FSlistaHistorico[I].FID                     := pHistorico.FID;
  FSlistaHistorico[I].FIDorganizacao          := pHistorico.FIDorganizacao;
  FSlistaHistorico[I].FIDHistorico            := pHistorico.FIDHistorico;
  FSlistaHistorico[I].FIDTP                   := pHistorico.FIDTP;
  FSlistaHistorico[I].FIDContaContabilDebito  := pHistorico.FIDContaContabilDebito;
  FSlistaHistorico[I].FValor                  := pHistorico.FValor;

end;   }


{ TTituloReceberModel }

constructor TTituloReceberModel.Create;
begin

end;

destructor TTituloReceberModel.Destroy;
begin

  inherited;
end;

procedure TTituloReceberModel.SetFFcarteira(const Value: string);
begin
  FFcarteira := Value;
end;

procedure TTituloReceberModel.SetFFCentroCustos(const Value: TCentroCustoModel);
begin
  FFCentroCustos := Value;
end;

procedure TTituloReceberModel.SetFFcodigoBarras(const Value: string);
begin
  FFcodigoBarras := Value;
end;

procedure TTituloReceberModel.SetFFcontrato(const Value: string);
begin
  FFcontrato := Value;
end;

procedure TTituloReceberModel.SetFFdataEmissao(const Value: TDateTime);
begin
  FFdataEmissao := Value;
end;

procedure TTituloReceberModel.SetFFdataPagamento(const Value: TDateTime);
begin
  FFdataPagamento := Value;
end;

procedure TTituloReceberModel.SetFFdataProtocolo(const Value: TDateTime);
begin
  FFdataProtocolo := Value;
end;

procedure TTituloReceberModel.SetFFdataRegistro(const Value: TDateTime);
begin
  FFdataRegistro := Value;
end;

procedure TTituloReceberModel.SetFFdataUltimaAtualizacao(
  const Value: TDateTime);
begin
  FFdataUltimaAtualizacao := Value;
end;

procedure TTituloReceberModel.SetFFdataVencimento(const Value: TDateTime);
begin
  FFdataVencimento := Value;
end;

procedure TTituloReceberModel.SetFFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TTituloReceberModel.SetFFHistorico(const Value: THistoricoModel);
begin
  FFHistorico := Value;
end;

procedure TTituloReceberModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTituloReceberModel.SetFFIDCBChequeVinculado(const Value: string);
begin
  FFIDCBChequeVinculado := Value;
end;

procedure TTituloReceberModel.SetFFIDCentroCusto(const Value: string);
begin
  FFIDCentroCusto := Value;
end;

procedure TTituloReceberModel.SetFFIDContaContabilCredito(const Value: string);
begin
  FFIDContaContabilCredito := Value;
end;

procedure TTituloReceberModel.SetFFIDContaContabilDebito(const Value: string);
begin
  FFIDContaContabilDebito := Value;
end;

procedure TTituloReceberModel.SetFFIDHistorico(const Value: string);
begin
  FFIDHistorico := Value;
end;

procedure TTituloReceberModel.SetFFIDLocalPagamento(const Value: string);
begin
  FFIDLocalPagamento := Value;
end;

procedure TTituloReceberModel.SetFFIDLoteContabil(const Value: string);
begin
  FFIDLoteContabil := Value;
end;

procedure TTituloReceberModel.SetFFIDLotePagamento(const Value: string);
begin
  FFIDLotePagamento := Value;
end;

procedure TTituloReceberModel.SetFFIDLoteTRB(const Value: string);
begin
  FFIDLoteTRB := Value;
end;

procedure TTituloReceberModel.SetFFIDNotaFiscalEntrada(const Value: string);
begin
  FFIDNotaFiscalEntrada := Value;
end;

procedure TTituloReceberModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTituloReceberModel.SetFFIDResponsavel(const Value: string);
begin
  FFIDResponsavel := Value;
end;

procedure TTituloReceberModel.SetFFIDSacado(const Value: string);
begin
  FFIDSacado := Value;
end;

procedure TTituloReceberModel.SetFFIDTipoCobranca(const Value: string);
begin
  FFIDTipoCobranca := Value;
end;

procedure TTituloReceberModel.SetFFIDTipoStatus(const Value: string);
begin
  FFIDTipoStatus := Value;
end;

procedure TTituloReceberModel.SetFFIDTituloPagarAnterior(const Value: string);
begin
  FFIDTituloPagarAnterior := Value;
end;

procedure TTituloReceberModel.SetFFIDUsuario(const Value: string);
begin
  FFIDUsuario := Value;
end;

procedure TTituloReceberModel.SetFFLocalPagamento(
  const Value: TLocalPagamentoModel);
begin
  FFLocalPagamento := Value;
end;

procedure TTituloReceberModel.SetFFLoteContabil(
  const Value: TLoteContabilModel);
begin
  FFLoteContabil := Value;
end;

procedure TTituloReceberModel.SetFFLotePagamento(
  const Value: TLotePagamentoModel);
begin
  FFLotePagamento := Value;
end;

procedure TTituloReceberModel.SetFFmoeda(const Value: string);
begin
  FFmoeda := Value;
end;

procedure TTituloReceberModel.SetFFnumeroDocumento(const Value: string);
begin
  FFnumeroDocumento := Value;
end;

procedure TTituloReceberModel.SetFFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TTituloReceberModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TTituloReceberModel.SetFFparcela(const Value: string);
begin
  FFparcela := Value;
end;

procedure TTituloReceberModel.SetFFprevisaoCartorio(const Value: TDateTime);
begin
  FFprevisaoCartorio := Value;
end;

procedure TTituloReceberModel.SetFFregistroProvisao(const Value: string);
begin
  FFregistroProvisao := Value;
end;

procedure TTituloReceberModel.SetFFResponsavel(const Value: TFuncionarioModel);
begin
  FFResponsavel := Value;
end;

procedure TTituloReceberModel.SetFFSacado(const Value: TSacadoModel);
begin
  FFSacado := Value;
end;

procedure TTituloReceberModel.SetFFTipoCobranca(
  const Value: TTipoCobrancaModel);
begin
  FFTipoCobranca := Value;
end;

procedure TTituloReceberModel.SetFFTipoStatus(const Value: TTipoStatusModel);
begin
  FFTipoStatus := Value;
end;

procedure TTituloReceberModel.SetFFTituloGerador(
  const Value: TTituloReceberModel);
begin
  FFTituloGerador := Value;
end;

procedure TTituloReceberModel.SetFFUsuario(const Value: TUsuarioModel);
begin
  FFUsuario := Value;
end;

procedure TTituloReceberModel.SetFFvalorAntecipado(const Value: currency);
begin
  FFvalorAntecipado := Value;
end;

procedure TTituloReceberModel.SetFFvalorNominal(const Value: currency);
begin
  FFvalorNominal := Value;
end;

end.
