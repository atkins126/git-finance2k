unit uFrmManterTituloReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao, uOrganizacaoModel, uDMOrganizacao,uUtil,
  uTituloReceberModel, uTituloReceberDAO, uContaContabilModel, uContaContabilDAO,
  uLoteContabilModel, uLoteContabilDAO, uCentroCustoModel, uCentroCustoDAO,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxControls, uSacadoModel,uSacadoDAO,  cxLookAndFeels, cxLookAndFeelPainters,
  dxRibbonSkins, uTipoStatusModel, uTipoStatusDAO,  dxRibbonCustomizationForm, dxBarBuiltInMenu, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, dxBar, cxClasses, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, uFrameTipoCobranca, ufrmBaixaTRFP,
  uFrameCentroCusto, ENumEd, Vcl.ComCtrls, Vcl.Buttons, uFrameResponsavel,
  uFrameGeneric, uFrameHistorico, uFrameLocalPagamento,
  cxPC, dxStatusBar, dxRibbon,  uContaBancariaCRModel, uContaBancariaCreditoDAO,
  uHistoricoModel, uHistoricoDAO, uFuncionarioModel, uFuncionarioDAO,
 uTituloReceberHistoricoDAO, uFrmReciboTR,
 uTituloReceberHistoricoModel, uTituloReceberCentroCustoModel, uTituloReceberCentroCustoDAO,
 uFrmEspelhoTR, uFrameTipoNotaFiscal,  uTesourariaCRModel, uTesourariaCRDAO,
 uTRBaixaModel, uTRBaixaChequeModel, uTRBaixaFPModel, uTRBaixaACModel, uTRBaixaDEModel, uTRBaixaInternetModel,
 uTRBaixaDAO, uTRBaixaChequeDAO, uTRBaixaFPDAO, uTRBaixaACDAO, uTRBaixaDEDAO, uTRBaixaInternetDAO,
  uFrameSacado, uFrameTR, EMsgDlg;

