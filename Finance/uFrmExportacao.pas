unit uFrmExportacao;

interface

uses
  uLancamentoCreditoModel, uLancamentoDebitoModel,uListaLancamentosCredito, UMostraErros,DateUtils,
   uListaLancamentosDebito, uListaLancamentos, Winapi.Windows, Winapi.Messages, System.SysUtils,
   System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uUtil,
   uDMRelatorioExportacaoMega, udmConexao, uDMOrganizacao, uDMHistoricoConsulta, uDMExportaFinanceDTS,
   uDMMegaContabil, uDMExportaFinanceTP, uDMExportaFinanceTR, uDMExportaFinanceManter, uDMExportaFinance, Data.DB, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, uFrameProgressBar ;

type
  TfrmExportacao = class(TForm)
    lblStatusSistemaContabil: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    cbxAnoLote: TComboBox;
    cbxMesLote: TComboBox;
    edtLote: TEdit;
    dtDataInicial: TDateTimePicker;
    dtDataFinal: TDateTimePicker;
    lblGeneratorID: TLabel;
    lblStatusExp: TLabel;
    btnGeraLote: TButton;
    imgGreen: TImage;
    btnImprimir: TBitBtn;
    imgRed: TImage;
    lblHistoricoSemConta: TLabel;
    imgGravaLote: TImage;
    lblGravaLoteMega: TLabel;
    imgGravaLoteFinance: TImage;
    tfdTransaction: TFDTransaction;
    lblSalvaLoteFnc: TLabel;
    lblExportaCBT: TLabel;
    imgCBT: TImage;
    lblExportaTPPROV: TLabel;
    imgTPPROV: TImage;
    qry1: TFDQuery;
    btnExportarCBT: TBitBtn;
    btnExportarTBT: TBitBtn;
    lblExportaTBT: TLabel;
    imgTBT: TImage;
    btnLimpar: TButton;
    btnExportarCaixaBanco: TBitBtn;
    lblExportaTTB: TLabel;
    imgTTB: TImage;
    btnExportaTPPROV: TButton;
    btnExportaTPQ: TButton;
    btnExportaTRPROV: TButton;
    btnExportaTRQ: TButton;
    lblExportaTP: TLabel;
    imgTPQ: TImage;
    lblExportaTRPROV: TLabel;
    imgTRPROV: TImage;
    lblExportaTR: TLabel;
    imgTRQ: TImage;
    framePB1: TframePB;
    procedure FormCreate(Sender: TObject);
    procedure btnGeraLoteClick(Sender: TObject);
    procedure cbxAnoLoteClick(Sender: TObject);
    procedure cbxMesLoteChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportarCBTClick(Sender: TObject);
    procedure dsPagosDataChange(Sender: TObject; Field: TField);
    procedure verificaHistoricoSemConta();
    procedure btnExportarTBTClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnExportarCaixaBancoClick(Sender: TObject);
    procedure btnExportaTPPROVClick(Sender: TObject);
    procedure btnExportaTPQClick(Sender: TObject);
    procedure btnExportaTRPROVClick(Sender: TObject);
    procedure btnExportaTRQClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure dtDataFinalChange(Sender: TObject);
    procedure dtDataInicialChange(Sender: TObject);


  private
    { Private declarations }
    idOrganizacao: string; // guarda o id da Organziacao em uso
    FsListaIdOrganizacoes: TStringList;
    FsListaLancamentosCredito: TListaLancamentoCredito;
    FsListaLancamentosDebito: TListaLancamentoDebito;
    FsListaLancamentos: TListaLancamentos; //lita que vai para o mega
    pIdClotes: Integer;
    codEmpresa, lote: Integer;
    cnpj, ano: string;
    loMostraErros: TFMostraErros;
    ultimoLoteSC : Integer; //guardar o ultimo lote inserido no Mega
    linha :Integer; //armazena a linha atual do registro inserido no MEGA -> CLANCAMENTOS
    pDataInicial: TDate;
    pDataFinal: TDate;
    valorCredito, valorDebito :Currency;


    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
    procedure statusExportar(sinal: Integer);
    function liberaExibirRelatorio: Integer;
    procedure ativaShapeExportaca(shape: Integer);
    procedure limpaPainelExportacao();
    function permiteExportar(pDataInicial, pDataFinal:Tdate):Boolean;


  public
    { Public declarations }
    function exportarLancamentosMega(pTable :string; lista :TListaLancamentos ): Integer;
  end;

var
  frmExportacao: TfrmExportacao;

implementation

{$R *.dfm}
uses
  uDMContaBancariaTransferencia, uDMContaBancariaDebitoConsulta, uDMContaBancariaCreditoConsulta;


procedure TfrmExportacao.btn1Click(Sender: TObject);
begin
framePB1.Visible :=True;
framePB1.progressBar(10,100 );
end;

procedure TfrmExportacao.btnExportarCaixaBancoClick(Sender: TObject);
//operacoes realizadas do caixa para o banco
var
 tipoLancamento, pPonto, pTipo, pTable, IdFechamento, idLote: string;
  pId, loteInicial: Integer;
  fechamento: Boolean;
  vDebito: Currency;
  //armazena qtd de registros exportados
  qtdReg : Integer;
  lista: TListaLancamentos;

