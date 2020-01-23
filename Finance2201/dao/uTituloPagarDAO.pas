unit uTituloPagarDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,System.Generics.Collections,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
 TTituloPagarDAO = class
  private
  class function getTP (query :TFDQuery) : TTituloPagarModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(titulo :TTituloPagarModel): Boolean;
    class function obterPorID(titulo :TTituloPagarModel): TTituloPagarModel;
    class function obterPorNumeroDocumento(titulo :TTituloPagarModel): TTituloPagarModel;
    class function Delete(titulo :TTituloPagarModel): Boolean;
    class function Update(titulo :TTituloPagarModel): Boolean;
 //   class function obterTodosPorStatus(status :string): TObjectList<TTituloPagarModel>; //fazer


  end;
implementation
{ TTituloPagarDAO }
class function TTituloPagarDAO.Delete(titulo: TTituloPagarModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM TITULO_PAGAR  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := titulo.FID;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR TITULO');

 end;

  Result := xResp;
end;

class function TTituloPagarDAO.Insert(titulo: TTituloPagarModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
try
     cmdSql := ' INSERT INTO TITULO_PAGAR '+
     ' ID_TITULO_PAGAR, ID_ORGANIZACAO, '+
     ' ID_HISTORICO, ID_CEDENTE, ID_TIPO_COBRANCA,'+
     ' ID_RESPONSAVEL, ID_LOCAL_PAGAMENTO, ID_TIPO_STATUS,'+
     ' ID_CENTRO_CUSTO, ID_TITULO_GERADOR, ID_NOTA_FISCAL_ENTRADA,' +
     ' NUMERO_DOCUMENTO, DESCRICAO, DATA_REGISTRO, DATA_EMISSAO, '+
     ' DATA_PROTOCOLO, DATA_VENCIMENTO, DATA_PAGAMENTO, PREVISAO_CARTORIO,'+
     ' VALOR_NOMINAL, MOEDA, CARTEIRA, CODIGO_BARRAS, CONTRATO, PARCELA, '+
     ' OBSERVACAO, VALOR_ANTECIPADO, ID_LOTE_CONTABIL, ID_USUARIO, ID_LOTE_PAGAMENTO,'+
     ' DATA_ULTIMA_ATUALIZACAO, ID_CONTA_CONTABIL_CREDITO, ID_CONTA_CONTABIL_DEBITO, '+
     ' REGISTRO_PROVISAO, ID_CONTA_BANCARIA_CHEQUE, ID_LOTE_TPB '+
     ' VALUES (:PIDTITULO_PAGAR,:PIDORGANIZACAO, '+
     ' :PIDHISTORICO,:PIDCEDENTE, :PIDTIPO_COBRANCA, '+
     ' :PIDRESPONSAVEL, :PIDLOCAL_PAGAMENTO, :PIDTIPO_STATUS, '+
     ' :PIDCENTRO_CUSTO, :PIDTITULO_GERADOR, :PIDNOTA_FISCAL_ENTRADA, '+
     ' :PNUMERO_DOCUMENTO, :PDESCRICAO, :PDATA_REGISTRO, :PDATA_EMISSAO, '+
     ' :PDATA_PROTOCOLO, :PDATA_VENCIMENTO, :PDATA_PAGAMENTO, :PPREVISAO_CARTORIO, '+
     ' :PVALOR_NOMINAL, :PMOEDA, :PCARTEIRA, :PCODIGO_BARRAS, :PCONTRATO, :PPARCELA, '+
     ' :POBSERVACAO, :PVALOR_ANTECIPADO, :PIDLOTE_CONTABIL, :PIDUSUARIO, :PIDLOTE_PAGAMENTO, '+
     ' :PDATA_ULTIMA_ATUALIZACAO, :PIDCONTA_CONTABIL_CREDITO, :PIDCONTA_CONTABIL_DEBITO, '+
     ' :PREGISTRO_PROVISAO, :PIDCONTA_BANCARIA_CHEQUE, :PIDLOTE_TPB ) ' ;

    qryInsert := TFDQuery.Create(nil);
    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PIDTITULO_PAGAR').AsString             := titulo.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString              := titulo.FIDorganizacao;
    qryInsert.ParamByName('PIDUSUARIO').AsString                  := titulo.FIDUsuario;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := titulo.FIDResponsavel;
    qryInsert.ParamByName('PIDLOTE_CONTABIL').AsString            := titulo.FIDLoteContabil;
    qryInsert.ParamByName('PIDHISTORICO').AsString                := titulo.FIDHistorico;
    qryInsert.ParamByName('PIDCEDENTE').AsString                  := titulo.FIDCedente;
    qryInsert.ParamByName('PIDLOTE_TPB').AsString                 := titulo.FIDLoteTPB;
    qryInsert.ParamByName('PIDTIPO_COBRANCA').AsString            := titulo.FIDTipoCobranca;
    qryInsert.ParamByName('PIDLOCAL_PAGAMENTO').AsString          := titulo.FIDLocalPagamento;
    qryInsert.ParamByName('PIDTIPO_STATUS').AsString              := titulo.FIDTipoStatus;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := titulo.FIDCentroCusto;
    qryInsert.ParamByName('PIDNOTA_FISCAL_ENTRADA').AsString      := titulo.FIDNotaFiscalEntrada;
    qryInsert.ParamByName('PIDTITULO_GERADOR').AsString           := titulo.FIDTituloPagarAnterior;
    qryInsert.ParamByName('PIDLOTE_PAGAMENTO').AsString           := titulo.FIDLotePagamento;
    qryInsert.ParamByName('PIDCONTA_CONTABIL_DEBITO').AsString    := titulo.FIDContaContabilDebito;
    qryInsert.ParamByName('PIDCONTA_CONTABIL_CREDITO').AsString   := titulo.FIDContaContabilCredito;
    qryInsert.ParamByName('PIDCONTA_BANCARIA_CHEQUE').AsString    := titulo.FIDCBChequeVinculado;
    qryInsert.ParamByName('PDESCRICAO').AsString                  := titulo.Fdescricao;
    qryInsert.ParamByName('POBSERVACAO').AsString                 := titulo.Fobservacao;
    qryInsert.ParamByName('PPARCELA').AsString                    := titulo.Fparcela;
    qryInsert.ParamByName('PCONTRATO').AsString                   := titulo.Fcontrato;
    qryInsert.ParamByName('PCODIGO_BARRAS').AsString              := titulo.FcodigoBarras;
    qryInsert.ParamByName('PCARTEIRA').AsString                   := titulo.Fcarteira;
    qryInsert.ParamByName('PMOEDA').AsString                      := titulo.Fmoeda;
    qryInsert.ParamByName('PREGISTRO_PROVISAO').AsString          := titulo.FregistroProvisao;
    qryInsert.ParamByName('PNUMERO_DOCUMENTO').AsString           := titulo.FnumeroDocumento;

    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := titulo.FdataRegistro;
    qryInsert.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := titulo.FdataUltimaAtualizacao;
    qryInsert.ParamByName('PPREVISAO_CARTORIO').AsDateTime        := titulo.FprevisaoCartorio;
    qryInsert.ParamByName('PDATA_PAGAMENTO').AsDateTime           := titulo.FdataPagamento;
    qryInsert.ParamByName('PDATA_VENCIMENTO').AsDateTime          := titulo.FdataVencimento;
    qryInsert.ParamByName('PDATA_PROTOCOLO').AsDateTime           := titulo.FdataProtocolo;
    qryInsert.ParamByName('PDATA_EMISSAO').AsDateTime             := titulo.FdataEmissao;

    qryInsert.ParamByName('PVALOR_NOMINAL').AsCurrency            := titulo.FvalorNominal;
    qryInsert.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := titulo.FvalorAntecipado;

    qryInsert.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar alterar TITULO');

end;

 Result := System.True;
end;

class function TTituloPagarDAO.obterPorID(titulo: TTituloPagarModel): TTituloPagarModel;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;

begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := titulo.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      tituloPagar := TTituloPagarModel.Create;
      tituloPagar := getTP(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter TITULO');

end;

 Result := tituloPagar;
end;

class function TTituloPagarDAO.obterPorNumeroDocumento(titulo: TTituloPagarModel): TTituloPagarModel;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;

begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND NUMERO_DOCUMENTO = :PDOC '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PDOC').AsString := titulo.FnumeroDocumento;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      tituloPagar := TTituloPagarModel.Create;
      tituloPagar := getTP(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter TITULO');

end;

 Result := tituloPagar;
end;

class function TTituloPagarDAO.Update(titulo: TTituloPagarModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
try

cmdSql := ' UPDATE TITULO_PAGAR '+
            ' SET ID_HISTORICO                = :PIDHISTORICO, '+
            ' ID_CEDENTE                      = :PIDCEDENTE, '+
            ' ID_TIPO_COBRANCA                = :PIDTIPO_COBRANCA, '+
            ' ID_RESPONSAVEL                  = :PIDRESPONSAVEL, '+
            ' ID_LOCAL_PAGAMENTO              = :PIDLOCAL_PAGAMENTO,'+
            ' ID_TIPO_STATUS                  = :PIDTIPO_STATUS, '+
            ' ID_CENTRO_CUSTO                 = :PIDCENTRO_CUSTO,'+
            ' ID_TITULO_GERADOR               = :PIDTITULO_GERADOR,'+
            ' ID_NOTA_FISCAL_ENTRADA          = :PIDNOTA_FISCAL_ENTRADA,'+
            ' NUMERO_DOCUMENTO                = :PNUMERO_DOCUMENTO, '+
            ' DESCRICAO                       = :PDESCRICAO, '+
            ' DATA_REGISTRO                   = :PDATA_REGISTRO, '+
            ' DATA_EMISSAO                    = :PDATA_EMISSAO, '+
            ' DATA_PROTOCOLO                  = :PDATA_PROTOCOLO,'+
            ' DATA_VENCIMENTO                 = :PDATA_VENCIMENTO,'+
            ' DATA_PAGAMENTO                  = :PDATA_PAGAMENTO,'+
            ' PREVISAO_CARTORIO               = :PPREVISAO_CARTORIO,'+
            ' VALOR_NOMINAL                   = :PVALOR_NOMINAL, '+
            ' MOEDA                           = :PMOEDA, '+
            ' CARTEIRA                        = :PCARTEIRA, '+
            ' CODIGO_BARRAS                   = :PCODIGO_BARRAS, '+
            ' CONTRATO                        = :PCONTRATO, '+
            ' PARCELA                         = :PPARCELA, '+
            ' OBSERVACAO                      = :POBSERVACAO, '+
            ' VALOR_ANTECIPADO                = :PVALOR_ANTECIPADO, '+
            ' ID_LOTE_CONTABIL                = :PIDLOTE_CONTABIL, '+
            ' ID_USUARIO                      = :PIDUSUARIO, '+
            ' ID_LOTE_PAGAMENTO               = :PIDLOTE_PAGAMENTO, '+
            ' DATA_ULTIMA_ATUALIZACAO         = :PDATA_ULTIMA_ATUALIZACAO, '+
            ' ID_CONTA_CONTABIL_CREDITO       = :PIDCONTA_CONTABIL_CREDITO, '+
            ' ID_CONTA_CONTABIL_DEBITO        = :PIDCONTA_CONTABIL_DEBITO, '+
            ' REGISTRO_PROVISAO               = :PREGISTRO_PROVISAO, '+
            ' ID_CONTA_BANCARIA_CHEQUE        = :PID_CONTA_BANCARIA_CHEQUE, '+
            ' ID_LOTE_TPB                     = :PIDLOTE_TPB '+

         ' WHERE (ID_TITULO_PAGAR = :PID ) AND (ID_ORGANIZACAO = :PIDORGANIZACAO ) ' ;


    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PID').AsString                         := titulo.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString              := titulo.FIDorganizacao;
    qryUpdate.ParamByName('PIDUSUARIO').AsString                  := titulo.FIDUsuario;
    qryUpdate.ParamByName('PIDRESPONSAVEL').AsString              := titulo.FIDResponsavel;
    qryUpdate.ParamByName('PIDLOTE_CONTABIL').AsString            := titulo.FIDLoteContabil;
    qryUpdate.ParamByName('PIDHISTORICO').AsString                := titulo.FIDHistorico;
    qryUpdate.ParamByName('PIDCEDENTE').AsString                  := titulo.FIDCedente;
    qryUpdate.ParamByName('PIDLOTE_TPB').AsString                 := titulo.FIDLoteTPB;
    qryUpdate.ParamByName('PIDTIPO_COBRANCA').AsString            := titulo.FIDTipoCobranca;
    qryUpdate.ParamByName('PIDLOCAL_PAGAMENTO').AsString          := titulo.FIDLocalPagamento;
    qryUpdate.ParamByName('PIDTIPO_STATUS').AsString              := titulo.FIDTipoStatus;
    qryUpdate.ParamByName('PIDCENTRO_CUSTO').AsString             := titulo.FIDCentroCusto;
    qryUpdate.ParamByName('PIDNOTA_FISCAL_ENTRADA').AsString      := titulo.FIDNotaFiscalEntrada;
    qryUpdate.ParamByName('PIDTITULO_GERADOR').AsString           := titulo.FIDTituloPagarAnterior;
    qryUpdate.ParamByName('PIDLOTE_PAGAMENTO').AsString           := titulo.FIDLotePagamento;
    qryUpdate.ParamByName('PIDCONTA_CONTABIL_DEBITO').AsString    := titulo.FIDContaContabilDebito;
    qryUpdate.ParamByName('PIDCONTA_CONTABIL_CREDITO').AsString   := titulo.FIDContaContabilCredito;
    qryUpdate.ParamByName('PIDCONTA_BANCARIA_CHEQUE').AsString    := titulo.FIDCBChequeVinculado;
    qryUpdate.ParamByName('PDESCRICAO').AsString                  := titulo.Fdescricao;
    qryUpdate.ParamByName('POBSERVACAO').AsString                 := titulo.Fobservacao;
    qryUpdate.ParamByName('PPARCELA').AsString                    := titulo.Fparcela;
    qryUpdate.ParamByName('PCONTRATO').AsString                   := titulo.Fcontrato;
    qryUpdate.ParamByName('PCODIGO_BARRAS').AsString              := titulo.FcodigoBarras;
    qryUpdate.ParamByName('PCARTEIRA').AsString                   := titulo.Fcarteira;
    qryUpdate.ParamByName('PMOEDA').AsString                      := titulo.Fmoeda;
    qryUpdate.ParamByName('PREGISTRO_PROVISAO').AsString          := titulo.FregistroProvisao;
    qryUpdate.ParamByName('PNUMERO_DOCUMENTO').AsString           := titulo.FnumeroDocumento;

    qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime            := titulo.FdataRegistro;
    qryUpdate.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := titulo.FdataUltimaAtualizacao;
    qryUpdate.ParamByName('PPREVISAO_CARTORIO').AsDateTime        := titulo.FprevisaoCartorio;
    qryUpdate.ParamByName('PDATA_PAGAMENTO').AsDateTime           := titulo.FdataPagamento;
    qryUpdate.ParamByName('PDATA_VENCIMENTO').AsDateTime          := titulo.FdataVencimento;
    qryUpdate.ParamByName('PDATA_PROTOCOLO').AsDateTime           := titulo.FdataProtocolo;
    qryUpdate.ParamByName('PDATA_EMISSAO').AsDateTime             := titulo.FdataEmissao;

    qryUpdate.ParamByName('PVALOR_NOMINAL').AsCurrency            := titulo.FvalorNominal;
    qryUpdate.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := titulo.FvalorAntecipado;

    qryUpdate.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar alterar TITULO');

end;

 Result := System.True;
end;

class function TTituloPagarDAO.getTP(query: TFDQuery): TTituloPagarModel;
var
tituloPagar: TTituloPagarModel;
begin
     tituloPagar                         := TTituloPagarModel.Create;

  if not query.IsEmpty then begin

      tituloPagar.FID                     := query.FieldByName('ID_TITULO_PAGAR').AsString;
      tituloPagar.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tituloPagar.FIDusuario              := query.FieldByName('ID_USUARIO').AsString;
      tituloPagar.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      tituloPagar.FIDloteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      tituloPagar.FIDHistorico            := query.FieldByName('ID_HISTORICO').AsString;
      tituloPagar.FIDCedente              := query.FieldByName('ID_CEDENTE').AsString;
      tituloPagar.FIDLoteTPB              := query.FieldByName('ID_LOTE_TPB').AsString;
      tituloPagar.FIDTipoCobranca         := query.FieldByName('ID_TIPO_COBRANCA').AsString;
      tituloPagar.FIDLocalPagamento       := query.FieldByName('ID_LOCAL_PAGAMENTO').AsString;
      tituloPagar.FIDTipoStatus           := query.FieldByName('ID_TIPO_STATUS').AsString;
      tituloPagar.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tituloPagar.FIDNotaFiscalEntrada    := query.FieldByName('ID_NOTA_FISCAL_ENTRADA').AsString;
      tituloPagar.FIDTituloPagarAnterior  := query.FieldByName('ID_TITULO_GERADOR').AsString;
      tituloPagar.FIDLotePagamento        := query.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      tituloPagar.FIDContaContabilDebito  := query.FieldByName('ID_CONTA_CONTABIL_DEBITO').AsString;
      tituloPagar.FIDContaContabilCredito := query.FieldByName('ID_CONTA_CONTABIL_CREDITO').AsString;
      tituloPagar.FIDCBChequeVinculado    := query.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
      tituloPagar.Fdescricao              := query.FieldByName('DESCRICAO').AsString;
      tituloPagar.Fobservacao             := query.FieldByName('OBSERVACAO').AsString;
      tituloPagar.Fparcela                := query.FieldByName('PARCELA').AsString;
      tituloPagar.Fcontrato               := query.FieldByName('CONTRATO').AsString;
      tituloPagar.FcodigoBarras           := query.FieldByName('CODIGO_BARRAS').AsString;
      tituloPagar.Fcarteira               := query.FieldByName('CARTEIRA').AsString;
      tituloPagar.Fmoeda                  := query.FieldByName('MOEDA').AsString;
      tituloPagar.FregistroProvisao       := query.FieldByName('REGISTRO_PROVISAO').AsString;
      tituloPagar.FnumeroDocumento        := query.FieldByName('NUMERO_DOCUMENTO').AsString;

      tituloPagar.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      tituloPagar.FdataUltimaAtualizacao  := query.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;
      tituloPagar.FprevisaoCartorio       := query.FieldByName('PREVISAO_CARTORIO').AsDateTime;
      tituloPagar.FdataPagamento          := query.FieldByName('DATA_PAGAMENTO').AsDateTime;
      tituloPagar.FdataVencimento         := query.FieldByName('DATA_VENCIMENTO').AsDateTime;
      tituloPagar.FdataProtocolo          := query.FieldByName('DATA_PROTOCOLO').AsDateTime;
      tituloPagar.FdataEmissao            := query.FieldByName('DATA_EMISSAO').AsDateTime;

      tituloPagar.FvalorNominal           := query.FieldByName('VALOR_NOMINAL').AsCurrency;
      tituloPagar.FvalorAntecipado        := query.FieldByName('VALOR_ANTECIPADO').AsCurrency;


  end;


  Result := tituloPagar;

end;




end.
