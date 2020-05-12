unit uLocalPagamentoDAO;

interface
{
CREATE TABLE LOCAL_PAGAMENTO (
    ID_LOCAL_PAGAMENTO  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO      VARCHAR(36) NOT NULL,
    DESCRICAO           VARCHAR(60)
);
}
uses
  Winapi.Windows, Winapi.Messages, System.DateUtils, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uLocalPagamentoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
uOrganizacaoDAO, uOrganizacaoModel, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

  const
   pTable : string = 'LOCAL_PAGAMENTO';

type
 TLocalPagamentoDAO = class
  private
   class function getModel (query :TFDQuery) : TLocalPagamentoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TLocalPagamentoModel): Boolean;
    class function Update(value :TLocalPagamentoModel) :Boolean;
    class function obterPorID(value :TLocalPagamentoModel): TLocalPagamentoModel;
    class function Delete(value :TLocalPagamentoModel): Boolean;

  end;


implementation

{ TLocalPagamentoDAO }

class function TLocalPagamentoDAO.Delete(value: TLocalPagamentoModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin

  xResp := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);
  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('DELETE FROM LOCAL_PAGAMENTO  ');
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_LOCAL_PAGAMENTO = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;
      xResp := True;

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := xResp;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;

end;


class function TLocalPagamentoDAO.getModel (query: TFDQuery): TLocalPagamentoModel;
var
local : TLocalPagamentoModel;
begin

    local                  := TLocalPagamentoModel.Create;

    if not query.IsEmpty then begin

       if not  query.IsEmpty then begin
        local.FID                      := (query.FieldByName('ID_LOCAL_PAGAMENTO').AsString);
        local.FIDorganizacao           := (query.FieldByName('ID_ORGANIZACAO').AsString);
        local.FDescricao               := (query.FieldByName('DESCRICAO').AsString);
       end;
  end;


   Result := local;

end;

class function TLocalPagamentoDAO.Insert(value: TLocalPagamentoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try
      cmdSql := ' INSERT INTO LOCAL_PAGAMENTO (ID_LOCAL_PAGAMENTO, ID_ORGANIZACAO, DESCRICAO) '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESC)';

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString                 := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString      := value.FIDorganizacao;
      qry.ParamByName('PDESC').AsString               := value.FDescricao;

      qry.ExecSQL;

       if qry.RowsAffected >0 then begin sucesso := True; end;


    except
      raise Exception.Create('Erro ao tentar manipular dados em  ' + pTable);
    end;

    Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TLocalPagamentoDAO.obterPorID(value: TLocalPagamentoModel): TLocalPagamentoModel;
var
 local : TLocalPagamentoModel;
 qryPesquisa : TFDQuery;
 cmdSql : string;
begin
   local := TLocalPagamentoModel.Create;
   dmConexao.conectarBanco;

   try
    cmdSql := ' SELECT * FROM LOCAL_PAGAMENTO CBC '+
              ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO) AND (CBC.ID_LOCAL_PAGAMENTO = :PID) ';

    qryPesquisa := TFDQuery.Create(nil);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmdSql);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryPesquisa.ParamByName('PID').AsString := value.FID;

    qryPesquisa.Open;

     if not  qryPesquisa.IsEmpty then begin

      local := getModel(qryPesquisa);

     end;


   except
   raise Exception.Create('Erro ao obter local por ID');

   end;

   Result := local;
end;


class function TLocalPagamentoDAO.Update(value: TLocalPagamentoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try
      cmdSql := ' UPDATE LOCAL_PAGAMENTO '+
                '  SET DESCRICAO = :PDESC '+
                '  WHERE (ID_LOCAL_PAGAMENTO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)';


      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString                 := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString      := value.FIDorganizacao;
      qry.ParamByName('PDESC').AsString               := value.FDescricao;

      qry.ExecSQL;

       if qry.RowsAffected >0 then begin sucesso := True; end;

    except
      raise Exception.Create('Erro ao tentar manipular dados em  ' + pTable);
    end;

    Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

end.
