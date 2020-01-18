unit uTPBaixaModel;

interface


uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel,System.Generics.Collections, uTituloPagarModel,uTPBaixaChequeModel,uTPBaixaFPModel;

type
  TTPBaixaModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao: string;
    FFOrganizacao: TOrganizacaoModel;

    FFIDCentroCusto: string;
    FFTituloPagar: TTituloPagarModel;
    FFIDResponsavel: string;
    FFTipoBaixa: string;
    FFIDusuario: string;
    FFIDloteContabil: string;
    FFIDlotePagamento: string;
    FFdataRegistro: TDateTime;
    FFvalorPago: Currency;

    FFTPBaixaCheque :TTPBaixaChequeModel; //pagamento em cheque
    FListaFormasPagto: TObjectList<TTPBaixaFPModel>; //cole��o de pagamentos realizados

    function getFFOrganizacao: TOrganizacaoModel;
    function getFFTPBaixaCheque: TTPBaixaChequeModel;

    function getFFIDorganizacao: string;
    function getFFID: string;
    function getFFIDResponsavel: string;
    function getFFIDusuario: string;
    function getFFIDloteContabil: string;
    function getFFIDlotePagamento: string;

    function getFFTituloPagar: TTituloPagarModel;
    function getFFTipoBaixa: string;
    function getFFIDCentroCusto: string;
    function getFFvalorPago: Currency;
    function getFFDataRegistro: TDateTime;


    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFTPBaixaCheque(const Value: TTPBaixaChequeModel);


    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFTipoBaixa(const Value: string);
    procedure setFFTituloPagar(const Value: TTituloPagarModel);


    procedure setFFIDResponsavel(const Value: string);
    procedure setFFIDusuario(const Value: string);
    procedure setFFIDloteContabil(const Value: string);
    procedure setFFIDlotePagamento(const Value: string);

    procedure setFFIDCentroCusto(const Value: string);
    procedure setFFdataRegistro(const Value: TDateTime);
    procedure setFFvalorPago(const Value: Currency);



  public


    property listaFormasPagto: TObjectList<TTPBaixaFPModel> read FListaFormasPagto  write FListaFormasPagto;

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;

    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;
    property FTPBaixaCheque: TTPBaixaChequeModel read getFFTPBaixaCheque write SetFFTPBaixaCheque;

    property FTituloPagar: TTituloPagarModel read getFFTituloPagar write SetFFTituloPagar;
    property FIDResponsavel: string read getFFIDResponsavel write SetFFIDResponsavel;
    property FIDusuario: string read getFFIDusuario write SetFFIDusuario;
    property FIDloteContabil: string read getFFIDloteContabil write SetFFIDloteContabil;
    property FdataRegistro: TDateTime read getFFdataRegistro write setFFdataRegistro;
    property FIDCentroCusto: string read getFFIDCentroCusto write setFFIDCentroCusto;
    property FTipoBaixa: string read getFFTipoBaixa write setFFTipoBaixa;
    property FIDlotePagamento: string read getFFIDlotePagamento write setFFIDlotePagamento;
    property FvalorPago: Currency read getFFvalorPago write setFFvalorPago;


    constructor Create;
    destructor Destroy; override;
    procedure AdicionarFP(pPagamento: TTPBaixaFPModel);

  end;


implementation

{ TTPBaixaModel }

procedure TTPBaixaModel.AdicionarFP(pPagamento: TTPBaixaFPModel);
// TITULO_PAGAR_BAIXA_FP
 var
 I: Integer;
 begin
  FListaFormasPagto.Add(TTPBaixaFPModel.Create);
  I := FListaFormasPagto.Count -1;
  FListaFormasPagto[I].FID := pPagamento.FID;
  FListaFormasPagto[I].FIDorganizacao := pPagamento.FIDorganizacao;
  FListaFormasPagto[I].FFormaPagamento := pPagamento.FFormaPagamento;
  FListaFormasPagto[I].FValor := pPagamento.FValor;
  FListaFormasPagto[I].FIDTPBaixa := pPagamento.FIDTPBaixa;

end;

constructor TTPBaixaModel.Create;
begin
//ver
end;

destructor TTPBaixaModel.Destroy;
begin
 FreeAndNil(FListaFormasPagto);
  inherited;
end;

function TTPBaixaModel.getFFDataRegistro: TDateTime;
begin
Result :=  FFdataRegistro;
end;

function TTPBaixaModel.getFFID: string;
begin
 Result :=  FFID;
end;

function TTPBaixaModel.getFFIDCentroCusto: string;
begin
  Result :=  FFIDCentroCusto;
end;

function TTPBaixaModel.getFFIDloteContabil: string;
begin
 Result :=  FFIDloteContabil;
end;

function TTPBaixaModel.getFFIDlotePagamento: string;
begin
  Result :=  FFIDlotePagamento;
end;

function TTPBaixaModel.getFFIDorganizacao: string;
begin
 Result :=  FFIDorganizacao;
end;

function TTPBaixaModel.getFFIDResponsavel: string;
begin
  Result :=  FFIDResponsavel;
end;


function TTPBaixaModel.getFFIDusuario: string;
begin
   Result := FFIDusuario;
end;

function TTPBaixaModel.getFFOrganizacao: TOrganizacaoModel;
begin
 Result := FFOrganizacao;
end;

function TTPBaixaModel.getFFTipoBaixa: string;
begin
  Result := FFTipoBaixa;
end;

function TTPBaixaModel.getFFTituloPagar: TTituloPagarModel;
begin
  Result := FFTituloPagar;
end;


function TTPBaixaModel.getFFTPBaixaCheque: TTPBaixaChequeModel;
begin
    Result := FFTPBaixaCheque;
end;

function TTPBaixaModel.getFFvalorPago: Currency;
begin
   Result := FFvalorPago;
end;

procedure TTPBaixaModel.setFFdataRegistro(const Value: TDateTime);
begin
 FFdataRegistro := Value;
end;

procedure TTPBaixaModel.setFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTPBaixaModel.setFFIDCentroCusto(const Value: string);
begin
    FFIDCentroCusto := Value;
end;

procedure TTPBaixaModel.setFFIDloteContabil(const Value: string);
begin
   FFIDloteContabil := Value;
end;

procedure TTPBaixaModel.setFFIDlotePagamento(const Value: string);
begin
   FFIDlotePagamento := Value;
end;

procedure TTPBaixaModel.setFFIDorganizacao(const Value: string);
begin
   FFIDorganizacao := Value;
end;

procedure TTPBaixaModel.setFFIDResponsavel(const Value: string);
begin
   FFIDResponsavel := Value;
end;

procedure TTPBaixaModel.setFFIDusuario(const Value: string);
begin
   FFIDusuario := Value;
end;

procedure TTPBaixaModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
   FFOrganizacao := Value;
end;

procedure TTPBaixaModel.setFFTipoBaixa(const Value: string);
begin
   FFTipoBaixa := Value;
end;

procedure TTPBaixaModel.setFFTituloPagar(const Value: TTituloPagarModel);
begin
    FFTituloPagar := Value;
end;


procedure TTPBaixaModel.SetFFTPBaixaCheque(const Value: TTPBaixaChequeModel);
begin
  FFTPBaixaCheque := Value;
end;

procedure TTPBaixaModel.setFFvalorPago(const Value: Currency);
begin
   FFvalorPago := Value;
end;

end.
