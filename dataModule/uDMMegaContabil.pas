unit uDMMegaContabil;

interface

uses
  uListaLancamentos, System.SysUtils, System.Classes, uUtil, udmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmMegaContabil = class(TDataModule)
    qryDadosEmpresaMega: TFDQuery;
    qryExistLote: TFDQuery;
    qryGenIdClotes: TFDQuery;
    qryVerificaFechamento: TFDQuery;
    qryGravaLote: TFDQuery;
    qryObterPlanoContas: TFDQuery;
    dtsPlanoContas: TDataSource;
    qryInsereLancamento: TFDQuery;
    qryConsultaContaContabil: TFDQuery;
    qryObterLotePorFiltro: TFDQuery;
    qryObterLoteError: TFDQuery;
    qryObterDataError: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function carregarDadosEmpresaMega(pCnpj: string): Boolean;
    function verificaSeExistLote(pIDEmpresa, pLote: Integer; pAno: string): Boolean;
    function verificaFechamento(pIDEmpresa: Integer; pDataInicial: Tdate): string;
    function lotesRestritos(pLote: Integer): Boolean;
    function retornarIDPorTabela(pTabela: string): Integer;
    function gravarCLote(pAno: string; pId, pEmpresa, pLote: Integer; pDebito: Currency): Boolean;
    function obterIDEmpresa(pCnpj: string): Integer;
    function obterPlanoContas(pIdEmpresa: Integer): Boolean;
    function obterLotePorFiltro(pIdEmpresa,pLote : Integer; pAno :string): Boolean;
    function locateContaContabil(pIdEmpresa: Integer; pConta: string): Boolean;
    function insereLancamento(pAno, pLote, pLinha, pCodReduzDeb,pCodReduzCre,pCodHist: Integer; pHistorico, pComple,  pDgCodReduzDeb, pContaDeb, pDgDeb, pDgCodReduzCre, pContaCre, pDgCre, pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime): Boolean;
    function insereLancamentoCRE(pAno, pLote, pLinha,pCodReduzCre,pCodHist: Integer; pHistorico, pComple, pDgCodReduzCre, pContaCre, pDgCre, pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime ): Boolean;
    function insereLancamentoDEB(pAno, pLote, pLinha, pCodReduzDeb,pCodHist : Integer; pHistorico, pComple, pDgCodReduzDeb, pContaDeb, pDgDeb, pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime): Boolean;
    function obterCLoteError(pIdEmpresa,pLote : Integer; pAno :string): Boolean;
    function obterCDataError(pIdEmpresa : Integer; pAno :string): Boolean;

  end;


var
  dmMegaContabil: TdmMegaContabil;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{
    EMPRESA       INTEGER NOT NULL,
    ANO           CHAR(4) NOT NULL,
    LOTE          INTEGER NOT NULL,
    LINHA         INTEGER NOT NULL,
    CCUSTO        INTEGER,
    FILIAL        INTEGER,
    DTLANC        TIMESTAMP,
    DATA          TIMESTAMP NOT NULL,
    TIPO          CHAR(1) NOT NULL,
    CONTA_DEB     CONTA_CONTABIL /* CONTA_CONTABIL = VARCHAR(30) */,
    DGDEB         CHAR(1),
    CONTA_CRE     CONTA_CONTABIL /* CONTA_CONTABIL = VARCHAR(30) */,
    DGCRE         CHAR(1),
    CDREDUZDEB    INTEGER,
    DGREDUZDEB    CHAR(1),
    CDREDUZCRE    INTEGER,
    DGREDUZCRE    CHAR(1),
    CDHIST        INTEGER NOT NULL,
    HISTORICO     VARCHAR(50),
    COMPL         VARCHAR(500),
    VALOR         NUMERIC(18,2) NOT NULL,
    LALUR         SMALLINT,
    GRUPOIMOB     INTEGER,
    CODIMOB       INTEGER,
    EXEC_TRIGGER  CHAR(1),
    SPED_FCONT    BOOLEAN DEFAULT 0


}

procedure TdmMegaContabil.inicializarDM(Sender: TObject);
begin
  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

  dmConexao.conectarMega;

end;