type
  TfrmManterTituloReceber = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBarManager1Bar7: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    dxBtnLimpar: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    dxBtnProvisao: TdxBarLargeButton;
    dxBtnEdit: TdxBarLargeButton;
    dxBtnSave: TdxBarLargeButton;
    dxBtnDelet: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    pgTitulo: TcxPageControl;
    tbBasica: TcxTabSheet;
    tbComplemento: TcxTabSheet;
    tbNotaFiscal: TcxTabSheet;
    tbRateioHistoricos: TcxTabSheet;
    tbRateioCentroCusto: TcxTabSheet;
    frmLocalPagto1: TfrmLocalPagto;
    frameHistorico1: TframeHistorico;
    frameResponsavel1: TframeResponsavel;
    edtLoteContabil: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    BtnGerarDOC: TBitBtn;
    Label4: TLabel;
    edtCEDConta: TEdit;
    edtCEDReduz: TEdit;
    lblResponsavel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtHISTConta: TEdit;
    edtHISTReduz: TEdit;
    edtCodigoHist: TEdit;
    Label7: TLabel;
    edtValorMainTP: TEvNumEdit;
    edtDescricao: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    dtPagamento: TDateTimePicker;
    dtProtocolo: TDateTimePicker;
    dtEmissao: TDateTimePicker;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtParcela: TEdit;
    Label13: TLabel;
    edtStatus: TEdit;
    Label14: TLabel;
    edtValorAntecipado: TEvNumEdit;
    Label15: TLabel;
    dxBarManager1Bar5: TdxBar;
    dxBtnPagar: TdxBarLargeButton;
    dxBarManager1Bar8: TdxBar;
    dxBarManager1Bar9: TdxBar;
    dxBtnRecibo: TdxBarLargeButton;
    dxBtnEspelho: TdxBarLargeButton;
    gridRateioHist: TDBGrid;
    dbgridHistorico: TDBGrid;
    dsHistorico: TDataSource;
    qryPreencheGridHistorico: TFDQuery;
    frameHistorico2: TframeHistorico;
    fdmHistorico: TFDMemTable;
    dsFdmHistorico: TDataSource;
    btnLimparRateioHist: TButton;
    btnSelectTHST: TButton;
    edtValorRateioHist: TEvNumEdit;
    EdtTotalRateioHist: TEvNumEdit;
    Label16: TLabel;
    edtValorTP: TEvNumEdit;
    Label17: TLabel;
    edtDifHistorico: TEvNumEdit;
    Label18: TLabel;
    frameCentroCusto2: TframeCentroCusto;
    edtValorRateioCC: TEvNumEdit;
    btnSelectTCC: TButton;
    gridRateioCC: TDBGrid;
    dbgridCC: TDBGrid;
    dsCentroCusto: TDataSource;
    fdmCentroCusto: TFDMemTable;
    qryPreencheGridCentroC: TFDQuery;
    Label19: TLabel;
    edtValorTPCC: TEvNumEdit;
    Label20: TLabel;
    edtTotalRateioCC: TEvNumEdit;
    Label21: TLabel;
    edtDifRateioCC: TEvNumEdit;
    btnLimparRateioCC: TButton;
    dsFdmCC: TDataSource;
    Label22: TLabel;
    dtPrevisaoCartorio: TDateTimePicker;
    Label23: TLabel;
    edtUltimoUpdate: TEdit;
    edtCodigoBarras: TEdit;
    Label24: TLabel;
    edtCarteira: TEdit;
    edtContrato: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtObervacao: TEdit;
    frmTipoNF1: TfrmTipoNF;
    edtValorNF: TEvNumEdit;
    edtValorISS: TEvNumEdit;
    edtBaseCalculo: TEvNumEdit;
    dtNFEmissao: TDateTimePicker;
    dtNFProtocolo: TDateTimePicker;
    dtNFRetencaoISS: TDateTimePicker;
    edtNFObservacao: TEdit;
    edtNFNumero: TEdit;
    edtNFDescricao: TEdit;
    edtNFAliquotaISS: TEdit;
    edtNFSerie: TEdit;
    edtNFSubSerie: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    frameCentroCusto1: TframeCentroCusto;
    frmTipoCobranca1: TfrmTipoCobranca;
    edtProvisao: TEdit;
    Label41: TLabel;
    dxBarManager1Bar10: TdxBar;
    dxBtnCancelBaixaTP: TdxBarLargeButton;
    frameSacado1: TframeSacado;
    frameTR1: TframeTR;
    PempecMsg: TEvMsgDlg;
    procedure dxBarBtnSairClick(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frameTP1cbbTPExit(Sender: TObject);
    procedure frameSacado1cbbcomboChange(Sender: TObject);
    procedure frameHistorico1cbbcomboChange(Sender: TObject);
    procedure BtnGerarDOCClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBtnProvisaoClick(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure dxBtnEspelhoClick(Sender: TObject);
    procedure dxBtnPagarClick(Sender: TObject);
    procedure dxBtnReciboClick(Sender: TObject);
    procedure btnLimparRateioHistClick(Sender: TObject);
    procedure btnSelectTHSTClick(Sender: TObject);
    procedure tbRateioHistoricosShow(Sender: TObject);
    procedure edtValorRateioHistChange(Sender: TObject);
    procedure edtValorMainTPChange(Sender: TObject);
    procedure frameHistorico2cbbcomboChange(Sender: TObject);
    procedure btnSelectTCCClick(Sender: TObject);
    procedure tbRateioCentroCustoShow(Sender: TObject);
    procedure btnLimparRateioCCClick(Sender: TObject);
    procedure edtValorRateioCCChange(Sender: TObject);
    procedure dtPagamentoChange(Sender: TObject);
    procedure edtCarteiraChange(Sender: TObject);
    procedure tbComplementoExit(Sender: TObject);
    procedure frmTipoNF1cbbTipoNFChange(Sender: TObject);
    procedure dxBtnSaveClick(Sender: TObject);
    procedure dxBtnDeletClick(Sender: TObject);
    procedure dxBtnEditClick(Sender: TObject);
    procedure tbNotaFiscalShow(Sender: TObject);
    procedure frameCentroCusto1cbbcomboChange(Sender: TObject);
    procedure dxBtnCancelBaixaTPClick(Sender: TObject);
    procedure frameTR1cbbTRChange(Sender: TObject);
    procedure frameTR1cbbTRExit(Sender: TObject);
    procedure tbBasicaShow(Sender: TObject);
    procedure tbComplementoShow(Sender: TObject);
  private
    { Private declarations }
   pIDNotaFiscal, pIDTipoNotaFiscal, pIDorganizacao :string;
    msg, pIDusuario :string;
    FRateioHistorico: TObjectList<TTituloReceberHistoricoModel>;
    FRateioCustos: TObjectList<TTituloReceberCentroCustoModel>;

    tituloReceberModel  : TTituloReceberModel;
    sacadoModel      : TSacadoModel;
    historicoModel    : THistoricoModel;
    centroCustoModel  : TCentroCustoModel;
    responsavelModel  : TFuncionarioModel;
    statusModel       : TTipoStatusModel;
    modo :Integer;

    FSlistaTipoCobranca,    FSlistaIdContaContabil, FSlistaResponsavel, FSlistaLocalPagamento : TStringList;
    FSlistaCentroCusto, FSlistaTipoNF, FSlistaHistorico, FSlistaTitulos, FSlistaSacado  : TStringList;


    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure carregarCombos(titulo :TTituloReceberModel) ;
    function obterLoteContabil (value :TLoteContabilModel) : TLoteContabilModel;
//    function obterLoteRecebimento (value :TLoteRecebimentoModel) : TLoteRecebimentoModel;
    function obterIndiceLista(pId :string; lista :TStringList) : Integer;
    procedure popularSacado(cedente :TSacadoModel);
    procedure popularHistorico(historico: THistoricoModel);
    procedure popularCentroCusto(centroCusto: TCentroCustoModel);
    procedure popularResponsavel(responsavel: TFuncionarioModel);
    procedure popularStatus(status: TTipoStatusModel);
    procedure preencheGridHistorico;
    procedure preencheGridCedntroC;

    procedure createTable;
    function obterValorRateioHistorico: Currency;
    procedure limpaRateioHistorico;
    function atualizarRateio(pTipo: string): Currency;
    procedure preencheAbaRateioHistorico(      listaH: TObjectList<TTituloReceberHistoricoModel>);
    procedure preencheAbaBasica(titulo: TTituloReceberModel);
    procedure preencheAbaRateioCC(listaCC: TObjectList<TTituloReceberCentroCustoModel>);
    function obterValorRateioCC: Currency;
    procedure limpaRateioCC;
    procedure StatusBotoes(value: Integer);
    procedure preencheDatas(titulo: TTituloReceberModel);
    procedure preencheAbaComplementar(titulo: TTituloReceberModel);
   // procedure preencheAbaNotaFiscal(nota: TNotaFiscalEntradaModel);
    function createTitulo : Boolean;
    procedure bloqueiaCampos(Form: TForm; status: Boolean);
    function validarForm(Form :TForm) : Boolean;
    function calcularISS(pValue, pAliquota: Currency): Currency;
    procedure atualizarTitulo;
    function salvarTitulo(titulo: TTituloReceberModel): Boolean;
    procedure limpaAbaNF;
    procedure ajustaComboForm;
    procedure retiraOrdemCampo(Form: TForm);

  public
    { Public declarations }
  end;

var
  frmManterTituloReceber : TfrmManterTituloReceber;

  implementation

{$R *.dfm}

uses uFrmTituloReceberParcelado;

procedure TfrmManterTituloReceber.BtnGerarDOCClick(Sender: TObject);
var
nDOC:string;
dtVenctoCartaoCredito : TDateTime;
begin

 if modo = 1 then begin

    StatusBotoes(0);

    nDOC := dmConexao.obterIdentificador('',pIDorganizacao, 'TR');

    tituloReceberModel := TTituloReceberModel.Create;
    tituloReceberModel.Fnovo := True;
    tituloReceberModel.FIDorganizacao := pIDorganizacao;
    tituloReceberModel.FID := dmConexao.obterNewID;
    tituloReceberModel.FnumeroDocumento := nDOC;
    tituloReceberModel.FIDTipoStatus := 'ABERTO';
    tituloReceberModel.listaHistorico := TObjectList<TTituloReceberHistoricoModel>.Create;
    tituloReceberModel.listaCustos := TObjectList<TTituloReceberCentroCustoModel>.Create;
    tituloReceberModel.listaHistorico.Clear;
    tituloReceberModel.listaCustos.Clear;
    tituloReceberModel.Fparcela := '1';
    tituloReceberModel.FdataRegistro           := Now;
    tituloReceberModel.FdataUltimaAtualizacao  := Now;

    frameTR1.cbbTR.Items.Add(nDOC);
    FSlistaTitulos.Add(tituloReceberModel.FID);
    frameTR1.cbbTR.ItemIndex := obterIndiceLista(tituloReceberModel.FID, FSlistaTitulos);

    edtStatus.Text                              := tituloReceberModel.FIDTipoStatus;
    edtParcela.Text                             := tituloReceberModel.Fparcela;
    edtDescricao.Text                           := 'CR REF: ' ;
    edtUltimoUpdate.Text                        := DateToStr(now);
    frmTipoCobranca1.cbbTipoCobranca.ItemIndex  := 1;
    frmLocalPagto1.cbbcombo.ItemIndex      := FSlistaLocalPagamento.Count -1;

   dxBtnPagar.Enabled :=True;

 end;


end;

procedure TfrmManterTituloReceber.btnLimparRateioCCClick(Sender: TObject);
begin
 limpaRateioCC;
 frameCentroCusto2.cbbcombo.ItemIndex := frameCentroCusto1.cbbcombo.ItemIndex;
 edtValorRateioCC.Enabled := True;
 edtValorRateioCC.SetFocus;
  //obs lembrar de setar o CC  principal novamente.

  atualizarRateio('C');
end;

procedure TfrmManterTituloReceber.btnLimparRateioHistClick(Sender: TObject);
begin

  limpaRateioHistorico;
  frameHistorico2.cbbcombo.ItemIndex           := 0;
  gridRateioHist.Refresh;
  edtValorRateioHist.Clear;

   frameHistorico2.cbbcombo.ItemIndex := frameHistorico1.cbbcombo.ItemIndex;
   edtValorRateioHist.Enabled := True;
   edtValorRateioHist.SetFocus;


  //obs lembrar de setar o historico principal novamente.

  atualizarRateio('H');
end;


procedure TfrmManterTituloReceber.limpaRateioHistorico;
begin
  fdmHistorico.Open;
  fdmHistorico.First;
  while not fdmHistorico.Eof do
  begin
    fdmHistorico.Delete;
    fdmHistorico.Next;
  end;
    gridRateioHist.DataSource.DataSet.Close;
    gridRateioHist.Refresh;

   if Assigned(tituloReceberModel.listaHistorico) then begin
     tituloReceberModel.listaHistorico.Clear;
   end;

   frameHistorico2.cbbcombo.ItemIndex :=0;
   edtValorRateioHist.Clear;
   atualizarRateio('H');

    //obs lembrar de setar o historico principal novamente.
end;

procedure TfrmManterTituloReceber.limpaRateioCC;
begin
  fdmCentroCusto.Open;
  fdmCentroCusto.First;
  while not fdmCentroCusto.Eof do
  begin
    fdmCentroCusto.Delete;
    fdmCentroCusto.Next;
  end;
    gridRateioCC.DataSource.DataSet.Close;
    gridRateioCC.Refresh;

   frameCentroCusto2.cbbcombo.ItemIndex :=0;
   edtValorRateioCC.Clear;
   atualizarRateio('C');

end;



procedure TfrmManterTituloReceber.ajustaComboForm;
begin
frameTR1.cbbTR.Left := 11;
frameTR1.cbbTR.Top  := 11;

end;

function TfrmManterTituloReceber.atualizarRateio(pTipo :string) : Currency;
var
totalRateio : Currency;
begin
  totalRateio:=0;
  if pTipo.Equals('H') then
  begin //atualiza saldo do rateio historico
    totalRateio := obterValorRateioHistorico;
    EdtTotalRateioHist.Value := totalRateio  ;
    edtDifHistorico.Value := edtValorMainTP.Value - totalRateio; //total do titulo menos o total do rateio

  end;

  totalRateio:=0;
  if pTipo.Equals('C') then
  begin //atualiza saldo do rateio CC
    totalRateio := obterValorRateioCC;
    edtTotalRateioCC.Value := totalRateio  ;
    edtDifRateioCC.Value := edtValorMainTP.Value - totalRateio; //total do titulo menos o total do rateio

  end;


end;

function TfrmManterTituloReceber.obterValorRateioCC: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmCentroCusto.Open;
 fdmCentroCusto.First;

 while not fdmCentroCusto.Eof do begin
 total := total + fdmCentroCusto.FieldByName('VALOR').AsCurrency;
 fdmCentroCusto.Next;
 end;


  Result := total;

end;


function TfrmManterTituloReceber.obterValorRateioHistorico: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmHistorico.Open;
 fdmHistorico.First;
 while not fdmHistorico.Eof do begin
 total := total + fdmHistorico.FieldByName('VALOR').AsCurrency;
 fdmHistorico.Next;
 end;
  Result := total;

end;



procedure TfrmManterTituloReceber.createTable;
begin

    fdmHistorico.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmHistorico.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmHistorico.FieldDefs.Add('ID_HISTORICO', ftString, 36, false);
    fdmHistorico.CreateDataSet;

    fdmCentroCusto.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmCentroCusto.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmCentroCusto.FieldDefs.Add('ID_CENTRO_CUSTO', ftString, 36, false);
    fdmCentroCusto.CreateDataSet;


end;


procedure TfrmManterTituloReceber.btnSelectTCCClick(Sender: TObject);
var
  rateioCC: TTituloReceberCentroCustoModel;
  ccValidado: Boolean;
begin
  //botao seleciona novo centro de custo
  //cria novo rateio

  rateioCC := TTituloReceberCentroCustoModel.Create;
  ccValidado := False;

  centroCustoModel := TCentroCustoModel.Create;
  centroCustoModel.FIDorganizacao := pIDorganizacao;
  centroCustoModel.FID := FSlistaCentroCusto[frameCentroCusto2.cbbcombo.ItemIndex];
  centroCustoModel := TCentroCustoDAO.obterPorID(centroCustoModel);

  if uUtil.Empty(centroCustoModel.FID) then
  begin
    ShowMessage('O centro de custo n�o pode ser utilizado. Poss�vel problema com a consulta . ');
    frameCentroCusto2.cbbcombo.ItemIndex := 0;
  end
  else
  begin
    ccValidado := True;
  end;

  if ccValidado then
  begin
    rateioCC.FIDorganizacao := pIDorganizacao;
    rateioCC.FID := dmConexao.obterNewID;
    rateioCC.FIDCentroCusto := centroCustoModel.FID;
    rateioCC.FIDTR := tituloReceberModel.FID;
    rateioCC.Fvalor := edtValorRateioCC.Value;
    rateioCC.FCentroCusto := centroCustoModel;

    tituloReceberModel.AdicionarCC(rateioCC);
    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([centroCustoModel.FDescricao, edtValorRateioCC.Value]);
    edtTotalRateioCC.Value := obterValorRateioCC;

    frameCentroCusto2.cbbcombo.ItemIndex := 0;
    edtValorRateioCC.Value := 0;
    btnSelectTCC.Enabled := False;

  end;

  atualizarRateio('C');
  StatusBotoes(0);
end;

procedure TfrmManterTituloReceber.btnSelectTHSTClick(Sender: TObject);
 var
 rateioHistorico  : TTituloReceberHistoricoModel;
 hstValidado : Boolean;

begin
  rateioHistorico := TTituloReceberHistoricoModel.Create;
  hstValidado := False;

  if edtValorRateioHist.Value > 0 then
  begin

      historicoModel                := THistoricoModel.Create;
      historicoModel.FID            := FSlistaHistorico[frameHistorico2.cbbcombo.ItemIndex];
      historicoModel.FIDorganizacao := pIDorganizacao;
      historicoModel := THistoricoDAO.obterPorID(historicoModel);

    if uutil.Empty(historicoModel.FIdContaContabil) then
    begin
      ShowMessage('O hist�rico n�o pode ser utilizado. Poss�vel problema no campo conta cont�bil. ');
      frameHistorico2.cbbcombo.ItemIndex := 0;

    end
    else
    begin
      hstValidado := True;
    end;

      rateioHistorico.FID                     := dmConexao.obterNewID;
      rateioHistorico.FIDorganizacao          := pIDorganizacao;
      rateioHistorico.FIDHistorico            := historicoModel.FID;
      rateioHistorico.FIDContaContabilDebito  := historicoModel.FIdContaContabil;
      rateioHistorico.FIDTR                   := tituloReceberModel.FID;
      rateioHistorico.Fvalor                  := edtValorRateioHist.Value;

      if hstValidado then begin

      tituloReceberModel.AdicionarHST(rateioHistorico);

      fdmHistorico.Open;
      fdmHistorico.InsertRecord([historicoModel.FDescricao, edtValorRateioHist.Value]);
      EdtTotalRateioHist.Value := obterValorRateioHistorico;

      frameHistorico2.cbbcombo.ItemIndex := 0;
      edtValorRateioHist.Value := 0;
      btnSelectTHST.Enabled := False;
      end;

  end;

  atualizarRateio('H');
  StatusBotoes(0);

end;

procedure TfrmManterTituloReceber.carregarCombos (titulo :TTituloReceberModel) ;
var
pDataFinal, pDataInicial :TDateTime;

begin

   ajustaComboForm;

    if uutil.Empty(titulo.FID) then begin

                  pDataInicial  :=  StrToDate('01'  + '/'+ FormatDateTime('mm',Now) + '/' + FormatDateTime('YYYY',Now)) ;
                  pDataFinal    :=  EndOfTheMonth(pDataInicial);


  //    frameTP1.obterTodos(pIDorganizacao, frameTR1.cbbTR, FSlistaTitulos);
      frameTR1.obterTodosPorPeriodo(pIDorganizacao, pDataInicial,pDataFinal, frameTR1.cbbTR, FSlistaTitulos);


      frameSacado1.obterTodos(pIDorganizacao, frameSacado1.cbbcombo, FSlistaSacado);
      frameHistorico1.obterTodosPorTipo (pIDorganizacao,'R', frameHistorico1.cbbcombo, FSlistaHistorico);
      frameCentroCusto1.obterTodos(pIDorganizacao, frameCentroCusto1.cbbcombo, FSlistaCentroCusto);

      frameResponsavel1.obterTodosAtivos(pIDorganizacao, frameResponsavel1.cbbcombo, FSlistaResponsavel);

      frmTipoCobranca1.obterTodos(pIDorganizacao, frmTipoCobranca1.cbbTipoCobranca, FSlistaTipoCobranca);
      frmLocalPagto1.obterTodos(pIDorganizacao, frmLocalPagto1.cbbcombo, FSlistaLocalPagamento);
      frameHistorico2.obterTodosPorTipo (pIDorganizacao,'R', frameHistorico2.cbbcombo, FSlistaHistorico);
      frameCentroCusto2.obterTodos(pIDorganizacao, frameCentroCusto2.cbbcombo, FSlistaCentroCusto);
      frmTipoNF1.obterTodos(pIDorganizacao, frmTipoNF1.cbbTipoNF, FSlistaTipoNF);



       frameSacado1.cbbcombo.ItemIndex             := 0;
       frameHistorico1.cbbcombo.ItemIndex           := 0;
       frameHistorico2.cbbcombo.ItemIndex           := 0;
       frameCentroCusto1.cbbcombo.ItemIndex   := 0;
       frameCentroCusto2.cbbcombo.ItemIndex   := 0;
       frameResponsavel1.cbbcombo.ItemIndex         := 0;
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := 0;
       frmLocalPagto1.cbbcombo.ItemIndex       := 0;
       frmTipoNF1.cbbTipoNF.ItemIndex               := 0;



    end else begin


       frameSacado1.cbbcombo.ItemIndex             := obterIndiceLista(titulo.FIDSacado, FSlistaSacado);
       frameHistorico1.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameHistorico2.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameCentroCusto1.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameCentroCusto2.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameResponsavel1.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDResponsavel, FSlistaResponsavel);
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := obterIndiceLista(titulo.FIDTipoCobranca, FSlistaTipoCobranca);
       frmLocalPagto1.cbbcombo.ItemIndex       := obterIndiceLista(titulo.FIDLocalPagamento, FSlistaLocalPagamento);
      // frmTipoNF1.cbbTipoNF.ItemIndex              := obterIndiceLista(titulo.FIDNotaFiscalEntrada, FSlistaTipoNF);


    end;


    frameTR1.Enabled := True;

end;

procedure TfrmManterTituloReceber.preencheGridCedntroC;
begin
try
    qryPreencheGridCentroC.Close;
    qryPreencheGridCentroC.Connection := dmConexao.conn;
    qryPreencheGridCentroC.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
    qryPreencheGridCentroC.Open;

 except
 raise Exception.Create('Erro ao consultar a tabela de centro de custos.');

 end;

    dbgridCC.Refresh;

end;



procedure TfrmManterTituloReceber.preencheGridHistorico;
begin
 try
    qryPreencheGridHistorico.Close;
    qryPreencheGridHistorico.Connection := dmConexao.conn;
    qryPreencheGridHistorico.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
    qryPreencheGridHistorico.ParamByName('PTIPO').AsString := 'P';
    qryPreencheGridHistorico.Open;

 except
 raise Exception.Create('Erro ao consultar a tabela de historicos.');

 end;

    dbgridHistorico.Refresh;

end;


procedure TfrmManterTituloReceber.tbBasicaShow(Sender: TObject);
begin

 if tituloReceberModel.Fnovo then begin
   tituloReceberModel.FTipoStatus := TTipoStatusModel.Create;
   tituloReceberModel.FTipoStatus.FIDorganizacao := pIDorganizacao;
   tituloReceberModel.FTipoStatus.FID := 'ABERTO';
 end;
 popularStatus(tituloReceberModel.FTipoStatus);
 msgStatusBar(3,'Aba b�sica.  CTRL + F12 carrega todos os t�tulos da ' + uutil.TOrgAtual.getOrganizacao.FSigla);


end;

procedure TfrmManterTituloReceber.tbComplementoExit(Sender: TObject);
begin
 //setando a complementar no titulo
 tituloReceberModel.FcodigoBarras     := edtCodigoBarras.Text;
 tituloReceberModel.Fcontrato         := edtContrato.Text;
 tituloReceberModel.Fcarteira         := edtCarteira.Text;
 tituloReceberModel.Fobservacao       := edtObervacao.Text;
 tituloReceberModel.FprevisaoCartorio := dtPrevisaoCartorio.DateTime;

end;

 procedure TfrmManterTituloReceber.tbComplementoShow(Sender: TObject);
begin
 popularStatus(tituloReceberModel.FTipoStatus);
 msgStatusBar(3,'Modo de edi��o. Para Salvar retorne a aba b�sica.');
end;

{
procedure TfrmManterTituloReceber.tbNotaFiscalExit(Sender: TObject);
var
notaFiscal :TNotaFiscalEntradaModel;
begin

  notaFiscal :=TNotaFiscalEntradaModel.Create;

  if not uutil.Empty( edtNFNumero.Text ) then begin


  notaFiscal.FIDorganizacao := pIDorganizacao;
  notaFiscal.FID            := dmConexao.obterNewID;
  notaFiscal.FdataRegistro  := Now;
  notaFiscal.Fnovo          := True;

  if not uUtil.Empty(tituloReceberModel.FIDNotaFiscalEmitida) then begin
     notaFiscal.FIDorganizacao  := pIDorganizacao;
     notaFiscal.FID             := tituloReceberModel.FIDNotaFiscalEmitida;
     notaFiscal.FdataRegistro   := tituloReceberModel.FdataRegistro;
       notaFiscal.Fnovo         := False;
    end;

    pIDNotaFiscal := notaFiscal.FID;


    notaFiscal.FIDresponsavel     := tituloReceberModel.FIDResponsavel;
    notaFiscal.FIDtipoNotaFiscal  := pIDTipoNotaFiscal;
    notaFiscal.FIDusuario         := StrToInt(uutil.TUserAtual.getUserId);
    notaFiscal.Fnumero            := edtNFNumero.Text;
    notaFiscal.Fdescricao         := edtNFDescricao.Text;
    notaFiscal.Fobservacao        := edtNFObservacao.Text;
    notaFiscal.Fserie             := edtNFSerie.Text;
    notaFiscal.FsubSerie          := edtNFSubSerie.Text;
    notaFiscal.FaliquotaISS       := edtNFAliquotaISS.Text;
    notaFiscal.FdataRetenncaoISS  := dtNFRetencaoISS.Date;
    notaFiscal.FdataEmissao       := dtNFEmissao.Date;
    notaFiscal.FdataProtocolo     := dtNFProtocolo.Date;
    notaFiscal.Fvalor             := edtValorNF.Value;
    notaFiscal.FvalorISS          := edtValorISS.Value;

    tituloReceberModel.FIDNotaFiscalEmitida := notaFiscal.FID;
  //  tituloReceberModel.FNotaFisca := notaFiscal;

  end;


 popularStatus(tituloReceberModel.FTipoStatus);


end;

}
function TfrmManterTituloReceber.calcularISS(pValue, pAliquota :Currency) :Currency;
begin

 Result := (pValue * pAliquota)/100;

end;
procedure TfrmManterTituloReceber.tbNotaFiscalShow(Sender: TObject);
begin
{dxBtnSave.Enabled := False;
dxBtnEdit.Enabled := False;}
 StatusBotoes(0);

edtNFDescricao.Text   := edtDescricao.Text;
edtBaseCalculo.Value  := edtValorNF.Value;
edtNFAliquotaISS.Text :=  '5';
edtValorISS.Value     :=  (calcularISS( StrToCurr(edtBaseCalculo.Text), StrToFloat(edtNFAliquotaISS.Text) ));


msgStatusBar(3,'Modo de edi��o. Aba nota fiscal. Para Salvar retorne a aba b�sica.');

end;

procedure TfrmManterTituloReceber.tbRateioCentroCustoShow(Sender: TObject);
begin
preencheGridCedntroC;
StatusBotoes(0);
end;

procedure TfrmManterTituloReceber.tbRateioHistoricosShow(Sender: TObject);
begin
 preencheGridHistorico;
 StatusBotoes(0);
end;

procedure TfrmManterTituloReceber.StatusBotoes(value :Integer);
var i :Integer;
ativar : Boolean;
begin
 ativar := True;   /// 1 = ativa e 0 = desativa

 if value = 0 then begin //desativar
   ativar := False;
 end;

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TdxBarLargeButton then
    begin
      (Self.Components[i] as TdxBarLargeButton).Enabled := ativar;
    end;

  end;

  dxBtnLimpar.Enabled := True;
  dxBarBtnSair.Enabled := True;

end;

procedure TfrmManterTituloReceber.dtPagamentoChange(Sender: TObject);
begin
 dtPrevisaoCartorio.Date := IncMonth(dtPagamento.Date, 1);
 tituloReceberModel.FisProvisao := 0;
    dxBtnSave.Enabled := True;
    dxBtnProvisao.Enabled := False;
  dxBtnPagar.Enabled := True;

  tituloReceberModel.FdataVencimento := dtPagamento.Date;

  if (tituloReceberModel.Fnovo) then
  begin
    if (IsToday(dtPagamento.Date) or (dtPagamento.Date < Now)) then
    begin
      Label10.Caption := 'Data pagamento';
      dxBtnPagar.Enabled := True;
      tituloReceberModel.FisProvisao := 0;

    end
    else
    begin
      dxBtnSave.Enabled := False;
      dxBtnProvisao.Enabled := True;
      dxBtnPagar.Enabled := False;

      Label10.Caption := 'Data provis�o';
      tituloReceberModel.FisProvisao := 1;
      tituloReceberModel.FregistroProvisao := tituloReceberModel.FID;

    end;
  end;

end;

procedure TfrmManterTituloReceber.dxBarBtnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterTituloReceber.dxBtnCancelBaixaTPClick(Sender: TObject);
var
  sucesso, permite: Boolean;
  tpModel :TTituloReceberModel;
  trBaixaModel : TTRBaixaModel;
  deducao : TTRBaixaDEModel;
  acrescimo :TTRBaixaACModel;

  formaPagto    : TTRBaixaFPModel;
  pagtoCheque   : TTRBaixaChequeModel;
  pagtoWWW      : TTRBaixaInternetModel;
 // cheque        : TContaBancariaChequeModel;
  creditoCaixa  : TTesourariaCRModel;
  contaDebito   : TContaBancariaCRModel;

  tpbCheques :TFDQuery;
  tpbWWW :TFDQuery;
  tpbFP :TFDQuery;

begin
  sucesso := False;
  permite := True;


  if not uUtil.Empty(edtLoteContabil.Text) then
  begin
    permite := False;
     msg :='O t�tulo j� foi exportado. Primeiro deve remover o lote cont�bil.';
     PempecMsg.MsgInformation(msg);
  end;

  if permite then
  begin
    dmConexao.conectarBanco;

    tituloReceberModel := TTituloReceberModel.Create;
    tituloReceberModel.FID := FSlistaTitulos[frameTR1.cbbTR.ItemIndex];
    tituloReceberModel.FIDorganizacao := pIDorganizacao;
    tituloReceberModel := TTituloReceberDAO.obterPorID(tituloReceberModel);

    if not uUtil.Empty(tituloReceberModel.FID) then
    begin
      if uutil.Empty(tituloReceberModel.FregistroProvisao) then
      begin
        msg :='O t�tulo ser� automaticamente provisionado. Deseja cancelar o recebimento? ';
        if PempecMsg.MsgConfirmation(msg) = 6 then
        begin
          permite := True;
          tituloReceberModel.FregistroProvisao := tituloReceberModel.FID;
          tituloReceberModel.FisProvisao := 1;
        end
        else
        begin
          permite := False;
        end;
      end;
    end;
  end;

 if permite then
  begin
    dmConexao.conectarBanco;

      trBaixaModel                := TTRBaixaModel.Create;
      trBaixaModel.FIDorganizacao := pIDorganizacao;
      trBaixaModel.FIDtituloReceber := tituloReceberModel.FID;
      trBaixaModel := TTRBaixaDAO.obterPorTR(trBaixaModel);

      if not uutil.Empty(trBaixaModel.FID) then begin
            trBaixaModel.FTituloReceber   := tituloReceberModel;
      end;


      if not uutil.Empty(trBaixaModel.FID) then begin

        //deleta AC/DE
        deducao := TTRBaixaDEModel.Create;
        deducao.FIDOrganizacao := pIDorganizacao;
        deducao.FIDtituloReceberBaixa := trBaixaModel.FID;

        TTRBaixaDEDAO.deletePorTRBaixa(deducao);

        acrescimo := TTRBaixaACModel.Create;
        acrescimo.FIDOrganizacao := pIDorganizacao;
        acrescimo.FIDtituloReceberBaixa := trBaixaModel.FID;

        TTRBaixaACDAO.deletePorTRBaixa(acrescimo);

         // buscar os pagamentos realizados em CHEQUE
         //s� deleta se nao tiver deposito
        pagtoCheque                 := TTRBaixaChequeModel.Create;
        pagtoCheque.FIDorganizacao  := pIDorganizacao;
        pagtoCheque.FIDTRBaixa     :=  trBaixaModel.FID;
        pagtoCheque := TTRBaixaChequeDAO.obterPorID(pagtoCheque);

        if not uutil.Empty(pagtoCheque.FID) then begin

           if uutil.Empty(pagtoCheque.FIDloteDeposito) then begin

            permite :=   TTRBaixaChequeDAO.Delete(pagtoCheque);

           end;

        end;

         //pagamentos via internet bank line

        pagtoWWW := TTRBaixaInternetModel.Create; //conta bancaria credito
        pagtoWWW.FIDorganizacao := pIDorganizacao;
        pagtoWWW.FIDTRB := trBaixaModel.FID;

        tpbWWW := TFDQuery.Create(Self);
        tpbWWW := TTRBaixaInternetDAO.obterTodosPorBaixa(pagtoWWW);

         if not tpbWWW.IsEmpty then begin

           FreeAndNil(pagtoWWW);
           tpbWWW.First;
         while not tpbWWW.Eof do begin

            pagtoWWW := TTRBaixaInternetModel.Create; //conta bancaria credito
            pagtoWWW.FIDorganizacao := pIDorganizacao;
            pagtoWWW.FIDTRB := trBaixaModel.FID;
            pagtoWWW.FID := tpbWWW.FieldByName('ID_TIT_RECEBER_BAIXA_INTERNET').AsString;
            pagtoWWW := TTRBaixaInternetDAO.obterPorID(pagtoWWW) ;

            if not uUtil.Empty(pagtoWWW.FID) then begin

               TTRBaixaInternetDAO.Delete(pagtoWWW);

            end;

            tpbWWW.Next;
         end;
            FreeAndNil(tpbWWW);
         end;

        // deletar da CBC por titulo pagar  = TP
        contaDebito := TContaBancariaCRModel.Create;
        contaDebito.FIDorganizacao := pIDorganizacao;
        contaDebito.FIDTR := trBaixaModel.FIDtituloReceber;

        TContaBancariaCreditoDAO.deleteTodosPorTR(contaDebito);

        //deletar da TC pot titulo RECEBER baixa = TRB

        creditoCaixa := TTesourariaCRModel.Create;
        creditoCaixa.FIDorganizacao := pIDorganizacao;
        creditoCaixa.FIDTRB := trBaixaModel.FID;
        TTesourariaCRDAO.deleteTodosPorTRB(creditoCaixa);

        //deletar as formas de pagamento
        formaPagto := TTRBaixaFPModel.Create;
        formaPagto.FIDorganizacao := pIDorganizacao;
        formaPagto.FIDTRBaixa := trBaixaModel.FID;

        if TTRBaixaFPDAO.deleteTodosPorTRB(formaPagto) then
        begin
         //alterar o TR
          tituloReceberModel.FIDTipoStatus := 'ABERTO';
          tituloReceberModel.FdataUltimaAtualizacao := Now;
          tituloReceberModel.FIDUsuario :=  uUtil.TUserAtual.userID;

          if TTituloReceberDAO.Update(tituloReceberModel) then
          begin
           //deletar o TRB
            sucesso := TTRBaixaDAO.Delete(trBaixaModel);

          end;
        end;

      end;

    end;

    if sucesso then
    begin

      msg := 'A baixa do t�tulo foi cancelada com sucesso. ';
      PempecMsg.MsgInformation(msg);
      limparPanel;

    end;

  end;

procedure TfrmManterTituloReceber.dxBtnDeletClick(Sender: TObject);
begin
 if frameTR1.cbbTR.ItemIndex >0  then begin

   if not uutil.Empty(tituloReceberModel.FID) then begin
     try
      tituloReceberModel.FIDTipoStatus := 'EXCLUIDO';
      tituloReceberModel.FdataUltimaAtualizacao := Now;
      tituloReceberModel.Fobservacao := 'TR deletado ' + uUtil.TUserAtual.getNameUser + '  PC ' + uutil.GetComputerNetName  ;

     if (TTituloReceberDAO.Update(tituloReceberModel)) then begin
      msg := 'Titulo deletado com sucesso.';
      PempecMsg.MsgInformation(msg);

     end;
     except
     raise Exception.Create('Erro ao tentar deletar o titulo ' + tituloReceberModel.FnumeroDocumento);
     end;

   end;
 end;

  dxBtnLimparClick(Self);

end;

procedure TfrmManterTituloReceber.dxBtnEditClick(Sender: TObject);
begin
    bloqueiaCampos(Self, True);
    dxBtnSave.Enabled :=True;
end;

procedure TfrmManterTituloReceber.dxBtnEspelhoClick(Sender: TObject);
begin

  try
    formEspelhoTR := TformEspelhoTR.Create(Self, tituloReceberModel);
    formEspelhoTR.ShowModal;
    FreeAndNil(formEspelhoTR);
  except
    on e: Exception do
      PempecMsg.MsgInformation('Ocorreu um erro : ' + e.Message + sLineBreak + ' Contate o suporte. ' );
  end;
end;

procedure TfrmManterTituloReceber.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
limpaRateioHistorico;
limpaRateioCC;
end;

procedure TfrmManterTituloReceber.dxBtnProvisaoClick(Sender: TObject);
var
 sucesso : Boolean;
begin
  sucesso := True;

  if validarForm(Self) then
  begin

    if not uUtil.Empty(tituloReceberModel.FID) then
    begin

      atualizarTitulo;

      try

        sucesso := salvarTitulo(tituloReceberModel);

        tituloReceberModel := TTituloReceberDAO.obterPorID(tituloReceberModel);

        frmTituloReceberParcelado := TFrmTituloReceberParcelado.Create(Self, tituloReceberModel);
        frmTituloReceberParcelado.ShowModal;
        sucesso := frmTituloReceberParcelado.getSucesso;
        FreeAndNil(frmTituloReceberParcelado);

      except
        on e: Exception do
        begin
          sucesso := False;
          ShowMessage(e.Message + sLineBreak + 'Contate o suporte. ');
        end;

      end;

    end;

    //  LimpaTela(Self);
    if sucesso then
       begin

      dxBtnLimpar.Click;

    end;


  end;




end;

procedure TfrmManterTituloReceber.dxBtnPagarClick(Sender: TObject);
 var
 sucesso : Boolean;
 aux : Integer;
begin
  sucesso := False;
  aux :=0;

  if validarForm(Self) then
  begin

    if not uUtil.Empty(tituloReceberModel.FID) then
    begin
     try
        atualizarTitulo;

        if tituloReceberModel.Fnovo then
        begin
          sucesso := TTituloReceberDAO.Insert(tituloReceberModel);
        end;

        if sucesso then
        begin

          frmBaixaTRFP := TfrmBaixaTRFP.Create(Self, tituloReceberModel);
          frmBaixaTRFP.ShowModal;
          FreeAndNil(frmBaixaTRFP);

        end;

      except
        on e: Exception do
        begin
          sucesso := False;
          ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + e.Message);
        end;
      end;

    end;


    if sucesso then
    begin

      dxBtnLimpar.Click;

    end ;


  end;