begin

  tipoLancamento :='DEPOSITO TESOURARIA/BANCO';
  pTable :=  'CONTA_BANCARIA_CREDITO';
  pTipo :='TCB'; //transferencia CAIXA para BANCO
  lista := TListaLancamentos.Create;
  fechamento := true;
  cnpj := TOrgAtual.getCNPJ;
  codEmpresa := 0;
  qtdReg := 0;
  loMostraErros := TFMostraErros.Create(Self);
  limpaPainelExportacao;
  framePB1.progressBar(0,100);
   framePB1.Visible :=True;
 //se falhar acima. Pega o CNPJ  direto no database FInance
  if cnpj = '' then
  begin
    try
    pPonto := 'Obtendo CNPJ - FNC';
      cnpj := dmOrganizacao.obterCNPJOrganizacao;
    except
      raise(Exception).Create('Impossivel obter o CNPJ da Organiza��o.');
    end;

  end;

  // Obter o codigo da empresa no MEGA usando o cnpj
  try
  pPonto := 'Obtendo ID MEGA   ';
    codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);

  except
    raise(Exception).Create('Impossivel obter o identificador da empresa no Sistema Cont�bil. '+ pPonto + pTipo);
  end;

  // verifica se o lote informado existe
  if not codEmpresa = (-1) then
  begin
    lote := StrToInt(edtLote.Text);
    loteInicial := lote;
    ano := cbxAnoLote.Text;

    //verifica se existe o lote que esta sendo inserido
    //verificacao em CLOTES do MEGA

    if dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) then
    begin

      idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;
      ShowMessage('Lote j� existe no Sistema Cont�bil. ');
      fechamento := false;
      btnImprimir.Enabled := false;
      Limpatela(Self);
      limpaPainelExportacao;
    end

  end;

  // verifica se tem ID_ORGANIZACAO Selecionada
  if idOrganizacao = '' then
  begin
    ShowMessage('Ser� preciso selecionar uma Organiza��o antes de prosseguir.');
    fechamento := false;
    btnImprimir.Enabled := false;
    Limpatela(Self);
    limpaPainelExportacao;

  end
  else
  begin
     // verifica se tem fechamento apos a data inicial at� 2020 e impede importar
    // recebe o ID EMPRESA e a data incial
    //ver com Roberto o prazo 2020

    if not (codEmpresa = (-1)) then
    begin

      IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa, pDataInicial);
    end;
    if not (IdFechamento = string.Empty) then
    begin
      limpaPainelExportacao;
      fechamento := false;
      btnImprimir.Enabled := false;
      btnExportarCBT.Enabled := False;
      Limpatela(Self);
      ShowMessage('Tem fechamento registrado. N�o ser� poss�vel continuar. Verifique o periodo informado. ' );
    end;
    if not (codEmpresa = (-1)) then
    begin
    // pega o generator (ID) da tabela CLOTES
      pIdClotes := dmMegaContabil.retornarIDPorTabela('CLOTES');
      ano := cbxAnoLote.Text;
     // codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);  feito na linha  117
      lote :=0;

      if not (edtLote.Text = '') then begin
      lote := StrToInt(edtLote.Text);
      end;
      loteInicial := lote;
      vDebito := 0; //o total dos debitos de todos os lancamentos

      if (dmMegaContabil.lotesRestritos(lote)) then
      begin
        edtLote.Text := 'LOTE RESTRITO';
        cbxAnoLote.ItemIndex := 0;
        cbxMesLote.ItemIndex := 0;
        idLote := '';
      end
      else
      begin
       if lote >0 then begin
        while dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) do
        begin
        //verificar no papel pq  / { TODO -oRanan -cLote :  Ver pq nao pode lote 65 e 75 }
          lote := lote + 1;  //
          edtLote.Text := IntToStr(lote);
          fechamento := true;
        end;
       end;
      end;
    end;

    if fechamento then
    begin
      edtLote.Text := IntToStr(lote);
      statusExportar(1); // ativa export com cor verde

      //inicio da transacao

      try
        tfdTransaction.Create(Self);
        tfdTransaction.Connection := dmConexao.ConnMega;
        tfdTransaction.StartTransaction;

        try
         //obtendo a lista com os lan�amentos
         pPonto := 'Obtendo LISTA DE LAN�AMENTOS  > ';
         lista := dmExportaFinance.obterCaixaBancoPorPeriodo(idOrganizacao, ano, dtDataInicial.Date, dtDataFinal.Date, codEmpresa, lote, loMostraErros);

        // PEGANDO O VALOR DE DEBITO DE PTABLE CONTA BANCARIA CREDITO
          vDebito := dmExportaFinance.obterValorDebitoGenericTOB(idOrganizacao, pTable, 'VALOR',tipoLancamento, pDataInicial, pDataFinal);

        //Gravando CLOTES para CBT
          if vDebito > 0 then
          begin
            if not dmMegaContabil.obterLotePorFiltro(codEmpresa, lote, ano) then
            begin

              if dmMegaContabil.gravarCLote(ano, pIdClotes, codEmpresa, lote, vDebito) then
              begin
                imgGravaLote.Visible := True;
                lblGravaLoteMega.Visible := True;
                ultimoLoteSC := lote;
                Application.ProcessMessages;
                Sleep(5000);

                //REALIZAR A EXPORTA��O
                qtdReg := exportarLancamentosMega(pTable,lista);

                if qtdReg > 0 then
                begin
                  lblExportaTBT.Visible := True;
                  imgTBT.Visible := True;
                  Application.ProcessMessages;
                  Sleep(5000);
                  btnExportarTBT.Enabled := False;
                  loMostraErros.Add('Lan�amentos EXPORTADOS - ' + pTipo, False, True);
                  loMostraErros.Add(' Foram exportadas ' + IntToStr(qtdReg) + ' '+  pTipo, False, True);
                  loMostraErros.Add(' ---------------------------------------------------', True, True);

                end
                else
                begin
                  limpaPainelExportacao;
                  loMostraErros.Add('N�o foram encontrados registros de ' + pTipo, True, True);

                end;

                tfdTransaction.Commit;

              end;

            end
            else
            begin
              lblGravaLoteMega.Visible := False;
              imgGravaLote.Visible := False;
              limpaPainelExportacao;
              ShowMessage('N�o foi poss�vel gravar o lote no sistema cont�bil. ' + pTipo);
            end;

          end
          else
          begin
            limpaPainelExportacao;
            ShowMessage('N�o foram encontrados lan�amentos ' + pTipo + ' para exportar.');
          end;

        except
          limpaPainelExportacao;
          tfdTransaction.Rollback;
          raise(Exception).Create('Ocorreram problemas com a exporta��o. Transa��o interrompida inesperadamente. ' + pPonto + pTipo);
        end;

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Erro ao tentar gravar o lote no Sistema Cont�bil! '+ pTipo);
      end;

    end;
  end;
  try
    limpaPainelExportacao;
    loMostraErros.caption := 'Aviso - Exporta��es  '+ pTipo;
    if loMostraErros.Count > 0 then
    begin
      loMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(loMostraErros);
  end;




end;
procedure TfrmExportacao.btnExportarCBTClick(Sender: TObject);
var
  tipoLancamento, pTipo,pTable, IdFechamento, idLote: string;
  pId, loteInicial: Integer;
  fechamento: Boolean;
  vDebito: Currency;
  //armazena qtd de registros exportados
  qtdCBT : Integer;
  lista: TListaLancamentos;



begin
  pTable :='CONTA_BANCARIA_TRANSFERENCIA';
  pTipo :='TBT'; //transferencia BANCO para CAIXA
  tipoLancamento :='TRANSFERENCIA ENTRE CONTAS'; //operacao bancaria
  lista := TListaLancamentos.Create;
  fechamento := true;
  cnpj := TOrgAtual.getCNPJ;
  codEmpresa := 0;
  qtdCBT := 0;
  loMostraErros := TFMostraErros.Create(Self);

  pDataInicial :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataInicial.Date));
  pDataFinal :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataFinal.Date));

  limpaPainelExportacao;
   framePB1.progressBar(0,100);
   framePB1.Visible :=True;

 //se falhar acima. Pega o CNPJ  direto no database FInance
  if cnpj = '' then
  begin
    try
      cnpj := dmOrganizacao.obterCNPJOrganizacao;
    except
      raise(Exception).Create( pTable + 'Impossivel obter o CNPJ da Organiza��o.');
    end;

  end;

  // Obter o codigo da empresa no MEGA usando o cnpj
  try
    codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);

  except
    raise(Exception).Create(pTable + 'Impossivel obter o identificador da empresa no Sistema Cont�bil.');
  end;

  // verifica se o lote informado existe
  if not codEmpresa = (-1) then
  begin
    lote := StrToInt(edtLote.Text);
    loteInicial := lote;
    ano := cbxAnoLote.Text;

    //verifica se existe o lote que esta sendo inserido
    //verificacao em CLOTES do MEGA

    if dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) then
    begin

      idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;
      ShowMessage('Lote j� existe no Sistema Cont�bil. ');
      fechamento := false;
      btnImprimir.Enabled := false;
      Limpatela(Self);
      limpaPainelExportacao;
    end

  end;

  // verifica se tem ID_ORGANIZACAO Selecionada
  if idOrganizacao = '' then
  begin
    ShowMessage('Ser� preciso selecionar uma Organiza��o antes de prosseguir.');
    fechamento := false;
    btnImprimir.Enabled := false;
    Limpatela(Self);
    limpaPainelExportacao;

  end
  else
  begin
    // verifica se tem fechamento apos a data inicial at� 2020 e impede importar
    // recebe o ID EMPRESA e a data incial
    //ver com Roberto o prazo 2020

    if not (codEmpresa = (-1)) then
    begin

      IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa, pDataInicial);
    end;
    if not (IdFechamento = string.Empty) then
    begin
      limpaPainelExportacao;
      fechamento := false;
      btnImprimir.Enabled := false;
      btnExportarCBT.Enabled := False;
      Limpatela(Self);
      ShowMessage('Tem fechamento registrado. N�o ser� poss�vel continuar. Verifique o periodo informado. ' );
    end;
    if not (codEmpresa = (-1)) then
    begin
    // pega o generator (ID) da tabela CLOTES
      pIdClotes := dmMegaContabil.retornarIDPorTabela('CLOTES');
      ano := cbxAnoLote.Text;
     // codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);  feito na linha  117
      lote :=0;

      if not (edtLote.Text = '') then begin
      lote := StrToInt(edtLote.Text);
      end;
      loteInicial := lote;
      vDebito := 0; //o total dos debitos de todos os lancamentos

      if (dmMegaContabil.lotesRestritos(lote)) then
      begin
        edtLote.Text := 'LOTE RESTRITO';
        cbxAnoLote.ItemIndex := 0;
        cbxMesLote.ItemIndex := 0;
        idLote := '';
      end
      else
      begin
       if lote >0 then begin
        while dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) do
        begin
        //verificar no papel pq  / { TODO -oRanan -cLote :  Ver pq nao pode lote 65 e 75 }
          lote := lote + 1;  //
          edtLote.Text := IntToStr(lote);
          fechamento := true;
        end;
       end;
      end;
    end;
    // so permite ate 10 lotes no mes de referencia
