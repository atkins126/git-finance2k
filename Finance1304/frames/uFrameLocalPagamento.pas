unit uFrameLocalPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uLocalPagamentoModel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmLocalPagto = class(TFrame)
    cbbcombo: TComboBox;
  private
    { Private declarations }
    pIdOrganizacao : string;
    FsListaIdLP : TStringList;

  public
    { Public declarations }

    function obterLista(pIdOrganizacao: string): TFDQuery;
    function obterPorID(pTipo :TLocalPagamentoModel): TLocalPagamentoModel;
    function obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
    procedure limpaFrame;
  end;

implementation

{$R *.dfm}

function TfrmLocalPagto.obterLista(pIdOrganizacao: string): TFDQuery;
var
 lista :TFDQuery;
cmd :string;
begin
  dmConexao.conectarBanco;
  try
    cmd :=  ' SELECT E.ID_LOCAL_PAGAMENTO, E.ID_ORGANIZACAO,E.DESCRICAO ' +
            ' FROM LOCAL_PAGAMENTO E  ' +
            ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
            '  ORDER BY E.DESCRICAO ';

   lista := TFDQuery.Create(Self);
   lista.Close;
   lista.Connection := dmConexao.conn;
   lista.SQL.Clear;
   lista.SQL.Add(cmd);
   lista.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   lista.Open;
   lista.Last;

  except
  raise Exception.Create('Erro ao obter lista de local pagto ');

  end;

  Result := lista;

end;


function TfrmLocalPagto.obterPorID(pTipo :TLocalPagamentoModel): TLocalPagamentoModel;
var
  qryObter: TFDQuery;
  cmd: string;
  local: TLocalPagamentoModel;
begin
  local := TLocalPagamentoModel.Create;
  dmConexao.conectarBanco;
  try
    cmd := ' SELECT TC.ID_LOCAL_PAGAMENTO, TC.ID_ORGANIZACAO, TC.DESCRICAO '+
           ' FROM LOCAL_PAGAMENTO TC WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  (TC.ID_LOCAL_PAGAMENTO = :PID) ';

    qryObter := TFDQuery.Create(Self);
    qryObter.Close;
    qryObter.Connection := dmConexao.conn;
    qryObter.SQL.Clear;
    qryObter.SQL.Add(cmd);
    qryObter.ParamByName('PIDORGANIZACAO').AsString := pTipo.FIDorganizacao;
    qryObter.ParamByName('PID').AsString := pTipo.FID;
    qryObter.Open;

    if not qryObter.IsEmpty then     begin

      local.FID            := qryObter.FieldByName('ID_LOCAL_PAGAMENTO').AsString;
      local.FIDorganizacao := qryObter.FieldByName('ID_ORGANIZACAO').AsString;
      local.FDescricao     := qryObter.FieldByName('DESCRICAO').AsString;
    end;

  except
    raise Exception.Create('Erro ao obter local pagto por ID');

  end;

  Result := local;

end;

function TfrmLocalPagto.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterTodos :TFDQuery;
 cmd :string;
begin
  cmd := ' SELECT E.ID_LOCAL_PAGAMENTO, E.DESCRICAO ' +
         ' FROM   LOCAL_PAGAMENTO E  ' +
         ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
         ' ORDER BY E.DESCRICAO ';


  dmConexao.conectarBanco;
  pIdOrganizacao := uUtil.TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione um TIPO  >>>');

   qryObterTodos := TFDQuery.Create(Self);
   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmd);

   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObterTodos.Open;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('DESCRICAO').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_LOCAL_PAGAMENTO').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;

procedure TfrmLocalPagto.limpaFrame;
var
i :Integer;
begin

// limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin

         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin

     // TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;
end;

end.