end;

procedure TfrmManterTituloReceber.dxBtnReciboClick(Sender: TObject);
begin

  try
      frmReciboTR := TfrmReciboTR.Create(Self, tituloReceberModel);
      frmReciboTR.ShowModal;
      FreeAndNil(frmReciboTR);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;

function TfrmManterTituloReceber.createTitulo : Boolean;
 var
hst : THistoricoModel;
sac : TSacadoModel;

begin

  //historico principal
  hst := THistoricoModel.Create;
  //centro de custos principal

  sac  := TSacadoModel.Create;
  //ambos irao fazer parte da lista
   {

  //chaves obrigatorias



  tituloReceberModel.FdataVencimento    := dtPagamento.Date;
  tituloReceberModel.FdataRegistro
  tituloReceberModel.FdataEmissao
  tituloReceberModel.FdataProtocolo
  tituloReceberModel.FdataUltimaAtualizacao
  tituloReceberModel.FprevisaoCartorio
  tituloReceberModel.FdataPagamento
  tituloReceberModel.FvalorNominal  := edtValor.Value;
  tituloReceberModel.FvalorAntecipado

  tituloReceberModel.Fparcela       := edtParcela.Text;
  tituloReceberModel.Fdescricao     := edtDescricao.Text;

  tituloReceberModel.FnumeroDocumento
  tituloReceberModel.FregistroProvisao
   tituloReceberModel.Fmoeda
   tituloReceberModel.Fcarteira
    tituloReceberModel.FcodigoBarras
    tituloReceberModel.Fcontrato
    tituloReceberModel.Fobservacao
                                      }
 //

 //objetos
 {

    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;

    property FSacado: TSacadoModel read getFFSacado write SetFFSacado;
    property FTipoCobranca: TTipoCobrancaModel read getFFTipoCobranca write SetFFTipoCobranca;
    property FResponsavel: TFuncionarioModel read getFFResponsavel write SetFFResponsavel;
    property FLocalPagamento: TLocalPagamentoModel read getFFLocalPagamento write SetFFLocalPagamento;
    property FLoteRecebimento: TLoteRecebimentoModel read getFFLoteRecebimento write SetFFLoteRecebimento;
    property FTipoStatus: TTipoStatusModel read getFFTipoStatus write SetFFTipoStatus;
    property FCentroCustos: TCentroCustoModel read getFFCentroCustos write SetFFCentroCustos;
    property FTituloReceber: TTituloReceberModel read getFFTituloReceber write SetFFTituloReceber;
    property FNotaFiscalEntrada: TNotaFiscalEntradaModel read getFFNotaFiscalEntrada write SetFFNotaFiscalEntrada;
    property FLoteContabil: TLoteContabilModel read getFFLoteContabil write SetFFLoteContabil;
    property FUsuario: TUsuarioModel read getFFUsuario write SetFFUsuario;
    property FCheque: TContaBancariaChequeModel read getFFCheque write SetFFCheque;

     property FHistorico: THistoricoModel read getFFHistorico write SetFFHistorico;


    property listaHistorico   : TObjectList<TTituloReceberHistoricoModel> read FSlistaHistorico  write FSlistaHistorico;
    property listaCustos      : TObjectList<TTituloReceberCentroCustoModel> read FSlistaCustos      write FSlistaCustos;

       }


 //



 //objetos
  hst.FIdOrganizacao := pIDorganizacao;
  hst.FID := tituloReceberModel.FIDHistorico;
  hst := THistoricoDAO.obterPorID(hst);
  tituloReceberModel.FHistorico := hst;

  sac.FIdOrganizacao := pIDorganizacao;
  sac.FID := tituloReceberModel.FIDSacado;
  sac := TSacadoDAO.obterPorID(sac);
  tituloReceberModel.FSacado := sac;


  Result := True;