//    if (lote > (loteInicial + 9)) then
//    begin
//      ShowMessage('Problemas com o n�mero do lote.  Verifique!');
//      Limpatela(Self);
//      fechamento := false;
//    end;

    if fechamento then
    begin
      edtLote.Text := IntToStr(lote);
      statusExportar(1); // ativa export com cor verde
     
      //inicio da transacao

      try
        tfdTransaction.Create(Self);
        tfdTransaction.Connection := dmConexao.ConnMega;
        tfdTransaction.StartTransaction;

        try
         //obtendo a lista com os lan�amentos
         lista := dmExportaFinance.obterCBTPorPeriodo(idOrganizacao, ano, pDataInicial, pDataFinal, codEmpresa, lote, loMostraErros);

        // PEGANDO O VALOR DE DEBITO DE PTABLE
          vDebito := dmExportaFinance.obterValorDebitoGenericTOB(idOrganizacao, pTable, 'VALOR',tipoLancamento, pDataInicial, pDataFinal);
        //Gravando CLOTES para CBT
          if vDebito > 0 then
          begin
            if not dmMegaContabil.obterLotePorFiltro(codEmpresa, lote, ano) then
            begin

              if dmMegaContabil.gravarCLote(ano, pIdClotes, codEmpresa, lote, vDebito) then
              begin
                imgGravaLote.Visible := True;
                lblGravaLoteMega.Visible := True;
                ultimoLoteSC := lote;
                Application.ProcessMessages;
                Sleep(5000);

               //exportacao CBT o Retorno � o numero de registros que foram exportados
               // qtdCBT := exportarCBT;  //somente conta bancaria transferencia

                qtdCBT := exportarLancamentosMega(pTable,lista);


                if qtdCBT > 0 then
                begin

                 framePB1.progressBar(100,100);

                  lblExportaCBT.Visible := True;
                  imgCBT.Visible := True;
                  Application.ProcessMessages;
                  Sleep(2000);
                  btnExportarCBT.Enabled := False;
                  loMostraErros.Add('Transfer�ncias entre contas banc�rias EXPORTADAS - CBT', False, True);
                  loMostraErros.Add(' Foram exportadas ' + IntToStr(qtdCBT) + ' CBT', False, True);
                  loMostraErros.Add(' ------------------------------------------------------------------------', True, True);

                end
                else
                begin
                  limpaPainelExportacao;
                  loMostraErros.Add('N�o foram encontrados registros de '+ pTipo, True, True);

                end;

                tfdTransaction.Commit;

              end;

            end
            else
            begin
              lblGravaLoteMega.Visible := False;
              imgGravaLote.Visible := False;
              limpaPainelExportacao;
              ShowMessage('N�o foi poss�vel gravar o lote no sistema cont�bil. ' +  pTipo);
            end;

          end
          else
          begin
            limpaPainelExportacao;
            ShowMessage('N�o foram encontrados lan�amentos para exportar. ' + pTipo);
          end;

        except
          limpaPainelExportacao;
          tfdTransaction.Rollback;
          raise(Exception).Create('Ocorreram problemas com a exporta��o. Transa��o interrompida inesperadamente. ' + pTipo);
        end;

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Erro ao tentar gravar o lote no Sistema Cont�bil! ' + pTipo);
      end;

    end;
  end;
  try
    limpaPainelExportacao;
    loMostraErros.caption := 'Aviso - Exporta��es';
    if loMostraErros.Count > 0 then
    begin
      loMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(loMostraErros);
  end;


end;

procedure TfrmExportacao.btnExportarTBTClick(Sender: TObject);
var
  tipoLancamento, pTipo, pTable, IdFechamento, idLote: string;
  pId, loteInicial: Integer;
  fechamento: Boolean;
  vDebito: Currency;
  //armazena qtd de registros exportados
  qtdReg : Integer;
  lista: TListaLancamentos;



begin
  pTable :='CONTA_BANCARIA_DEBITO';
  pTipo :='TBT';
  tipoLancamento := 'TRANSFERE BANCO/TESOURARIA' ;//operacao bancaria
  lista := TListaLancamentos.Create;
  fechamento := true;
  cnpj := TOrgAtual.getCNPJ;
  codEmpresa := 0;
  qtdReg := 0;
  loMostraErros := TFMostraErros.Create(Self);
  limpaPainelExportacao;
   framePB1.progressBar(0,100);
   framePB1.Visible :=True;
 //se falhar acima. Pega o CNPJ  direto no database FInance
  if cnpj = '' then
  begin
    try
      cnpj := dmOrganizacao.obterCNPJOrganizacao;
    except
      raise(Exception).Create('Impossivel obter o CNPJ da Organiza��o.');
    end;

  end;

  // Obter o codigo da empresa no MEGA usando o cnpj
  try
    codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);

  except
    raise(Exception).Create('Impossivel obter o identificador da empresa no Sistema Cont�bil. ' + tipoLancamento);
  end;

  // verifica se o lote informado existe
  if not codEmpresa = (-1) then
  begin
    lote := StrToInt(edtLote.Text);
    loteInicial := lote;
    ano := cbxAnoLote.Text;

    //verifica se existe o lote que esta sendo inserido
    //verificacao em CLOTES do MEGA

    if dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) then
    begin

      idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;
      ShowMessage('Lote j� existe no Sistema Cont�bil. ');
      fechamento := false;
      btnImprimir.Enabled := false;
      Limpatela(Self);
      limpaPainelExportacao;
    end

  end;

  // verifica se tem ID_ORGANIZACAO Selecionada
  if idOrganizacao = '' then
  begin
    ShowMessage('Ser� preciso selecionar uma Organiza��o antes de prosseguir.');
    fechamento := false;
    btnImprimir.Enabled := false;
    Limpatela(Self);
    limpaPainelExportacao;

  end
  else
  begin
     // verifica se tem fechamento apos a data inicial at� 2020 e impede importar
    // recebe o ID EMPRESA e a data incial
    //ver com Roberto o prazo 2020

    if not (codEmpresa = (-1)) then
    begin

      IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa, pDataInicial);
    end;
    if not (IdFechamento = string.Empty) then
    begin
      limpaPainelExportacao;
      fechamento := false;
      btnImprimir.Enabled := false;
      btnExportarCBT.Enabled := False;
      Limpatela(Self);
      ShowMessage('Tem fechamento registrado. N�o ser� poss�vel continuar. Verifique o periodo informado. ' );
    end;
    if not (codEmpresa = (-1)) then
    begin
    // pega o generator (ID) da tabela CLOTES
      pIdClotes := dmMegaContabil.retornarIDPorTabela('CLOTES');
      ano := cbxAnoLote.Text;
     // codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);  feito na linha  117
      lote :=0;

      if not (edtLote.Text = '') then begin
      lote := StrToInt(edtLote.Text);
      end;
      loteInicial := lote;
      vDebito := 0; //o total dos debitos de todos os lancamentos

      if (dmMegaContabil.lotesRestritos(lote)) then
      begin
        edtLote.Text := 'LOTE RESTRITO';
        cbxAnoLote.ItemIndex := 0;
        cbxMesLote.ItemIndex := 0;
        idLote := '';
      end
      else
      begin
       if lote >0 then begin
        while dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) do
        begin
        //verificar no papel pq  / { TODO -oRanan -cLote :  Ver pq nao pode lote 65 e 75 }
          lote := lote + 1;  //
          edtLote.Text := IntToStr(lote);
          fechamento := true;
        end;
       end;
      end;
    end;

    if fechamento then
    begin
      edtLote.Text := IntToStr(lote);
      statusExportar(1); // ativa export com cor verde

      //inicio da transacao

      try
        tfdTransaction.Create(Self);
        tfdTransaction.Connection := dmConexao.ConnMega;
        tfdTransaction.StartTransaction;

        try
        //transfere do banco para a tesouraria
         //obtendo a lista com os lan�amentos
         lista := dmExportaFinance.obterTBTPorPeriodo(idOrganizacao, ano, pDataInicial, pDataFinal, codEmpresa, lote, loMostraErros);

        // PEGANDO O VALOR DE DEBITO DE PTABLE
         // vDebito := dmExportaFinance.obterValorDebitoGeneric(idOrganizacao, pTable, 'VALOR', dtDataInicial.Date, dtDataFinal.Date);
          vDebito := dmExportaFinance.obterValorDebitoGenericTOB(idOrganizacao,pTable,'VALOR', tipoLancamento, pDataInicial, pDataFinal);
        //Gravando CLOTES para CBT
          if vDebito > 0 then
          begin
            if not dmMegaContabil.obterLotePorFiltro(codEmpresa, lote, ano) then
            begin

              if dmMegaContabil.gravarCLote(ano, pIdClotes, codEmpresa, lote, vDebito) then
              begin
                imgGravaLote.Visible := True;
                lblGravaLoteMega.Visible := True;
                ultimoLoteSC := lote;
                Application.ProcessMessages;
                Sleep(5000);

                //REALIZAR A EXPORTA��O
                qtdReg := exportarLancamentosMega(pTable,lista);

                if qtdReg > 0 then
                begin
                  lblExportaTBT.Visible := True;
                  imgTBT.Visible := True;
                  Application.ProcessMessages;
                  Sleep(5000);
                  btnExportarTBT.Enabled := False;
                  loMostraErros.Add('Lan�amentos EXPORTADOS - ' + pTipo, False, True);
                  loMostraErros.Add(' Foram exportadas ' + IntToStr(qtdReg) + ' '+  pTipo, False, True);
                  loMostraErros.Add(' ---------------------------------------------------', True, True);

                end
                else
                begin
                  limpaPainelExportacao;
                  loMostraErros.Add('N�o foram encontrados registros de ' + pTipo, True, True);

                end;

                tfdTransaction.Commit;

              end;

            end
            else
            begin
              lblGravaLoteMega.Visible := False;
              imgGravaLote.Visible := False;
              limpaPainelExportacao;
              ShowMessage('N�o foi poss�vel gravar o lote no sistema cont�bil.');
            end;

          end
          else
          begin
            limpaPainelExportacao;
            ShowMessage('N�o foram encontrados lan�amentos ' + pTipo + ' para exportar.');
          end;

        except
          limpaPainelExportacao;
          tfdTransaction.Rollback;
          raise(Exception).Create('Ocorreram problemas com a exporta��o. Transa��o interrompida inesperadamente. '+ pTipo);
        end;

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Erro ao tentar gravar o lote no Sistema Cont�bil! '+ pTipo);
      end;

    end;
  end;
  try
    limpaPainelExportacao;
    loMostraErros.caption := 'Aviso - Exporta��es ' + pTipo;
    if loMostraErros.Count > 0 then
    begin
      loMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(loMostraErros);
  end;




