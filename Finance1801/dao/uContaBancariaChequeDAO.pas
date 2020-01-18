unit uContaBancariaChequeDAO;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uContaBancariaChequeModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
 TContaBancariaChequeDAO = class
  private

  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TContaBancariaChequeModel): Boolean;
    class function obterPorID(value :TContaBancariaChequeModel): TContaBancariaChequeModel;
    class function obterPorNumero(value :TContaBancariaChequeModel): TContaBancariaChequeModel;
   // class function obterPorStatus(value :TContaBancariaChequeModel): TContaBancariaChequeModel;  VER NO FRAME

    class function Delete(value :TContaBancariaChequeModel): Boolean;
    class function Update(value :TContaBancariaChequeModel): Boolean;
    class function gerarCheques (qtd :Integer; value :TContaBancariaChequeModel): Boolean;

  end;


implementation

{ TContaBancariaChequeDAO }

class function TContaBancariaChequeDAO.Delete(value: TContaBancariaChequeModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
chequeDeletar :TContaBancariaChequeModel;
begin
xResp := False;
 dmConexao.conectarBanco;
 try

    chequeDeletar :=TContaBancariaChequeModel.Create;
    chequeDeletar.FID              := value.FID;
    chequeDeletar.FIDorganizacao   := value.FIDorganizacao;
    chequeDeletar.FIDcontaBancaria := value.FIDcontaBancaria;
    chequeDeletar.FIDtipoStatus    := 'DESATIVADO';
    chequeDeletar.FIDusuario       := uutil.TUserAtual.getUserId;
    chequeDeletar.Fobservacao      := 'Deletado por : ' + uutil.TUserAtual.getNameUser ;


    if Update(value) then
    begin

      xResp := True;
    end;

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR CHEQUE');

 end;

  Result := xResp;
end;

class function TContaBancariaChequeDAO.gerarCheques(qtd: Integer;value: TContaBancariaChequeModel): Boolean;
var //o primeiro cheque precisa vir preenchido. o numero do cheque ser� incrementado
chequeGerado : TContaBancariaChequeModel;
existCheque, numero: Integer;
auxResp : Boolean;

begin
 auxResp :=False;
 existCheque :=1;;
 numero := StrToInt(value.FNumero);
 try

  while qtd > 0 do
  begin

    chequeGerado                  := TContaBancariaChequeModel.Create;
    chequeGerado.FIDorganizacao   := value.FIDorganizacao;
    chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
    chequeGerado.FNumero          := IntToStr(numero);
    while existCheque > 0 do
    begin
      chequeGerado.FIDorganizacao := value.FIDorganizacao;
      chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
      chequeGerado.FNumero := IntToStr(numero);

      chequeGerado := obterPorNumero(chequeGerado);

      if not uutil.Empty(chequeGerado.FID) then
      begin
        Inc(numero);
        Inc(existCheque);
        chequeGerado := TContaBancariaChequeModel.Create;
        chequeGerado.FIDorganizacao := value.FIDorganizacao;
        chequeGerado.FIDcontaBancaria := value.FIDcontaBancaria;
        chequeGerado.FNumero := IntToStr(numero);

      end
      else
      begin
        Dec(existCheque);
      end;

    end;

    chequeGerado.FID              := dmConexao.obterNewID;
    chequeGerado.FIDresponsavel   := value.FIDresponsavel;
    chequeGerado.FIDusuario       := value.FIDusuario;
    chequeGerado.FIDtipoStatus    := 'BLOQUEADO';
    chequeGerado.Fvalor           :=0;
    chequeGerado.FdataRegistro    := Now;
    chequeGerado.FqtdImpressao    := 0;

    if Insert(chequeGerado) then
    begin
     auxResp :=True;
     Dec(qtd);
     Inc(numero);
    end;

  end;

 except
 auxResp :=False;
 raise Exception.Create('Erro ao tentar gerar cheques. ');
 end;

Result := auxResp
end;

class function TContaBancariaChequeDAO.Insert(value: TContaBancariaChequeModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
//cheque inserido por funcao gerar cheques

try
     cmdSql := ' INSERT INTO CONTA_BANCARIA_CHEQUE ' +
               '(ID_CONTA_BANCARIA_CHEQUE, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ' +
               ' ID_FUNCIONARIO, ID_USUARIO, ID_TIPO_STATUS, NUMERO_CHEQUE, ' +
               ' DATA_REGISTRO, QTD_IMPRESSAO)' +
               ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTA_BANCARIA, ) '+
               ' :PIDFUNCIONARIO, :PIDUSUARIO, :PIDTIPO_STATUS, :PNUMERO_CHEQUE, '+
               ' :PDATA_REGISTRO, :PQTD_IMPRESSAO)';


    qryInsert := TFDQuery.Create(nil);
    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString               := value.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qryInsert.ParamByName('PIDCONTA_BANCARIA').AsString := value.FIDcontaBancaria;
    qryInsert.ParamByName('PIDFUNCIONARIO').AsString    := value.FIDresponsavel;
    qryInsert.ParamByName('PIDUSUARIO').AsString        := value.FIDusuario;
    qryInsert.ParamByName('PIDTIPO_STATUS').AsString    := value.FIDtipoStatus;
    qryInsert.ParamByName('PNUMERO_CHEQUE').AsString    := value.FNumero;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime  := value.FdataRegistro;
    qryInsert.ParamByName('PQTD_IMPRESSAO').AsInteger   := 0;

    qryInsert.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar alterar CHEQUE');

end;

 Result := System.True;
end;

class function TContaBancariaChequeDAO.obterPorID(value: TContaBancariaChequeModel): TContaBancariaChequeModel;
var
cheque : TContaBancariaChequeModel;
 qryPesquisa : TFDQuery;
 cmdSql : string;
begin
   cheque :=TContaBancariaChequeModel.Create;
   dmConexao.conectarBanco;

   try
    cmdSql := ' SELECT * FROM CONTA_BANCARIA_CHEQUE CBC '+
              ' WHERE (CBC.ID_ORGANIZACAO =:PIDORGANIZACAO)AND (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE) ';


    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmdSql);
