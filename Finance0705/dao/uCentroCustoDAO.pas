unit uCentroCustoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uCentroCustoModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'CENTRO_CUSTO';



type
 TCentroCustoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

  class function getModel (query :TFDQuery) : TCentroCustoModel;

  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TCentroCustoModel): Boolean;
    class function obterPorID(value :TCentroCustoModel): TCentroCustoModel;
    class function Update(value :TCentroCustoModel): Boolean;
    class function Delete(value :TCentroCustoModel): Boolean;

  end;

implementation

class function TCentroCustoDAO.Delete(value: TCentroCustoModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin
 xResp := False;
 dmConexao.conectarBanco;
 try

  qryDelete := TFDQuery.Create(nil);
  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM CENTRO_CUSTO  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CENTRO_CUSTO = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;

  dmConexao.conn.CommitRetaining;

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := xResp;
end;

class function TCentroCustoDAO.getModel(query: TFDQuery): TCentroCustoModel;
var model :TCentroCustoModel;
 contaCtb : TContaContabilModel;
begin
 model                 := TCentroCustoModel.Create;

  if not query.IsEmpty then begin

    try


      model.FID             := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      model.FIDorganizacao  := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao      := query.FieldByName('DESCRICAO').AsString;
      model.FSigla          := query.FieldByName('SIGLA').AsString;
      model.FCodigo         := query.FieldByName('CODIGO').AsInteger;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TCentroCustoDAO.Insert(value: TCentroCustoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
    try

     cmdSql :=   ' INSERT INTO CENTRO_CUSTO '+
                 ' (ID_CENTRO_CUSTO, ID_ORGANIZACAO, DESCRICAO, CODIGO, SIGLA)'+
                 ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO, :PCODIGO, :PSIGLA)';
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString      := value.FDescricao;
    qry.ParamByName('PCODIGO').AsInteger        := value.FCodigo;
    qry.ParamByName('PSIGLA').AsString          := value.FSigla ;


      qry.ExecSQL;
      if qry.RowsAffected > 0 then
      begin
        sucesso := True;
        dmConexao.conn.CommitRetaining;
      end;

    except
      Result := False;
      dmConexao.conn.RollbackRetaining;
      raise Exception.Create('Erro ao tentar inserir ' + pTable);
    end;


  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

  Result := sucesso;

end;

class function TCentroCustoDAO.obterPorID( value: TCentroCustoModel): TCentroCustoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TCentroCustoModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TCentroCustoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CENTRO_CUSTO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CENTRO_CUSTO = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TCentroCustoDAO.Update(value: TCentroCustoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try
      cmdSql := 'UPDATE CENTRO_CUSTO   ' +
      ' SET DESCRICAO = :PDESCRICAO,' +
      '     CODIGO = :PCODIGO, ' +
      '     SIGLA = :PSIGLA ' +
      ' WHERE (ID_CENTRO_CUSTO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString             := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString      := value.FDescricao;
    qry.ParamByName('PCODIGO').AsInteger        := value.FCodigo;
    qry.ParamByName('PSIGLA').AsString          := value.FSigla ;


    qry.ExecSQL;
    dmConexao.conn.CommitRetaining;

  except
    Result := False;
    dmConexao.conn.RollbackRetaining;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
   finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;
end.