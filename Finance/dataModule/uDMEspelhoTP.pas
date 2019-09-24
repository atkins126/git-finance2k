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
    qryTPPROVBASE: TFDQuery;
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
  private
    { Private declarations }

  public
    { Public declarations }
    procedure inicializarDM(Sender: TObject);
    function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure exibirRelatorio(dtInicial, dtFinal: TDate);

    //TP PRovisionado
    function obterTPProBase(pIdOrganizacao : string; pDataInicial, pDataFinal: TDate ): Boolean;
    function obterTPProvCR(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
    function obterTPProvDB(pIdOrganizacao,pRegistroProvisao : string ): Boolean;

    //TP BAIXA
    function obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterTPBaixaPorTitulo(pIdOrganizacao, pIdtituloPagar: String): Boolean;
    function obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBHistorico(pIdorganizacao, tituloPagarQuitado : string): Boolean;

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


Procedure TdmEspelhoTP.exibirRelatorio ( dtInicial, dtFinal: TDate);
begin

         frxEspelhoTP.Clear;
  if not(frxEspelhoTP.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
    // Mensagem n�o encontrou o arquivo do relatorio. Fazer try p levantar erros
  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal); //verficar essa data
    frxEspelhoTP.OldStyleProgress := True;
    frxEspelhoTP.ShowProgress := True;
    frxEspelhoTP.ShowReport;

    end;
end;


function  TdmEspelhoTP.obterTPProvCR(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
begin
  Result := false;

  qryTPPROVCR.Close;
  qryTPPROVCR.Connection := dmConexao.Conn;
  qryTPPROVCR.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPPROVCR.ParamByName('pregistro').AsString := pRegistroProvisao;
  qryTPPROVCR.Open;

  Result := not qryTPPROVCR.IsEmpty;

end;



function TdmEspelhoTP.obterTPProvDB(pIdOrganizacao,pRegistroProvisao : string ): Boolean;
begin
  Result := false;

  qryTPPROVDB.Close;
  qryTPPROVDB.Connection := dmConexao.Conn;
  qryTPPROVDB.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPPROVDB.ParamByName('pregistro').AsString := pRegistroProvisao;
  qryTPPROVDB.Open;

  Result := not qryTPPROVDB.IsEmpty;

end;


function TdmEspelhoTP.obterTPProBase(pIdOrganizacao : string; pDataInicial, pDataFinal: TDate ): Boolean;
var
aux :Integer;
begin
  Result := false;

  qryTPPROVBASE.Close;
  qryTPPROVBASE.Connection := dmConexao.Conn;

  qryTPPROVBASE.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPPROVBASE.ParamByName('pDataInicial').AsDate := pDataInicial;
  qryTPPROVBASE.ParamByName('pDataFinal').AsDate := pDataFinal;
  qryTPPROVBASE.Open;


  Result := not qryTPPROVBASE.IsEmpty;

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

function TdmEspelhoTP.obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  qryTPBAcrescimos.Close;
  qryTPBAcrescimos.Connection := dmConexao.Conn;
  qryTPBAcrescimos.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBAcrescimos.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBAcrescimos.Open;

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
