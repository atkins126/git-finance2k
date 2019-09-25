unit uDMEspelhoTP;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,Vcl.Forms,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao,uDMContasPagar,uDMOrganizacao,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet;

type
  TdmEspelhoTP = class(TDataModule)
    frxDBTitulos: TfrxDBDataset;
    frxTPROVDB: TfrxDBDataset;
    frxTPPROVCR: TfrxDBDataset;
    qryTPPROVCR: TFDQuery;
    qryTPPROVDB: TFDQuery;
    dsDetalhesTP: TDataSource;
    frxDBTPQuitados: TfrxDBDataset;
    frxDBTPBCaixa: TfrxDBDataset;
    frxTPBAcrescimo: TfrxDBDataset;
    frxTPBDeducao: TfrxDBDataset;
    frxDBTPB: TfrxDBDataset;
    frxTPBCheque: TfrxDBDataset;
    qryTPQuitados: TFDQuery;
    dsDetalhesTPB: TDataSource;
    qryObterTPBaixaPorTitulo: TFDQuery;
    qryBaixaTPCaixa: TFDQuery;
    qryBaixaTPCheque: TFDQuery;
    qryTPBAcrescimos: TFDQuery;
    qryTPBDeducao: TFDQuery;
    qryTPBHistorico: TFDQuery;
    frxTPBHistorico: TfrxDBDataset;
    frxEspelhoTP: TfrxReport;
    qryObterTPBBanco: TFDQuery;
    qryCedente: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    frxCedente: TfrxDBDataset;
    qryRateioCentroCustos: TFDQuery;
    frxCentroCustos: TfrxDBDataset;
    procedure dsDetalhesTPDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure inicializarDM(Sender: TObject);
    function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure exibirRelatorio(dtInicial, dtFinal: TDate);

    //TP PRovisionado
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTPProvCR(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
    function obterTPProvDB(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
    function obterRateioCentroCusto(pIdOrganizacao,pIdTituloPagar : string ): Boolean;

    //TP BAIXA
    function obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterTPBaixaPorTitulo(pIdOrganizacao, pIdtituloPagar: String): Boolean;
    function obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBHistorico(pIdorganizacao, tituloPagarQuitado : string): Boolean;
    function obterCdentePorID(pIdorganizacao, idCedente : string): Boolean;

  end;

var
  dmEspelhoTP: TdmEspelhoTP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function TdmEspelhoTP.retornarCaminhoRelatorio: string;
begin
    Result := ExtractFilePath(Application.ExeName) + '\relEspelhoTituloPagar.fr3';
end;

procedure  TdmEspelhoTP.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end ;

   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end  ;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


end;

procedure TdmEspelhoTP.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with   frxEspelhoTP.Variables do
  begin

    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));



    // Variables['strTipo'] := QuotedStr(tipo); // muda a depender do lancamento

  end;

end;


procedure TdmEspelhoTP.dsDetalhesTPDataChange(Sender: TObject; Field: TField);
var
idOrganizacao, idCedente, idTituloPagar :string;
begin
//pegar os dados dos detalhe
 idOrganizacao := qryObterPorNumeroDocumento.FieldByName('ID_ORGANIZACAO').AsString;
 idCedente     := qryObterPorNumeroDocumento.FieldByName('ID_CEDENTE').AsString;
 idTituloPagar := qryObterPorNumeroDocumento.FieldByName('ID_TITULO_PAGAR').AsString;

 obterCdentePorID(idOrganizacao, idCedente);
 obterTPProvDB(idOrganizacao,idTituloPagar);
 obterRateioCentroCusto(idOrganizacao,idTituloPagar);


end;

Procedure TdmEspelhoTP.exibirRelatorio ( dtInicial, dtFinal: TDate);
begin

         frxEspelhoTP.Clear;
  if not(frxEspelhoTP.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
    ///dasa
  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal); //verficar essa data
    frxEspelhoTP.OldStyleProgress := True;
    frxEspelhoTP.ShowProgress := True;
    frxEspelhoTP.ShowReport;

    end;
end;


