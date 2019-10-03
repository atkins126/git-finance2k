unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  Vcl.Dialogs, IniFiles,uFrmRegistraBaseDados,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, uUtil,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef;

type
  TdmConexao = class(TDataModule)
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    ConnMega: TFDConnection;
    qryEstacoesConectadas: TFDQuery;
    qryObterGUID: TFDQuery;
    conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    database: string;
    databaseFinance:String;
    databaseMega: string;
    pathMega: string;
    host: string;
    porta: string;
    user: string;
    password: string;
    function conectarBanco: boolean;
    function conectarMega: boolean;
    function obterHostONLINE: boolean;
    function obterNewID():string; // retorna o id novo do banco




  end;

var
  dmConexao: TdmConexao;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmConexao.conectarBanco: boolean;
var  Arquivo: TIniFile { uses IniFiles };
begin

  if not(Conn.Connected) then
   begin
    Result := False;
      uUtil.TOrgAtual.setPathSGBD(databaseFinance);
      try

      //  databaseFinance := '192.168.15.15/3050:D:\Clientes\imap\FINANCE.FDB';

        conn.Params.Clear;
        conn.LoginPrompt := false;
        conn.DriverName := 'FB';
        conn.Params.Add('database=' + databaseFinance);
        conn.Params.Add('user_name=' + 'SYSDBA');
        conn.Params.Add('password=' + 'masterkey');//
        conn.Params.Add('blobsize=-1');
        conn.Params.Add('SQLDialect=3');
        conn.Params.Add('CharacterSet = iso8859_1');
        conn.Params.Add('PageSize=4096');
        conn.Open;


    except
      raise Exception.Create('N�o foi poss�vel conectar ao banco de dados!  ' + databaseFinance);
     // Exception.Create('O Caminho do banco de dados parece estar incorreto.');

    end;
 end;

  Result := Conn.Connected;
end;

function TdmConexao.conectarMega: boolean;
 var
 Arquivo: TIniFile ;
 databaseMega:String;
begin
Arquivo := TIniFile.Create(uUtil.GetPathConfigIni);
databaseMega :=  Arquivo.ReadString('DADOSMEGA','DATABASE', '');

  if not(ConnMega.Connected) then
   begin

    try
      begin
        ConnMega.Params.Clear;
        ConnMega.LoginPrompt := false;
        ConnMega.DriverName := 'FB';
        ConnMega.Params.Add('database=' + databaseMega);
        //ConnMega.Params.Add('drivername=' + ConnMega.DriverName);
        //ConnMega.Params.Add('hostname=' + host);
        //ConnMega.Params.Add('port=' + '3050');
        ConnMega.Params.Add('user_name=' + 'SYSDBA');
        ConnMega.Params.Add('password=' + 'masterkey');//
        ConnMega.Params.Add('blobsize=-1');
        ConnMega.Params.Add('SQLDialect=3');
        ConnMega.Params.Add('CharacterSet = iso8859_1');
        ConnMega.Params.Add('PageSize=4096');
        ConnMega.Open;
      end;
      if not ConnMega.Ping then
      begin

        raise Exception.Create('N�o foi poss�vel conectar ao Sistema Cont�bil! '   + databaseMega);
      end;
    except
      raise Exception.Create('Erro ao tentar acessar a base do Sistema Cont�bil !');
    end;
  end;// chamar o registra base de dados aqui



   Arquivo.Free;
  Result := ConnMega.Connected;
end;


procedure TdmConexao.DataModuleCreate(Sender: TObject);
var  Arquivo: TIniFile { uses IniFiles };

begin
   //      teste := uUtil.GetPathConfigIni;
   Arquivo := TIniFile.Create(uUtil.GetPathConfigIni);

    if not uUtil.ArquivoExist(Arquivo.FileName) then
    begin
          raise Exception.Create('N�o foi poss�vel acesso ao Config!');
    end ;

   databaseFinance :=  Arquivo.ReadString('DADOSFINANCE','DATABASE', '');

   FreeAndNil(Arquivo);

   Conn.Connected :=False;
   ConnMega.Connected :=False;
end;

function TdmConexao.obterHostONLINE: boolean;
begin
 //verifica as estacoes que estao ativas no momento

  qryEstacoesConectadas.Connection := dmConexao.Conn;
  qryEstacoesConectadas.Close;
  qryEstacoesConectadas.Open;


  Result := not qryEstacoesConectadas.IsEmpty;

end;




function TdmConexao.obterNewID: string;
var id:string;
begin
//fornece um novo id.
//o banco precisa ter instalado a UDF createguid
  id := '0';

  qryObterGUID.Close;
  qryObterGUID.Connection := dmConexao.Conn;
  qryObterGUID.Open;


    if  not qryObterGUID.IsEmpty then
      begin
       id := qryObterGUID.FieldByName('NEWID').AsString;
       qryObterGUID.Free;
     end;

 Result := id;
end;



end.