end;

procedure TfrmExportacao.btnExportaTPPROVClick(Sender: TObject);
var
 tipoLancamento, pPonto, pTipo, pTable, IdFechamento, idLote: string;
  pId, loteInicial: Integer;
  fechamento: Boolean;
  vDebito: Currency;
  //armazena qtd de registros exportados
  qtdReg : Integer;
  lista: TListaLancamentos;

begin
  tipoLancamento :='ABERTO/QUITADO';
  pTable :=  'TITULO_PAGAR';
  pTipo :='TPPROV'; //TITULO A PAGAR PROVISIONADO
  lista := TListaLancamentos.Create;
  fechamento := true;
  cnpj := TOrgAtual.getCNPJ;
  codEmpresa := 0;
  qtdReg := 0;
  loMostraErros := TFMostraErros.Create(Self);
  limpaPainelExportacao;
   framePB1.progressBar(0,100);
   framePB1.Visible :=True;
 //se falhar acima. Pega o CNPJ  direto no database FInance
  if cnpj = '' then
  begin
    try
     pPonto := 'Obtendo CNPJ - FNC';
      cnpj := dmOrganizacao.obterCNPJOrganizacao;
    except
      raise(Exception).Create('Impossivel obter o CNPJ da Organiza��o.');
    end;

  end;

  // Obter o codigo da empresa no MEGA usando o cnpj
  try
  pPonto := 'Obtendo ID MEGA   ';
    codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);

  except
    raise(Exception).Create('Impossivel obter o identificador da empresa no Sistema Cont�bil. '+ pPonto + pTipo);
  end;

  // verifica se o lote informado existe
  if not codEmpresa = (-1) then
  begin
    lote        := StrToInt(edtLote.Text);
    loteInicial := lote;
    ano         := cbxAnoLote.Text;

    //verifica se existe o lote que esta sendo inserido
    //verificacao em CLOTES do MEGA

    if dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) then
    begin

      idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;

      ShowMessage('Lote j� existe no Sistema Cont�bil. ');

      fechamento := false;
      btnImprimir.Enabled := false;
      Limpatela(Self);
      limpaPainelExportacao;
    end

  end;

  // verifica se tem ID_ORGANIZACAO Selecionada
  if idOrganizacao = '' then
  begin
    ShowMessage('Ser� preciso selecionar uma Organiza��o antes de prosseguir.');
    fechamento := false;
    btnImprimir.Enabled := false;
    Limpatela(Self);
    limpaPainelExportacao;

  end
  else
  begin
     // verifica se tem fechamento apos a data inicial at� 2020 e impede importar
    // recebe o ID EMPRESA e a data incial
    //ver com Roberto o prazo 2020

    if not (codEmpresa = (-1)) then
    begin

      IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa, pDataInicial);
    end;
    if not (IdFechamento = string.Empty) then
    begin
      limpaPainelExportacao;
      fechamento := false;
      btnImprimir.Enabled := false;
      btnExportaTPPROV.Enabled := False;
      Limpatela(Self);
      ShowMessage('Tem fechamento registrado. N�o ser� poss�vel continuar. Verifique o periodo informado. ' );
    end;
    if not (codEmpresa = (-1)) then
    begin
    // pega o generator (ID) da tabela CLOTES
      pIdClotes := dmMegaContabil.retornarIDPorTabela('CLOTES');
      ano := cbxAnoLote.Text;
     // codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);  feito na linha  117
      lote :=0;

      if not (edtLote.Text = '') then begin
      lote := StrToInt(edtLote.Text);
      end;
      loteInicial := lote;


      if (dmMegaContabil.lotesRestritos(lote)) then
      begin
        edtLote.Text := 'LOTE RESTRITO';
        cbxAnoLote.ItemIndex := 0;
        cbxMesLote.ItemIndex := 0;
        idLote := '';
      end
      else
      begin
       if lote >0 then begin
        while dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) do
        begin
        //verificar no papel pq  / { TODO -oRanan -cLote :  Ver pq nao pode lote 65 e 75 }
          lote := lote + 1;  //
          edtLote.Text := IntToStr(lote);
          fechamento := true;
        end;
       end;
      end;
    end;

    if fechamento then
    begin
      edtLote.Text := IntToStr(lote);
      statusExportar(1); // ativa export com cor verde

      //inicio da transacao

      try
        tfdTransaction.Create(Self);
        tfdTransaction.Connection := dmConexao.ConnMega;
        tfdTransaction.StartTransaction;

        try
        vDebito := 0; //o total dos debitos de todos os lancamentos
         //obtendo a lista com os lan�amentos
         pPonto := 'Obtendo LISTA DE LAN�AMENTOS  > ';

         lista := dmExportaFinance.obterTPPROVBase(idOrganizacao, ano, pDataInicial, pDataFinal, codEmpresa, lote, loMostraErros);

        // PEGANDO O VALOR DE DEBITO DE PTABLE TP
           vDebito := dmExportaFinance.obterValorDebitoGeneric(idOrganizacao, pTable, 'VALOR_NOMINAL','DATA_EMISSAO', pDataInicial, pDataFinal);
        //Gravando CLOTES para CBT
          if vDebito > 0 then
          begin
            if not dmMegaContabil.obterLotePorFiltro(codEmpresa, lote, ano) then
            begin

              if dmMegaContabil.gravarCLote(ano, pIdClotes, codEmpresa, lote, vDebito) then
              begin
                imgGravaLote.Visible := True;
                lblGravaLoteMega.Visible := True;
                ultimoLoteSC := lote;
                Application.ProcessMessages;
                Sleep(5000);

                //REALIZAR A EXPORTA��O
                  qtdReg := exportarLancamentosMega(pTable,lista);


                if qtdReg > 0 then
                begin
                  lblExportaTPPROV.Visible := True;
                  imgTPPROV.Visible := True;
                  Application.ProcessMessages;
                  Sleep(5000);
                  btnExportaTPPROV.Enabled := False;
                  loMostraErros.Add('Lan�amentos EXPORTADOS - ' + pTipo, False, True);
                  loMostraErros.Add(' Foram exportadas ' + IntToStr(qtdReg) + ' '+  pTipo, False, True);
                  loMostraErros.Add(' ---------------------------------------------------', True, True);

                end
                else
                begin
                  limpaPainelExportacao;
                  loMostraErros.Add('N�o foram encontrados registros de ' + pTipo, True, True);

                end;

                tfdTransaction.Commit;

              end;

            end
            else
            begin
              lblGravaLoteMega.Visible := False;
              imgGravaLote.Visible := False;
              limpaPainelExportacao;
              ShowMessage('N�o foi poss�vel gravar o lote no sistema cont�bil. ' + pTipo);
            end;

          end
          else
          begin
            limpaPainelExportacao;
            ShowMessage('N�o foram encontrados lan�amentos ' + pTipo + ' para exportar.');
          end;

        except
          limpaPainelExportacao;
          tfdTransaction.Rollback;
          raise(Exception).Create('Ocorreram problemas com a exporta��o. Transa��o interrompida inesperadamente. ' + pPonto + pTipo);
        end;

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Erro ao tentar gravar o lote no Sistema Cont�bil! '+ pTipo);
      end;

    end;
  end;
  try
    limpaPainelExportacao;
    loMostraErros.caption := 'Aviso - Exporta��es  '+ pTipo;
    if loMostraErros.Count > 0 then
    begin
      loMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(loMostraErros);
  end;

