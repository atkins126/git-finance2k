unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,Vcl.Dialogs,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,uUtil,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    Conn: TFDConnection;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    ConnMega: TFDConnection;
  private
    { Private declarations }
    procedure loadParamentrosSGBD;
  public
    { Public declarations }
    database: string;
    databaseMega: string;
    pathMega:string;
    host: string;
    porta: string;
    user: string;
    password: string;
    function  conectarBanco: boolean;
    function  conectarMega: boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//responsavel por pegar os dados para conectar o banco de dados
//esses dados estao registrados pela tela de Backup



procedure TdmConexao.loadParamentrosSGBD;
 begin
    database := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
    host     := LerRegistro('Pempec Enterprise', 'Finance', 'IPSERVERBD');
    porta    := LerRegistro('Pempec Enterprise', 'Finance', 'PORTABD');
    dataBaseMega := LerRegistro('Pempec Enterprise', 'Mega', 'PATH_BD');
    pathMega := LerRegistro('Pempec Enterprise', 'Mega', 'PATH_MEGA');
    user     := 'SYSDBA';
    password := 'masterkey';
end;



function TdmConexao.conectarBanco: boolean;

begin
{Verificando se o banco esta conectado}
  if not(conn.Connected) then begin
       loadParamentrosSGBD;  //carrega os dados para conectar o banco de dados

    try

    //path_server = caminho completo da base de dados

      if uUtil.PastaExist(LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER')) then begin
        if uUtil.ArquivoExist(database) then  begin
          Conn.Params.Clear;
          Conn.LoginPrompt := False;
          Conn.DriverName := 'FB';
          Conn.Params.Add('database=' + database);
          Conn.Params.Add('drivername=' + Conn.DriverName);
          Conn.Params.Add('hostname=' + host);
          Conn.Params.Add('user_name=' + user);
          Conn.Params.Add('password=' + password);
          Conn.Params.Add('port=' + porta);
          Conn.Params.Add('blobsize=-1');
          Conn.Params.Add('SQLDialect=3');
          Conn.Params.Add('CharacterSet = iso8859_1');
          Conn.Params.Add('PageSize=4096');
          Conn.Open;
        end;

        if not Conn.Ping then  begin
          raise Exception.Create('N�o foi poss�vel conectar ao banco de dados!');
        end;
      end  else  begin
        raise Exception.Create('O Caminho do banco de dados parece estar incorreto.');
      end;
    except
      raise Exception.Create('ERRO DE REGISTRO. REGISTRE OS SISTEMAS!');
    end;
  end;
    Result := conn.Connected;
end;




function TdmConexao.conectarMega: boolean;

begin
{Verificando se o banco esta conectado}

//dataBaseMega := LerRegistro('Pempec Enterprise', 'Mega', 'PATH_BD');
  //  pathMega := LerRegistro('Pempec Enterprise', 'Mega', 'PATH_MEGA');


  if not(ConnMega.Connected) then begin
       loadParamentrosSGBD;  //carrega os dados para conectar o banco de dados

    try

      if uUtil.PastaExist(pathMega) then begin
        if uUtil.ArquivoExist(databaseMega) then  begin
          ConnMega.Params.Clear;
          ConnMega.LoginPrompt := False;
          ConnMega.DriverName := 'FB';
          ConnMega.Params.Add('database=' + dataBaseMega);
          ConnMega.Params.Add('drivername=' + ConnMega.DriverName);
          ConnMega.Params.Add('hostname=' + host);
          ConnMega.Params.Add('user_name=' + user);
          ConnMega.Params.Add('password=' + password);
          ConnMega.Params.Add('port=' + porta);
          ConnMega.Params.Add('blobsize=-1');
          ConnMega.Params.Add('SQLDialect=3');
          ConnMega.Params.Add('CharacterSet = iso8859_1');
          ConnMega.Params.Add('PageSize=4096');
          ConnMega.Open;
        end;

        if not ConnMega.Ping then  begin
          raise Exception.Create('N�o foi poss�vel conectar ao Mega Cont�bil!');
        end;
      end  else  begin
        raise Exception.Create('O Caminho da Base Mega parece estar incorreto.');
      end;
    except
      raise Exception.Create('ERRO DE REGISTRO. REGISTRE OS SISTEMAS!');
    end;
  end;
    Result := ConnMega.Connected;
end;

end.
