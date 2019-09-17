unit uDMMegaContabil;

interface

uses
  System.SysUtils, System.Classes,uUtil,
  udmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmMegaContabil = class(TDataModule)
    qryDadosEmpresaMega: TFDQuery;
    qryExistLote: TFDQuery;
    qryGenIdClotes: TFDQuery;
    qryVerificaFechamento: TFDQuery;
    qryGravaLote: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  function carregarDadosEmpresaMega(pCnpj :string) : Boolean;
  function verificaSeExistLote(pIDEmpresa,pLote  :Integer; pAno :String) : Boolean;
  function verificaFechamento(pIDEmpresa :Integer; pDataInicial :String) : String;
  function lotesRestritos(pLote :Integer) : Boolean;
  function retornarIDPorTabela(pTabela :String) : Integer;
  function gravarCLote( pAno:String; pId,pEmpresa,pLote :Integer; pCre,pDeb :Currency) : Boolean;
  end;


  var
  dmMegaContabil: TdmMegaContabil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

 function TdmMegaContabil.verificaFechamento(pIDEmpresa :Integer; pDataInicial :String) : String;
 begin
 //verifica se existe na TABLE CLANCAMENTOS registro de CDHIST com valor 65/66/75/76
 //apos periodo inicial at� ano 2020.
 //SE o retorno for ID. Significa que exist CDHIST dentro do periodo e nao pode receber a importacao
    qryVerificaFechamento.Close;
    qryVerificaFechamento.Connection := dmConexao.ConnMega;
    qryVerificaFechamento.ParamByName('pIDEmpresa').AsInteger :=pIDEmpresa ;
    qryVerificaFechamento.ParamByName('pDataInicial').AsDateTime:=StrToDate(pDataInicial); //QuotedStr(FormatDateTime('dd.mm.yyyy',StrToDate(pDataInicial)));
   // qryVerificaFechamento.ParamByName('pDataFinal').AsDateTime:= StrToDate(pDataFinal);
    qryVerificaFechamento.Open;

    Result := qryVerificaFechamento.Fields[0].AsString;

 end;





 function TdmMegaContabil.lotesRestritos(pLote :Integer) : Boolean;
//verifica se um lote est� entre os lotes restritos. Retorne TRUE caso esteja.
// restritos:  9999 / 9901 at� 9912 / 901 at� 912 / 9001 at� 9012
   var
   rst : Boolean;
  begin
   rst := false;

   if (pLote  > 900 ) then begin
      rst := true;
   end;

   Result := rst;
   end;



  function TdmMegaContabil.gravarCLote(pAno:String; pId,pEmpresa,pLote :Integer; pCre,pDeb :Currency): Boolean;
  //CAMPOS: ID/
{  CREATE TABLE CLOTES (
    ID             INTEGER NOT NULL,
    EMPRESA        INTEGER NOT NULL,
    ANO            CHAR(4) NOT NULL,
    LOTE           INTEGER NOT NULL,
    TOTAL          NUMERIC(18,2),
    DEBITO         NUMERIC(18,2),
    CREDITO        NUMERIC(18,2),
    EXEC_TRIGGER   CHAR(1)
    USUARIO        VARCHAR(50),
    ESTACAO        VARCHAR(50),
    IDENTIFICACAO  VARCHAR(50), );  }

   var
   execTrigger,comando,user,station,ident :string;

   begin

   execTrigger := 'S';
   user := 'Finance';
   station := uUtil.NomeComputador;
   ident := uUtil.GetUserFromWindows;
    comando :=  'INSERT INTO CLOTES (ID, EMPRESA, ANO, LOTE, TOTAL, DEBITO, CREDITO, ' +
                'USUARIO, ESTACAO, IDENTIFICACAO, EXEC_TRIGGER) ' +
                'VALUES (:pId, :pEmpresa, :pAno, :pLote, :pCre, :pDeb, :pUser, '+
                ' :pStation, :piDent, :pExecTrigger)';

     try
        qryGravaLote .Close;
        qryGravaLote.Connection := dmConexao.ConnMega;
        qryGravaLote.SQL.Clear;
        qryGravaLote.SQL.Add( comando );

        qryGravaLote.ParamByName('pId').AsInteger := pId;
        qryGravaLote.ParamByName('pEmpresa').AsInteger := pEmpresa;
        qryGravaLote.ParamByName('pAno').AsString := pAno;
        qryGravaLote.ParamByName('pLote').AsInteger := pLote;
        qryGravaLote.ParamByName('pCre').AsCurrency := pCre;
        qryGravaLote.ParamByName('pDeb').AsCurrency := pDeb;
        qryGravaLote.ParamByName('pUser').AsString := user;
        qryGravaLote.ParamByName('pStation').AsString := station;
        qryGravaLote.ParamByName('piDent').AsString := ident;
        qryGravaLote.ParamByName('pExecTrigger').AsString := execTrigger;
        qryGravaLote.ExecSQL;
        dmConexao.ConnMega.Commit;  // procedimento que fiz para comitar diretamente pela conex�o com o banco de dados;

      Result := System.True;

     except
      raise;
     end;
   end;






  function TdmMegaContabil.retornarIDPorTabela(pTabela :String) : Integer;
   var
   comando :string;
   begin

//   select gen_id(gen_id_clotes,1) from rdb$database
    comando :=  'SELECT GEN_ID(gen_id_'+ pTabela + ',1) FROM RDB$DATABASE';

    qryGenIdClotes.Close;
    qryGenIdClotes.Connection := dmConexao.ConnMega;
    qryGenIdClotes.SQL.Clear;
    qryGenIdClotes.SQL.Add( comando );
    qryGenIdClotes.Open;

    Result := qryGenIdClotes.Fields[0].AsInteger;

   end;


 function TdmMegaContabil.verificaSeExistLote(pIDEmpresa,pLote :Integer; pAno :String) : Boolean;
 begin
    qryExistLote.Close;
    qryExistLote.Connection := dmConexao.ConnMega;
    qryExistLote.ParamByName('pLote').AsInteger :=pLote ;
    qryExistLote.ParamByName('pIDEmpresa').AsInteger :=pIDEmpresa ;
    qryExistLote.ParamByName('pAno').AsString  :=pAno ;
    qryExistLote.Open;

       Result := not qryExistLote.IsEmpty;
 end;


function TdmMegaContabil.carregarDadosEmpresaMega(pCnpj :string) : Boolean;
begin
    qryDadosEmpresaMega.Close;
    qryDadosEmpresaMega.Connection := dmConexao.ConnMega;
    qryDadosEmpresaMega.ParamByName('pCnpj').AsString :=pCnpj ;
    qryDadosEmpresaMega.Open;
    Result := not     qryDadosEmpresaMega.IsEmpty;
end;


end.
