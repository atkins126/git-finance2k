unit uFrmTelaImpressaoLotePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,UMostraErros,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uUtil,uLotePagamentoModel, uLotePagamentoDAO,
  udmConexao, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,  System.Generics.Collections, uTituloPagarModel, uTituloPagarDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uDMOrganizacao,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,uTPBaixaDAO,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, frxClass, frxDBSet, uContaBancariaChequeModel, uContaBancariaChequeDAO,
  dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, dxBar, cxBarEditItem, uLoteContabilModel, uLoteContabilDAO,
  cxClasses, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, uContaBancariaDBModel, uContaBancariaDebitoDAO,
  dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon, EMsgDlg, dxStatusBar;

type
  TfmTelaImpressaoLotePagamento = class(TForm)
    dbgrdMain: TDBGrid;
    dsDbGrid: TDataSource;
    qryPreencheDBGrid: TFDQuery;
    qryObterTitulos: TFDQuery;
    frxRelLotePagamento: TfrxReport;
    frxDBLote: TfrxDBDataset;
    frxDBTitulo: TfrxDBDataset;
    dxBarManager1: TdxBarManager;
    dxBtnEditar: TdxBarLargeButton;
    dxBtnSalvar: TdxBarLargeButton;
    dxBtnImprimir: TdxBarLargeButton;
    dxBtnFechar: TdxBarLargeButton;
    dxBtnDeletar: TdxBarLargeButton;
    cxbrdtmPesquisa: TcxBarEditItem;
    dxBtnImprime: TdxBarLargeButton;
    dxBtnImpimir: TdxBarLargeButton;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBtnFechar1: TdxBarLargeButton;
    dxBarImprimir: TdxBarLargeButton;
    cxbrdtmLote: TcxBarEditItem;
    qryLote: TFDQuery;
    PempecMsg: TEvMsgDlg;
    dxStatusBar: TdxStatusBar;
    dxBarManager1Bar1: TdxBar;
    dxBtnCancelaLote: TdxBarLargeButton;
    qryObterPagos: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dsDbGridDataChange(Sender: TObject; Field: TField);
    procedure dxBtnFechar1Click(Sender: TObject);
    procedure dxBarImprimirClick(Sender: TObject);
    procedure dbgrdMainTitleClick(Column: TColumn);
    procedure cxbrdtmLoteCurChange(Sender: TObject);
    procedure dxBtnCancelaLoteClick(Sender: TObject);

  private
    { Private declarations }
    pIDlote, pIDorganizacao, pLote :string;
    lotePagamento : TLotePagamentoModel;
    function preencheGrid: Boolean;
    function obterTitulosPorLote(pLote :TLotePagamentoModel) : Boolean;
    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure limpaStatusBar;
    procedure limpaPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    function isExportado(var loMostraErros: TFMostraErros): Boolean;
    function obterTitulosPagosPorLote(pLote: TLotePagamentoModel): Boolean;


  public
    { Public declarations }
  end;

var
  fmTelaImpressaoLotePagamento: TfmTelaImpressaoLotePagamento;

implementation

{$R *.dfm}

procedure TfmTelaImpressaoLotePagamento.btnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfmTelaImpressaoLotePagamento.cxbrdtmLoteCurChange(Sender: TObject);
begin
dbgrdMain.DataSource.DataSet.Locate('LOTE',UpperCase(cxbrdtmLote.CurEditValue),[loPartialKey]);
end;

procedure TfmTelaImpressaoLotePagamento.dbgrdMainTitleClick(Column: TColumn);
begin

(dbgrdMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;

end;


procedure TfmTelaImpressaoLotePagamento.dsDbGridDataChange(Sender: TObject;   Field: TField);

begin
  pIDorganizacao   := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
  pIDlote          := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_LOTE_PAGAMENTO').AsString;

 lotePagamento := TLotePagamentoModel.Create;
 lotePagamento.FIDorganizacao := pIDorganizacao;
 lotePagamento.FID := pIDlote;
 lotePagamento := TLotePagamentoDAO.obterPorID(lotePagamento)   ;

  qryLote.Close;
  qryLote.ParamByName('PID').AsString := pIDlote;
  qryLote.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
  qryLote.Open;

  obterTitulosPorLote(lotePagamento);

end;

procedure TfmTelaImpressaoLotePagamento.dxBarImprimirClick(Sender: TObject);
begin

  if not qryLote.IsEmpty then begin

     exibirRelatorio(1);

 end;

end;

procedure TfmTelaImpressaoLotePagamento.dxBtnCancelaLoteClick(Sender: TObject);
var
lotePagto : TLotePagamentoModel;
continua, sucesso, exportado : Boolean;
loMostraErros : TFMostraErros;
cheque : TContaBancariaChequeModel;
lancamentoDB : TContaBancariaDBModel;

tituloPagar :TTituloPagarModel;

qtdTitulos :Integer;

begin
  qtdTitulos :=0;
  sucesso := False;
  continua := True;
  exportado := False;
  loMostraErros := TFMostraErros.Create(Self);
  loMostraErros.Caption := 'Cancelamento de Lote Pagamento ';

  lotePagto := TLotePagamentoModel.Create;
  lotePagto.FIDorganizacao := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
  lotePagto.FID := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_LOTE_PAGAMENTO').AsString;
  lotePagto := TLotePagamentoDAO.obterPorID(lotePagto);

  try
    if not uUtil.Empty(lotePagto.FID) then
    begin

      msgStatusBar(3, 'Consultando dados do pagamento');

    //verificar se o lote foi pago em cheque e se o lancamento ja foi exportado
      if not uUtil.Empty(lotePagto.FIDcheque) then
      begin
        cheque := TContaBancariaChequeModel.Create;
        cheque.FIDorganizacao := pIDorganizacao;
        cheque.FID := lotePagto.FIDcheque;
        cheque := TContaBancariaChequeDAO.obterPorID(cheque);

        if cheque.FIDtipoStatus.Equals('COMPENSADO') then
        begin
          continua := False;

          msgStatusBar(3, 'O cheque est� compensado. N�o podemos cancelar o lote de pagamento.');

          loMostraErros.Clear;
          loMostraErros.Add('Lote pago com cheque ' + #13);

          loMostraErros.Add('Banco            ' + cheque.FcontaBancaria.Fbanco.FCODIGO_BANCO);
          loMostraErros.Add('Conta            ' + cheque.FcontaBancaria.Fconta);
          loMostraErros.Add('Agencia          ' + cheque.FcontaBancaria.Fagencia);
          loMostraErros.Add('Cheque           ' + cheque.FNumero);
          loMostraErros.Add('Emitido em       ' + DateToStr(cheque.FdataEmissao));
          loMostraErros.Add('Compensando  em  ' + DateToStr(cheque.FdataCompensacao));
          loMostraErros.Add('----------------------------------------------------');
          loMostraErros.Add(' DADOS DO LAN�AMENTO ');
          loMostraErros.Add('----------------------------------------------------' + #13);

          lancamentoDB := TContaBancariaDBModel.Create;
          lancamentoDB.FIDorganizacao := pIDorganizacao;
          lancamentoDB.FIDCheque := cheque.FID;
          lancamentoDB.Fcheque := cheque;

          lancamentoDB := TContaBancariaDebitoDAO.obterPorCheque(lancamentoDB);

          if not uutil.Empty(lancamentoDB.FID) then
          begin

            loMostraErros.Add('Identifica��o do lan�amento  ' + lancamentoDB.Fidentificacao);
            loMostraErros.Add('Descri��o ' + lancamentoDB.Fdescricao);
            loMostraErros.Add('Observacao  ' + lancamentoDB.Fobservacao);
          end;

          loMostraErros.Add('----------------------------------------------------');

          PempecMsg.MsgError('N�o � poss�vel cancelar um lote pago com cheque. � preciso estornar a compensa��o do cheque. ');

          if loMostraErros.Count > 0 then
          begin
            loMostraErros.ShowModal;
          end;

        end;

      end;

 //obter os titulos pagos no lote
      if ((continua) and (obterTitulosPorLote(lotePagto))) then
      begin
      //verificar se tem algum titulo pago j� exportado
        exportado := isExportado(loMostraErros);

        if exportado then
        begin

          PempecMsg.MsgError('N�o � poss�vel cancelar um lote que cont�m t�tulos exportados. ');
          continua := False;
          msgStatusBar(3, ' N�o � poss�vel cancelar o lote de pagamento.');

          if loMostraErros.Count > 0 then
          begin
            loMostraErros.ShowModal;
          end;

        end
        else
        begin
          continua := True;
          msgStatusBar(3, 'Todas as verifica��es foram feitas. O lote de pagamento est� pronto para ser cancelado.');
        end;

        //se chegou aqui .. pode deletar o lote

        if continua then
        begin
            dbgrdMain.DataSource.DataSet.Close;
          qryObterTitulos.First;
          while not qryObterTitulos.Eof do
          begin
            msgStatusBar(3, 'O lote est� sendo cancelado. Aguarde. ');


            tituloPagar := TTituloPagarModel.Create;
            tituloPagar.FIDorganizacao := pIDorganizacao;
            tituloPagar.FID := qryObterTitulos.FieldByName('ID_TITULO_PAGAR').AsString;
            tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);

            if not uUtil.Empty(tituloPagar.FID) then
            begin
              tituloPagar.FIDLoteContabil := '';
              tituloPagar.FIDTipoStatus := 'ABERTO';
              tituloPagar.FIDLotePagamento := '';

              if TTPBaixaDAO.cancelarBaixa(tituloPagar) then
              begin

                sucesso := True;
                Inc(qtdTitulos);

              end else begin

                loMostraErros.Clear;
                loMostraErros.Add('T�tulos que n�o foi poss�vel cancelar a baixa' + #13);

                loMostraErros.Add('DOCUMENTO   ' + tituloPagar.FnumeroDocumento);
                loMostraErros.Add('-------------------------------');

                loMostraErros.Add(' Alguns t�tulos podem ter sido cancelados. ');
                loMostraErros.Add(' O lote n�o ser� cancelado. ');

              end;
            end;


            qryObterTitulos.Next;

          end;

          if loMostraErros.Count > 0 then
          begin
            sucesso := False;
            loMostraErros.ShowModal;
          end;

          if sucesso then
          begin
            if qtdTitulos = qryObterTitulos.RecordCount then
            begin
              if TLotePagamentoDAO.Delete(lotePagto) then
                PempecMsg.MsgInformation('O lote foi deletado com sucesso');
                msgStatusBar(3, 'Ativo');
               // dbgrdMain.DataSource.DataSet.Open;
               limpaPanel;

            end;
          end;

        end;

      end
      else
      begin
        if  ((not continua) and (obterTitulosPagosPorLote(lotePagto))) then
        begin
          loMostraErros.Clear;
          loMostraErros.Add(' Existem lan�amentos de baixa vinculados ao lote ' + #13);

          qryObterPagos.First;
          if not qryObterPagos.Eof then
          begin

            loMostraErros.Add('DOCUMENTO   ' + qryObterPagos.FieldByName('NUMERO_DOCUMENTO').AsString);
            loMostraErros.Add('-------------------------------');
            loMostraErros.Add(' O lote n�o ser� cancelado. Consulte o suporte.  ');

            qryObterPagos.Next;
          end;

        end
        else
        begin

          if qryObterTitulos.RecordCount = 0 then
            PempecMsg.MsgError('N�o foram encontrados t�tulos vinculados ao lote ' + lotePagto.Flote);

          if PempecMsg.MsgConfirmation('Voc� deseja tentar apagar o lote pagamento ' + lotePagto.Flote + ' ?') = 6 then
          begin

            if TLotePagamentoDAO.Delete(lotePagto) then
              PempecMsg.MsgInformation('O lote foi deletado com sucesso');
            msgStatusBar(3, 'Ativo');
            limpaPanel;
          end;
        end;

         testar isso

        if loMostraErros.Count > 0 then
          begin
            sucesso := False;
            loMostraErros.ShowModal;
          end;


      end;

    end else begin PempecMsg.MsgError('N�o foi poss�vel localizar o lote de pagamento. ' + lotePagto.Flote); end;

  except
    on e: Exception do
      PempecMsg.MsgInformation(e.Message + sLineBreak + ' Problemas ao tentar cancelar o lote : ' + lotePagto.Flote);

  end;

end;

function TfmTelaImpressaoLotePagamento.isExportado (var loMostraErros: TFMostraErros) :Boolean;
var
sucesso : Boolean;
loteContabil : TLoteContabilModel;
dadosLote :string;
begin
 sucesso := False;
 dadosLote := '';
  loMostraErros.Clear;
  loMostraErros.Add('T�tulos que j� foram exportados. ' + #13);


  if qryObterTitulos.RecordCount > 0 then
  begin
      //verificar se tem algum titulo pago j� exportado
    qryObterTitulos.First;

    while not qryObterTitulos.Eof do
    begin

      if not uutil.Empty(qryObterTitulos.FieldByName('ID_LOTE_CONTABIL').AsString) then
      begin

        loteContabil := TLoteContabilModel.Create;
        loteContabil.FIDorganizacao := pIDorganizacao;
        loteContabil.FID := qryObterTitulos.FieldByName('ID_LOTE_CONTABIL').AsString;
        loteContabil := TLoteContabilDAO.obterPorID(loteContabil);

        if not uUtil.Empty(loteContabil.FID) then
        begin

          dadosLote := 'LOTE  ' + loteContabil.Flote + ' DATA ' + DateToStr(loteContabil.FdataRegistro);

        end;


        loMostraErros.Add('T�tulo exportado. DOC NUM  ' + qryObterTitulos.FieldByName('NUMERO_DOCUMENTO').AsString +  ' ' + dadosLote );

         sucesso := True;
      end;

      qryObterTitulos.Next;

    end;

  end;

   if not sucesso then begin   loMostraErros.Clear; end;
   

  Result := sucesso;

end;

procedure TfmTelaImpressaoLotePagamento.dxBtnFechar1Click(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfmTelaImpressaoLotePagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfmTelaImpressaoLotePagamento.FormCreate(Sender: TObject);
begin
dmConexao.conectarBanco;
 pIDorganizacao := uUtil.TOrgAtual.getId;
 limpaPanel;
end;

function TfmTelaImpressaoLotePagamento.obterTitulosPorLote(pLote :TLotePagamentoModel) : Boolean;
var
cmd :string;

begin

  dmConexao.conectarBanco;

try
   cmd := ' SELECT TP.ID_TITULO_PAGAR,'+
          ' TP.NUMERO_DOCUMENTO, '+
          ' TP.valor_nominal,  '+
          ' TP.DESCRICAO,    '+
          ' TP.id_lote_pagamento,    '+
          ' TP.ID_LOTE_CONTABIL, '+
          ' C.nome,  C.id_cedente    '+
          ' FROM TITULO_PAGAR TP    '+
          ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
          ' WHERE TP.ID_ORGANIZACAO = :PIDORGANIZACAO  AND TP.ID_LOTE_PAGAMENTO = :PIDLOTE ' +
          ' ORDER BY TP.VALOR_NOMINAL ' ;


  qryObterTitulos.Close;
  qryObterTitulos.Connection := dmConexao.conn;
  qryObterTitulos.SQL.Clear;
  qryObterTitulos.SQL.Add(cmd);
  qryObterTitulos.ParamByName('PIDORGANIZACAO').AsString := pLote.FIDorganizacao;
  qryObterTitulos.ParamByName('PIDLOTE').AsString := pLote.FID;
  qryObterTitulos.Open;


  Result := not qryObterTitulos.IsEmpty;

except

raise Exception.Create('Erro ao tentar obter TITULO POR LOTE PAGTO');

end;
end;




function TfmTelaImpressaoLotePagamento.obterTitulosPagosPorLote(pLote :TLotePagamentoModel) : Boolean;
var
cmd :string;
begin
   dmConexao.conectarBanco;

try
   cmd :=' SELECT TP.ID_TITULO_PAGAR, '+
        ' TP.ID_ORGANIZACAO, '+
        ' TP.NUMERO_DOCUMENTO, '+
        ' TP.DESCRICAO,        '+
        ' TP.DATA_VENCIMENTO,  '+
        'TP.VALOR_NOMINAL    '+
' FROM TITULO_PAGAR TP     '+
' LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB  ON (TPB.id_titulo_pagar = TP.ID_TITULO_PAGAR) AND (TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
' WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
 '  AND (TP.ID_LOTE_PAGAMENTO = :PIDLOTE) ';


  qryObterPagos.Close;
  qryObterPagos.Connection := dmConexao.conn;
  qryObterPagos.SQL.Clear;
  qryObterPagos.SQL.Add(cmd);
  qryObterPagos.ParamByName('PIDORGANIZACAO').AsString := pLote.FIDorganizacao;
  qryObterPagos.ParamByName('PIDLOTE').AsString := pLote.FID;
  qryObterPagos.Open;


  Result := not qryObterPagos.IsEmpty;


except

raise Exception.Create('Erro ao tentar obter TITULOS PAGOS POR LOTE PAGTO');

end;
end;




function TfmTelaImpressaoLotePagamento.preencheGrid : Boolean;
begin

dmConexao.conectarBanco;

 qryPreencheDBGrid.Close;
 qryPreencheDBGrid.Connection := dmConexao.conn;
 qryPreencheDBGrid.ParamByName('PIDORGANIZACAO').AsString :=  pIDorganizacao;
 qryPreencheDBGrid.Open;

 Result := System.True;

end;

procedure TfmTelaImpressaoLotePagamento.exibirRelatorio(tipo: Integer);
var
 retornarCaminhoRelatorio :string;
begin

retornarCaminhoRelatorio := uUtil.TPathRelatorio.getRelatorioLotePagamento;
frxRelLotePagamento.Clear;
  if not(frxRelLotePagamento.LoadFromFile(retornarCaminhoRelatorio))
  then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(now, now);
    frxRelLotePagamento.OldStyleProgress := true;
    frxRelLotePagamento.ShowProgress := true;
    frxRelLotePagamento.ShowReport;

  end;
end;



procedure TfmTelaImpressaoLotePagamento.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxRelLotePagamento.Variables do
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
    Variables['strExtenso'] :=   QuotedStr('0');
    Variables['strValidate'] :=   QuotedStr('');

  end;
end;


procedure TfmTelaImpressaoLotePagamento.limpaPanel;
begin
 limpaStatusBar;
 preencheGrid;
end;

procedure TfmTelaImpressaoLotePagamento.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

//dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfmTelaImpressaoLotePagamento.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;



end.
