unit uFormaPagamentoDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uFormaPagamentoModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
TFormaPagamentoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
  //  class function Insert(tForma :TFormaPagamentoModel): Boolean;
    class function obterPorID(tForma :TFormaPagamentoModel): TFormaPagamentoModel;
  //  class function Update(tForma :TFormaPagamentoModel): Boolean;
  //  class function Delete(tForma :TFormaPagamentoModel): Boolean;
 //   class function getContaContabil (tForma :TFormaPagamentoModel): TContaContabilModel;
  end;


implementation

{ TFormaPagamentoDAO }

class function TFormaPagamentoDAO.obterPorID( tForma: TFormaPagamentoModel): TFormaPagamentoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
tFormaPagto: TFormaPagamentoModel;
begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT ID_FORMA_PAGAMENTO, ID_ORGANIZACAO, '  );
  qryPesquisa.SQL.Add('DESCRICAO, ID_CONTA_CONTABIL '  );
  qryPesquisa.SQL.Add('FROM FORMA_PAGAMENTO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_FORMA_PAGAMENTO = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := tForma.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := TFORMA.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      tFormaPagto                  := TFormaPagamentoModel.Create;
      tFormaPagto.FID              := qryPesquisa.FieldByName('ID_FORMA_PAGAMENTO').AsString;
      tFormaPagto.FIDorganizacao   := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
      tFormaPagto.FDescricao       := qryPesquisa.FieldByName('DESCRICAO').AsString;
      tFormaPagto.FIDcontaContabil := qryPesquisa.FieldByName('ID_CONTA_CONTABIL').AsString;


  end;


except
raise Exception.Create('Erro ao tentar obter forma de pagamento ');

end;

 Result := tFormaPagto;
end;

end.