function TdmMegaContabil.insereLancamento(pAno, pLote, pLinha, pCodReduzDeb,pCodReduzCre,pCodHist: Integer; pHistorico, pComple,  pDgCodReduzDeb, pContaDeb, pDgDeb, pDgCodReduzCre, pContaCre, pDgCre, pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime): Boolean;
var
  cmd, execTrigger: string;
  pId, idEmpresa, ccusto, filial: Integer;
  dataLanc: TDateTime;
begin
  execTrigger := 'S';
  ccusto := 0;
  filial := 0;
  dataLanc := Now;
  idEmpresa := obterIDEmpresa(TOrgAtual.getId);
  pId := retornarIDPorTabela('CLANCAMENTOS');

  cmd := ' INSERT INTO CLANCAMENTOS (ID,EMPRESA, ANO, LOTE, LINHA, CCUSTO, FILIAL, DTLANC, DATA, ' + ' TIPO, CONTA_DEB, DGDEB, CONTA_CRE, DGCRE, CDREDUZDEB, DGREDUZDEB, CDREDUZCRE, DGREDUZCRE, ' + ' CDHIST, HISTORICO, COMPL, VALOR, EXEC_TRIGGER) ' + ' VALUES (:pId,:pIdEmpresa, :pAno, :pLote, :pLinha, :pCcusto, :pFilial, :pDataLanc, :pData, ' + ' :pTipo, :pContaDeb, :pDgDeb, :pContaCre,:pDgCre, :pCodReduzDeb, :pDgCodReduzDeb, :pCodReduzCre, :pDgCodReduzCre, ' + ' :pCodHist,:pHistorico, :pComple, :pValor, :pExecTrg) ';

        //ver com Roberto de onde vem linha
        //como lancar debito e credito

  try
    qryInsereLancamento.Close;
    qryInsereLancamento.Connection := dmConexao.ConnMega;
    qryInsereLancamento.SQL.Clear;
    qryInsereLancamento.SQL.Add(cmd);
    qryInsereLancamento.ParamByName('pId').AsInteger := pId;
    qryInsereLancamento.ParamByName('pIdEmpresa').AsInteger := idEmpresa;
    qryInsereLancamento.ParamByName('pAno').AsInteger := pAno;
    qryInsereLancamento.ParamByName('pLote').AsInteger := pLote;
    qryInsereLancamento.ParamByName('pLinha').AsInteger := pLinha;
    qryInsereLancamento.ParamByName('pCcusto').AsInteger := ccusto;
    qryInsereLancamento.ParamByName('pFilial').AsInteger := filial;
    qryInsereLancamento.ParamByName('pDataLanc').AsDateTime := dataLanc;
    qryInsereLancamento.ParamByName('pData').AsDateTime := pData;
    qryInsereLancamento.ParamByName('pTipo').AsString := pTipo;
    qryInsereLancamento.ParamByName('pContaDeb').AsString := pContaDeb;
    qryInsereLancamento.ParamByName('pDgDeb').AsString := pDgDeb;
    qryInsereLancamento.ParamByName('pContaCre').AsString := pContaCre;
    qryInsereLancamento.ParamByName('pDgCre').AsString := pDgCre;
    qryInsereLancamento.ParamByName('pCodReduzDeb').AsInteger := pCodReduzDeb;
    qryInsereLancamento.ParamByName('pDgCodReduzDeb').AsString := pDgCodReduzDeb;
    qryInsereLancamento.ParamByName('pCodReduzCre').AsInteger := pCodReduzCre;
    qryInsereLancamento.ParamByName('pDgCodReduzCre').AsString := pDgCodReduzCre;
    qryInsereLancamento.ParamByName('pCodHist').AsInteger := pCodHist;
    qryInsereLancamento.ParamByName('pHistorico').AsString := pHistorico;
    qryInsereLancamento.ParamByName('pComple').AsString := pComple;
    qryInsereLancamento.ParamByName('pValor').AsCurrency := pValor;
    qryInsereLancamento.ParamByName('pExecTrg').AsString := execTrigger;
    qryInsereLancamento.ExecSQL;
    dmConexao.ConnMega.Commit;

    Result := System.True;

  except
    raise;
  end;

end;

//insere apenas CREDITO

function TdmMegaContabil.insereLancamentoCRE(pAno, pLote, pLinha,pCodReduzCre,pCodHist: Integer; pHistorico, pComple, pDgCodReduzCre, pContaCre, pDgCre, pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime): Boolean;
var
  cmd, execTrigger: string;
  pId, idEmpresa, ccusto, filial: Integer;
  dataLanc: TDateTime;