end;

procedure TfrmManterTituloReceber.atualizarTitulo;
 var
 Value :Integer;
begin
   //  pega os dados do form e seta no titulo
    tituloReceberModel.FIDSacado             := FSlistaSacado[frameSacado1.cbbcombo.ItemIndex];
    tituloReceberModel.FIDHistorico           := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
    tituloReceberModel.FIDCentroCusto         := FSlistaCentroCusto[frameCentroCusto1.cbbcombo.ItemIndex];
    tituloReceberModel.FIDResponsavel         := FSlistaResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
    tituloReceberModel.FIDTipoStatus          := edtStatus.Text;
    tituloReceberModel.FIDUsuario             := StrToInt(uutil.TUserAtual.getUserId);
    tituloReceberModel.FIDorganizacao         := uUtil.TOrgAtual.getId;
    tituloReceberModel.FIDTipoCobranca        := FSlistaTipoCobranca[frmTipoCobranca1.cbbTipoCobranca.ItemIndex];
    tituloReceberModel.FIDLocalPagamento      := FSlistaLocalPagamento[frmLocalPagto1.cbbcombo.ItemIndex] ;
    tituloReceberModel.FdataVencimento        := uUtil.TFormat.proximoDiaUtil(dtPagamento.Date);
    tituloReceberModel.FSacado                := sacadoModel;
    tituloReceberModel.FIDContaContabilCredito  := historicoModel.FIdContaContabil;
    tituloReceberModel.FIDContaContabilDebito   := sacadoModel.FIDcontaContabil ;


    tituloReceberModel.FdataUltimaAtualizacao := Now;
    tituloReceberModel.FdataEmissao           := dtEmissao.Date;
    tituloReceberModel.FdataProtocolo         := dtProtocolo.Date;
    tituloReceberModel.FprevisaoCartorio      := uUtil.TFormat.proximoDiaUtil(dtPrevisaoCartorio.Date);
    tituloReceberModel.Fdescricao             := edtDescricao.Text;
    tituloReceberModel.Fparcela               := edtParcela.Text;
    tituloReceberModel.FvalorNominal          := edtValorMainTP.Value;
    tituloReceberModel.FcodigoBarras          := edtCodigoBarras.Text;
    tituloReceberModel.Fcontrato              := edtContrato.Text;
    tituloReceberModel.Fcarteira              := edtCarteira.Text;
    tituloReceberModel.Fobservacao            := edtObervacao.Text;
    tituloReceberModel.FvalorAntecipado       := edtValorAntecipado.Value;

