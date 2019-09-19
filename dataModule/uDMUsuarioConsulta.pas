unit uDMUsuarioConsulta;

interface

uses
  System.SysUtils, uMD5, System.Classes, FireDAC.Stan.Intf, uUtil, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmUsuarioConsulta = class(TDataModule)
    qryPreencheCombo: TFDQuery;
    qryObterUsuarioPorID: TFDQuery;
    dtsPreencheGrid: TDataSource;
    dtsUsuarioPorID: TDataSource;
    qryUsuarios: TFDQuery;
    qryValidarUsuario: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function preencheCombo(): Boolean;
    function carregarUsuarios: Boolean;
    function obterListaUsuarios: TStringList;
    function obterUsuarioPorID(idUsuario: Integer): Boolean;

    function validarLogin(idUsuario: Integer; login, senha: string): Boolean;
  end;

var
  dmUsuarioConsulta: TdmUsuarioConsulta;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmUsuarioConsulta }

function TdmUsuarioConsulta.carregarUsuarios: Boolean;
begin
  if not (qryUsuarios.Connection.Connected) then
  begin
    qryUsuarios.Connection := dmConexao.Conn;
  end;

  qryUsuarios.Close;
  qryUsuarios.Open;

  Result := not qryUsuarios.IsEmpty;
end;

procedure TdmUsuarioConsulta.freeAndNilDM(Sender: TObject);
begin
  if (Assigned(dmConexao)) then
  begin
    FreeAndNil(dmConexao);
  end;
end;

procedure TdmUsuarioConsulta.inicializarDM(Sender: TObject);
begin
  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

end;

function TdmUsuarioConsulta.obterListaUsuarios: TStringList;
begin
         //ver como
end;

function TdmUsuarioConsulta.obterUsuarioPorID(idUsuario: Integer): Boolean;
begin
  try
    if (idUsuario > 0) then
    begin

      inicializarDM(Self);
      if not qryObterUsuarioPorID.Connection.Connected then
      begin
        qryObterUsuarioPorID.Connection := dmConexao.Conn;
      end;

      qryObterUsuarioPorID.Close;
      qryObterUsuarioPorID.ParamByName('pIdUsuario').AsInteger := idUsuario;
      qryObterUsuarioPorID.Open;

      //lanca os dados na       uUtil.TUserAtual

      if not qryObterUsuarioPorID.IsEmpty then
      begin

        uUtil.TUserAtual.setId(qryObterUsuarioPorID.FieldByName('id_usuario').AsString);
        uUtil.TUserAtual.setLogin(qryObterUsuarioPorID.FieldByName('login').AsString);
        uUtil.TUserAtual.setNameUser(qryObterUsuarioPorID.FieldByName('nome').AsString);

      end;

    end;

  except
    raise

  end;

   Result := not qryObterUsuarioPorID.IsEmpty;

end;

function TdmUsuarioConsulta.preencheCombo(): Boolean;
begin

  Result := false;
//  cmd := 'SELECT C.NOME,C.ID_CEDENTE FROM CEDENTE C ' +
//    ' WHERE ( C.ID_ORGANIZACAO = :pIdOrganizacao ) ' + ' ORDER BY C.NOME;';

  if dmConexao.conectarBanco then
  begin

    qryPreencheCombo.Close;
    if not qryPreencheCombo.Connection.Connected then
    begin
      qryPreencheCombo.Connection := dmConexao.Conn;
    end;
   // qryPreencheCombo.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryPreencheCombo.Open;

    Result := not qryPreencheCombo.IsEmpty;
  end;
end;

function TdmUsuarioConsulta.validarLogin(idUsuario: Integer; login, senha: string): Boolean;
begin
   inicializarDM(Self);

      if not qryValidarUsuario.Connection.Connected then
      begin
        qryValidarUsuario.Connection := dmConexao.Conn;
      end;

      qryValidarUsuario.Close;
      qryValidarUsuario.ParamByName('pIdUsuario').AsInteger := idUsuario;
      qryValidarUsuario.ParamByName('pLogin').AsString := login.ToLower;
      qryValidarUsuario.ParamByName('pSenha').AsString := MD5String(senha);
      qryValidarUsuario.Open;


 Result := not qryValidarUsuario.IsEmpty;;
    // Result := True;
end;

end.