//ATE AQUI
end;

procedure TfrmExportacao.btnExportaTPQClick(Sender: TObject);
var
 tipoLancamento, pPonto, pTipo, pTable, IdFechamento, idLote: string;
  pId, loteInicial: Integer;
  fechamento: Boolean;
  vDebito: Currency;
  //armazena qtd de registros exportados
  qtdReg : Integer;
  lista: TListaLancamentos;

begin
  tipoLancamento :='QUITADO';
  pTable :=  'TITULO_PAGAR';
  pTipo :='TPB_PROV'; //TITULO A PAGAR PROVISIONADO
  lista := TListaLancamentos.Create;
  fechamento := true;
  cnpj := TOrgAtual.getCNPJ;
  codEmpresa := 0;
  qtdReg := 0;
  loMostraErros := TFMostraErros.Create(Self);
  limpaPainelExportacao;
   framePB1.progressBar(0,100);
   framePB1.Visible :=True;
 //se falhar acima. Pega o CNPJ  direto no database FInance
  if cnpj = '' then
  begin
    try
     pPonto := 'Obtendo CNPJ - FNC';
      cnpj := dmOrganizacao.obterCNPJOrganizacao;
    except
      raise(Exception).Create('Impossivel obter o CNPJ da Organiza��o.');
    end;

  end;

  // Obter o codigo da empresa no MEGA usando o cnpj
  try
  pPonto := 'Obtendo ID MEGA   ';
    codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);

  except
    raise(Exception).Create('Impossivel obter o identificador da empresa no Sistema Cont�bil. '+ pPonto + pTipo);
  end;

  // verifica se o lote informado existe
  if not codEmpresa = (-1) then
  begin
    lote        := StrToInt(edtLote.Text);
    loteInicial := lote;
    ano         := cbxAnoLote.Text;

    //verifica se existe o lote que esta sendo inserido
    //verificacao em CLOTES do MEGA

    if dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) then
    begin

      idLote := dmMegaContabil.qryExistLote.FieldByName('ID').AsString;

      ShowMessage('Lote j� existe no Sistema Cont�bil. ');

      fechamento := false;
      btnImprimir.Enabled := false;
      Limpatela(Self);
      limpaPainelExportacao;
    end

  end;

  // verifica se tem ID_ORGANIZACAO Selecionada
  if idOrganizacao = '' then
  begin
    ShowMessage('Ser� preciso selecionar uma Organiza��o antes de prosseguir.');
    fechamento := false;
    btnImprimir.Enabled := false;
    Limpatela(Self);
    limpaPainelExportacao;

  end
  else
  begin
     // verifica se tem fechamento apos a data inicial at� 2020 e impede importar
    // recebe o ID EMPRESA e a data incial
    //ver com Roberto o prazo 2020

    if not (codEmpresa = (-1)) then
    begin

      IdFechamento := dmMegaContabil.verificaFechamento(codEmpresa, pDataInicial);
    end;
    if not (IdFechamento = string.Empty) then
    begin
      limpaPainelExportacao;
      fechamento := false;
      btnImprimir.Enabled := false;
      btnExportaTPPROV.Enabled := False;
      Limpatela(Self);
      ShowMessage('Tem fechamento registrado. N�o ser� poss�vel continuar. Verifique o periodo informado. ' );
    end;
    if not (codEmpresa = (-1)) then
    begin
    // pega o generator (ID) da tabela CLOTES
      pIdClotes := dmMegaContabil.retornarIDPorTabela('CLOTES');
      ano := cbxAnoLote.Text;
     // codEmpresa := dmMegaContabil.obterIDEmpresa(cnpj);  feito na linha  117
      lote :=0;

      if not (edtLote.Text = '') then begin
      lote := StrToInt(edtLote.Text);
      end;
      loteInicial := lote;


      if (dmMegaContabil.lotesRestritos(lote)) then
      begin
        edtLote.Text := 'LOTE RESTRITO';
        cbxAnoLote.ItemIndex := 0;
        cbxMesLote.ItemIndex := 0;
        idLote := '';
      end
      else
      begin
       if lote >0 then begin
        while dmMegaContabil.VerificaSeExistLote(codEmpresa, lote, ano) do
        begin
        //verificar no papel pq  / { TODO -oRanan -cLote :  Ver pq nao pode lote 65 e 75 }
          lote := lote + 1;  //
          edtLote.Text := IntToStr(lote);
          fechamento := true;
        end;
       end;
      end;
    end;

    if fechamento then
    begin
      edtLote.Text := IntToStr(lote);
      statusExportar(1); // ativa export com cor verde

      //inicio da transacao

      try
        tfdTransaction.Create(Self);
        tfdTransaction.Connection := dmConexao.ConnMega;
        tfdTransaction.StartTransaction;

        try
        vDebito := 0; //o total dos debitos de todos os lancamentos
         //obtendo a lista com os lan�amentos
         pPonto := 'Obtendo LISTA DE LAN�AMENTOS  > ';

         lista := dmExportaFinance.obterTPB_PROV(idOrganizacao, ano, pDataInicial, pDataFinal, codEmpresa, lote, loMostraErros);

        // PEGANDO O VALOR DE DEBITO DE PTABLE TP
           vDebito := dmExportaFinance.obterValorDebitoTPB(idOrganizacao, pTable, 'VALOR_NOMINAL','DATA_EMISSAO', pDataInicial, pDataFinal,1);
        //Gravando CLOTES para CBT
          if vDebito > 0 then
          begin
            if not dmMegaContabil.obterLotePorFiltro(codEmpresa, lote, ano) then
            begin

              if dmMegaContabil.gravarCLote(ano, pIdClotes, codEmpresa, lote, vDebito) then
              begin
                imgGravaLote.Visible := True;
                lblGravaLoteMega.Visible := True;
                ultimoLoteSC := lote;
                Application.ProcessMessages;
                Sleep(5000);

                //REALIZAR A EXPORTA��O
                qtdReg := exportarLancamentosMega(pTable,lista);

                if qtdReg > 0 then
                begin
                  lblExportaTPPROV.Visible := True;
                  imgTPPROV.Visible := True;
                  Application.ProcessMessages;
                  Sleep(5000);
                  btnExportaTPPROV.Enabled := False;
                  loMostraErros.Add('Lan�amentos EXPORTADOS - ' + pTipo, False, True);
                  loMostraErros.Add(' Foram exportadas ' + IntToStr(qtdReg) + ' '+  pTipo, False, True);
                  loMostraErros.Add(' ---------------------------------------------------', True, True);

                end
                else
                begin
                  limpaPainelExportacao;
                  loMostraErros.Add('N�o foram encontrados registros de ' + pTipo, True, True);

                end;

                tfdTransaction.Commit;

              end;

            end
            else
            begin
              lblGravaLoteMega.Visible := False;
              imgGravaLote.Visible := False;
              limpaPainelExportacao;
              ShowMessage('N�o foi poss�vel gravar o lote no sistema cont�bil. ' + pTipo);
            end;

          end
          else
          begin
            limpaPainelExportacao;
            ShowMessage('N�o foram encontrados lan�amentos ' + pTipo + ' para exportar.');
          end;

        except
          limpaPainelExportacao;
          tfdTransaction.Rollback;
          raise(Exception).Create('Ocorreram problemas com a exporta��o. Transa��o interrompida inesperadamente. ' + pPonto + pTipo);
        end;

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Erro ao tentar gravar o lote no Sistema Cont�bil! '+ pTipo);
      end;

    end;
  end;
  try
    limpaPainelExportacao;
    loMostraErros.caption := 'Aviso - Exporta��es  '+ pTipo;
    if loMostraErros.Count > 0 then
    begin
      loMostraErros.ShowModal;
    end;
  finally
    FreeAndNil(loMostraErros);
  end;

