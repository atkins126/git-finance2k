unit uFrmBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Phys.FBDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Error, FireDAC.Stan.Error, FireDAC.VCLUI.Wait, FireDAC.Stan.Def,
  FireDAC.Phys.IBWrapper, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FireDAC.Phys.IBBase, FireDAC.Phys, Vcl.ExtCtrls, IdBaseComponent,uUtil,uBrowseForFolderU,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, FireDAC.Comp.UI, FireDAC.Stan.Intf,
  FireDAC.Phys.FB, VCLUnZip, VCLZip, Vcl.StdCtrls, Vcl.Buttons,uVarGlobais,
  Vcl.Samples.Spin,udmConexao, Vcl.ComCtrls, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TfrmBackup = class(TForm)
    edtOrigem: TLabeledEdit;
    edtDestino: TLabeledEdit;
    lblPrincipal: TLabel;
    btnBackup: TButton;
    btnDestino: TBitBtn;
    btnOrigem: TBitBtn;
    btnSalvar: TBitBtn;
    chkFechaApp: TCheckBox;
    chkZipar: TCheckBox;
    chkEmail: TCheckBox;
    lblEmailOff: TLabel;
    AttachmentDialog: TOpenDialog;
    VCLZip1: TVCLZip;
    dlgOrigem: TOpenDialog;
    DrvLnk: TFDPhysFBDriverLink;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Timer1: TTimer;
    FinanceBackup: TFDIBBackup;
    IdHTTP1: TIdHTTP;
    lblAviso: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    spinHora: TSpinEdit;
    spinMin: TSpinEdit;
    spinSeg: TSpinEdit;
    edtHrAgendada: TEdit;
    chkDesliga: TCheckBox;
    Label4: TLabel;
    edtHoraAtual: TEdit;
    btnAgendar: TButton;
    Label3: TLabel;
    ledAttachment: TLabeledEdit;
    btnAttachment: TBitBtn;
    btnRestore: TButton;
    Label5: TLabel;
    FDFBNBackup1: TFDFBNBackup;
    FinanceRestore: TFDFBNRestore;
    PageControl1: TPageControl;
    tbsBackup: TTabSheet;
    tbsAgenda: TTabSheet;
    tbsRestore: TTabSheet;
    edtEnderecoEmail: TLabeledEdit;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure btnBackupClick(Sender: TObject);
    procedure btnOrigemClick(Sender: TObject);
    procedure btnDestinoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Limpatela(Sender: TObject);
    procedure btnAgendarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnAttachmentClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure inicializarDM(Sender: TObject);
    procedure preencheDadosHost(Sender: TObject);

  private
    { Private declarations }
    ipReal,Versao, Anexo: String;
    nomeFileBackup, path_backup, arquivoZip, arquivoBackup, arquivoFBK, hora,
      data, Path_Bd: String;
    destinoUm, conta, senha, host, porta, autentica: String;
    FsListaIdOrganizacoes: TStringList;

  public
    { Public declarations }
  end;

var
  frmBackup: TfrmBackup;

implementation

{$R *.dfm}



procedure TfrmBackup.btnAgendarClick(Sender: TObject);
var
  hora, minuto: Integer;
begin
  hora := StrToInt(spinHora.Text);
  minuto := StrToInt(spinMin.Text);

  edtHrAgendada.Text := FormatDateTime('hh:MM:ss',
    EncodeTime(hora, minuto, 0, 0));

    GravarRegistros('Pempec Enterprise', 'Finance', 'AgendaBackup',
      edtHrAgendada.Text);

end;

procedure TfrmBackup.btnAttachmentClick(Sender: TObject);
begin
  Label3.Visible := True;
  lblAviso.Visible := False;
  lblAviso.Caption := 'Pesquisando arquivo...';

  if AttachmentDialog.Execute then
  begin
    ledAttachment.Text := AttachmentDialog.FileName;
    Anexo := ledAttachment.Text;
  end;
  if Anexo <> '' then
  begin
    btnRestore.Enabled := True;
    btnBackup.Enabled := False;
  end;
