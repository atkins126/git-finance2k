unit uHistoricoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uHistoricoModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'HISTORICO';



type
 THistoricoDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : THistoricoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :THistoricoModel): Boolean;
    class function obterPorID(value :THistoricoModel): THistoricoModel;
    class function Update(value :THistoricoModel): Boolean;
    class function Delete(value :THistoricoModel): Boolean;

  end;

implementation

class function THistoricoDAO.Delete(value: THistoricoModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM HISTORICO  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_HISTORICO = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;


 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := xResp;
end;

class function THistoricoDAO.getModel(query: TFDQuery): THistoricoModel;
var model :THistoricoModel;
 contaCtb : TContaContabilModel;
begin

  if not query.IsEmpty then begin

    try

      model                       := THistoricoModel.Create;
      model.FID                   := query.FieldByName('ID_HISTORICO').AsString;
      model.FIDorganizacao        := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDescricao            := query.FieldByName('DESCRICAO').AsString;
      model.FTipo                 := query.FieldByName('TIPO').AsString;
      model.FIdContaContabil      := query.FieldByName('ID_CONTA_CONTABIL').AsString;
      model.FdescricaoReduzida    := query.FieldByName('DESCRICAO_REDUZIDA').AsString;
      model.FProduto              := query.FieldByName('PRODUTO').AsString;


    try
      contaCtb                := TContaContabilModel.Create;
      contaCtb.FID            := model.FIDcontaContabil;
      contaCtb.FIDorganizacao := model.FIDorganizacao;
      model.FcontaContabil    := TContaContabilDAO.obterPorID(contaCtb);

    except
      raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

    end;




    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function THistoricoDAO.Insert(value: THistoricoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' INSERT INTO HISTORICO '+
                ' (ID_HISTORICO, ID_ORGANIZACAO, DESCRICAO, '+
                ' TIPO, CODIGO, ID_CONTA_CONTABIL, DESCRICAO_REDUZIDA, PRODUTO )'+
                ' VALUES (:PID, :PIDORGANIZACAO, :PDESCRICAO, '+
                ' :PTIPO, :PCODIGO, :PIDCONTA_CONTABIL, :PDESC_REDUZ, :PPRODUTO) ' ;

    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PTIPO').AsString                 := value.FTipo;
    qry.ParamByName('PCODIGO').AsInteger              := value.FCodigo;
    qry.ParamByName('PIDCONTA_CONTABIL').AsString     := value.FIdContaContabil ;
    qry.ParamByName('PDESC_REDUZ').AsString           := value.FdescricaoReduzida;
    qry.ParamByName('PPRODUTO').AsString              := value.FProduto;
    qry.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := System.True;
end;

class function THistoricoDAO.obterPorID( value: THistoricoModel): THistoricoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: THistoricoModel;
begin

dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM HISTORICO  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_HISTORICO = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := THistoricoModel.Create;
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function THistoricoDAO.Update(value: THistoricoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql := ' UPDATE HISTORICO ' +
               ' SET DESCRICAO            = :PDESCRICAO,'+
               '     TIPO                 = :PTIPO, '+
               '     CODIGO               = :PCODIGO, '+
               '     ID_CONTA_CONTABIL    = :PIDCONTA_CONTABIL,'+
               '     DESCRICAO_REDUZIDA   = :PDESC_REDUZ, '+
               '     PRODUTO              = :PPRODUTO '+
               ' WHERE (ID_HISTORICO = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';



    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PDESCRICAO').AsString            := value.FDescricao;
    qry.ParamByName('PTIPO').AsString                 := value.FTipo;
    qry.ParamByName('PCODIGO').AsInteger              := value.FCodigo;
    qry.ParamByName('PIDCONTA_CONTABIL').AsString     := value.FIdContaContabil ;
    qry.ParamByName('PDESC_REDUZ').AsString           := value.FdescricaoReduzida;
    qry.ParamByName('PPRODUTO').AsString              := value.FProduto;
    qry.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
end;
end.