end;


function TfrmManterTituloReceber.salvarTitulo(titulo :TTituloReceberModel) :Boolean;
var
sucesso :Boolean;
begin
  dmConexao.conectarBanco;
  sucesso := True;

  if not (titulo.Fnovo) then  //j� existe.. ent�o atualiza
  begin
    try
     sucesso := TTituloReceberDAO.Update(titulo);
    except
      sucesso := False;
      raise Exception.Create('Erro ao atualizar o TR');

    end;
  end
  else
  begin
    try
     TTituloReceberDAO.Insert(titulo);
    except
      sucesso := False;
      raise Exception.Create('Erro ao inserir o TR');

    end;

  end;

  Result := sucesso;
end;
procedure TfrmManterTituloReceber.dxBtnSaveClick(Sender: TObject);

begin

  if validarForm(Self) then
  begin
  { if not dmConexao.conn.InTransaction then
          dmConexao.conn.StartTransaction;  }
    try
      //atualizando o titulo com dados do form
         atualizarTitulo;
      if salvarTitulo(tituloReceberModel) then begin
      // if not dmConexao.conn.InTransaction then  dmConexao.conn.CommitRetaining;
         dxBtnLimpar.Click;
      end;

    except
      on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: BTNSALVAR_TR ');
    end;

  end;

