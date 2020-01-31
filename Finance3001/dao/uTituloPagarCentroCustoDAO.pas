unit uTituloPagarCentroCustoDAO;


interface
 {CREATE TABLE TITULO_PAGAR_RATEIO_CC (
    ID_TITULO_PAGAR_RATEIO_CC  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO             VARCHAR(36) NOT NULL,
    ID_CENTRO_CUSTO            VARCHAR(36),
    ID_TITULO_PAGAR            VARCHAR(36),
    VALOR                      NUMERIC(10,2)
); }





uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  uFuncionarioModel, uCedenteModel, uCedenteDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uTituloPagarCentroCustoModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uCentroCustoModel, uCentroCustoDAO,
  udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TITULO_PAGAR_RATEIO_CC';
type
 TTituloPagarCentroCustoDAO = class
  private
    class function getModel (query :TFDQuery) : TTituloPagarCentroCustoModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TTituloPagarCentroCustoModel): Boolean;
    class function Update (value :TTituloPagarCentroCustoModel) :Boolean;
    class function obterPorID(value :TTituloPagarCentroCustoModel): TTituloPagarCentroCustoModel;
    class function Delete(value :TTituloPagarCentroCustoModel): Boolean;

  end;

implementation



class function TTituloPagarCentroCustoDAO.Delete(value: TTituloPagarCentroCustoModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM '+pTable     );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_'+pTable +  ' = :PID '  );
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

class function TTituloPagarCentroCustoDAO.getModel(query: TFDQuery): TTituloPagarCentroCustoModel;
var model : TTituloPagarCentroCustoModel;
 centroCusto : TCentroCustoModel;
begin

  if not query.IsEmpty then begin

    try

      model                         := TTituloPagarCentroCustoModel.Create;
      model.FID                     := query.FieldByName('ID_TITULO_PAGAR_RATEIO_CC').AsString;
      model.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      model.FIDTP                   := query.FieldByName('ID_TITULO_PAGAR').AsString;
      model.Fvalor                  := query.FieldByName('VALOR').AsCurrency;



        try
          {
            centroCusto := TCentroCustoModel.Create;


          model.fce                := TTPBaixaModel.Create;
          model.FTituloPagarBaixa.FID            := model.FIDTPB;
          model.FTituloPagarBaixa.FIDOrganizacao := model.FIDOrganizacao;
          model.FTituloPagarBaixa                := TCedenteDAO.obterPorID(model.FTituloPagarBaixa);
              referencia circular.. ver depois
             }


        except
          raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

        end;




    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTituloPagarCentroCustoDAO.Insert(value: TTituloPagarCentroCustoModel): Boolean;
var
  qryInsert: TFDQuery;
  cmdDB: string;
begin
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);
  try
    try

     cmdDB :=  ' INSERT INTO TITULO_PAGAR_RATEIO_CC '+
                ' (ID_TITULO_PAGAR_RATEIO_CC, ID_ORGANIZACAO, ID_CENTRO_CUSTO,' +
                ' ID_TITULO_PAGAR, VALOR) '+
                ' VALUES (:PID, :PIDORGANIZACAO,:PIDCC, '+
                ' :PIDTP, :PVALOR )' ;

    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdDB);
    qryInsert.ParamByName('PID').AsString             := value.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qryInsert.ParamByName('PIDCC').AsString           := value.FIDCentroCusto;
    qryInsert.ParamByName('PIDTP').AsString           := value.FIDTP;
    qryInsert.ParamByName('PVALOR').AsCurrency        := value.Fvalor;


     qryInsert.ExecSQL;
     dmConexao.conn.CommitRetaining;


  except
    Result := False;
     dmConexao.conn.RollbackRetaining;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

   Result := System.True;


  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;



end;

class function TTituloPagarCentroCustoDAO.obterPorID( value: TTituloPagarCentroCustoModel): TTituloPagarCentroCustoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTituloPagarCentroCustoModel;
begin
  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  try

    try

      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add('SELECT * ');
      qryPesquisa.SQL.Add('FROM ' + pTable);
      qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO ) AND  ID_' + pTable + ' = :PID ');

      qryPesquisa.ParamByName('PID').AsString := value.FID;
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;

      qryPesquisa.Open;

      if not qryPesquisa.IsEmpty then
      begin

        model := TTituloPagarCentroCustoModel.Create;
        model := getModel(qryPesquisa);
      end;

    except
      raise Exception.Create('Erro ao tentar obter ' + pTable);

    end;

    Result := model;

  finally
    if Assigned(qryPesquisa) then
    begin
      FreeAndNil(qryPesquisa);
    end;
  end;

end;
class function TTituloPagarCentroCustoDAO.Update(value: TTituloPagarCentroCustoModel): Boolean;
var
  qry : TFDQuery;
  cmdDB: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdDB := ' UPDATE TITULO_PAGAR_RATEIO_CC '+
              ' SET ID_CENTRO_CUSTO = :PID_CENTRO_CUSTO, '+
              ' ID_TITULO_PAGAR = :PIDTP,'+
              ' VALOR = :PVALOR '+
              ' WHERE (ID_TITULO_PAGAR_RATEIO_CC = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ' ;


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdDB);
    qry.ParamByName('PID').AsString               := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qry.ParamByName('PID_CENTRO_CUSTO').AsString  := value.FIDCentroCusto;
    qry.ParamByName('PIDTP').AsString             := value.FIDTP;
    qry.ParamByName('PVALOR').AsCurrency          := value.Fvalor;


     qry.ExecSQL;
     dmConexao.conn.CommitRetaining;


  except
    Result := False;
     dmConexao.conn.RollbackRetaining;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
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