begin
  execTrigger := 'S';
  ccusto := 0;
  filial := 0;
  dataLanc := Now;
  idEmpresa := obterIDEmpresa(TOrgAtual.getId);
  pId := retornarIDPorTabela('CLANCAMENTOS');

  //  criar campos no MEGA - CLANCAMENTOS
 //   ID_FINANCE VARCHAR(36)
 //   IDENT_FNC VARCHAR(36)

  cmd := ' INSERT INTO CLANCAMENTOS (ID,EMPRESA,ID_FINANCE,IDENT_FNC, ANO, LOTE, LINHA, CCUSTO, FILIAL, DTLANC, DATA, ' +
         ' TIPO, CONTA_CRE, DGCRE, CDREDUZCRE, DGREDUZCRE, CDHIST, HISTORICO, COMPL, VALOR, EXEC_TRIGGER)  ' +
         ' VALUES (:pId,:pIdEmpresa, :pIdFinance, :pIdentFnc,:pAno, :pLote, :pLinha, :pCcusto, :pFilial, :pDataLanc, :pData, ' +
         ' :pTipo, :pContaCre,:pDgCre,:pCodReduzCre, :pDgCodReduzCre, ' + ' :pCodHist,:pHistorico, :pComple, :pValor, :pExecTrg) ';

  try
    qryInsereLancamento.Close;
    qryInsereLancamento.Connection := dmConexao.ConnMega;
    qryInsereLancamento.SQL.Clear;
    qryInsereLancamento.SQL.Add(cmd);
    qryInsereLancamento.ParamByName('pId').AsInteger := pId;
    qryInsereLancamento.ParamByName('pIdEmpresa').AsInteger := idEmpresa;
    qryInsereLancamento.ParamByName('pAno').AsInteger := pAno;
    qryInsereLancamento.ParamByName('pLote').AsInteger := pLote;
    qryInsereLancamento.ParamByName('pLinha').AsInteger := pLinha;
    qryInsereLancamento.ParamByName('pCcusto').AsInteger := ccusto;
    qryInsereLancamento.ParamByName('pFilial').AsInteger := filial;
    qryInsereLancamento.ParamByName('pDataLanc').AsDateTime := dataLanc;
    qryInsereLancamento.ParamByName('pData').AsDateTime := pData;
    qryInsereLancamento.ParamByName('pTipo').AsString := pTipo;
    qryInsereLancamento.ParamByName('pContaCre').AsString := pContaCre;
    qryInsereLancamento.ParamByName('pDgCre').AsString := pDgCre;
    qryInsereLancamento.ParamByName('pCodReduzCre').AsInteger := pCodReduzCre;
    qryInsereLancamento.ParamByName('pDgCodReduzCre').AsString := pDgCodReduzCre;
    qryInsereLancamento.ParamByName('pCodHist').AsInteger := pCodHist;
    qryInsereLancamento.ParamByName('pHistorico').AsString := pHistorico;
    qryInsereLancamento.ParamByName('pComple').AsString := pComple;
    qryInsereLancamento.ParamByName('pIdFinance').AsString := pIdFinance;
    qryInsereLancamento.ParamByName('pIdentFnc').AsString := pIdentFnc;
    qryInsereLancamento.ParamByName('pValor').AsCurrency := pValor;
    qryInsereLancamento.ParamByName('pExecTrg').AsString := execTrigger;
    qryInsereLancamento.ExecSQL;
    //dmConexao.ConnMega.Commit;

    Result := System.True;

  except
    raise;
  end;

end;

//insere apenas DEBITO


function TdmMegaContabil.insereLancamentoDEB(pAno, pLote, pLinha,pCodReduzDeb,pCodHist: Integer; pHistorico, pComple, pDgCodReduzDeb, pContaDeb, pDgDeb,  pTipo,pIdFinance, pIdentFnc: string; pValor: Currency; pData: TDateTime): Boolean;
var
  cmd, execTrigger: string;
  pId, idEmpresa, ccusto, filial: Integer;
  dataLanc: TDateTime;