end;

procedure TfrmManterTituloReceber.edtCarteiraChange(Sender: TObject);
begin
tituloReceberModel.Fcarteira := edtCarteira.Text;
end;

procedure TfrmManterTituloReceber.edtValorMainTPChange(Sender: TObject);
begin

  edtValorTP.Value := edtValorMainTP.Value;
  edtValorTPCC.Value := edtValorMainTP.Value;
  edtValorNF.Value := edtValorMainTP.Value;
  frameCentroCusto1.cbbcombo.ItemIndex := 0;
  frameHistorico1.cbbcombo.ItemIndex := 0;
  edtHISTConta.Clear;
  edtHISTReduz.Clear;
  edtCodigoHist.Clear;


end;

procedure TfrmManterTituloReceber.edtValorRateioCCChange(Sender: TObject);
begin

if edtValorRateioCC.Value > 0 then begin
btnSelectTCC.Enabled := True;
end;
end;

procedure TfrmManterTituloReceber.edtValorRateioHistChange(Sender: TObject);
begin

if edtValorRateioHist.Value > 0 then begin
btnSelectTHST.Enabled := True;
end;
end;

procedure TfrmManterTituloReceber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  FreeAndNil(tituloReceberModel);
  FreeAndNil(sacadoModel);
  FreeAndNil(historicoModel);
  FreeAndNil(centroCustoModel);
  FreeAndNil(responsavelModel);
  Action := caFree;
end;

procedure TfrmManterTituloReceber.FormCreate(Sender: TObject);
begin
tbNotaFiscal.Enabled := False; //10ativado ate ficar pronta
limparPanel;


end;

procedure TfrmManterTituloReceber.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

 case key of
  vk_f2: dxBtnEdit.Click;
//  vk_f4: dxBtnNew.Click;
  vk_f10: dxBtnSave.Click;
  VK_RETURN : BtnGerarDOC.Click;

  end;


   if ((Shift = [ssCtrl]) and (Key = VK_F12)) then begin
       frameTR1.obterTodos(pIDorganizacao, frameTR1.cbbTR, FSlistaTitulos);
   end;



  end;

procedure TfrmManterTituloReceber.popularSacado(cedente :TSacadoModel);
var
vctoCartao : string;
diaHoje, diaCompra, diaVcto : Integer;

begin
 dxBtnPagar.Enabled := True;
 dxBtnProvisao.Enabled := False;

 if tituloReceberModel.Fnovo then begin
  dtPagamento.Date :=  uUtil.TFormat.proximoDiaUtil(Now);
 end;


  if not uUtil.Empty(cedente.FID) then
  begin
      sacadoModel := TSacadoDAO.obterPorID(cedente);

    if not uutil.Empty(cedente.FcontaContabil.FID) then
    begin


       tituloReceberModel.FIDSacado := sacadoModel.FID;
       tituloReceberModel.FSacado   := sacadoModel;
       tituloReceberModel.FIDContaContabilDebito := sacadoModel.FIDcontaContabil;

      edtCEDConta.Text := sacadoModel.FcontaContabil.Fconta;
      edtCEDReduz.Text := sacadoModel.FcontaContabil.FcodigoReduzido;

      dxBtnPagar.Enabled :=True;


    end
    else
    begin
      edtCEDConta.Text := 'NC';
      edtCEDReduz.Text := 'NC';
    end;

  end;

end;

procedure TfrmManterTituloReceber.popularCentroCusto( centroCusto: TCentroCustoModel);
begin
    centroCustoModel                := TCentroCustoModel.Create;
    centroCustoModel.FIDorganizacao := centroCusto.FIDorganizacao;
    centroCustoModel.FID            := centroCusto.FID;
    centroCustoModel                := TCentroCustoDAO.obterPorID(centroCusto);

  if not uUtil.Empty(centroCustoModel.FID) then
  begin

    frameCentroCusto1.cbbcombo.ItemIndex := obterIndiceLista(centroCustoModel.FID,FSlistaCentroCusto );

  end;

end;

procedure TfrmManterTituloReceber.popularHistorico(historico: THistoricoModel);
begin
    historicoModel                 := THistoricoModel.Create;
    historicoModel.FIDorganizacao := historico.FIDorganizacao;
    historicoModel.FID            := historico.FID;
    historicoModel                := THistoricoDAO.obterPorID(historico);

  if not uUtil.Empty(historicoModel.FID) then
  begin
    if not uutil.Empty(historicoModel.FcontaContabil.FID) then
    begin

      edtHISTConta.Text   := historicoModel.FcontaContabil.Fconta;
      edtHISTReduz.Text   := historicoModel.FcontaContabil.FcodigoReduzido;
      edtCodigoHist.Text  := IntToStr(historicoModel.FCodigo);

      tituloReceberModel.FIDContaContabilCredito := historicoModel.FIdContaContabil;


    end
    else
    begin
      edtHISTConta.Text := 'NC';
      edtHISTReduz.Text := 'NC';
      msgStatusBar(1, 'Verifique a conta cont�bil do hist�rico');
      dxBtnSave.Enabled := False;
    end;

  end;




end;


procedure TfrmManterTituloReceber.popularResponsavel(responsavel: TFuncionarioModel);
begin
    responsavelModel                := TFuncionarioModel.Create;
    responsavelModel.FIDorganizacao := responsavel.FIDorganizacao;
    responsavelModel.FID            := responsavel.FID;
    responsavelModel                := TFuncionarioDAO.obterPorID(responsavel);

  end;

procedure TfrmManterTituloReceber.popularStatus(status: TTipoStatusModel);

begin

   StatusBotoes(0);

    statusModel                     := TTipoStatusModel.Create;
    statusModel.FIDorganizacao      := status.FIDorganizacao;
    statusModel.FID                 := status.FID;
    statusModel                     := TTipoStatusDAO.obterPorID(status);

    if status.FID.Equals('ABERTO') then begin

            dxBtnPagar.Enabled      := True;
            dxBtnEdit.Enabled       := True;
            dxBtnSave.Enabled      := True;
            dxBtnDelet.Enabled      := True;
            dxBtnEspelho.Enabled    := True;
            dxBtnRecibo.Enabled     := False; //N�o permite emitir recibo com TP aberto

    end;


    if (status.FID.Equals('QUITADO')) then begin

            dxBtnEspelho.Enabled        := True;
            dxBtnRecibo.Enabled         := True;
            dxBtnCancelBaixaTP.Enabled  := True;
    end;

      if (status.FID.Equals('PARCIAL')) then begin

            dxBtnEspelho.Enabled        := True;
            dxBtnRecibo.Enabled         := True;
            dxBtnCancelBaixaTP.Enabled  := True;


    end;



  if status.FID.Equals('EXCLUIDO') then
  begin
    StatusBotoes(0);
  end;




end;

procedure TfrmManterTituloReceber.frameSacado1cbbcomboChange(Sender: TObject);

begin

if frameSacado1.cbbcombo.ItemIndex > 0 then begin

  sacadoModel                := TSacadoModel.Create;
  sacadoModel.FID            := FSlistaSacado[frameSacado1.cbbcombo.ItemIndex];
  sacadoModel.FIDorganizacao := pIDorganizacao;
  sacadoModel := TSacadoDAO.obterPorID(sacadoModel);

  popularSacado(sacadoModel);

 end ;

end;

procedure TfrmManterTituloReceber.frameCentroCusto1cbbcomboChange( Sender: TObject);
var
rateioCC : TTituloReceberCentroCustoModel;
I :Integer;

begin
dmConexao.conectarBanco;
 limpaRateioCC;

 if edtValorMainTP.Value = 0 then begin
    frameCentroCusto1.cbbcombo.ItemIndex :=0;
    msg :='O valor do t�tulo n�o pode ser 0 ';
    PempecMsg.MsgInformation(msg);


 end;

  if frameCentroCusto1.cbbcombo.ItemIndex > 0 then
  begin

   centroCustoModel                 := TCentroCustoModel.Create;
   centroCustoModel.FID             := FSlistaCentroCusto[frameCentroCusto1.cbbcombo.ItemIndex];
   centroCustoModel.FIDorganizacao  := pIDorganizacao;
   popularCentroCusto(centroCustoModel);

    rateioCC := TTituloReceberCentroCustoModel.Create;
    rateioCC.FIDorganizacao := pIDorganizacao;
    rateioCC.FID := dmConexao.obterNewID;
    rateioCC.FIDCentroCusto := centroCustoModel.FID;
    rateioCC.FIDTR := tituloReceberModel.FID;
    rateioCC.Fvalor := edtValorMainTP.Value;
    rateioCC.FCentroCusto := centroCustoModel;

    tituloReceberModel.listaCustos.Clear; //zera todos os historicos existentes.. tem que refazer o rateio
    tituloReceberModel.AdicionarCC(rateioCC);
    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([centroCustoModel.FDescricao, edtValorMainTP.Value]);
  end
  else
  begin

    msg := 'Selecione um centro de custos. ';
    PempecMsg.MsgInformation(msg);

  end;
  atualizarRateio('C');
