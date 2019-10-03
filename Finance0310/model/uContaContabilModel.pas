       unit uContaContabilModel;
interface

uses
  Windows, Messages, Classes, SysUtils;

type
  TContaContabilModel = class(TObject)
  private
    FFConta: string;
    FFDgReduz: string;
    FFDgVer: string;
    FFCodigoReduzido: string;
    FFIdContaContabil: string;
    FFDescricao: string;

    procedure SetFCodigoReduzido(const Value: string);
    procedure SetFConta(const Value: string);
    procedure SetFDescricao(const Value: string);
    procedure SetFDgReduz(const Value: string);
    procedure SetFDgVer(const Value: string);
    procedure SetFIdContaContabil(const Value: string);

    property  FDescricao: string read FFDescricao write SetFDescricao;
    property     FCodigoReduzido: string read FFCodigoReduzido write SetFCodigoReduzido;
    property     FDgVer: string read FFDgVer write SetFDgVer;
    property     FConta: string read FFConta write SetFConta;
    property     FDgReduz: string read FFDgReduz write SetFDgReduz;
    property FIdContaContabil :string read FFIdContaContabil write SetFIdContaContabil;

  end;

implementation

{ TContaContabilModel }

procedure TContaContabilModel.SetFCodigoReduzido(const Value: string);
begin
  FFCodigoReduzido := Value;
end;

procedure TContaContabilModel.SetFConta(const Value: string);
begin
  FFConta := Value;
end;

procedure TContaContabilModel.SetFDescricao(const Value: string);
begin
  FFDescricao := Value;
end;

procedure TContaContabilModel.SetFDgReduz(const Value: string);
begin
  FFDgReduz := Value;
end;

procedure TContaContabilModel.SetFDgVer(const Value: string);
begin
  FFDgVer := Value;
end;

procedure TContaContabilModel.SetFIdContaContabil(const Value: string);
begin
  FFIdContaContabil := Value;
end;

end.