//    qryChequePorID.ParamByName('PIDCONTA').AsString := value.FIDcontaBancaria;
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryPesquisa.ParamByName('PIDCHEQUE').AsString := value.FID;

    qryPesquisa.Open;

     if not  qryPesquisa.IsEmpty then begin
      cheque.FID                      := (qryPesquisa.FieldByName('id_conta_bancaria_cheque').AsString);
      cheque.FIDorganizacao           := (qryPesquisa.FieldByName('id_organizacao').AsString);
      cheque.FIDcontaBancaria         := (qryPesquisa.FieldByName('id_conta_bancaria').AsString);
      cheque.FIDresponsavel           := (qryPesquisa.FieldByName('id_funcionario').AsString);
      cheque.FIDtipoStatus            := (qryPesquisa.FieldByName('id_tipo_status').AsString);
      cheque.FNumero                  := (qryPesquisa.FieldByName('numero_cheque').AsString);
      cheque.Fobservacao              := (qryPesquisa.FieldByName('observacao').AsString);
      cheque.Fportador                := (qryPesquisa.FieldByName('portador').AsString);
      cheque.FIDusuario               := (qryPesquisa.FieldByName('id_usuario').AsString);
      cheque.FdataPrevisaoCompensacao := (qryPesquisa.FieldByName('data_previsao_compensacao').AsDateTime);
      cheque.FdataEstorno             := (qryPesquisa.FieldByName('data_estorno').AsDateTime);
      cheque.FdataRegistro            := (qryPesquisa.FieldByName('data_registro').AsDateTime);
      cheque.FdataEmissao             := (qryPesquisa.FieldByName('data_emissao').AsDateTime);
      cheque.FdataCompensacao         := (qryPesquisa.FieldByName('data_compensacao').AsDateTime);
      cheque.Fvalor                   := (qryPesquisa.FieldByName('valor').AsCurrency);
      cheque.FqtdImpressao            := (qryPesquisa.FieldByName('qtd_impressao').AsInteger);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por ID');

   end;

   Result := cheque;
end;


class function TContaBancariaChequeDAO.obterPorNumero(value: TContaBancariaChequeModel): TContaBancariaChequeModel;
var
cheque : TContaBancariaChequeModel;
 qryPesquisa : TFDQuery;
 cmdSql : string;