function  TdmEspelhoTP.obterTPProvCR(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
begin
  Result := false;

  qryTPPROVCR.Close;
  qryTPPROVCR.Connection := dmConexao.Conn;
  qryTPPROVCR.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTPPROVCR.ParamByName('PIDTITULOPAGAR').AsString := pIdTituloPagar;
  qryTPPROVCR.Open;

  Result := not qryTPPROVCR.IsEmpty;

end;



function TdmEspelhoTP.obterTPProvDB(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
begin
  Result := false;

  qryTPPROVDB.Close;
  qryTPPROVDB.Connection := dmConexao.Conn;
  qryTPPROVDB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTPPROVDB.ParamByName('PIDTITULOPAGAR').AsString := pIdTituloPagar;
  qryTPPROVDB.Open;


  Result := not qryTPPROVDB.IsEmpty;

end;



function TdmEspelhoTP.obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
var auxSql :string;
begin
  Result := false;

  qryTPQuitados.Close;
  qryTPQuitados.Connection := dmConexao.Conn;
  qryTPQuitados.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPQuitados.ParamByName('pIdStatus').AsString := pIdStatus;
  qryTPQuitados.ParamByName('pDataInicial').AsDate := pDataInicial;
  qryTPQuitados.ParamByName('pDataFinal').AsDate := pDataFinal;
//  auxSql := QuotedStr(qry1.SQL.Text); S� PARA TESTE
  qryTPQuitados.Open;



  Result := not qryTPQuitados.IsEmpty;

end;

function TdmEspelhoTP.obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
begin
  Result := false;
  //obtem os TP pago pela tesouraria

  qryBaixaTPCaixa.Close;
  qryBaixaTPCaixa.Connection := dmConexao.Conn;
  qryBaixaTPCaixa.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
  qryBaixaTPCaixa.ParamByName('PIDTITULOPAGARBAIXA').AsString := pIdTPB;
  qryBaixaTPCaixa.Open;

  Result := not qryBaixaTPCaixa.IsEmpty;

end;

function TdmEspelhoTP.obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
begin

  Result := false;

  qryBaixaTPCheque.Close;
  qryBaixaTPCheque.Connection := dmConexao.Conn;
  qryBaixaTPCheque.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryBaixaTPCheque.ParamByName('PIDTITULOPAGARBAIXA').AsString :=pIdTPB;
  qryBaixaTPCheque.Open;

  Result := not qryBaixaTPCheque.IsEmpty;
end;

function TdmEspelhoTP.obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;

begin
  Result := false;

  qryObterTPBBanco.Close;
  qryObterTPBBanco.Connection := dmConexao.Conn;
  qryObterTPBBanco.ParamByName('pIdOrganizacao').AsString :=   pIdOrganizacao;
  qryObterTPBBanco.ParamByName('PIDTPB').AsString := pIdTPB;

  qryObterTPBBanco.Open;

  Result := not qryObterTPBBanco.IsEmpty;

end;

function TdmEspelhoTP.obterCdentePorID(pIdorganizacao,
  idCedente: string): Boolean;
begin
try

      qryCedente.Close;
      qryCedente.Connection := dmConexao.Conn;
      qryCedente.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCedente.ParamByName('PIDCEDENTE').AsString := idCedente;

      qryCedente.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o Fornecedor ' );


  end;

  Result := not qryCedente.IsEmpty;
end;

function TdmEspelhoTP.obterPorNumeroDocumento(pIdOrganizacao,
  pNumDoc: string): Boolean;
begin
 try

      qryObterPorNumeroDocumento.Close;
      qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
      qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

      qryObterPorNumeroDocumento.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o TP DOC ' + pNumDoc );


  end;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;

function TdmEspelhoTP.obterRateioCentroCusto(pIdOrganizacao,
  pIdTituloPagar: string): Boolean;
begin
 try

      qryRateioCentroCustos.Close;
      qryRateioCentroCustos.Connection := dmConexao.Conn;
      qryRateioCentroCustos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryRateioCentroCustos.ParamByName('PIDTITULOPAGAR').AsString := pIdTituloPagar;

      qryRateioCentroCustos.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o rateio de custos ....');


  end;

  Result := not qryRateioCentroCustos.IsEmpty;
end;

function TdmEspelhoTP.obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;
  try
  qryTPBAcrescimos.Close;
  qryTPBAcrescimos.Connection := dmConexao.Conn;
  qryTPBAcrescimos.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBAcrescimos.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBAcrescimos.Open;
  except

  raise(Exception).Create('Erro ao tentar obter os acr�scimos ....');


  end;
  Result := not qryTPBAcrescimos.IsEmpty;
end;




function TdmEspelhoTP.obterTPBaixaPorTitulo(pIdOrganizacao,
  pIdtituloPagar: String): Boolean;
begin
 Result := false;


  qryObterTPBaixaPorTitulo.Close;
  qryObterTPBaixaPorTitulo.Connection := dmConexao.Conn;
  qryObterTPBaixaPorTitulo.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
  qryObterTPBaixaPorTitulo.ParamByName('pIdtituloPagar').AsString :=  pIdtituloPagar;
  qryObterTPBaixaPorTitulo.Open;

  Result := not qryObterTPBaixaPorTitulo.IsEmpty;
end;

function TdmEspelhoTP.obterTPBDE(pIdOrganizacao, pIdTPB
  : String): Boolean;
begin

  Result := false;

  qryTPBDeducao.Close;
  qryTPBDeducao.Connection := dmConexao.Conn;
  qryTPBDeducao.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBDeducao.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBDeducao.Open;

  Result := not qryTPBDeducao.IsEmpty;
end;


function TdmEspelhoTP.obterTPBHistorico(pIdorganizacao, tituloPagarQuitado :string): Boolean;
begin
  Result := false;

  if not qryTPBHistorico.Connection.Connected then
  begin
    qryTPBHistorico.Connection := dmConexao.Conn;
  end;

  qryTPBHistorico.Close;
  qryTPBHistorico.ParamByName('PIDTP').AsString := tituloPagarQuitado;
  qryTPBHistorico.ParamByName('pIdOrganizacao').AsString := pIdorganizacao;

  qryTPBHistorico.Open();

  Result := not qryTPBHistorico.IsEmpty;

end;



end.