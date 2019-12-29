unit uFrmReciboTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel,
  uFrameContaContabil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg, uFrameBanco, ENumEd, frxClass,
  frxDBSet, EExtenso;

type
  TfrmReciboTP = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrd1: TDBGrid;
    dxBarManager1Bar3: TdxBar;
    dxBtnFechar: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    cxbrdtmPesquisa: TcxBarEditItem;
    msgDlg: TEvMsgDlg;
    dsGrid: TDataSource;
    qryPreencheGrid: TFDQuery;
    dxBtnImprime: TdxBarLargeButton;
    dxBarManager1Bar1: TdxBar;
    dxBtnImpimir: TdxBarLargeButton;
    frxReportRecibo: TfrxReport;
    frxDBRecibo: TfrxDBDataset;
    qryObterDados: TFDQuery;
    qryObterIDTPB: TFDQuery;
    qryBaixaTPCaixa: TFDQuery;
    qryBaixaTPCheque: TFDQuery;
    qryObterTPBBanco: TFDQuery;
    qryTPBAcrescimos: TFDQuery;
    qryTPBDeducao: TFDQuery;
    extenso: TEvExtenso;
    frxDBTPQuitados: TfrxDBDataset;
    frxDBTPB: TfrxDBDataset;
    frxTPBAcrescimo: TfrxDBDataset;
    frxTPBDeducao: TfrxDBDataset;
    frxDBTPBCaixa: TfrxDBDataset;
    frxTPBCheque: TfrxDBDataset;
    frxTPBBanco: TfrxDBDataset;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dsGridDataChange(Sender: TObject; Field: TField);
    procedure dxBtnImpimirClick(Sender: TObject);
  private
    { Private declarations }
   pIdValue,  pIdOrganizacao, pIdUsuario :string;
 validate, vlrExtenso,  pTable, pIdTable :string;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure LimpaTela(Form: TForm);
    procedure controleEdit(Form: TForm; pValue: Boolean);
    function obterIDTPB(pIdOrganizacao, pIdtituloPagar: String): string;
    function obterTPBAC(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBBanco(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCheque(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBDE(pIdOrganizacao, pIdTPB: String): Boolean;
    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);

  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao :string);
    function obterDadosRecibo(pIdOrganizaco, pIdTitulo :string) : Boolean;



  end;

var
  frmReciboTP: TfrmReciboTP;

implementation

{$R *.dfm}

procedure TfrmReciboTP.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('DOC',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmReciboTP.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;
procedure TfrmReciboTP.dsGridDataChange(Sender: TObject; Field: TField);
var
tituloTPB :string;
begin
      cxbrdtmPesquisa.Enabled := True;
      dxBtnImpimir.Enabled := True;

   pIdValue := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_TITULO_PAGAR').AsString;



        if obterDadosRecibo(pIdOrganizacao, pIdValue) then
        begin
           vlrExtenso := UpperCase(extenso.GetExtenso(qryObterDados.FieldByName('VALOR_PAGO').AsCurrency));
           validate := 'tp'+ pIdValue;
          tituloTPB := obterIDTPB(pIdOrganizacao, pIdValue);

          if not uUtil.Empty(tituloTPB) then
          begin


        // talvez nao precise obterTPBaixaPorTitulo(pRegistroProvisao, idOrganizacao, tituloPagarQuitado);

            // baixa POR TEsouraria
            obterTPBCaixa(pIdOrganizacao, tituloTPB);
            //obter por Cheque
            obterTPBCheque(pIdOrganizacao, tituloTPB);
            // obter baixa por Banco
            obterTPBBanco(pIdOrganizacao, tituloTPB);
            // dts acrescimo
            obterTPBAC(pIdOrganizacao, tituloTPB);
            // dts deducao
            obterTPBDE(pIdOrganizacao, tituloTPB);
          end;

        end;


end;



procedure TfrmReciboTP.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;



procedure TfrmReciboTP.dxBtnImpimirClick(Sender: TObject);
begin

   if not uutil.Empty(pIdValue) then begin
       exibirRelatorio(1);
    end;


end;

procedure TfrmReciboTP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmReciboTP.FormCreate(Sender: TObject);
begin
 pTable := 'TITULO_PAGAR';
 Self.Caption := pTable;
 dxRibbon1Tab1.Caption := 'Emiss�o de recibos';

 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmReciboTP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f3: dxBtnImpimir.Click;
end;

end;

procedure TfrmReciboTP.freeAndNilDM(Sender: TObject);
begin

//nada
end;


procedure TfrmReciboTP.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;


end;

procedure TfrmReciboTP.limparPanel();
var
  I: Integer;
begin
 limpaStatusBar;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;
// frmPeriodo1.inicializa(IncDay(Now, -1), Now);

 //botao editar muda
  dbgrd1.Enabled :=True;


 // LimpaTela(Self);

  //botao novo
   cxbrdtmPesquisa.Enabled := True;
   preencheGrid(pIdOrganizacao);
   dxBtnImpimir.Enabled :=False;


end;

procedure TfrmReciboTP.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

function TfrmReciboTP.obterDadosRecibo(pIdOrganizaco,  pIdTitulo: string): Boolean;
  begin

dmConexao.conectarBanco;
try
 qryObterDados.Close;
 qryObterDados.Connection := dmConexao.conn;
 qryObterDados.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizaco;
 qryObterDados.ParamByName('PID').AsString := pIdTitulo;
 qryObterDados.Open;

except
raise Exception.Create('Erro ao obter dados do titulo..'  );

end;

Result := not qryObterDados.IsEmpty;

end;

procedure TfrmReciboTP.preencheGrid(pIdOrganizacao: string);
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try

    sqlCmd := ' SELECT TP.ID_TITULO_PAGAR, ' +
              ' TP.NUMERO_DOCUMENTO AS DOC,       ' +
              ' TP.ID_ORGANIZACAO,'  +
              ' (H.descricao || '' '' ||  TP.DESCRICAO) AS DESCRICAO,' +
              ' TPB.VALOR_PAGO, TP.ID_CEDENTE,' +
              ' TP.data_pagamento, C.nome AS FORNECEDOR, TP.PARCELA' +
              ' FROM TITULO_PAGAR TP' +
              ' LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.id_titulo_pagar = TP.id_titulo_pagar) AND (TPB.id_organizacao = TP.id_organizacao) '+
              ' LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AND (C.id_organizacao = TP.id_organizacao)' +
              ' LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_historico) AND (H.id_organizacao = TP.id_organizacao)' +
              ' WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO ) ' +
              ' AND  ( TP.ID_TIPO_STATUS IN (''PARCIAL'', ''QUITADO'') )' +
              ' ORDER BY TP.DATA_EMISSAO DESC, TP.VALOR_NOMINAL DESC ';


    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;

 except
 raise Exception.Create('Erro ao obter lista...' + pTable);

 end;


end;

procedure TfrmReciboTP.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F3] = Imprime ';
end;

procedure TfrmReciboTP.LimpaTela(Form: TForm);
var
  i: Integer;
begin

  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TCustomEdit then
    begin
      (Form.Components[i] as TCustomEdit).Clear;
    end;

    if Form.Components[i] is TLabel then
    begin
      TLabel(Form.Components[i]).Caption := '';
    end;

    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Clear;
    end;

    if Form.Components[i] is TEvNumEdit then
    begin
      TEvNumEdit(Form.Components[i]).Clear ;
    end;

    if Form.Components[i] is TComboBox then
    begin
      TComboBox(Form.Components[i]).Clear ;
      TComboBox(Form.Components[i]).ItemIndex := 0;
    end;



   end;
end;

procedure TfrmReciboTP.controleEdit(Form: TForm; pValue :Boolean);
var
i: Integer;
begin

 for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TCustomEdit then
    begin
      (Form.Components[i] as TCustomEdit).Enabled :=pValue;
    end;

    if Form.Components[i] is TLabel then
    begin
      TLabel(Form.Components[i]).Enabled :=pValue;
    end;

    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Enabled :=pValue;
    end;

    if Form.Components[i] is TEvNumEdit then
    begin
      TEvNumEdit(Form.Components[i]).Enabled :=pValue;
    end;

    if Form.Components[i] is TComboBox then
    begin
      TComboBox(Form.Components[i]).Enabled :=pValue;
    end;

   end;


end;



function TfrmReciboTP.obterIDTPB(pIdOrganizacao, pIdtituloPagar: String): string;
var
idTPB : string;
begin
  idTPB :='';
 Result := '';
 dmConexao.conectarBanco;

  qryObterIDTPB.Close;
  qryObterIDTPB.Connection := dmConexao.Conn;

  qryObterIDTPB.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
  qryObterIDTPB.ParamByName('pIdtituloPagar').AsString :=  pIdtituloPagar;
  qryObterIDTPB.Open;

   if not qryObterIDTPB.IsEmpty then
          idTPB := qryObterIDTPB.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;


  Result := idTPB;

end;


function TfrmReciboTP.obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
begin
  Result := false;
  //obtem os TP pago pela tesouraria

 dmConexao.conectarBanco;


  qryBaixaTPCaixa.Close;
  qryBaixaTPCaixa.Connection := dmConexao.Conn;
  qryBaixaTPCaixa.ParamByName('PIDORGANIZACAO').AsString :=
    pIdOrganizacao;
  qryBaixaTPCaixa.ParamByName('PIDTITULOPAGARBAIXA').AsString :=
    pIdTPB;
  qryBaixaTPCaixa.Open;

  Result := not qryBaixaTPCaixa.IsEmpty;

end;

function TfrmReciboTP.obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
begin

  Result := false;

 dmConexao.conectarBanco;

  qryBaixaTPCheque.Close;
  qryBaixaTPCheque.Connection := dmConexao.Conn;
  qryBaixaTPCheque.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryBaixaTPCheque.ParamByName('PIDTITULOPAGARBAIXA').AsString :=pIdTPB;
  qryBaixaTPCheque.Open;

  Result := not qryBaixaTPCheque.IsEmpty;
end;

function TfrmReciboTP.obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;

begin
  Result := false;

  dmConexao.conectarBanco;

  qryObterTPBBanco.Close;
  qryObterTPBBanco.Connection := dmConexao.Conn;
  qryObterTPBBanco.ParamByName('pIdOrganizacao').AsString :=   pIdOrganizacao;
  qryObterTPBBanco.ParamByName('PIDTPB').AsString := pIdTPB;

  qryObterTPBBanco.Open;

  Result := not qryObterTPBBanco.IsEmpty;

end;

function TfrmReciboTP.obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;

  dmConexao.conectarBanco;

  qryTPBAcrescimos.Close;
  qryTPBAcrescimos.Connection := dmConexao.Conn;
  qryTPBAcrescimos.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBAcrescimos.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBAcrescimos.Open;

  Result := not qryTPBAcrescimos.IsEmpty;
end;


function TfrmReciboTP.obterTPBDE(pIdOrganizacao, pIdTPB
  : String): Boolean;
begin

  Result := false;

 dmConexao.conectarBanco;

  qryTPBDeducao.Close;
  qryTPBDeducao.Connection := dmConexao.Conn;
  qryTPBDeducao.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTPBDeducao.ParamByName('pIdTitutloPagarBaixa').AsString :=
    pIdTPB;
  qryTPBDeducao.Open;

  Result := not qryTPBDeducao.IsEmpty;
end;

procedure TfrmReciboTP.exibirRelatorio(tipo: Integer);
var
 retornarCaminhoRelatorio :string;
begin

retornarCaminhoRelatorio := uUtil.TPathRelatorio.getReciboTP;

  frxReportRecibo.Clear;

  if not(frxReportRecibo.LoadFromFile(retornarCaminhoRelatorio))
  then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(now, now);
    frxReportRecibo.OldStyleProgress := true;
    frxReportRecibo.ShowProgress := true;
    frxReportRecibo.ShowReport;

  end;
end;


procedure TfrmReciboTP.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxReportRecibo.Variables do
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
    Variables['strUF'] :=    QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));
    Variables['strTipoStatus'] := 'TODOS';
    Variables['strExtenso'] :=   QuotedStr(vlrExtenso);
    Variables['strValidate'] :=   QuotedStr(validate);



  end;
end;




end.