begin
  execTrigger := 'S';
  ccusto := 0;
  filial := 0;
  dataLanc := Now;
  idEmpresa := obterIDEmpresa(TOrgAtual.getId);
  pId := retornarIDPorTabela('CLANCAMENTOS');

  cmd := ' INSERT INTO CLANCAMENTOS (ID,EMPRESA,ID_FINANCE,IDENT_FNC, ANO, LOTE, LINHA, CCUSTO, FILIAL, DTLANC, DATA, ' + ' TIPO, CONTA_DEB, DGDEB, CDREDUZDEB, DGREDUZDEB, ' + ' CDHIST, HISTORICO, COMPL, VALOR, EXEC_TRIGGER) ' +
         ' VALUES (:pId,:pIdEmpresa, :pIdFinance, :pIdentFnc, :pAno, :pLote, :pLinha, :pCcusto, :pFilial, :pDataLanc, :pData, ' + ' :pTipo, :pContaDeb, :pDgDeb, :pCodReduzDeb, :pDgCodReduzDeb,' + ' :pCodHist,:pHistorico, :pComple, :pValor, :pExecTrg) ';

        //ver com Roberto de onde vem linha
        //como lancar debito e credito

  try
    qryInsereLancamento.Close;
    qryInsereLancamento.Connection := dmConexao.ConnMega;
    qryInsereLancamento.SQL.Clear;
    qryInsereLancamento.SQL.Add(cmd);
    qryInsereLancamento.ParamByName('pId').AsInteger := pId;
    qryInsereLancamento.ParamByName('pIdEmpresa').AsInteger := idEmpresa;
    qryInsereLancamento.ParamByName('pAno').AsInteger := pAno;
    qryInsereLancamento.ParamByName('pLote').AsInteger := pLote;
    qryInsereLancamento.ParamByName('pLinha').AsInteger := pLinha;
    qryInsereLancamento.ParamByName('pCcusto').AsInteger := ccusto;
    qryInsereLancamento.ParamByName('pFilial').AsInteger := filial;
    qryInsereLancamento.ParamByName('pDataLanc').AsDateTime := dataLanc;
    qryInsereLancamento.ParamByName('pData').AsDateTime := pData;
    qryInsereLancamento.ParamByName('pTipo').AsString := pTipo;
    qryInsereLancamento.ParamByName('pContaDeb').AsString := pContaDeb;
    qryInsereLancamento.ParamByName('pDgDeb').AsString := pDgDeb;
    qryInsereLancamento.ParamByName('pCodReduzDeb').AsInteger := pCodReduzDeb;
    qryInsereLancamento.ParamByName('pDgCodReduzDeb').AsString := pDgCodReduzDeb;
    qryInsereLancamento.ParamByName('pCodHist').AsInteger := pCodHist;
    qryInsereLancamento.ParamByName('pHistorico').AsString := pHistorico;
    qryInsereLancamento.ParamByName('pComple').AsString := pComple;
    qryInsereLancamento.ParamByName('pValor').AsCurrency := pValor;
    qryInsereLancamento.ParamByName('pIdFinance').AsString := pIdFinance;
    qryInsereLancamento.ParamByName('pIdentFnc').AsString := pIdentFnc;

    qryInsereLancamento.ParamByName('pExecTrg').AsString := execTrigger;
    qryInsereLancamento.ExecSQL;
    //dmConexao.ConnMega.Commit;

    Result := System.True;

  except
    raise;
  end;

end;






function TdmMegaContabil.obterCDataError(pIdEmpresa: Integer;
  pAno: string): Boolean;
begin
   //verifca tabela cDatas_error
//verificar se existem registros referente ao lote que acaba de ser inserido

         qryObterDataError.Close;
  if not qryObterDataError.Connection.Connected then
  begin
         qryObterDataError.Connection := dmConexao.ConnMega;
  end;
         qryObterDataError.ParamByName('PIDEMPRESA').AsInteger := pIdEmpresa;
         qryObterDataError.ParamByName('PANO').AsString := PANO;
         qryObterDataError.Open;

  Result := not qryObterDataError.IsEmpty;

end;

function TdmMegaContabil.obterCLoteError(pIdEmpresa, pLote: Integer;
  pAno: string): Boolean;


begin
//verifca tabela clotes_error
//verificar se existem registros referente ao lote que acaba de ser inserido

  qryObterLoteError.Close;
  if not qryObterLoteError.Connection.Connected then
  begin
    qryObterLoteError.Connection := dmConexao.ConnMega;
  end;
  qryObterLoteError.ParamByName('PIDEMPRESA').AsInteger := pIdEmpresa;
  qryObterLoteError.ParamByName('PLOTE').AsInteger := PLOTE;
  qryObterLoteError.ParamByName('PANO').AsString := PANO;

  qryObterLoteError.Open;


  Result := not qryObterLotePorFiltro.IsEmpty;