end;

procedure TfrmBackup.btnBackupClick(Sender: TObject);
 var
  arqLastSize,arquivoSize,aux, I: Integer;
  lastSize,host, arq, msg, cap: String;
begin
// verifica se foi marcado para envio de email e se os dados para envio foram preenchidos.
  if chkEmail.Checked then
  begin
    if not(uVarGlobais.rHost.isEnable) then
    begin
      chkEmail.Checked := False;
      chkEmail.Enabled := False;
      lblEmailOff.Visible := True;
    end;

    //ERRO pq da tela n ter os dados. talvez pegar do registro
    destinoUm := LerRegistro('Pempec Enterprise', 'Host','destinoUm');
    destinoUm := edtEnderecoEmail.Text;

  end;
  Label1.Caption := 'Pempec Enterprise Backup ';
  lblAviso.Caption := ' ATEN��O:  ';

  if not DirectoryExists(edtDestino.Text) then
  begin
    lblAviso.Caption := 'PASTA DESTINO N�O EXISTE...';

    if MessageDlg(PChar(' Deseja criar a pasta ' +
      uUtil.GetUserFromWindows + '?'),  mtWarning, mbOKCancel, 0) = mrOk then
//
    begin;
      if CreateDir(edtDestino.Text) then
      begin
        lblAviso.Caption := 'PASTA CRIADA...';
        btnSalvar.Click;
        btnBackup.Click; // repete a operacao
      end;
    end
    else
    begin
      ShowMessage
        ('A aplica��o ser� encerrada. Obrigado por utilizar nossos servi�os...');
      Application.Terminate;
      Close;
      Application.ProcessMessages;
    end;
  end
  else
  begin

    cap := Label1.Caption;
    btnBackup.Visible := False;
    Label1.Caption := '          OPERA��O INICIADA';
    Application.ProcessMessages;

    try
      arquivoFBK := 'FIN_' + nomeFileBackup.ToUpper + data + hora;
      arquivoZip := edtDestino.Text + arquivoFBK + '.ZIP';
      arquivoBackup := edtDestino.Text + arquivoFBK + '.FBK';
      Path_Bd := edtOrigem.Text;
      FinanceBackup.DriverLink := DrvLnk;
      FinanceBackup.UserName := 'SYSDBA';
      FinanceBackup.Password := 'masterkey';
      if not host.IsEmpty then
      begin
        FinanceBackup.host := LerRegistro('Pempec Enterprise', 'Finance',
          'IPSERVERBD'); // configurar na aba
      end
      else
      begin
        FinanceBackup.host := '127.0.0.1';
      end;

      FinanceBackup.Protocol := ipTCPIP;
      FinanceBackup.Database := Path_Bd;
      GravarRegistros('Pempec Enterprise', 'Finance','PATH_BD',Path_Bd); //setando no registro para usar no restore
      FinanceBackup.BackupFiles.Clear; //cld 0807
      FinanceBackup.BackupFiles.Add(arquivoBackup);
      Application.ProcessMessages;
      FinanceBackup.Backup;


      //dados do FBK
     //arqLastSize :=0;

      //problema. Quando nao existe o registro d� erro aqui
        arqLastSize := 0;
        lastSize :=LerRegistro('Pempec Enterprise', 'Finance','LastFile');

        if  not (lastSize = String.Empty ) then begin
           arqLastSize := StrToInt(lastSize);
        end;

     arquivoSize := getFileSize(arquivoBackup);
     //registrando o tamanho do ultimo arquivo de backup

     GravarRegistros('Pempec Enterprise', 'Finance','LastFile',IntToStr(arquivoSize));
     GravarRegistros('Pempec Enterprise', 'Finance','LastFileDate',DateTimeToStr(Now));
     arquivoBackup.ToUpper;
      sleep(10);
      lblAviso.Visible := True;
      lblAviso.Caption := 'Opera��o Conclu�da com sucesso...' +' Tamanho do arquivo : ' + IntToStr(arquivoSize) ;
      sleep(10);
      Label1.Caption := cap;
      btnBackup.Visible := True;
      btnBackup.Enabled := True;
      sleep(10);
      Label1.Caption := cap;

      arq := GeraNameFileJPG();
      CapturaTelaForm(Self, arq);

      if uVarGlobais.rHost.isEnable then
      // verifrica se o sistema pode enviar email
      begin
        msg := 'BCKP SUCESS' + sLineBreak + 'FILE :   ' + arquivoBackup + #13 +
          DateTimeToStr(Now) + #13 + 'IP > ' + ipReal ;
      //  EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
        //  destinoUm, '', arq);

        Application.ProcessMessages;
      end;

      if chkZipar.Checked then
      begin
        With VCLZip1 do
        begin

          lblAviso.Caption :=
            'Pempec Enterprise Backup  -  Compactando arquivo(s). Aguarde...';
          sleep(20);
          Label1.Caption := ' Arquivo Compactado : ' + arquivoZip;
          Application.ProcessMessages;
          sleep(50);
          Label1.Caption := cap;

          ZipName := arquivoZip;
          FilesList.Add(arquivoBackup);
          Recurse := True; // * Recurse directories */
          StorePaths := True; // * Keep path information */
          PackLevel := 9; // * Highest level of compression */
          Zip;
          // * Return value of Zip is the actual number of files zipped */
          sleep(20);
          lblAviso.Caption :=
            'Pempec Enterprise Backup  - Compactado com Sucesso! ';
          Application.ProcessMessages;
        end;
      end;

      if chkEmail.Checked then
      begin

        lblAviso.Caption :=
          'Pempec Enterprise Backup  -  Enviando Email. Aguarde...';
        sleep(50);
        Application.ProcessMessages;

        if chkZipar.Checked then
        begin
          if uVarGlobais.rHost.isEnable then
          begin
            msg := 'ZIP FILE ' + #13 + 'ANEXO :   ' + arquivoZip + #13 +
              DateTimeToStr(Now);;
            EnviarEmailGen(Self.GetNamePath, msg, 'Backup comprimido',
              destinoUm, '', arquivoZip);

            msg := #13 + DateTimeToStr(Now);
          end;
        //   EnviarEmailGen(Self.GetNamePath, msg, 'Email Enviado...',  destinoUm, '', '');
        end
        else
        begin
          if (
            MessageDlg(PChar('O arquivo n�o est� comprimido!' + #13 +
            #13 + #13 + 'O envio ser� muito demorado. ' + #13 + #13 + #13 + #13
            + 'Tem certeza que deseja continuar Sr(a) ' +
            uUtil.GetUserFromWindows + ' ?'),  mtWarning, mbOKCancel, 0) = mrOk
          ) then