//ATE AQUI
end;


procedure TfrmExportacao.btnExportaTRPROVClick(Sender: TObject);
begin
ShowMessage('Em constru��o');
framePB1.progressBar(0,100);
   framePB1.Visible :=True;

end;

procedure TfrmExportacao.btnExportaTRQClick(Sender: TObject);
begin
ShowMessage('Em constru��o');
framePB1.progressBar(0,100);
   framePB1.Visible :=True;
end;

procedure TfrmExportacao.btnGeraLoteClick(Sender: TObject);
var
  aux: Integer;
  vDebito : Currency;
  tipoLancamento :string;
begin
   vDebito :=0;




     aux :=0;
  // dmOrganizacao.carregarDadosEmpresa(idOrganizacao); ver
     limpaPainelExportacao;


   //  inicializarDM(Self);
   // Essa parte � s� para impress�o e libera��o dos bot�es de exporta��o
     pDataInicial :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataInicial.Date));
     pDataFinal :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataFinal.Date));


     //transferencia entre contas
          tipoLancamento := 'TRANSFERENCIA ENTRE CONTAS';  //operaco bancaria
          vDebito := dmExportaFinance.obterValorDebitoGenericTOB(idOrganizacao, 'CONTA_BANCARIA_TRANSFERENCIA', 'VALOR',tipoLancamento, pDataInicial, pDataFinal);
      if ( vDebito  > 0 ) then begin

                      btnExportarCBT.Enabled := permiteExportar(pDataInicial,pDataFinal);
                      dmRelExportacaoMega.obterCBT(idOrganizacao, pDataInicial, pDataFinal) ;
                      aux := Trunc(vDebito);

      end;

           // transferencia Banco para a Tesouraria
          vDebito :=0;
          tipoLancamento := 'TRANSFERE BANCO/TESOURARIA';
          vDebito := dmExportaFinance.obterValorDebitoGenericTOB(idOrganizacao, 'CONTA_BANCARIA_DEBITO', 'VALOR',tipoLancamento, pDataInicial, pDataFinal);
      if ( vDebito  > 0 ) then begin

            if(permiteExportar(pDataInicial,pDataFinal)) then begin


                     btnExportarTBT.Enabled := permiteExportar(pDataInicial,pDataFinal);
                     dmRelExportacaoMega.obterTRFBancoCaixa(idOrganizacao, pDataInicial, pDataFinal);
                     aux := Trunc(vDebito);
            end;
      end;

      //btnExportarCaixaBanco
       // transferencia Tesouraria para o Banco
          vDebito :=0;
          tipoLancamento := 'DEPOSITO TESOURARIA/BANCO';
          vDebito := dmExportaFinance.obterValorDebitoGenericTOB(idOrganizacao, 'CONTA_BANCARIA_CREDITO', 'VALOR',tipoLancamento, pDataInicial, pDataFinal);
      if ( vDebito  > 0 ) then begin

            if(permiteExportar(pDataInicial,pDataFinal)) then begin


                     btnExportarCaixaBanco.Enabled := permiteExportar(pDataInicial,pDataFinal);
                     dmRelExportacaoMega.obterTRFCaixaBanco(idOrganizacao, pDataInicial, pDataFinal);
                     aux := Trunc(vDebito);
            end;
      end;

        //titulos a PAGAR provisionados   //DECIDIR SER O RELATORIO IR� TRAZER TITULOS QUE JA FORAM EXPORTADOS
           vDebito :=0;
           tipoLancamento := 'ABERTO/QUITADO';
           vDebito := dmExportaFinance.obterValorDebitoTitulo(idOrganizacao, 'TITULO_PAGAR', 'VALOR_NOMINAL', 'DATA_EMISSAO',pDataInicial, pDataFinal, 1);
      if ( vDebito  > 0 ) then begin

            if(permiteExportar(pDataInicial,pDataFinal)) then begin

                     btnExportaTPPROV.Enabled := permiteExportar(pDataInicial,pDataFinal);
                     dmRelExportacaoMega.obterTPProBase(idOrganizacao, pDataInicial, pDataFinal);
                     aux := Trunc(vDebito);
            end;
      end;

       //titulos a PAGAR BAIXA
           vDebito :=0;
           tipoLancamento := 'QUITADO';
           vDebito := dmExportaFinance.obterValorDebitoTPB(idOrganizacao, 'TITULO_PAGAR', 'VALOR_NOMINAL', 'DATA_PAGAMENTO',pDataInicial, pDataFinal,1);
      if ( vDebito  > 0 ) then begin

            if(permiteExportar(pDataInicial,pDataFinal)) then begin

                     btnExportaTPQ.Enabled := permiteExportar(pDataInicial,pDataFinal);
                     dmRelExportacaoMega.obterTPQuitados(idOrganizacao, tipoLancamento, pDataInicial, pDataFinal);
                     aux := Trunc(vDebito);
            end;
      end;

            //titulos a RECEBER provisionados
       vDebito :=0;
          tipoLancamento := 'ABERTO/QUITADO';
          vDebito := dmExportaFinance.obterValorDebitoTitulo(idOrganizacao, 'TITULO_RECEBER', 'VALOR_NOMINAL', 'DATA_EMISSAO',pDataInicial, pDataFinal,1);
      if ( vDebito  > 0 ) then begin

            if(permiteExportar(pDataInicial,pDataFinal)) then begin

                     btnExportaTRPROV.Enabled := permiteExportar(pDataInicial,pDataFinal);
                     dmRelExportacaoMega.obterTRProBase(idOrganizacao, pDataInicial, pDataFinal);
                     aux := Trunc(vDebito);
            end;
      end;

        //titulos a RECEBER BAIXA
           vDebito :=0;
           tipoLancamento := 'QUITADO';
           vDebito := dmExportaFinance.obterValorDebitoTRB(idOrganizacao, 'TITULO_RECEBER', 'VALOR_NOMINAL', 'DATA_PAGAMENTO',pDataInicial, pDataFinal,1);
      if ( vDebito  > 0 ) then begin

            if(permiteExportar(pDataInicial,pDataFinal)) then begin

                     btnExportaTRQ.Enabled := permiteExportar(pDataInicial,pDataFinal);
                     dmRelExportacaoMega.obterTRQuitados(idOrganizacao, tipoLancamento, pDataInicial, pDataFinal);
                     aux := Trunc(vDebito);
            end;
      end;



   if( aux >0) then begin
      btnImprimir.Visible := true;
      btnImprimir.Enabled := true;

      try
        if not (dmMegaContabil.obterIDEmpresa(TOrgAtual.getCNPJ) = (-1)) then
        begin
          if(permiteExportar(pDataInicial,pDataFinal)) then begin
             statusExportar(1);
          end
          else
          begin statusExportar(0) end;
        end else begin
         limpaPainelExportacao;
         end;
      except
        raise(Exception).Create('Impossivel obter o identificador da empresa.');
      end;
   end
    else begin
       ShowMessage('N�o existem dados para o per�odo informado...');
    end;

end;

procedure TfrmExportacao.btnImprimirClick(Sender: TObject);
begin

  if (liberaExibirRelatorio > 0) then
  begin
    dmRelExportacaoMega.exibirRelatorioExportacao(pDataInicial, pDataFinal);
     limpaPainelExportacao;
  end
  else
  begin
    btnImprimir.Enabled := false;
    limpaPainelExportacao;
    ShowMessage('N�o existem dados para imprimir.');
  end

end;

procedure TfrmExportacao.btnLimparClick(Sender: TObject);
begin
  limpaPainelExportacao;
  cbxMesLote.ItemIndex := 0;
  cbxAnoLote.ItemIndex := 0;
  dtDataInicial.Date := now;
  dtDataFinal.Date := now;
  edtLote.Text :='';
