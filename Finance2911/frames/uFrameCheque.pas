unit uFrameCheque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uCheque,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TframeCheque = class(TFrame)
    cbbCheque: TComboBox;
    lbl1: TLabel;
    qryObterTodos: TFDQuery;
    qryChequePorID: TFDQuery;
    qryChequePorNumero: TFDQuery;
  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdCheques : TStringList;
  public
    { Public declarations }
    function obterTodosPorStatus(pIdContaBancaria, pStatus: string; var combo: TComboBox;   var listaID: TStringList): boolean;
    function obterChequePorID (pIdContaBancaria, pIdCheque : string): TChequeModel;
    function obterChequePorNumero (pIdContaBancaria, pNUmeroCheque : string): TChequeModel;

  end;

implementation

{$R *.dfm}

function TframeCheque.obterChequePorID(pIdContaBancaria,  pIdCheque: string): TChequeModel;
var
cheque : TChequeModel;

begin
   cheque :=TChequeModel.Create;
   idOrganizacao := TOrgAtual.getId;
   dmConexao.conectarBanco;

   try

    qryChequePorID.Close;
    qryChequePorID.Connection := dmConexao.conn;
    qryChequePorID.ParamByName('PIDCONTA').AsString := pIdContaBancaria;
    qryChequePorID.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryChequePorID.ParamByName('PIDCHEQUE').AsString := pIdCheque;

    qryChequePorID.Open;

     if not  qryChequePorID.IsEmpty then begin
      cheque.SetIdCheque(qryChequePorID.FieldByName('id_conta_bancaria_cheque').AsString);
      cheque.SetIdOrganizacao(qryChequePorID.FieldByName('id_organizacao').AsString);
      cheque.SetIdContaBancaria(qryChequePorID.FieldByName('id_conta_bancaria').AsString);
      cheque.SetIdFuncionario(qryChequePorID.FieldByName('id_funcionario').AsString);
      cheque.SetIdTipoStatus(qryChequePorID.FieldByName('id_tipo_status').AsString);
      cheque.SetNumeroCheque(qryChequePorID.FieldByName('numero_cheque').AsString);
      cheque.SetObservacao(qryChequePorID.FieldByName('observacao').AsString);

      cheque.SetPortador(qryChequePorID.FieldByName('portador').AsString);
      cheque.SetIdUsuario(qryChequePorID.FieldByName('id_usuario').AsString);
      cheque.SetDataCompensacao(qryChequePorID.FieldByName('data_previsao_compensacao').AsDateTime);
      cheque.SetDataEstorno(qryChequePorID.FieldByName('data_estorno').AsDateTime);
      cheque.SetDataRegistro(qryChequePorID.FieldByName('data_registro').AsDateTime);
      cheque.SetDataEmissao(qryChequePorID.FieldByName('data_emissao').AsDateTime);
      cheque.SetDataCompensacao(qryChequePorID.FieldByName('data_compensacao').AsDateTime);
      cheque.SetValor(qryChequePorID.FieldByName('valor').AsCurrency);
      cheque.SetQtdImpressao(qryChequePorID.FieldByName('qtd_impressao').AsInteger);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por ID');

   end;

   Result := cheque;
end;

function TframeCheque.obterChequePorNumero(pIdContaBancaria, pNUmeroCheque: string): TChequeModel;
var
cheque : TChequeModel;

begin
   cheque :=TChequeModel.Create;
   idOrganizacao := TOrgAtual.getId;
   dmConexao.conectarBanco;

   try

    qryChequePorNumero.Close;
    qryChequePorNumero.Connection := dmConexao.conn;
    qryChequePorNumero.ParamByName('PIDCONTA').AsString := pIdContaBancaria;
    qryChequePorNumero.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryChequePorNumero.ParamByName('CHEQUE').AsString := pNUmeroCheque;

    qryChequePorNumero.Open;

     if not  qryChequePorNumero.IsEmpty then begin
      cheque.SetIdCheque(qryChequePorNumero.FieldByName('id_conta_bancaria_cheque').AsString);
      cheque.SetIdOrganizacao(qryChequePorNumero.FieldByName('id_organizacao').AsString);
      cheque.SetIdContaBancaria(qryChequePorNumero.FieldByName('id_conta_bancaria').AsString);
      cheque.SetIdFuncionario(qryChequePorNumero.FieldByName('id_funcionario').AsString);
      cheque.SetIdTipoStatus(qryChequePorNumero.FieldByName('id_tipo_status').AsString);
      cheque.SetNumeroCheque(qryChequePorNumero.FieldByName('numero_cheque').AsString);
      cheque.SetObservacao(qryChequePorNumero.FieldByName('observacao').AsString);

      cheque.SetPortador(qryChequePorNumero.FieldByName('portador').AsString);
      cheque.SetIdUsuario(qryChequePorNumero.FieldByName('id_usuario').AsString);
      cheque.SetDataCompensacao(qryChequePorNumero.FieldByName('data_previsao_compensacao').AsDateTime);
      cheque.SetDataEstorno(qryChequePorNumero.FieldByName('data_estorno').AsDateTime);
      cheque.SetDataRegistro(qryChequePorNumero.FieldByName('data_registro').AsDateTime);
      cheque.SetDataEmissao(qryChequePorNumero.FieldByName('data_emissao').AsDateTime);
      cheque.SetDataCompensacao(qryChequePorNumero.FieldByName('data_compensacao').AsDateTime);
      cheque.SetValor(qryChequePorNumero.FieldByName('valor').AsCurrency);
      cheque.SetQtdImpressao(qryChequePorNumero.FieldByName('qtd_impressao').AsInteger);

     end;


   except
   raise Exception.Create('Erro ao obter cheque por ID');

   end;

   Result := cheque;
end;

function TframeCheque.obterTodosPorStatus(pIdContaBancaria,pStatus: string; var combo: TComboBox;
  var listaID: TStringList): boolean;

begin

 dmConexao.conectarBanco;
 idOrganizacao := 'imap';// TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione um Cheque  >>>');

   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.ParamByName('PIDCONTA').AsString := pIdContaBancaria;
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTodos.ParamByName('PIDSTATUS').AsString := pStatus;
   qryObterTodos.Open;
   qryObterTodos.Last;


   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('CHEQUE').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID').AsString);
          qryObterTodos.Next;
        end;

      combo.ItemIndex := 0;

   end;

   Result := not qryObterTodos.IsEmpty;

end;


end.