//          if EvMsgDlg1.MsgConfirmation('O arquivo n�o est� comprimido!' + #13 +
//            #13 + #13 + 'O envio ser� muito demorado. ' + #13 + #13 + #13 + #13
//            + 'Tem certeza que deseja continuar Sr(a) ' +
//            uUtil.GetUserFromWindows + ' ?') = 6 then
          begin;
            msg := 'FBK FILE ' + #13 + 'FILE :   ' + arquivoBackup + #13 +
              DateTimeToStr(Now);
            if uVarGlobais.rHost.isEnable then
            begin
              EnviarEmailGen(Self.GetNamePath, msg, 'Backup FBK', destinoUm, '',
                arquivoBackup);
            end;

          end;
        end;

        lblAviso.Caption := 'Pempec Enterprise Backup ';
        Application.ProcessMessages;
        sleep(50);
      Label1.Caption := cap;

      end;

    except
      on E: EIBNativeException do
      begin
        MessageDlg('Erro no Backup do Banco.' + 'Opera��o  n�o conclu�da.' + #13
          + 'Possivelmente o Banco de Dados ainda est� em uso.  ' + e.Message, mtInformation,
          [mbOK], 0);
        lblAviso.Visible := True;
        lblAviso.Caption := 'Erro no Backup do Banco.' +
          'Opera��o  n�o conclu�da.' + #13 +
          'Possivelmente o Banco de Dados ainda est� em uso.';
        btnBackup.Visible := True;
        Label1.Caption := cap;
        btnBackup.Enabled := True;

        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
         // EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
           // destinoUm, '', arq);
        end;
      end;

      on E: Exception do
      begin
        MessageDlg('Um erro inesperado ocorreu.' + 'Backup n�o realizado.' + #13
          + E.Message, mtWarning, [mbOK], 0);
        msg := 'BCKP ERRO' + #13 + 'FILE :   ' + arquivoBackup + #13 + E.Message
          + #13 + DateTimeToStr(Now);
        if uVarGlobais.rHost.isEnable then
        begin
         // EnviarEmailGen(Self.GetNamePath, msg, 'Formulario Backup',
            //destinoUm, '', arq);
        end;

      end;

    end;

  end;

  if chkFechaApp.Checked then
  begin
    lblAviso.Caption :=
      'Pempec Enterprise Backup  - Opera��o conclu�da. Aguarde a tela fechar... ';
    Application.ProcessMessages;
    sleep(10000);
     Label1.Caption := cap;
