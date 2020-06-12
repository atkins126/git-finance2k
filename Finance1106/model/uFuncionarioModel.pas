unit uFuncionarioModel;


interface
{
CREATE TABLE FUNCIONARIO (
    ID_FUNCIONARIO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO  VARCHAR(36) NOT NULL,
    ID_ENDERECO     VARCHAR(36),
    ID_CONTATO      VARCHAR(36),
    NOME            VARCHAR(140),
    CPF             VARCHAR(20),
    ATIVO           INTEGER DEFAULT 1
);

}

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel, uContatoModel, uEnderecoModel;

type
  TFuncionarioModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao :string;
    FFOrganizacao :TOrganizacaoModel;
    FFIDendereco: string;
    FFIDcontato: string;
    FFnome: string;
    FFCpf: string;
    FFativo :Integer;
    FFcontato : TContatoModel;
    FFendereco :TEnderecoModel;

    FFnovo : Boolean;

    function getFFOrganizacao : TOrganizacaoModel;
    function getFFID: string;
    function getFFIDendereco: string;
    function getFFIDcontato: string;
    function getFFnome: string;
    function getFFCpf: string;
    function getFFIDorganizacao: string;

    procedure SetFFCpf(const Value: string);
    procedure SetFFIDcontato(const Value: string);
    procedure SetFFIDendereco(const Value: string);
    procedure SetFFnome(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFOrganizacao(const Value: TOrganizacaoModel);
    procedure SetFFID(const Value: string);
    function getFFativo: Integer;
    procedure SetFFativo(const Value: Integer);
    procedure SetFFcontato(const Value: TContatoModel);
    procedure SetFFendereco(const Value: TEnderecoModel);

  public

    property Fcontato: TContatoModel read FFcontato write SetFFcontato;
    property Fendereco: TEnderecoModel read FFendereco write SetFFendereco;

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property FIDEndereco: string read getFFIDEndereco write SetFFIDEndereco;
    property FIDContato: string read getFFIDContato write SetFFIDContato;
    property FNOME: string read getFFNOME write SetFFNome;
    property FCPF: string read getFFCPF write SetFFCPF;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFFOrganizacao;
    property Fativo: Integer read getFFativo write SetFFativo;
    property Fnovo :Boolean                         read FFnovo                write FFnovo; //define se � novo ou j� existe.


    Constructor Create;

  end;


implementation


{ TFuncionarioModel }

constructor TFuncionarioModel.Create;
begin
 FFnovo := True;
end;


function TFuncionarioModel.getFFativo: Integer;
begin
Result := FFativo;
end;

function TFuncionarioModel.getFFCpf: string;
begin
 Result := FFCpf;

end;

function TFuncionarioModel.getFFID: string;
begin
   Result := FFID;
end;

function TFuncionarioModel.getFFIDcontato: string;
begin
    Result := FFIDcontato;
end;

function TFuncionarioModel.getFFIDendereco: string;
begin
   Result := FFIDendereco;
end;

function TFuncionarioModel.getFFIDorganizacao: string;
begin
   Result := FFIDorganizacao;
end;

function TFuncionarioModel.getFFnome: string;
begin
   Result := FFnome;
end;

function TFuncionarioModel.getFFOrganizacao: TOrganizacaoModel;
begin
    Result := FFOrganizacao;
end;

procedure TFuncionarioModel.SetFFativo(const Value: Integer);
begin
  FFativo := Value;
end;

procedure TFuncionarioModel.SetFFcontato(const Value: TContatoModel);
begin
  FFcontato := Value;
end;

procedure TFuncionarioModel.SetFFCpf(const Value: string);
begin
 FFCpf := Value;
end;

procedure TFuncionarioModel.SetFFendereco(const Value: TEnderecoModel);
begin
  FFendereco := Value;
end;

procedure TFuncionarioModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TFuncionarioModel.SetFFIDcontato(const Value: string);
begin
   FFIDcontato := Value;
end;

procedure TFuncionarioModel.SetFFIDendereco(const Value: string);
begin
   FFIDendereco := Value;
end;

procedure TFuncionarioModel.SetFFIDorganizacao(const Value: string);
begin
    FFIDorganizacao := Value;
end;

procedure TFuncionarioModel.SetFFnome(const Value: string);
begin
  FFnome := Value;
end;

procedure TFuncionarioModel.SetFFOrganizacao(const Value: TOrganizacaoModel);
begin
    FFOrganizacao := Value;
end;

end.
