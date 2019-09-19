unit uFrmServidorEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, uUtil,
  uDMServerMail, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmServidorEmail = class(TForm)
    lblPrincipal: TLabel;
    btnSalvar: TBitBtn;
    edtHost: TEdit;
    edtConta: TEdit;
    edtPorta: TEdit;
    edtSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chAutentica: TCheckBox;
    lblDados: TLabel;
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }
  end;

var
  frmServidorEmail: TfrmServidorEmail;

implementation

{$R *.dfm}
{ tabela

  CREATE TABLE SERVIDOR_EMAIL (
  ID_SERVIDOR_EMAIL    NUMERIC(5,0) NOT NULL,
  HOST                 VARCHAR(50) NOT NULL,
  REQUER_AUTENTICACAO  INTEGER,
  REMETENTE            VARCHAR(50) NOT NULL,
  LOGIN                VARCHAR(50),
  SENHA                VARCHAR(50)
  );
}

procedure TfrmServidorEmail.btnSalvarClick(Sender: TObject);
begin
  // host
  // pega dados da tabela Servidor_Email

  if chAutentica.Checked then
  begin
    GravarRegistros('Pempec Enterprise', 'Host', 'autentica', '1');
  end
  else
  begin
    GravarRegistros('Pempec Enterprise', 'Host', 'autentica', '0');
  end;

  GravarRegistros('Pempec Enterprise', 'Host', 'conta', edtConta.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'host', edtHost.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'porta', edtPorta.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'senha', edtSenha.Text);
  GravarRegistros('Pempec Enterprise', 'Host', 'destinoUm',
    'ranansousa@gmail.com');

  ShowMessage('Dados gravados com sucesso.');


end;

procedure TfrmServidorEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  freeAndNilDM(Self);
  Action := caFree; // sempre como ultimo comando

end;

procedure TfrmServidorEmail.FormCreate(Sender: TObject);
var
  aut, porta: String;
  autentica: Boolean;
begin
  // LimpaTela(Self);
  lblDados.Caption := 'Banco de Dados N�o Conectado.';
  if not(Assigned(dmServerMail)) then
  begin
    dmServerMail := TdmServerMail.Create(Self);
  end;

  if dmServerMail.verificaConectarBanco then
  begin

    lblDados.Caption := 'Banco de Dados conectado.';
    { porta :=dmServerMail.qryObterDadosMail.FieldByName('PORTA').AsString;
      aut   :=dmServerMail.qryObterDadosMail.FieldByName('REQUER_AUTENTICACAO').AsString; }

    porta := '587';
    aut := LerRegistro('Pempec Enterprise', 'Host', 'autentica');

    dmServerMail.obterDadosServidorEmail(TOrgAtual.getId);

    edtHost.Text := dmServerMail.qryObterDadosMail.FieldByName('HOST').AsString;
    edtConta.Text := dmServerMail.qryObterDadosMail.FieldByName
      ('LOGIN').AsString;
    edtSenha.Text := dmServerMail.qryObterDadosMail.FieldByName
      ('SENHA').AsString;
    if not(LerRegistro('Pempec Enterprise', 'Host', 'porta') = '') then
    begin
      edtPorta.Text := LerRegistro('Pempec Enterprise', 'Host', 'porta');
    end
    else
    begin
      if not(porta = '') then
      begin
        GravarRegistros('Pempec Enterprise', 'Host', 'porta', porta);
      end;
    end;
    if not(aut = '') then
    begin
      aut := '1';
      chAutentica.Checked := True;;
    end;

  end;

end;

procedure TfrmServidorEmail.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmServerMail)) then
  begin
    dmServerMail := TdmServerMail.Create(Self);
  end;

end;

procedure TfrmServidorEmail.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmServerMail)) then
  begin
    FreeAndNil(dmServerMail);
  end;

end;

end.