//    Application.Terminate;
Self.Close;
  end;
end;


procedure TfrmBackup.btnDestinoClick(Sender: TObject);

var
  caminho: String;
begin

  caminho := BrowseForFolder(' Pastas ', 'C:\', False);
  // dlgDestino.FileName;
  edtDestino.Text := caminho + '\';
  path_backup := edtDestino.Text;

end;

procedure TfrmBackup.btnOrigemClick(Sender: TObject);
begin
if dlgOrigem.Execute then
  begin
    edtOrigem.Text := dlgOrigem.FileName;
  end;
end;

procedure TfrmBackup.btnRestoreClick(Sender: TObject);
begin
  lblAviso.Caption := '';
    lblAviso.Visible := False;
    freeAndNilDM(Self);
  try
    lblAviso.Caption := 'Opera��o iniciada...';
    FinanceRestore.DriverLink := DrvLnk;
    FinanceRestore.UserName := 'sysdba';
    FinanceRestore.Password := 'masterkey';
    FinanceRestore.host := LerRegistro('Pempec Enterprise', 'Finance',
      'IPSERVERBD');
    FinanceRestore.Protocol := ipTCPIP;

    FinanceRestore.Database := LerRegistro('Pempec Enterprise', 'Finance',
      'PATH_BD');

    FinanceRestore.BackupFiles.Clear;
    FinanceRestore.BackupFiles.Add(Anexo);

    if (MessageDlg('Esta opera��o � irrevers�vel. ' + #13 +
      ' Tem certeza que deseja continuar ?', mtConfirmation, mbYesNo, 0) = mrYes)
    then
    begin;

      FinanceRestore.Restore;
      lblAviso.Visible := True;
      lblAviso.Caption := 'Opera��o conclu�da com sucesso...';
      btnBackup.Visible := True;
      btnBackup.Enabled := True;
      btnRestore.Enabled := False;
      ledAttachment.Text := '';
      Application.ProcessMessages;
    end;

  except
    on E: EIBNativeException do
      // raise EIBNativeException.Create('Erro ao restaurar o Banco.'+#13 +'Possivelmente o  Banco de Dados ainda est� em uso.');
      MessageDlg('Erro ao restaurar o Banco.' + #13 +
        'Possivelmente o  Banco de Dados ainda est� em uso.' + #13 +
        'Ser� necess�rio parar o servi�o do Banco de Dados.', mtInformation,
        [mbOK], 0);

    on E: Exception do
      MessageDlg('Um erro inesperado ocorreu.', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmBackup.btnSalvarClick(Sender: TObject);
begin
if edtOrigem.Text <> '' then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD', edtOrigem.Text);
  end;

  if edtDestino.Text <> '' then
  begin
    GravarRegistros('Pempec Enterprise', 'Finance', 'PATH_BD_BKP',
      edtDestino.Text);
  end;
end;

procedure TfrmBackup.FormCreate(Sender: TObject);
begin
 Limpatela(Self);

  preencheDadosHost(Self);

  Versao := 'V. 2.0 - 1609';
  Path_Bd := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
  edtOrigem.Text := Path_Bd;
  hora := FormatDateTime('hhmmss', Now());
  data := FormatDateTime('ddmmyyyy', Now());
  nomeFileBackup := LerRegistro('Pempec Enterprise', 'Finance',
    'ID_ORGANIZACAO');
  if (nomeFileBackup = String.Empty) then
  begin
    nomeFileBackup := 'BKP_';
  end
  else
  begin
    nomeFileBackup := nomeFileBackup + '_';
  end;

  path_backup := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD_BKP');
  edtEnderecoEmail.Text :=LerRegistro('Pempec Enterprise', 'Host', 'destinoUm');
  // 'dados\backup\';
  edtDestino.Text := path_backup;
  Label1.Caption := 'Pempec Enterprise Backup ' + #13 + Versao;


end;




procedure TfrmBackup.Limpatela(Sender: TObject);
begin
  PageControl1.ActivePage := tbsBackup;
  lblAviso.Visible := False;
  lblAviso.Caption :=' ATEN��O:  ';
  btnBackup.Enabled := True;
  btnBackup.Visible := True;
  Label1.Caption := 'Pempec Enterprise Backup ' + sLineBreak + Versao;
//  btnRestore.Enabled := False;
  btnBackup.Enabled := True;
  btnBackup.Visible := True;
  Label1.Caption := 'Pempec Enterprise Backup ' + sLineBreak + Versao;
  //edtHrAgendada.Text := '';
 // edtHoraAtual.Text := '';
  lblEmailOff.Visible := False;
  edtHrAgendada.Text :=   LerRegistro('Pempec Enterprise', 'Finance', 'AgendaBackup');

end;


procedure TfrmBackup.Timer1Timer(Sender: TObject);
begin
  edtHoraAtual.Text := FormatDateTime('hh:MM:ss', Now);

  if edtHoraAtual.Text = edtHrAgendada.Text then
  begin
    // ShowMessage('vai comercar o back..');
    btnBackupClick(Self);
    Application.ProcessMessages;

    if chkDesliga.Checked then
    begin
      WinExec('cmd /c shutdown -s -t 61', SW_NORMAL);
      Application.ProcessMessages;
    end;

  end;
end;


procedure TfrmBackup.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmConexao)) then begin
    FreeAndNil(dmConexao);
  end;

  end;



procedure TfrmBackup.inicializarDM(Sender: TObject);
  begin

      if not(Assigned(dmConexao)) then begin
             dmConexao := TdmConexao.Create(Self);
             dmConexao.conectarBanco;
      end;

end;


procedure TfrmBackup.preencheDadosHost(Sender: TObject);
begin
  conta     := LerRegistro('Pempec Enterprise', 'Host', 'conta');
  senha     := LerRegistro('Pempec Enterprise', 'Host', 'senha');
  host      := LerRegistro('Pempec Enterprise', 'Host', 'host');
  porta     := LerRegistro('Pempec Enterprise', 'Host', 'porta');
  autentica := LerRegistro('Pempec Enterprise', 'Host', 'autentica');


  edtEnderecoEmail.Text := LerRegistro('Pempec Enterprise', 'Host', 'destinoUm');

  // inicializa as variaveis do host do email a ser enviado.
  uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);

end;




end.