end;

function TdmMegaContabil.verificaFechamento(pIDEmpresa: Integer; pDataInicial: Tdate): string;
begin
  // verifica se existe na TABLE CLANCAMENTOS registro de CDHIST com valor 65/66/75/76
  // apos periodo inicial at� ano 2020.
  // SE o retorno for ID. Significa que exist CDHIST dentro do periodo e nao pode receber a importacao
  qryVerificaFechamento.Close;
  qryVerificaFechamento.Connection := dmConexao.ConnMega;
  qryVerificaFechamento.ParamByName('pIDEmpresa').AsInteger := pIDEmpresa;
  qryVerificaFechamento.ParamByName('pDataInicial').AsDate := pDataInicial;
  // QuotedStr(FormatDateTime('dd.mm.yyyy',StrToDate(pDataInicial)));
  // qryVerificaFechamento.ParamByName('pDataFinal').AsDateTime:= StrToDate(pDataFinal);
  qryVerificaFechamento.Open;

  Result := qryVerificaFechamento.Fields[0].AsString;

end;

function TdmMegaContabil.lotesRestritos(pLote: Integer): Boolean;
// verifica se um lote est� entre os lotes restritos. Retorne TRUE caso esteja.
// restritos:  9999 / 9901 at� 9912 / 901 at� 912 / 9001 at� 9012
var
  rst: Boolean;
begin
  rst := false;

  if (pLote > 900) then
  begin
    rst := true;
  end;

  Result := rst;
end;

function TdmMegaContabil.obterIDEmpresa(pCnpj: string): Integer;
var
  id: Integer;
begin
  id := (-1);
  if carregarDadosEmpresaMega(TOrgAtual.getCNPJ) then
  begin
    id := qryDadosEmpresaMega.FieldByName('ID').AsInteger;
  end;

  Result := id;

end;

function TdmMegaContabil.obterLotePorFiltro(pIdEmpresa, pLote: Integer;  pAno: string): Boolean;
begin
  {WHERE cl.ano = :PANO
  AND cl.empresa = :PIDEMPRESA
  AND cl.lote = :PLOTE }

  qryObterLotePorFiltro.Close;
  if not qryObterLotePorFiltro.Connection.Connected then
  begin
    qryObterLotePorFiltro.Connection := dmConexao.ConnMega;
  end;
  qryObterLotePorFiltro.ParamByName('PIDEMPRESA').AsInteger := pIdEmpresa;
  qryObterLotePorFiltro.ParamByName('PLOTE').AsInteger := pLote;
  qryObterLotePorFiltro.ParamByName('PANO').AsString := pAno;

  qryObterLotePorFiltro.Open;

  Result := not qryObterLotePorFiltro.IsEmpty;

end;

function TdmMegaContabil.obterPlanoContas(pIdEmpresa: Integer): Boolean;
begin

  qryObterPlanoContas.Close;
  if not qryObterPlanoContas.Connection.Connected then
  begin
    qryObterPlanoContas.Connection := dmConexao.ConnMega;
  end;

  qryObterPlanoContas.ParamByName('PIDEMPRESA').AsInteger := pIdEmpresa;
  qryObterPlanoContas.Open;

  Result := not qryObterPlanoContas.IsEmpty;

end;

function TdmMegaContabil.locateContaContabil(pIdEmpresa: Integer; pConta: string): Boolean;
var
found :Boolean;
begin
  if obterPlanoContas(pIdEmpresa) then
  begin
    if qryObterPlanoContas.Locate('CONTA', pConta, []) then
    begin

       found := True;

    end;
  end;

  Result := found;

end;

function TdmMegaContabil.gravarCLote(pAno: string; pId, pEmpresa, pLote: Integer; pDebito: Currency): Boolean;
var
  execTrigger, comando, user, station, ident: string;
