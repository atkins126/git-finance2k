unit uFrmDemonstrativoRD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,uUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao,uDMRD, uDMOrganizacao,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, frxClass,  MDDAO,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,System.DateUtils,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.DBChart, VCLTee.Series, VCLTee.ArrowCha, Vcl.Buttons,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxRibbonCustomizationForm, cxClasses,
  dxRibbon, dxBar, dxStatusBar, dxBarExtItems, EMsgDlg;

type
  TfrmDemonstrativoRD = class(TForm)
    dbgrdReceitas: TDBGrid;
    dbgrdDespesas: TDBGrid;
    lbl1: TLabel;
    lbl2: TLabel;
    dsReceitas: TDataSource;
    dsDespesas: TDataSource;
    edtValorDespesa: TEdit;
    edtValorReceita: TEdit;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarFechar: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    dtpDataInicial: TdxBarDateCombo;
    dtpDataFinal: TdxBarDateCombo;
    dxBarConsulta: TdxBarButton;
    dxBarImprimir: TdxBarLargeButton;
    PempecMsg: TEvMsgDlg;
    procedure FormCreate(Sender: TObject);
  //  procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarFecharClick(Sender: TObject);
    procedure dxBarConsultaClick(Sender: TObject);
    procedure dxBarImprimirClick(Sender: TObject);
  private
  idOrganizacao :String;
  vlrReceitas, vlrDespesas : Currency;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM;
    procedure exibirRelatorioExportacao(dtInicial, dtFinal: TDate);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    function retornarCaminhoRelatorio: string;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
    function validarPeriodo: Boolean;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);


    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemonstrativoRD: TfrmDemonstrativoRD;

implementation

{$R *.dfm}


procedure TfrmDemonstrativoRD.inicializarDM(Sender: TObject);
begin

  idOrganizacao := uutil.TOrgAtual.getId;

  if not(Assigned(dmRD)) then
  begin
    dmRD := TdmRD.Create(Self);
  end;

end;


procedure TfrmDemonstrativoRD.freeAndNilDM();
begin

  if (Assigned(dmRD)) then
  begin
       FreeAndNil(dmRD);
  end;

end;

 {
procedure TfrmDemonstrativoRD.btnConfirmaClick(Sender: TObject);
begin
vlrDespesas :=0; vlrReceitas :=0;
edtValorDespesa.Text :=  FormatFloat('#,.##',vlrDespesas);
edtValorReceita.Text :=  FormatFloat('#,.##',vlrReceitas);
 if uutil.Empty(idOrganizacao) then begin
    idOrganizacao := uUtil.TOrgAtual.getId;
 end;



   if validarPeriodo then begin

      if (dmRD.obterDespesas(idOrganizacao,dtpDataInicial.Date, dtpDataFinal.Date)) then begin
           TFDQuery(dbgrdDespesas.DataSource.DataSet).First;
           while not TFDQuery(dbgrdDespesas.DataSource.DataSet).Eof do begin
                   vlrDespesas := vlrDespesas + TFDQuery(dbgrdDespesas.DataSource.DataSet).FieldByName('VALOR_DESPESA').AsCurrency;
                 TFDQuery(dbgrdDespesas.DataSource.DataSet).Next;
           end;

          edtValorDespesa.Text :=  FormatFloat('#,.##',vlrDespesas);

      end;

      if (dmRD.obterReceitas(idOrganizacao,dtpDataInicial.Date, dtpDataFinal.Date)) then begin

            TFDQuery(dbgrdReceitas.DataSource.DataSet).First;
           while not TFDQuery(dbgrdReceitas.DataSource.DataSet).Eof do begin
                   vlrReceitas := vlrReceitas + TFDQuery(dbgrdReceitas.DataSource.DataSet).FieldByName('VALOR_RECEITA').AsCurrency;
                 TFDQuery(dbgrdReceitas.DataSource.DataSet).Next;
           end;

          edtValorReceita.Text :=  FormatFloat('#,.##',vlrReceitas);
      end;

       registraMovimentacao(idOrganizacao, 'CENTRO_CUSTO', 'DEMONSTRATIVO RD', uutil.TUserAtual.getNameUser + ' solicitou DEMONSTRATIVO RD'  , 'SOLICITADO');

       btnImprimir.Enabled := True;
   end else begin
       ShowMessage('O per�odo parece estar incorreto... Verifique e tente novamente. ');
   end;


end;   }