begin
   cheque :=TContaBancariaChequeModel.Create;
   dmConexao.conectarBanco;

   try
    cmdSql := ' SELECT * FROM CONTA_BANCARIA_CHEQUE CBC '+
              ' WHERE (CBC.ID_ORGANIZACAO   = :PIDORGANIZACAO) '+
              ' AND (CBC.ID_CONTA_BANCARIA  = :PIDCONTA) ' +
              ' AND (CBC.NUMERO_CHEQUE      = :PNUMERO) ' ;


    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmdSql);
    qryPesquisa.ParamByName('PIDCONTA').AsString := value.FIDcontaBancaria;
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryPesquisa.ParamByName('PNUMERO').AsString := value.FNumero;

    qryPesquisa.Open;

     if not  qryPesquisa.IsEmpty then begin
      cheque.FID                      := (qryPesquisa.FieldByName('id_conta_bancaria_cheque').AsString);
      cheque.FIDorganizacao           := (qryPesquisa.FieldByName('id_organizacao').AsString);
      cheque.FIDcontaBancaria         := (qryPesquisa.FieldByName('id_conta_bancaria').AsString);
      cheque.FIDresponsavel           := (qryPesquisa.FieldByName('id_funcionario').AsString);
      cheque.FIDtipoStatus            := (qryPesquisa.FieldByName('id_tipo_status').AsString);
      cheque.FNumero                  := (qryPesquisa.FieldByName('numero_cheque').AsString);
      cheque.Fobservacao              := (qryPesquisa.FieldByName('observacao').AsString);
      cheque.Fportador                := (qryPesquisa.FieldByName('portador').AsString);
      cheque.FIDusuario               := (qryPesquisa.FieldByName('id_usuario').AsString);
      cheque.FdataPrevisaoCompensacao := (qryPesquisa.FieldByName('data_previsao_compensacao').AsDateTime);
      cheque.FdataEstorno             := (qryPesquisa.FieldByName('data_estorno').AsDateTime);
      cheque.FdataRegistro            := (qryPesquisa.FieldByName('data_registro').AsDateTime);
      cheque.FdataEmissao             := (qryPesquisa.FieldByName('data_emissao').AsDateTime);
      cheque.FdataCompensacao         := (qryPesquisa.FieldByName('data_compensacao').AsDateTime);
      cheque.Fvalor                   := (qryPesquisa.FieldByName('valor').AsCurrency);
      cheque.FqtdImpressao            := (qryPesquisa.FieldByName('qtd_impressao').AsInteger);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por NUMERO');

   end;

   Result := cheque;
end;


class function TContaBancariaChequeDAO.Update(value: TContaBancariaChequeModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
try

cmdSql := ' UPDATE CONTA_BANCARIA_CHEQUE '+
          ' SET NUMERO_CHEQUE                 = :PNUMERO_CHEQUE, '+
            ' ID_USUARIO                      = :PIDUSUARIO, '+
            ' ID_FUNCIONARIO                  = :PIDRESPONSAVEL, '+
            ' ID_TIPO_STATUS                  = :PIDTIPO_STATUS,'+
            ' VALOR                           = :PVALOR,'+
            ' DATA_EMISSAO                    = :PDATA_EMISSAO, '+
            ' DATA_COMPENSACAO                = :PDATA_COMPENSACAO,'+
            ' DATA_REGISTRO                   = :PDATA_REGISTRO, '+
            ' DATA_PREVISAO_COMPENSACAO       = :PDATA_PREVISAO_COMPENSACAO,'+
            ' DATA_ESTORNO                    = :PDATA_ESTORNO,'+
            ' OBSERVACAO                      = :POBSERVACAO,'+
            ' PORTADOR                        = :PPORTADOR,'+
            ' QTD_IMPRESSAO                   = :PQTD_IMPRESSAO '+
          ' WHERE (ID_CONTA_BANCARIA_CHEQUE = :PID ) '+
          '   AND (ID_ORGANIZACAO = :PPIDORGANIZACAO ) ' ;


    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);

    qryUpdate.ParamByName('PNUMERO_CHEQUE').AsString                := value.FNumero;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString                := value.FIDorganizacao;
    qryUpdate.ParamByName('PIDUSUARIO').AsString                    := value.FIDUsuario;
    qryUpdate.ParamByName('PIDRESPONSAVEL').AsString                := value.FIDResponsavel;
    qryUpdate.ParamByName('PIDTIPO_STATUS').AsString                := value.FIDTipoStatus;

    qryUpdate.ParamByName('POBSERVACAO').AsString                   := value.Fobservacao;
    qryUpdate.ParamByName('PPORTADOR').AsString                     := value.Fportador;
    qryUpdate.ParamByName('PQTD_IMPRESSAO').AsInteger               := value.FqtdImpressao;
    qryUpdate.ParamByName('PVALOR').AsCurrency                      := value.Fvalor;

    qryUpdate.ParamByName('PDATA_EMISSAO').AsDateTime               := value.FdataEmissao;
    qryUpdate.ParamByName('PDATA_PREVISAO_COMPENSACAO').AsDateTime  := value.FdataPrevisaoCompensacao;
    qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime              := value.FdataRegistro;
    qryUpdate.ParamByName('PDATA_COMPENSACAO').AsDateTime           := value.FdataCompensacao;
    qryUpdate.ParamByName('PDATA_ESTORNO').AsDateTime               := value.FdataEstorno;

    qryUpdate.ExecSQL;    

except
Result :=False;

raise Exception.Create('Erro ao tentar alterar CHEQUE');

end;

 Result := System.True;
end;
end.
