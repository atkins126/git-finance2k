unit uFrameCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  udmConexao,uUtil,uContaContabilModel,uCedenteModel,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TframeCedente = class(TFrame)
    cbbcombo: TComboBox;
    procedure cbbcomboChange(Sender: TObject);
 private
    pIdOrganizacao : string;
    comboItemIndex :Integer;
    FsListaIdCedentes : TStringList;


  public
    { Public declarations }
 function getContaContabil(pIDOrganizacao, pIDCedente: string): TContaContabilModel;
 function obterTodos      (pIdOrganizacao: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function getCedente      (pIDOrganizacao, pIDCedente :string) : TCedenteModel;
 function getComboItemIndex :Integer;
 function getComboID :string;
// function preencheDBGrid(pIDOrganizacao :string; var dBGrid: TDBGrid ) :TFDQuery;
function preencheDBGrid(pIDOrganizacao :string ) :TFDQuery;




  end;

implementation

{$R *.dfm}

procedure TframeCedente.cbbcomboChange(Sender: TObject);
begin
 comboItemIndex := cbbcombo.ItemIndex;

end;

function TframeCedente.getCedente(pIDOrganizacao,  pIDCedente: string): TCedenteModel;
var
cedenteModel : TCedenteModel;
qryObterC : TFDQuery;
 cmdSql :string;
begin
  dmConexao.conectarBanco;
  cedenteModel   := TCedenteModel.Create;

       cmdSql := ' SELECT C.ID_CEDENTE, C.ID_ORGANIZACAO,' +
                     ' C.ID_TIPO_CEDENTE, C.ID_ENDERECO,' +
                     ' C.ID_CONTATO, C.NOME, C.CPFCNPJ,' +
                     ' C.PERSONALIDADE, C.CONTA_BANCARIA,' +
                     ' C.AGENCIA, C.ID_BANCO, C.CGA,' +
                     ' C.INSCRICAO_ESTADUAL,  C.ID_CONTA_CONTABIL,' +
                     ' C.INSCRICAO_MUNICIPAL, C.ID_CARTAO_CREDITO,' +
                     ' C.DATA_REGISTRO, C.SACADO, C.STATUS, ' +
                     ' C.DATA_ULTIMA_ATUALIZACAO, C.CODIGO' +
             ' FROM CEDENTE C ' +
             ' WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO )' +
             '   AND ( C.ID_CEDENTE     = :PIDCEDENTE ) ';

  try

        qryObterC := TFDQuery.Create(Self);
        qryObterC.Close;
        qryObterC.SQL.Clear;
        qryObterC.SQL.Add(cmdSql);
        qryObterC.Connection := dmConexao.conn;
        qryObterC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterC.ParamByName('PIDCEDENTE').AsString := pIDCedente;
        qryObterC.Open;

   if not qryObterC.IsEmpty then begin


     cedenteModel.FID                    := qryObterC.FieldByName('ID_CEDENTE').AsString;
     cedenteModel.FIDtipoCedente         := qryObterC.FieldByName('ID_TIPO_CEDENTE').AsString;
     cedenteModel.FIDorganizacao         := qryObterC.FieldByName('ID_ORGANIZACAO').AsString;
     cedenteModel.FIDendereco            := qryObterC.FieldByName('ID_ENDERECO').AsString;
     cedenteModel.FIDcontato             := qryObterC.FieldByName('ID_CONTATO').AsString;
     cedenteModel.Fnome                  := qryObterC.FieldByName('NOME').AsString;
     cedenteModel.FcpfCnpj               := qryObterC.FieldByName('CPFCNPJ').AsString;
     cedenteModel.FinscricaoEstadual     := qryObterC.FieldByName('INSCRICAO_ESTADUAL').AsString;
     cedenteModel.FinscricaoMunicipal    := qryObterC.FieldByName('INSCRICAO_MUNICIPAL').AsString;
     cedenteModel.Fcga                   := qryObterC.FieldByName('CGA').AsString;
     cedenteModel.Fpersonalidade         := qryObterC.FieldByName('PERSONALIDADE').AsString;
     cedenteModel.Fconta                 := qryObterC.FieldByName('CONTA_BANCARIA').AsString;
     cedenteModel.Fagencia               := qryObterC.FieldByName('AGENCIA').AsString;
     cedenteModel.FIDbanco               := qryObterC.FieldByName('ID_BANCO').AsString;
     cedenteModel.FIDcontaContabil       := qryObterC.FieldByName('ID_CONTA_CONTABIL').AsString;
     cedenteModel.FIDcartaoCreditoModel  := qryObterC.FieldByName('ID_CARTAO_CREDITO').AsString;
     cedenteModel.FCodigo                := qryObterC.FieldByName('CODIGO').AsString;
     cedenteModel.FStatus                := qryObterC.FieldByName('STATUS').AsString;
     cedenteModel.FDataRegistro          := qryObterC.FieldByName('DATA_REGISTRO').AsDateTime;
     cedenteModel.FDataUltimaAtualizacao := qryObterC.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;

   end;

   except

   raise Exception.Create('Erro ao tentar obter o cedente');

   end;


 Result := cedenteModel;

end;

function TframeCedente.getComboID: string;
var idCombo :string;
begin

 if cbbcombo.ItemIndex > 0 then begin

    idCombo := FsListaIdCedentes[getComboItemIndex];

 end;

 Result := idCombo;

end;

function TframeCedente.getComboItemIndex: Integer;
begin

Result := comboItemIndex;

end;

function TframeCedente.getContaContabil(pIDOrganizacao,  pIDCedente: string): TContaContabilModel;
var
contaContabilModel : TContaContabilModel;
cedenteModel : TCedenteModel;
qryObterCC : TFDQuery;
 cmdSql :string;
begin
 dmConexao.conectarBanco;
 contaContabilModel                  := TContaContabilModel.Create;

 try
   cmdSql := ' SELECT CC.ID_CONTA_CONTABIL, '+
                    ' CC.ID_ORGANIZACAO, CC.DESCRICAO, ' +
                    ' CC.CONTA, CC.CODREDUZ, CC.TIPO,' +
                    ' CC.GRAU, CC.DATA_REGISTRO' +
             ' FROM CONTA_CONTABIL CC ' +
             ' WHERE ( CC.ID_ORGANIZACAO  = :PIDORGANIZACAO )' +
             ' AND (CC.ID_CONTA_CONTABIL = :PIDCONTA ) ';


    cedenteModel := TCedenteModel.Create;
    cedenteModel := getCedente(pIdOrganizacao, pIDCedente);
    contaContabilModel.SetFIdContaContabil(cedenteModel.FIDcontaContabil);

   if not uUtil.Empty (cedenteModel.FIDcontaContabil) then begin

    qryObterCC := TFDQuery.Create(Self);
    qryObterCC.Close;
    qryObterCC.SQL.Clear;
    qryObterCC.SQL.Add(cmdSql);
    qryObterCC.Connection := dmConexao.conn;
    qryObterCC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterCC.ParamByName('PIDCONTA').AsString := cedenteModel.FIDcontaContabil;
    qryObterCC.Open;


    contaContabilModel.FDescricao       := qryObterCC.FieldByName('DESCRICAO').AsString;
    contaContabilModel.FCodigoReduzido  := qryObterCC.FieldByName('CODREDUZ').AsString;
    contaContabilModel.FConta           := qryObterCC.FieldByName('CONTA').AsString;
    contaContabilModel.FIdContaContabil := qryObterCC.FieldByName('ID_CONTA_CONTABIL').AsString;

   end;


 except
 raise Exception.Create('Erro ao obter conta cont�bil');

 end;

Result := contaContabilModel;

end;



function TframeCedente.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
 qryObterTodos : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

 cmdSql := 'SELECT C.ID_CEDENTE, C.NOME FROM CEDENTE C WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) ORDER BY C.NOME' ;

  FsListaIdCedentes := TStringList.Create;
  FsListaIdCedentes.Clear;
  FsListaIdCedentes.Add('Sem ID');


  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');

  combo.Clear;
  combo.Items.Add('<<< Selecione um Cedente  >>>');

  qryObterTodos := TFDQuery.Create(Self);
  qryObterTodos.Close;
  qryObterTodos.SQL.Clear;
  qryObterTodos.SQL.Add(cmdSql);
  qryObterTodos.Connection := dmConexao.conn;
  qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterTodos.Open;
  qryObterTodos.Last;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('NOME').AsString);
         // listaID.Add(qryObterTodos.FieldByName('ID_CEDENTE').AsString);
          FsListaIdCedentes.Add(qryObterTodos.FieldByName('ID_CEDENTE').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      listaID := FsListaIdCedentes;
      combo.ItemIndex := 0;

   end;

end;

function TframeCedente.preencheDBGrid(pIDOrganizacao: string): TFDQuery;
var
 qryPreencheGrid : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := ' SELECT C.ID_CEDENTE, C.ID_ORGANIZACAO,' +
                     ' C.ID_TIPO_CEDENTE, C.ID_ENDERECO,' +
                     ' C.ID_CONTATO, C.NOME, C.CPFCNPJ,' +
                     ' C.PERSONALIDADE, C.CONTA_BANCARIA,' +
                     ' C.AGENCIA, C.ID_BANCO, C.CGA,' +
                     ' C.INSCRICAO_ESTADUAL,  C.ID_CONTA_CONTABIL,' +
                     ' C.INSCRICAO_MUNICIPAL, C.ID_CARTAO_CREDITO,' +
                     ' C.DATA_REGISTRO, C.SACADO, C.STATUS, ' +
                     ' C.DATA_ULTIMA_ATUALIZACAO, C.CODIGO' +
             ' FROM CEDENTE C ' +
             ' WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO )' ;
  try

        qryPreencheGrid := TFDQuery.Create(Self);
        qryPreencheGrid.Close;
        qryPreencheGrid.SQL.Clear;
        qryPreencheGrid.SQL.Add(cmdSql);
        qryPreencheGrid.Connection := dmConexao.conn;
        qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryPreencheGrid.Open;
   except

   raise Exception.Create('Erro preencher grid');

  end;

 Result := qryPreencheGrid;

end;

end.