end;

procedure TfrmManterTituloReceber.frameHistorico1cbbcomboChange(Sender: TObject);
var
rateioHistorico : TTituloReceberHistoricoModel;
hstValidado : Boolean;
I,J :Integer;
begin
   dmConexao.conectarBanco;
   hstValidado := False;
   limpaRateioHistorico; //sempre limpa a lista

  if edtValorMainTP.Value = 0 then
  begin
    frameHistorico1.cbbcombo.ItemIndex := 0;
    msg := 'O valor do t�tulo n�o pode ser 0 ';
    PempecMsg.MsgInformation(msg);

  end
  else
  begin
    if frameHistorico1.cbbcombo.ItemIndex >0 then begin

      historicoModel                := THistoricoModel.Create;
      historicoModel.FID            := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
      historicoModel.FIDorganizacao := pIDorganizacao;
      popularHistorico(historicoModel);

      rateioHistorico                         := TTituloReceberHistoricoModel.Create;
      rateioHistorico.FID                     := dmConexao.obterNewID;
      rateioHistorico.FIDorganizacao          := pIDorganizacao;
      rateioHistorico.FIDHistorico            := historicoModel.FID;
      rateioHistorico.FIDContaContabilDebito  := historicoModel.FIdContaContabil;
      rateioHistorico.FIDTR                   := tituloReceberModel.FID;
      rateioHistorico.Fvalor                  := edtValorMainTP.Value; //valor total do TP

      tituloReceberModel.listaHistorico.Clear; //zera todos os historicos existentes.. tem que refazer o rateio
      tituloReceberModel.AdicionarHST(rateioHistorico);

      fdmHistorico.Open;
      fdmHistorico.InsertRecord([historicoModel.FDescricao, edtValorMainTP.Value]);


    end;

 end;

  atualizarRateio('H');
end;

procedure TfrmManterTituloReceber.frameHistorico2cbbcomboChange(Sender: TObject);
begin


  if frameHistorico2.cbbcombo.ItemIndex > 0 then
  begin

    edtValorRateioHist.Enabled := True;
  end
  else
  begin
    edtValorRateioHist.Enabled := False;
  end;


end;

procedure TfrmManterTituloReceber.frameResponsavel1cbbcomboChange(  Sender: TObject);
begin

if frameResponsavel1.cbbcombo.ItemIndex >0 then begin

  responsavelModel                := TFuncionarioModel.Create;
  responsavelModel.FID            := FSlistaResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
  responsavelModel.FIDorganizacao := pIDorganizacao;
  popularResponsavel(responsavelModel);

  end
  else
  begin
    msg := 'Selecione um respons�vel. ';
    PempecMsg.MsgInformation(msg);
  end;

end;


procedure TfrmManterTituloReceber.bloqueiaCampos(Form :TForm; status :Boolean);
var
i :Integer;
begin

  for i := 0 to Form.ComponentCount - 1 do
  begin

      if Form.Components[i] is TCustomEdit then
      begin
        (Form.Components[i] as TCustomEdit).Enabled := status;
      end;

       if Form.Components[i] is TButton then
      begin
        (Form.Components[i] as TButton).Enabled := status;
      end;


       if Form.Components[i] is TFrame then
      begin
        (Form.Components[i] as TFrame).Enabled := status;
      end;

      if Form.Components[i] is TEdit then
      begin
        TEdit(Form.Components[i]).Enabled := status;
      end;


      if Form.Components[i] is TComboBox then
      begin

        TComboBox(Form.Components[i]).Enabled := status;
      end;


      if Form.Components[i] is TDateTimePicker then
      begin
        TDateTimePicker(Form.Components[i]).Enabled := status;
      end;


  end;

end;

procedure TfrmManterTituloReceber.frameTP1cbbTPExit(Sender: TObject);
begin
 // limparPanel;

  limpaRateioHistorico;
  limpaRateioCC;
  StatusBotoes(0);
  tituloReceberModel := TTituloReceberModel.Create;
  BtnGerarDOC.Enabled := True;


 if frameTR1.cbbTR.ItemIndex >0 then begin
   //verifica se tem lotes (contabil e pagametno)
   //titulo veio da consulta
    bloqueiaCampos(Self, False); //seta False na propriedade enabled do componente

   tituloReceberModel.FID := FSlistaTitulos[frameTR1.cbbTR.ItemIndex];
   tituloReceberModel.FIDorganizacao := pIDorganizacao;
   tituloReceberModel := TTituloReceberDAO.obterPorID(tituloReceberModel);

    if not uutil.Empty(tituloReceberModel.FID) then
    begin

      tituloReceberModel.Fnovo := False;
      preencheAbaBasica(tituloReceberModel);
      preencheDatas(tituloReceberModel);
      preencheAbaComplementar(tituloReceberModel);
      carregarCombos(tituloReceberModel); //carrega com o objeto que vem do BD
      popularSacado(tituloReceberModel.FSacado);
      popularHistorico(tituloReceberModel.FHistorico);
      preencheAbaRateioHistorico(tituloReceberModel.listaHistorico);
//      preencheAbaNotaFiscal(tituloReceberModel.FNotaFiscalEntrada);
      preencheAbaRateioCC(tituloReceberModel.listaCustos);
      popularCentroCusto(tituloReceberModel.FCentroCustos);
      popularResponsavel(tituloReceberModel.FResponsavel);
      popularStatus(tituloReceberModel.FTipoStatus); //libera os botoes

      msgStatusBar(3, 'Para liberar os campos, clique em Editar.');

    end else
    begin
      FreeAndNil(tituloReceberModel) ;
      msg := 'N�o foi poss�vel localiar o titulo. ';
      PempecMsg.MsgInformation(msg );
    end; 
    BtnGerarDOC.Caption := 'Consultar';
 end;

  msgStatusBar(2, 'ATENC�O:' );
  msgStatusBar(3, 'CTRL + F12 carrega todos os t�tulos ' );


end;

procedure TfrmManterTituloReceber.frameTR1cbbTRChange(Sender: TObject);
begin
 limpaRateioHistorico;
 limpaRateioCC;

 modo :=0; //modo de consulta

 if modo = 0  then begin
    BtnGerarDOC.Caption := 'Consultar';
    BtnGerarDOC.Enabled := True;
  end;

end;

procedure TfrmManterTituloReceber.frameTR1cbbTRExit(Sender: TObject);
begin
// limparPanel;
  limpaRateioHistorico;
  limpaRateioCC;
  StatusBotoes(0);
  tituloReceberModel := TTituloReceberModel.Create;
  BtnGerarDOC.Enabled := True;


 if frameTR1.cbbTR.ItemIndex >0 then begin
   //verifica se tem lotes (contabil e pagametno)
   //titulo veio da consulta
    bloqueiaCampos(Self, False); //seta False na propriedade enabled do componente

   tituloReceberModel.FID := FSlistaTitulos[frameTR1.cbbTR.ItemIndex];
   tituloReceberModel.FIDorganizacao := pIDorganizacao;
   tituloReceberModel := TTituloReceberDAO.obterPorID(tituloReceberModel);

    if not uutil.Empty(tituloReceberModel.FID) then
    begin

      tituloReceberModel.Fnovo := False;
      preencheAbaBasica(tituloReceberModel);
      preencheDatas(tituloReceberModel);
      preencheAbaComplementar(tituloReceberModel);
      carregarCombos(tituloReceberModel); //carrega com o objeto que vem do BD
      popularSacado(tituloReceberModel.FSacado);
      popularHistorico(tituloReceberModel.FHistorico);
      preencheAbaRateioHistorico(tituloReceberModel.listaHistorico);
//      preencheAbaNotaFiscal(tituloReceberModel.FNotaFiscalEntrada);
      preencheAbaRateioCC(tituloReceberModel.listaCustos);
      popularCentroCusto(tituloReceberModel.FCentroCustos);
      popularResponsavel(tituloReceberModel.FResponsavel);
      popularStatus(tituloReceberModel.FTipoStatus); //libera os botoes

      msgStatusBar(3, 'Para liberar os campos, clique em Editar.');

    end else
    begin
      FreeAndNil(tituloReceberModel);
      msg := 'N�o foi poss�vel localiar o titulo. ';
      PempecMsg.MsgInformation(msg );
    end;
    BtnGerarDOC.Caption := 'Consultar';
 end;

  msgStatusBar(2, 'TODOS :' );
  msgStatusBar(3, 'CTRL + F12 carrega todos os t�tulos ' );


end;

procedure TfrmManterTituloReceber.frmTipoNF1cbbTipoNFChange(Sender: TObject);
begin
  if frmTipoNF1.cbbTipoNF.ItemIndex > 0 then
  begin

    pIDTipoNotaFiscal := FSlistaTipoNF[frmTipoNF1.cbbTipoNF.ItemIndex];

  end;
end;

procedure TfrmManterTituloReceber.preencheAbaComplementar(titulo : TTituloReceberModel);
begin
 edtUltimoUpdate.Text     := DateToStr(titulo.FdataUltimaAtualizacao);
 dtPrevisaoCartorio.Date  := (titulo.FprevisaoCartorio);
 edtCodigoBarras.Text     := titulo.FcodigoBarras;
 edtContrato.Text         := titulo.Fcontrato;
 edtCarteira.Text         := titulo.Fcarteira;
 edtObervacao.Text        := titulo.Fobservacao;

end;

procedure TfrmManterTituloReceber.preencheAbaBasica(titulo : TTituloReceberModel);
var
loteCC : TLoteContabilModel;

