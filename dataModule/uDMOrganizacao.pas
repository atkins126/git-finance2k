unit uDMOrganizacao;

interface

uses
  System.SysUtils, System.Variants, System.Classes,uUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, udmConexao,
  FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdmOrganizacao = class(TDataModule)
    qryDadosEmpresa: TFDQuery;
    qryLoadOrgs: TFDQuery;
    qryOrganizacoes: TFDQuery;
    qryValidaLogin: TFDQuery;
    dtsOrganizacao: TDataSource;
    qryPreencheCombo: TFDQuery;
    qryDataServer: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function carregarOrganizacoes: Boolean;
    function carregarDadosEmpresa(pIdOrganizacao: string): Boolean;
    function obterListaOrganizacoes: TStringList;
    function preencheCombo(): Boolean;
    function obterCNPJOrganizacao():String;
    function obterDataServidor(): TDateTime;

  end;

var
  dmOrganizacao: TdmOrganizacao;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmOrganizacao.carregarDadosEmpresa(pIdOrganizacao: string): Boolean;
begin

  inicializarDM(Self);

  if not(qryDadosEmpresa.Connection.Connected) then
  begin
    qryDadosEmpresa.Connection := dmConexao.Conn;
  end;

  qryDadosEmpresa.Close;
  qryDadosEmpresa.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  // qryDadosEmpresa.Par
  qryDadosEmpresa.Open;
  Result := not qryDadosEmpresa.IsEmpty;
end;

function TdmOrganizacao.carregarOrganizacoes: Boolean;
begin
   inicializarDM(Self);
  if not(qryOrganizacoes.Connection.Connected) then
  begin
    qryOrganizacoes.Connection := dmConexao.Conn;
  end;

  qryOrganizacoes.Close;
  qryOrganizacoes.Open;


  Result := not qryOrganizacoes.IsEmpty;
end;

procedure TdmOrganizacao.freeAndNilDM(Sender: TObject);
begin
  if Assigned(dmConexao) then
  begin
    FreeAndNil(dmConexao);
  end;
end;

procedure TdmOrganizacao.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmConexao)) then
   begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
   end;



end;

function TdmOrganizacao.obterCNPJOrganizacao: String;
begin
  Result := qryOrganizacoes.FieldByName('CNPJ').AsString ;
end;

function TdmOrganizacao.obterDataServidor: TDateTime;
var
data : TDateTime;
begin
if not qryDataServer.Connection.Connected then
  begin
    qryDataServer.Connection := dmConexao.Conn;
  end;

  qryDataServer.Open;

  data := qryDataServer.Fields[0].AsVariant;

  uUtil.setDataServer(data); //seta a data atual no sistema

  Result := data;

end;

function TdmOrganizacao.obterListaOrganizacoes: TStringList;
var
  listaIdOrganizacoes: TStringList;
begin
  inicializarDM(Self);
  listaIdOrganizacoes := TStringList.Create;
  listaIdOrganizacoes.Clear;
  qryOrganizacoes.First;
  while not qryOrganizacoes.Eof do
  begin
    listaIdOrganizacoes.Add(qryOrganizacoes.FieldByName('NOME')
      .AsString);
    listaIdOrganizacoes.Add(qryOrganizacoes.FieldByName
      ('ID_ORGANIZACAO').AsString);
    qryOrganizacoes.Next;
  end;
  qryOrganizacoes.Close;

  Result := listaIdOrganizacoes;

end;


function TdmOrganizacao.preencheCombo(): Boolean;
var
cmd : String;
begin
inicializarDM(Self);
  Result := false;
  cmd :=' SELECT O.razao_social, '+
        ' O.id_organizacao       '+
        ' FROM ORGANIZACAO O     '+
        ' WHERE 1=1 '+
        ' ORDER BY  O.data_atualizacao desc ;';


  if dmConexao.conectarBanco then
  begin

    qryPreencheCombo.Close;
    if not qryPreencheCombo.Connection.Connected then
    begin
      qryPreencheCombo.Connection := dmConexao.Conn;
    end;
    //qryPreencheCombo.SQL.Clear;
    //qryPreencheCombo.SQL.Add(cmd);
    qryPreencheCombo.Open;

    Result := not qryPreencheCombo.IsEmpty;
  end;
end;


end.
