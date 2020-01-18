unit uContaBancariaDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaBancariaModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
 TContaBancariaDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
  //  class function Insert(tForma :TContaBancariaModel): Boolean;
    class function obterPorID(tConta :TContaBancariaModel): TContaBancariaModel;
  //  class function Update(tForma :TContaBancariaModel): Boolean;
  //  class function Delete(tForma :TContaBancariaModel): Boolean;
 //   class function getContaContabil (tForma :TFormaPagamentoModel): TContaContabilModel;
  end;


implementation

class function TContaBancariaDAO.obterPorID( tConta: TContaBancariaModel): TContaBancariaModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
conta: TContaBancariaModel;
begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tConta.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := tConta.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      conta                  := TContaBancariaModel.Create;
      conta.FID              := qryPesquisa.FieldByName('ID_CONTA_BANCARIA').AsString;
      conta.FIDorganizacao   := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
      conta.FIDbanco         := qryPesquisa.FieldByName('ID_BANCO').AsString;
      conta.FIDusuario       := qryPesquisa.FieldByName('ID_USUARIO').AsString;
      conta.FIDcontaContabil := qryPesquisa.FieldByName('ID_CONTA_CONTABIL').AsString;
      conta.Fconta           := qryPesquisa.FieldByName('CONTA').AsString;
      conta.FcontaInterna    := qryPesquisa.FieldByName('CONTA_INTERNA').AsString;
      conta.Fagencia         := qryPesquisa.FieldByName('AGENCIA').AsString;
      conta.Fobservacao      := qryPesquisa.FieldByName('OBSERVACAO').AsString;
      conta.Ftitular         := qryPesquisa.FieldByName('TITULAR').AsString;
      conta.Fdependente      := qryPesquisa.FieldByName('DEPENDENTE').AsString;
      conta.FlimiteCredito   := qryPesquisa.FieldByName('LIMITE_CREDITO').AsCurrency;
      conta.FsaldoInicial    := qryPesquisa.FieldByName('SALDO_INICIAL').AsCurrency;


  end;


except
raise Exception.Create('Erro ao tentar obter CONTA BANCARIA ');

end;

 Result := conta;
end;

end.