begin
   loteCC := TLoteContabilModel.Create;
   edtLoteContabil.Clear;

   loteCC := obterLoteContabil(titulo.FLoteContabil);
  // lotePP := obterLoteRecebimento(titulo.FLoteRecebimento);

   if not uutil.Empty(loteCC.FID) then begin
     edtLoteContabil.Text   := 'DATA '+ DateToStr(titulo.FLoteContabil.FdataRegistro) + ' LOTE :' + titulo.FLoteContabil.Flote;
   end;

 {  if not uutil.Empty(lotePP.FID) then begin
     edtLoteRecebimento.Text   :=  titulo.FLoteRecebimento.Flote;
   end;    }

   edtValorMainTP.Value     := titulo.FvalorNominal;
   edtValorAntecipado.Value := titulo.FvalorAntecipado;
   edtParcela.Text          := titulo.Fparcela;
   edtStatus.Text           := titulo.FTipoStatus.Fdescricao;
   edtDescricao.Text        := titulo.Fdescricao;
   edtProvisao.Text         := titulo.FregistroProvisao;


   if not (titulo.FIDTipoStatus = 'ABERTO') then begin
   if not uutil.Empty(loteCC.FID) then begin
     edtLoteContabil.Text   := 'DATA '+ DateToStr(titulo.FLoteContabil.FdataRegistro) + ' LOTE :' + titulo.FLoteContabil.Flote;
   end;
   end;

   FreeAndNil(loteCC);

end;

procedure TfrmManterTituloReceber.preencheDatas(titulo : TTituloReceberModel);
begin
  bloqueiaCampos(Self, true);

   Label10.Caption := 'Data pagamento';
   dtPagamento.DateTime     := titulo.FdataPagamento;
   dtEmissao.DateTime       := titulo.FdataEmissao;
   dtProtocolo.DateTime     := titulo.FdataProtocolo;
   dtPrevisaoCartorio.DateTime := titulo.FprevisaoCartorio;
   edtUltimoUpdate.Text        := DateToStr(titulo.FdataUltimaAtualizacao);

   if titulo.FIDTipoStatus.Equals('ABERTO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := titulo.FdataVencimento;
    dxBtnPagar.Enabled := True;
   end;
    if titulo.FIDTipoStatus.Equals('EXCLUIDO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := titulo.FdataVencimento;
   end;

     bloqueiaCampos(Self, False);

end;

procedure TfrmManterTituloReceber.preencheAbaRateioCC(listaCC :TObjectList<TTituloReceberCentroCustoModel>);
 var
I :Integer;
centroCusto : TCentroCustoModel;
TPCCModel : TTituloReceberCentroCustoModel;
begin

  for I := 0 to listaCC.Count - 1 do
  begin

    TPCCModel := TTituloReceberCentroCustoModel.Create;
    TPCCModel := TTituloReceberCentroCustoModel(listaCC[I]);
    TPCCModel := TTituloReceberCentroCustoDAO.obterPorID(TPCCModel);

    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([TPCCModel.FCentroCusto.FDescricao, TPCCModel.Fvalor]);

  end;

  atualizarRateio('C');


end;

procedure TfrmManterTituloReceber.limpaAbaNF;
begin

   edtNFObservacao.Clear;
   edtNFNumero.Clear;
   edtNFDescricao.Clear;
   edtNFAliquotaISS.Clear;
   edtNFSerie.Clear;
   edtNFSubSerie.Clear;
   dtNFEmissao.Date := Now;
   dtNFProtocolo.Date := Now;
   dtNFRetencaoISS.Date :=Now;
   edtValorNF.Value           := 0;
   edtBaseCalculo.Value     := 0;
   edtValorISS.Value        := 0;

   pIDTipoNotaFiscal := '';
   pIDNotaFiscal := '';

end;

procedure TfrmManterTituloReceber.preencheAbaRateioHistorico(listaH :TObjectList<TTituloReceberHistoricoModel>);
var
  I: Integer;
  historico: THistoricoModel;
  TPHModel: TTituloReceberHistoricoModel;
begin

  for I := 0 to listaH.Count - 1 do
  begin

    TPHModel := TTituloReceberHistoricoModel.Create;
    TPHModel := TTituloReceberHistoricoModel(listaH[I]);
    TPHModel := TTituloReceberHistoricoDAO.obterPorID(TPHModel);

    fdmHistorico.Open;
    fdmHistorico.InsertRecord([TPHModel.FHistorico.FDescricao, TPHModel.Fvalor]);

  end;

  atualizarRateio('H');

end;


procedure TfrmManterTituloReceber.limparPanel;
begin
  modo :=1;//modo de titulo novo. altera quando clica no combo de TP para pesquisar TP existente
  retiraOrdemCampo(Self);
  bloqueiaCampos(Self, True);

  dxBtnSave.Caption := 'Salvar';
  BtnGerarDOC.Caption := 'Gerar';
  dxBtnPagar.Enabled := True;
 // LimpaTela(Self); dando erro

 limpaStatusBar;

 if Assigned(tituloReceberModel) then begin FreeAndNil(tituloReceberModel); end;

 tituloReceberModel := TTituloReceberModel.Create;
 BtnGerarDOC.Enabled := True;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

 carregarCombos(tituloReceberModel);


  pgTitulo.ActivePageIndex :=0;
  btnSelectTHST.Enabled := False; //tb rateio historico
  edtValorRateioHist.Enabled := False; //tb rateio historico
  btnSelectTCC.Enabled := False; //tb rateio CC
  edtValorRateioCC.Enabled := False; //tb rateio CC

  LimpaTela(Self);


  msgStatusBar(2, 'ATENC�O :' );
  msgStatusBar(3, 'CTRL + F12 carrega todos os t�tulos ' );


end;

procedure TfrmManterTituloReceber.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

//dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfrmManterTituloReceber.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;

function TfrmManterTituloReceber.obterIndiceLista(pId: string;  lista: TStringList): Integer;
var
  I: Integer;
begin
 Result :=0;

  for I := 0 to lista.Count-1 do begin
    if(lista[I].Equals(pId)) then begin
       Result := I;
       Break;
    end;

  end;

end;

function TfrmManterTituloReceber.obterLoteContabil( value: TLoteContabilModel): TLoteContabilModel;
var
lote :TLoteContabilModel;
begin
 lote := TLoteContabilModel.Create;

 try

   lote := TLoteContabilDAO.obterPorID(value);

 except
 on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );
 end;
 Result := lote;
end;


procedure TfrmManterTituloReceber.retiraOrdemCampo(Form: TForm);
var
  I: Integer;
begin
  for I := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[I].ClassType = TEdit then
      if not (TEdit(Form.Components[I]).Enabled) then
      begin
        TEdit(Form.Components[I]).TabOrder := 1000 ;
      end;
  end;
end;

function TfrmManterTituloReceber.validarForm(Form :TForm ) : Boolean;
var
I :Integer;
begin
  Result := True;
  bloqueiaCampos(Self, True);

  for I := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[I].ClassType = TEdit then
      if (TEdit(Form.Components[I]).Text = '') and (TEdit(Form.Components[I]).Tag = 1) then
      begin
        Result := False;
        TEdit(Components[I]).Enabled := True;
        TEdit(Components[I]).Visible := True;
        TEdit(Components[I]).SetFocus;
        TEdit(Form.Components[I]).TextHint := 'Campo Obrigat�rio';

      end;


  end;

  if frameSacado1.cbbcombo.ItemIndex > 0  then begin
       if uutil.Empty( sacadoModel.FIDcontaContabil ) then
        Result := False;
        frameSacado1.cbbcombo.Enabled := True;
        frameSacado1.cbbcombo.SetFocus;
  end;


  if frameSacado1.cbbcombo.ItemIndex < 1 then begin

        Result := False;
        frameSacado1.cbbcombo.Enabled := True;
        frameSacado1.cbbcombo.SetFocus;
  end;

  if frameHistorico1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frameHistorico1.cbbcombo.Enabled := True;
        frameHistorico1.cbbcombo.SetFocus;
  end;

   if frameCentroCusto1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frameCentroCusto1.cbbcombo.Enabled := True;
        frameCentroCusto1.cbbcombo.SetFocus;
  end;

   if frameResponsavel1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frameResponsavel1.cbbcombo.Enabled := True;
        frameResponsavel1.cbbcombo.SetFocus;
  end;

  if frmTipoCobranca1.cbbTipoCobranca.ItemIndex < 1 then begin
        Result := False;
        frmTipoCobranca1.cbbTipoCobranca.Enabled := True;
        frmTipoCobranca1.cbbTipoCobranca.SetFocus;
  end;

   if frmLocalPagto1.cbbcombo.ItemIndex < 1 then begin
        Result := False;
        frmLocalPagto1.cbbcombo.Enabled := True;
        frmLocalPagto1.cbbcombo.SetFocus;
  end;

  if edtCEDConta.Text = 'NC' then
  begin

    msgStatusBar(1, 'Verifique a conta cont�bil do sacado/cliente.');
    frameSacado1.cbbcombo.Enabled := True;
    frameSacado1.cbbcombo.SetFocus;
   // PempecMsg.MsgInformation('Cliente sem conta cont�bil. Favor corrigir o problema. ', mtInformation, [mbOK], 0);
    msg :='Cliente sem conta cont�bil. Favor corrigir o problema. ';
    PempecMsg.MsgInformation(msg);

   // StatusBotoes(0);
   // bloqueiaCampos(Self, False);
    Result := False;
  end;

  if edtValorMainTP.Value = 0  then begin
        Result := False;
        edtValorMainTP.Enabled := True;
        edtValorMainTP.SetFocus;
      msg :='O valor do t�tulo n�o pode ser 0 (zero) ';
      PempecMsg.MsgInformation(msg);
  end;



end;




end.