begin

  execTrigger := 'S';
  user := 'FNC - ' + UpperCase(uUtil.TUserAtual.getLogin);
  station := 'HOST '+  uUtil.NomeComputador + ' IP -> ' + Uutil.GetIp;
  ident := uUtil.TUserAtual.getNameUser; //pegar o usuario logado aqui
  pId := retornarIDPorTabela('CLOTES');

  { INSERT INTO CLOTES (ID, EMPRESA, ANO, LOTE, TOTAL, DEBITO, CREDITO, USUARIO, ESTACAO,
    IDENTIFICACAO, EXEC_TRIGGER) }


  comando := ' INSERT INTO CLOTES (ID, EMPRESA, ANO, LOTE, TOTAL, ' + ' USUARIO, ESTACAO, IDENTIFICACAO, EXEC_TRIGGER) ' + 'VALUES (:pId, :pEmpresa, :pAno, :pLote, :pDebito, :pUser, ' + '        :pStation, :piDent, :pExecTrigger)';

  try

    qryGravaLote.Close;
    qryGravaLote.Connection := dmConexao.ConnMega;
    qryGravaLote.SQL.Clear;
    qryGravaLote.SQL.Add(comando);
    qryGravaLote.ParamByName('pId').AsInteger := pId;
    qryGravaLote.ParamByName('pEmpresa').AsInteger := pEmpresa;
    qryGravaLote.ParamByName('pAno').AsString := pAno;
    qryGravaLote.ParamByName('pLote').AsInteger := pLote;
    qryGravaLote.ParamByName('pDebito').AsCurrency := pDebito;
    qryGravaLote.ParamByName('pUser').AsString := user;
    qryGravaLote.ParamByName('pStation').AsString := station;
    qryGravaLote.ParamByName('piDent').AsString := ident;
    qryGravaLote.ParamByName('pExecTrigger').AsString := execTrigger;

    qryGravaLote.ExecSQL;
//    dmConexao.ConnMega.Commit; retirado em 25/07.

    Result := System.True;

  except
    raise(Exception).Create('Erro ao tentar gravar o lote no Sist. Cont�bil');
  end;
end;

function TdmMegaContabil.retornarIDPorTabela(pTabela: string): Integer;
var
  comando: string;

begin

  if pTabela ='' then pTabela :='clotes';


  // select gen_id(gen_id_clotes,1) from rdb$database
  comando := 'SELECT GEN_ID(gen_id_' + pTabela + ',1) FROM RDB$DATABASE';

  qryGenIdClotes.Close;
  qryGenIdClotes.Connection := dmConexao.ConnMega;
  qryGenIdClotes.SQL.Clear;
  qryGenIdClotes.SQL.Add(comando);
  qryGenIdClotes.Open;

  Result := qryGenIdClotes.Fields[0].AsInteger;

end;

function TdmMegaContabil.verificaSeExistLote(pIDEmpresa, pLote: Integer; pAno: string): Boolean;
begin

  if not (dmConexao.ConnMega.Connected) then
  begin
    dmConexao.conectarMega;
  end;

  qryExistLote.Close;
  qryExistLote.Connection := dmConexao.ConnMega;
  qryExistLote.ParamByName('pLote').AsInteger := pLote;
  qryExistLote.ParamByName('pIDEmpresa').AsInteger := pIDEmpresa;
  qryExistLote.ParamByName('pAno').AsString := pAno;
  qryExistLote.Open;

  Result := not qryExistLote.IsEmpty;
end;

function TdmMegaContabil.carregarDadosEmpresaMega(pCnpj: string): Boolean;
var
  x: string;
begin
  if not (dmConexao.ConnMega.Connected) then
  begin
    dmConexao.conectarMega;
  end;

  qryDadosEmpresaMega.Close;
  qryDadosEmpresaMega.Connection := dmConexao.ConnMega;
  qryDadosEmpresaMega.ParamByName('pCnpj').AsString := pCnpj;
  qryDadosEmpresaMega.Open;

  Result := not qryDadosEmpresaMega.IsEmpty;
end;


//function TdmMegaContabil.verificarSeContaExiste(pIdOrganizacao, pValue, pCampo: string): Boolean;
//var
//  existConta: Boolean;      //analisar metodo para depois mudar. 23/07
//begin
//  existConta := False;
//   //ID ORGANIZACAO, A CONTA DO MEGA E O PARAMETRO A SER PESQUISADO
//
//  if (pCampo.Equals('CONTA')) then
//  begin
//
//    if dmContaContabil.obterContaPorFiltro(pIdOrganizacao, pValue, pCampo) then
//    begin
//      existConta := True;
//    end;
//  end;

end.