end;

procedure TfrmExportacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM();
 Action := caFree; // sempre como ultimo comando
end;

procedure TfrmExportacao.FormCreate(Sender: TObject);
begin
  // LimpaTela(Self);

  inicializarDM(Self);
  cbxAnoLote.Enabled := true;
  cbxMesLote.ItemIndex := 0;
  cbxAnoLote.ItemIndex := 0;
  btnGeraLote.Enabled := false;
  cbxMesLote.Enabled := false;
  statusExportar(0);
  idOrganizacao := TOrgAtual.getId;
  dtDataInicial.Date := now;
  dtDataFinal.Date := now;
  statusExportar(0);
  limpaPainelExportacao;
  verificaHistoricoSemConta;


  // obterIdMega; So vai obter no botao exportar

end;

procedure TfrmExportacao.inicializarDM(Sender: TObject);
begin
  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;


  try
      dmConexao.conectarMega;
  except on E: Exception do
      ShowMessage(' '+ e.Message);
  end;

  try
       dmConexao.conectarBanco;

  except on E: Exception do
      ShowMessage(' '+ e.Message);
  end;

  if not (Assigned(dmRelExportacaoMega)) then
  begin
    dmRelExportacaoMega := TdmRelExportacaoMega.Create(Self);
  end;


  if not (Assigned(dmMegaContabil)) then
  begin
    dmMegaContabil := TdmMegaContabil.Create(Self);
  end;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not (Assigned(dmExportaFinance)) then
  begin
    dmExportaFinance := TdmExportaFinance.Create(Self);
  end;


end;

// tipo:  cbt = 1 ; cbd=2; cbc = 3; tp = 4; tpb=5; tr=6; trb=7
function TfrmExportacao.liberaExibirRelatorio: Integer;
var
  valor: Integer;
begin
  valor := 0;

  valor := 100;
  Result := valor;

end;

procedure TfrmExportacao.limpaPainelExportacao;
begin
//IMAGE
imgGravaLote.Visible := False;
imgGravaLoteFinance.Visible := False;
imgCBT.Visible := False;
imgTPPROV.Visible := False;
imgTPQ.Visible := False;
imgTRPROV.Visible := False;
imgTRQ.Visible := False;
imgTBT.Visible := False;
imgTTB.Visible := False;

statusExportar(0);

//LABEL
lblGravaLoteMega.Visible := False;
lblSalvaLoteFnc.Visible := False;
lblExportaCBT.Visible := False;
lblExportaTBT.Visible := False;
lblExportaTTB.Visible := False;
lblExportaTPPROV.Visible := False;
lblExportaTP.Visible := False;
lblExportaTR.Visible := False;
lblExportaTRPROV.Visible := False;
lblStatusSistemaContabil.Caption := 'Aguardando conex�o';


//BOTOES
btnImprimir.Enabled := False;
btnExportarCBT.Enabled := False;
btnExportarTBT.Enabled := False;
btnExportarCaixaBanco.Enabled := False;
btnExportaTPPROV.Enabled := False;
btnExportaTPQ.Enabled := False;
btnExportaTRPROV.Enabled := False;
btnExportaTRQ.Enabled := False;

btnGeraLote.Enabled :=False;

framePB1.Visible :=False;


end;

procedure TfrmExportacao.freeAndNilDM();
begin

   //existe
  if (Assigned(dmExportaFinance)) then
  begin
       FreeAndNil(dmExportaFinance);
  end;


  if (Assigned(dmExdportFinanceManter)) then
  begin
       FreeAndNil(dmExdportFinanceManter);
  end;

  if  (Assigned(dmMegaContabil)) then
  begin
    FreeAndNil(dmMegaContabil);
  end;

  if  (Assigned(dmRelExportacaoMega)) then
  begin
    FreeAndNil(dmRelExportacaoMega);
  end;

  if  (Assigned(dmTPDTS)) then
  begin
    FreeAndNil(dmTPDTS);
  end;

  if  (Assigned(dmHistoricoConsulta)) then
  begin
    FreeAndNil(dmHistoricoConsulta);
  end;


//  if (Assigned(dmExportFinanceTP)) then
 // begin
  //  FreeAndNil(dmExportFinanceTP);
  //end;

  //if  (Assigned(dmExportFinanceTR)) then
  //begin
   // FreeAndNil(dmExportFinanceTR);
  //end;

  // conta bancaria transferencia

   {
  if  (Assigned(dmCBT)) then
  begin
    FreeAndNil(dmCBT);
  end;

  // conta bancaria credito
  if  (Assigned(dmCBCConsulta)) then
  begin
    FreeAndNil(dmCBCConsulta);
  end;

  // conta bancaria debito
  if  (Assigned(dmCBDConsulta)) then
  begin
    FreeAndNil(dmCBDConsulta);
  end;
    }

end;

procedure TfrmExportacao.statusExportar(sinal: Integer);
begin

  // So ativa o sinal verde
  if sinal = 1 then
  begin
    imgGreen.Visible := true;
    imgGreen.Top := 117;
    imgRed.Visible := false;
    imgRed.Top := 117;
  end;

  // So 10ativa o sinal verde
  if sinal = 0 then
  begin
    imgGreen.Visible := false;
    imgGreen.Top := 117;
    imgRed.Visible := true;
    imgRed.Top := 117;
  end;

end;



procedure TfrmExportacao.verificaHistoricoSemConta;
begin
 // verifica se existem historicos sem conta contabil e avisa no label
      if   dmExportaFinance.obterListaHistoricoSemContaContabil(TOrgAtual.getId) then
      begin
        lblHistoricoSemConta.Visible := true;
        lblHistoricoSemConta.Caption := 'Existem Hist�ricos sem Conta Cont�bil. Mantenha os hist�ricos atualizados!';
      end;

end;

procedure TfrmExportacao.cbxAnoLoteClick(Sender: TObject);
begin

  if cbxAnoLote.ItemIndex > 0 then
  begin
    cbxMesLote.Enabled := true;
  end
  else
  begin
    cbxMesLote.Enabled := false;
    edtLote.Enabled := false;
    dtDataInicial.Enabled := false;
    dtDataFinal.Enabled := false;
    btnGeraLote.Enabled := false;

  end;

end;

procedure TfrmExportacao.cbxMesLoteChange(Sender: TObject);
begin
  case cbxMesLote.ItemIndex of

    0:
      edtLote.Text := '';
    1:
      edtLote.Text := IntToStr(10);
    2:
      edtLote.Text := IntToStr(20);
    3:
      edtLote.Text := IntToStr(30);
    4:
      edtLote.Text := IntToStr(40);
    5:
      edtLote.Text := IntToStr(50);
    6:
      edtLote.Text := IntToStr(60);
    7:
      edtLote.Text := IntToStr(70);
    8:
      edtLote.Text := IntToStr(80);
    9:
      edtLote.Text := IntToStr(90);
    10:
      edtLote.Text := IntToStr(100);
    11:
      edtLote.Text := IntToStr(110);
    12:
      edtLote.Text := IntToStr(120);
  end;

  if cbxMesLote.ItemIndex > 0 then
  begin
    dtDataInicial.Enabled := true;
    btnGeraLote.Enabled := true;
  end
  else
  begin
    edtLote.Enabled := false;
    btnGeraLote.Enabled := false;
  end;
end;



procedure TfrmExportacao.dsPagosDataChange(Sender: TObject; Field: TField);
var
  tituloPagarQuitado, idOrganizacao, tituloTPB: String;
begin
  tituloPagarQuitado := dmRelExportacaoMega.qryTPQuitados.FieldByName('ID_TITULO_PAGAR').AsString;
  idOrganizacao := dmRelExportacaoMega.qryTPQuitados.FieldByName('ID_ORGANIZACAO').AsString;
  //obter os hitoricos
  dmRelExportacaoMega.obterTPBHistorico(idOrganizacao,tituloPagarQuitado);
  // obter a baixa
  dmRelExportacaoMega.obterTPBaixaPorTitulo(idOrganizacao, tituloPagarQuitado);
  tituloTPB := dmRelExportacaoMega.qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
  // baixa POR TEsouraria
  dmRelExportacaoMega.obterTPBCaixa(idOrganizacao, tituloTPB);
  //obter por Cheque
  dmRelExportacaoMega.obterTPBCheque(idOrganizacao, tituloTPB);
  // obter baixa por Banco
  dmRelExportacaoMega.obterTPBBanco(idOrganizacao, tituloTPB);
  // dts acrescimo
  dmRelExportacaoMega.obterTPBAC(idOrganizacao, tituloTPB);
  // dts deducao
  dmRelExportacaoMega.obterTPBDE(idOrganizacao, tituloTPB);