function TfrmDemonstrativoRD.validarPeriodo: Boolean;
var
validador :Boolean;
begin
   validador :=True;
  if(dtpDataInicial.Date > dtpDataFinal.Date) then begin
     validador := False;
   end;

  Result :=validador;

end;


procedure TfrmDemonstrativoRD.dxBarConsultaClick(Sender: TObject);
begin
vlrDespesas :=0; vlrReceitas :=0;
edtValorDespesa.Text :=  FormatFloat('#,.##',vlrDespesas);
edtValorReceita.Text :=  FormatFloat('#,.##',vlrReceitas);

 if uutil.Empty(idOrganizacao) then begin
    idOrganizacao := uUtil.TOrgAtual.getId;
 end;

 msgStatusBar(3, 'Processando a solicita��o...');

   if validarPeriodo then begin

      if (dmRD.obterDespesas(idOrganizacao,dtpDataInicial.Date, dtpDataFinal.Date)) then begin

           TFDQuery(dbgrdDespesas.DataSource.DataSet).First;

           while not TFDQuery(dbgrdDespesas.DataSource.DataSet).Eof do begin
                     vlrDespesas := vlrDespesas + TFDQuery(dbgrdDespesas.DataSource.DataSet).FieldByName('VALOR_DESPESA').AsCurrency;
                     TFDQuery(dbgrdDespesas.DataSource.DataSet).Next;
           end;

          edtValorDespesa.Text :=  FormatFloat('#,.##',vlrDespesas);

      end;

      if (dmRD.obterReceitas(idOrganizacao,dtpDataInicial.Date, dtpDataFinal.Date)) then begin

            TFDQuery(dbgrdReceitas.DataSource.DataSet).First;

           while not TFDQuery(dbgrdReceitas.DataSource.DataSet).Eof do begin
                   vlrReceitas := vlrReceitas + TFDQuery(dbgrdReceitas.DataSource.DataSet).FieldByName('VALOR_RECEITA').AsCurrency;
                     TFDQuery(dbgrdReceitas.DataSource.DataSet).Next;
           end;

          edtValorReceita.Text :=  FormatFloat('#,.##',vlrReceitas);
      end;

       registraMovimentacao(idOrganizacao, 'CENTRO_CUSTO', 'DEMONSTRATIVO RD', uutil.TUserAtual.getNameUser + ' solicitou DEMONSTRATIVO RD'  , 'SOLICITADO');

      dxBarImprimir.Enabled := True;


   end else begin

       PempecMsg.MsgError('O per�odo parece estar incorreto... Verifique e tente novamente.' );
       msgStatusBar(3, 'Problemas com o per�odo informado..');
   end;


end;

procedure TfrmDemonstrativoRD.dxBarFecharClick(Sender: TObject);
begin
     PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmDemonstrativoRD.dxBarImprimirClick(Sender: TObject);
begin
   msgStatusBar(3, 'Relat�rio enviado para impress�o...');
 exibirRelatorioExportacao(dtpDataInicial.Date, dtpDataFinal.Date);

end;

procedure TfrmDemonstrativoRD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
freeAndNilDM;
Action := caFree;
end;

procedure TfrmDemonstrativoRD.FormCreate(Sender: TObject);
begin

 dtpDataInicial.Date := StartOfTheMonth(now);
 dtpDataFinal.Date := EndOfTheMonth(Now);
 dxBarImprimir.Enabled := False;
  inicializarDM(Self);
  limpaStatusBar;
end;

procedure TfrmDemonstrativoRD.exibirRelatorioExportacao ( dtInicial, dtFinal: TDate);
begin

      dmRD.frxReportRD.Clear;
  if (dmRD.frxReportRD.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal);
    dmRD.frxReportRD.OldStyleProgress := True;
    dmRD.frxReportRD.ShowProgress := True;
    dmRD.frxReportRD.ShowReport;
  end;

   dxBarImprimir.Enabled := False;
end;

function TfrmDemonstrativoRD.retornarCaminhoRelatorio: string;
begin
   // Result := ExtractFilePath(Application.ExeName) + '\relDemonstrativoRDSintetico.fr3';
    Result := uUtil.TPathRelatorio.getDemontrativoRDSintetico;
end;


procedure TfrmDemonstrativoRD.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with dmRD.frxReportRD.Variables do
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

  end;
end;



procedure TfrmDemonstrativoRD.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmDemonstrativoRD.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. ';
dxStatusBar.Panels[2].Text := '  ';
dxStatusBar.Panels[3].Text := '  ';

end;

procedure TfrmDemonstrativoRD.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;



end.
