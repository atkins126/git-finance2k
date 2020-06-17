unit uTipoDeducaoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTipoDeducaoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uHistoricoModel, uHistoricoDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TIPO_DEDUCAO';

type
 TTipoDeducaoDAO = class
  private
    class function getModel (query :TFDQuery) : TTipoDeducaoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TTipoDeducaoModel): Boolean;
    class function obterPorID(value :TTipoDeducaoModel): TTipoDeducaoModel;
    class function Update(value :TTipoDeducaoModel): Boolean;
    class function Delete(value :TTipoDeducaoModel): Boolean;

  end;

implementation

class function TTipoDeducaoDAO.Delete(value: TTipoDeducaoModel): Boolean;
var
  qry: TFDQuery;
  xResp: Boolean;
begin

  xResp := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
    try

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM ' + pTable);
      qry.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_' + pTable + ' = :PID ');
      qry.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qry.ParamByName('PID').AsString := value.FID;

      qry.ExecSQL;
     if qry.RowsAffected >0 then begin
      xResp := True; end;

    except
      xResp := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := xResp;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TTipoDeducaoDAO.getModel(query: TFDQuery): TTipoDeducaoModel;
var model :TTipoDeducaoModel;
 historico : THistoricoModel;
begin

  model                    := TTipoDeducaoModel.Create;
  historico                := THistoricoModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                := query.FieldByName('ID_TIPO_DEDUCAO').AsString;
      model.FIDorganizacao     := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao         := query.FieldByName('DESCRICAO').AsString;
      model.FIDHistorico       := query.FieldByName('ID_HISTORICO').AsString;
      model.Fnovo              := False;



          historico.FID            := model.FIDHistorico;
          historico.FIDorganizacao := model.FIDorganizacao;
          model.Fhistorico         := THistoricoDAO.obterPorID(historico);


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTipoDeducaoDAO.Insert(value: TTipoDeducaoModel): Boolean;
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

     cmdSql :=  ' INSERT INTO TIPO_DEDUCAO '+
                ' (ID_TIPO_DEDUCAO, ID_ORGANIZACAO, DESCRICAO, ID_HISTORICO '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO, :PIDHISTORICO )' ;


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PIDHISTORICO').AsString          := value.FIDHistorico ;

    qry.ExecSQL;

     if qry.RowsAffected > 0 then
    begin
      sucesso := True;
    end;

    Result := sucesso;


  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;


  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TTipoDeducaoDAO.obterPorID( value: TTipoDeducaoModel): TTipoDeducaoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTipoDeducaoModel;
begin

  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TTipoDeducaoModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE ID_'+pTable+ ' = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

    if not qryPesquisa.IsEmpty then
    begin
      model := getModel(qryPesquisa);
    end;

except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TTipoDeducaoDAO.Update(value: TTipoDeducaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
  try

     cmdSql := ' UPDATE TIPO_DEDUCAO '+
               ' SET ID_HISTORICO = :PIDHISTORICO, '+
               ' DESCRICAO = :PDESCRICAO '+
               ' WHERE (ID_TIPO_DEDUCAO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO )';




    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PIDHISTORICO').AsString          := value.FIDHistorico ;
    qry.ExecSQL;

    except
      Result := False;
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