end;

procedure TfrmExportacao.dtDataFinalChange(Sender: TObject);
begin
btnGeraLote.Enabled := true;
end;

procedure TfrmExportacao.dtDataInicialChange(Sender: TObject);
begin
btnGeraLote.Enabled := true;
end;

procedure TfrmExportacao.ativaShapeExportaca(shape: Integer);
begin

  case shape of
    1:
      ShowMessage('wwww');
    2:
      imgGravaLoteFinance.Visible := true


  end;
end;


function TfrmExportacao.exportarLancamentosMega(pTable :string; lista :TListaLancamentos ): Integer;
  var
 tamLista, listaDB,listaCR, lancamentoDB, lancamentoCR,  aux: Integer;
  vDEB, vCRE :Currency;
begin
     linha :=0;
     valorDebito:=0; valorCredito :=0;
     tamLista :=0; listaDB :=0; listaCR :=0; lancamentoDB :=0; lancamentoCR :=0;  aux :=0;

  if (lista <> nil) then
  begin

     tamLista := TListaLancamentoDebito(lista).Count ;   //usado s� na barra de progresso

    for   listaCR := 0 to TListaLancamentoCredito(lista).Count -1 do begin
      for lancamentoCR := 0 to TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Count  - 1 do
      begin
            Inc(linha);
        dmMegaContabil.insereLancamentoCRE(StrToInt(ano),lote,linha,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).CodReduzCre,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).CodHistorico,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).Historico,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).Complemento,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).DgCodReduzCre,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).ContaCredito,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).DgContaCredito,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).Tipo,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).IdRegistroFinance,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).FncIdentificacao,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).Valor,
                                          TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).Data
                                          );

                                          //insere debito
                                          valorCredito := valorCredito + TLancamentoCreditoModel(TListaLancamentoCredito(lista.ListaCredito[listaCR]).FListaLancamentoCredito.Items[lancamentoCR]).Valor;

                                          framePB1.progressBar(linha,(tamLista+1));
                                          Application.ProcessMessages;
        end;

     end;



     for  listaDB := 0 to TListaLancamentoDebito(lista).Count-1 do begin
        for lancamentoDB := 0 to TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Count  - 1 do
        begin
      //  INC(X);
         Inc(linha);
      dmMegaContabil.insereLancamentoDEB(StrToInt(ano),lote,linha,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).CodReduzDeb,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).CodHistorico,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).Historico,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).Complemento,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).DgCodReduzDeb,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).ContaDebito,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).DgContaDebito,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).Tipo,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).IdRegistroFinance,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).FncIdentificacao,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).Valor,
                                        TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).Data );


                                        valorDebito := valorDebito +  TLancamentoDebitoModel(TListaLancamentoDebito(lista.ListaDebito[listaDB]).FListaLancamentoDebito.Items[lancamentoDB]).Valor;

                                        framePB1.progressBar(linha,(tamLista+1));
                                        Application.ProcessMessages;
      end;

     end;


    if dmMegaContabil.obterCLoteError(codEmpresa, lote, ano) then
    begin
       framePB1.progressBar(1,tamLista);
       Application.ProcessMessages;

                  loMostraErros.Add('Existe diferen�a de valores no lote', False, True);
                  loMostraErros.Add(' Verifique o relat�rio de lote ' + IntToStr(lote), False, True);
                  loMostraErros.Add(' ERRO EM CLOTE----------------------------------------------------', True, True);


      //ver o que fazer quando encontrar
           raise(Exception).Create('Ocorreram problemas com a exporta��o. CLOTES');

    end;

    if dmMegaContabil.obterCDataError(codEmpresa, ano) then
    begin
     framePB1.progressBar(1,tamLista);
      Application.ProcessMessages;
       loMostraErros.Add('Existe diferen�a de valores no lote', False, True);
       loMostraErros.Add(' Verifique o relat�rio de lote ' + IntToStr(lote), False, True);
       loMostraErros.Add(' ERRO EM CDATA--------------------------------------------------', True, True);

      //ver o que fazer quando encontrar
      //lan�ar o registro na table pendencias da exportacao

            {
        CREATE TABLE LANC_EXPORT_PEND (
            ID              VARCHAR(36) NOT NULL,
            ID_ORGANIZACAO  VARCHAR(36) NOT NULL,
            VALOR           NUMERIC(10,2) NOT NULL,
            TIPO            VARCHAR(100),
            IDENTIFICACAO   VARCHAR(100),
            PENDENCIA       VARCHAR(1000),
            DATA_REGISTRO   DATE
        ); }

        {

CREATE TABLE LOTE_CONTABIL (
    ID_LOTE_CONTABIL  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO    VARCHAR(36) NOT NULL,
    LOTE              VARCHAR(30),
    STATUS            VARCHAR(30),
    ID_USUARIO        NUMERIC(5,0),
    DATA_REGISTRO     DATE,
    DATA_ATUALIZACAO  DATE NOT NULL,
    QTD_TIT_PAG       NUMERIC(5,0),
    QTD_TIT_REC       NUMERIC(5,0),
    QTD_TIT_PAG_BX    NUMERIC(5,0),
    QTD_TIT_REC_BX    NUMERIC(5,0),
    QTD_TES_CRED      NUMERIC(5,0),
    QTD_CTA_DEB       NUMERIC(5,0),
    QTD_CTA_TRA       NUMERIC(5,0),
    QTD_CTA_CRE       NUMERIC(5,0),
    QTD_TES_DEB       NUMERIC(5,0),
    PERIODO_INICIAL   DATE,
    PERIODO_FINAL     DATE,
    TIPO_TABLE        VARCHAR(200) CHARACTER SET ISO8859_1,
    QTD_REGISTROS     SMALLINT,
    VALOR_DB          NUMERIC(10,2),
    VALOR_CR          NUMERIC(10,2)
);

           }

             raise(Exception).Create('Ocorreram problemas com a exporta��o. CDATA');


    end;

          //gravar o lote informando o tipoExportado
         //linha deve retornar o total de lancamentos.
           linha :=  (linha div 2);

    //(pIdLote, pIdOrganizacao, pLote, pDataInicial, pDataFinal: string; pLista :TListaLancamentos; pTable :string):
    if (dmExportaFinance.gravarLoteContabil('FNCEXP@' + ano + '@' + IntToStr(lote) + '@' + IntToStr(linha), idOrganizacao,
        IntToStr(lote), FormatDateTime('dd/mm/yyyy', dtDataInicial.Date), FormatDateTime('dd/mm/yyyy', dtDataFinal.Date),
          lista, pTable,linha, valorDebito, valorCredito)) then
       begin

      lblSalvaLoteFnc.Visible := True;
      imgGravaLoteFinance.Visible := True;
      aux := linha + (100 - linha);
      framePB1.progressBar(100,tamLista);
      Application. ProcessMessages;
      Sleep(1000);


    end;


  end;

  Result := linha;
end;





function TfrmExportacao.permiteExportar(pDataInicial, pDataFinal:Tdate):Boolean;
var
aux :Boolean;
dias, meses :Integer;
conexaoMega : string;

begin
aux := True;
conexaoMega := 'BASE DE DADOS DO SISTEMA CONT�BIL CONECTADA';
 dias := DaysBetween(pDataInicial, pDataFinal);
 meses := MonthsBetween(pDataInicial, pDataFinal);


   //N�o permite exporta��o de mais de 31 dias
      if(DaysBetween(pDataInicial, pDataFinal)>31) then begin
           aux:=False;
       end;

       //N�o permite exporta��o de meses diferentes
       //pode ser criado um parametro para permitir isso
      if(MonthsBetween(pDataInicial, pDataFinal)>0) then begin
           aux:=False;
       end;




       if not dmConexao.conectarMega then begin
            aux :=False;
            conexaoMega := ' SISTEMA CONT�BIL N�O ENCONTRADO';

       end;

       lblStatusSistemaContabil.Caption := conexaoMega;
       Application.ProcessMessages;

Result := aux;
end;




end.


