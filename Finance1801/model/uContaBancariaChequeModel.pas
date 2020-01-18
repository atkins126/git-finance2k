unit uContaBancariaChequeModel;

interface
{TABLE
CREATE TABLE CONTA_BANCARIA_CHEQUE (
    ID_CONTA_BANCARIA_CHEQUE   VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO             VARCHAR(36) NOT NULL,
    ID_CONTA_BANCARIA          VARCHAR(36),
    ID_FUNCIONARIO             VARCHAR(36),
    ID_USUARIO                 NUMERIC(5,0),
    ID_TIPO_STATUS             VARCHAR(36),
    NUMERO_CHEQUE              VARCHAR(10),
    VALOR                      NUMERIC(10,2),
    DATA_REGISTRO              DATE,
    DATA_EMISSAO               DATE,
    DATA_COMPENSACAO           DATE,
    OBSERVACAO                 VARCHAR(250),
    PORTADOR                   VARCHAR(150),
    DATA_PREVISAO_COMPENSACAO  DATE,
    DATA_ESTORNO               DATE,
    QTD_IMPRESSAO              SMALLINT DEFAULT 0
);   }

uses
  Windows, Messages, Classes, SysUtils;

type
  TContaBancariaChequeModel= class(TObject)
  private

    FFNumero: string;
    FFID :string;
    FFIDcontaBancaria: string;
    FFIDtipoStatus: string;
    FFIDresponsavel :string;
    FFIDorganizacao : string;
    FFIDusuario :string;

    FFdescricao: string;
    FFobservacao :string;

    FFportador :string;

    FFdataRegistro: TDate;
    FFdataEmissao: TDate;
    FFdataCompensacao: TDate;
    FFdataPrevisaoCompensacao: TDate;
    FFdataEstorno: TDate;
    FFvalor: Currency;

    FFqtdImpressao :Integer;
    function getFdataCompensacao: TDate;
    function getFFdataEmissao: TDate;
    function getFFdataEstorno: TDate;
    function getFFdataPrevisaoCompensacao: TDate;
    function getFFdataRegistro: TDate;
    function getFFdescricao: string;
    function getFFID: string;
    function getFFIDcontaBancaria: string;
    function getFFIDorganizacao: string;
    function getFFIDresponsavel: string;
    function getFFIDtipoStatus: string;
    function getFFIDusuario: string;
    function getFFNumero: string;
    function getFFobservacao: string;
    function getFFportador: string;
    function getFFqtdImpressao: Integer;
    function getFFvalor: Currency;


    procedure SetFdataCompensacao(const Value: TDate);
    procedure SetFdataEmissao(const Value: TDate);
    procedure SetFdataEstorno(const Value: TDate);
    procedure SetFdataPrevisaoCompensacao(const Value: TDate);
    procedure SetFdataRegistro(const Value: TDate);
    procedure SetFdescricao(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIDcontaBancaria(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFIDresponsavel(const Value: string);
    procedure SetFIDtipoStatus(const Value: string);
    procedure SetFIDusuario(const Value: string);
    procedure SetFNumero(const Value: string);
    procedure SetFobservacao(const Value: string);
    procedure SetFportador(const Value: string);
    procedure SetFqtdImpressao(const Value: Integer);
    procedure SetFvalor(const Value: Currency);



 public
    property FNumero: string read getFFNumero write SetFNumero;
    property FID: string read getFFID write SetFID;
    property FIDcontaBancaria: string read getFFIDcontaBancaria write SetFIDcontaBancaria;
    property FIDtipoStatus: string read getFFIDtipoStatus write SetFIDtipoStatus;
    property Fobservacao: string read getFFobservacao write SetFobservacao;
    property Fportador: string read getFFportador write SetFportador;
    property FIDresponsavel: string read getFFIDresponsavel write SetFIDresponsavel;
    property Fdescricao: string read getFFdescricao write SetFdescricao;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property FIDusuario: string read getFFIDusuario write SetFIDusuario;
    property FdataRegistro: TDate read getFFdataRegistro write SetFdataRegistro;
    property FdataEmissao: TDate read getFFdataEmissao write SetFdataEmissao;
    property FdataCompensacao: TDate read getFdataCompensacao write SetFdataCompensacao;
    property FdataPrevisaoCompensacao: TDate read getFFdataPrevisaoCompensacao write SetFdataPrevisaoCompensacao;
    property FdataEstorno: TDate read getFFdataEstorno write SetFdataEstorno;
    property Fvalor: Currency read getFFvalor write SetFvalor;
    property FqtdImpressao: Integer read getFFqtdImpressao write SetFqtdImpressao;

    Constructor Create;


  end;

implementation

{ TContaBancariaChequeModel }

constructor TContaBancariaChequeModel.Create;
begin
 //ver
end;

function TContaBancariaChequeModel.getFdataCompensacao: TDate;
begin
  Result := FFdataCompensacao
end;

function TContaBancariaChequeModel.getFFdataEmissao: TDate;
begin
     Result := FFdataEmissao;
end;

function TContaBancariaChequeModel.getFFdataEstorno: TDate;
begin
    Result := FFdataEstorno;
end;

function TContaBancariaChequeModel.getFFdataPrevisaoCompensacao: TDate;
begin
    Result := FFdataPrevisaoCompensacao;
end;

function TContaBancariaChequeModel.getFFdataRegistro: TDate;
begin
      Result := FFdataRegistro;
end;

function TContaBancariaChequeModel.getFFdescricao: string;
begin
    Result := FFdescricao;
end;

function TContaBancariaChequeModel.getFFID: string;
begin
    Result := FFID;
end;

function TContaBancariaChequeModel.getFFIDcontaBancaria: string;
begin
    Result := FFIDcontaBancaria;
end;

function TContaBancariaChequeModel.getFFIDorganizacao: string;
begin
    Result := FFIDorganizacao;
end;

function TContaBancariaChequeModel.getFFIDresponsavel: string;
begin
     Result := FFIDresponsavel;
end;

function TContaBancariaChequeModel.getFFIDtipoStatus: string;
begin
    Result := FFIDtipoStatus;
end;

function TContaBancariaChequeModel.getFFIDusuario: string;
begin
     Result := FFIDusuario;
end;

function TContaBancariaChequeModel.getFFNumero: string;
begin
      Result := FFNumero;
end;

function TContaBancariaChequeModel.getFFobservacao: string;
begin
      Result := FFobservacao;
end;

function TContaBancariaChequeModel.getFFportador: string;
begin
    Result := FFportador;
end;

function TContaBancariaChequeModel.getFFqtdImpressao: Integer;
begin
     Result := FFqtdImpressao;
end;

function TContaBancariaChequeModel.getFFvalor: Currency;
begin
     Result := FFvalor;
end;

procedure TContaBancariaChequeModel.SetFdataCompensacao(const Value: TDate);
begin
  FFdataCompensacao := Value;

end;

procedure TContaBancariaChequeModel.SetFdataEmissao(const Value: TDate);
begin
 FFdataEmissao := Value;
end;

procedure TContaBancariaChequeModel.SetFdataEstorno(const Value: TDate);
begin
   FFdataEstorno := Value;
end;

procedure TContaBancariaChequeModel.SetFdataPrevisaoCompensacao(
  const Value: TDate);
begin
   FFdataPrevisaoCompensacao := Value;
end;

procedure TContaBancariaChequeModel.SetFdataRegistro(const Value: TDate);
begin
   FFdataRegistro := Value;
end;

procedure TContaBancariaChequeModel.SetFdescricao(const Value: string);
begin
   FFdescricao := Value;
end;

procedure TContaBancariaChequeModel.SetFID(const Value: string);
begin
 FFID := Value;
end;

procedure TContaBancariaChequeModel.SetFIDcontaBancaria(const Value: string);
begin
  FFIDcontaBancaria := Value;
end;

procedure TContaBancariaChequeModel.SetFIDorganizacao(const Value: string);
begin
   FFIDorganizacao := Value;
end;

procedure TContaBancariaChequeModel.SetFIDresponsavel(const Value: string);
begin
   FFIDresponsavel := Value;
end;

procedure TContaBancariaChequeModel.SetFIDtipoStatus(const Value: string);
begin
  FFIDtipoStatus := Value;
end;

procedure TContaBancariaChequeModel.SetFIDusuario(const Value: string);
begin
   FFIDusuario := Value;
end;

procedure TContaBancariaChequeModel.SetFNumero(const Value: string);
begin
  FFNumero := Value;
end;

procedure TContaBancariaChequeModel.SetFobservacao(const Value: string);
begin
   FFobservacao := Value;
end;

procedure TContaBancariaChequeModel.SetFportador(const Value: string);
begin
  FFportador := Value;
end;

procedure TContaBancariaChequeModel.SetFqtdImpressao(const Value: Integer);
begin
  FFqtdImpressao := Value;
end;

procedure TContaBancariaChequeModel.SetFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.
