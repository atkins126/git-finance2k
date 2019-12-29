unit uFrmManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, udmConexao,System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  uDMContasPagarManter, uUTil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, uFrameOrganizacoes,
  uFrameBDTables, uFrameProgressBar, uFramePeriodo, Vcl.ExtCtrls;

type
  TfrmManutencao = class(TForm)
    pgcAjustes: TPageControl;
    tbsTP: TTabSheet;
    tbsTR: TTabSheet;
    btnDeletarExcluidos: TBitBtn;
    dbgrdMain: TDBGrid;
    dsPreencheGrid: TDataSource;
    tsTabelas: TTabSheet;
    frameOrgs: TframeOrg;
    frameBDTables: TfrmBDTables;
    btn1: TButton;
    lbl1: TLabel;
    qryQtdRegistros: TFDQuery;
    dbgrd2: TDBGrid;
    lbl2: TLabel;
    ds2: TDataSource;
    btnAjustaDataEmissaoTP: TButton;
    qryTodosTP: TFDQuery;
    qryAjustaDataEmissao: TFDQuery;
    qryDeletaTP: TFDQuery;
    FDSDeletaTP: TFDStoredProc;
    qryObterFilhosTP: TFDQuery;
    qryRemoveFilhoTP: TFDQuery;
    qryObterRateioHistorico: TFDQuery;
    qryAjustaHistorico: TFDQuery;
    lblQryRecordCount: TLabel;
    qryObterRateioCC: TFDQuery;
    tsAjustaRateios: TTabSheet;
    frmPeriodo1: TfrmPeriodo;
    qryObterTodosTPPeriodo: TFDQuery;
    dbgrd1: TDBGrid;
    dsRateio: TDataSource;
    lbl3: TLabel;
    dbgrd3: TDBGrid;
    dsGridTR: TDataSource;
    qryObterTodosTRPeriodo: TFDQuery;
    pnlAjustaTP: TPanel;
    pnlAjustaTR: TPanel;
    qryAjustaRateioCC: TFDQuery;
    qryInsereHistorico: TFDQuery;
    qryObterBaixaBCO: TFDQuery;
    qryAjustaData: TFDQuery;
    btnAjustaDATAPAGTOTP: TButton;
    lbl4: TLabel;
    tsCedente: TTabSheet;
    btnLimparEnd: TBitBtn;
    qryObterEnderecos: TFDQuery;
    qryObterCedentePorEndereco: TFDQuery;
    qryDeletaEndereco: TFDQuery;
    qryObterSacadoPorEndereco: TFDQuery;
    framePB1: TframePB;
    qryObterFuncionarioPorEndereco: TFDQuery;
    btnFechar: TBitBtn;
    ts1: TTabSheet;
    tsMovimentoDiario: TTabSheet;
    btnLimpaMovDiario: TBitBtn;
    frmPeriodo2: TfrmPeriodo;
    procedure btnDeletarExcluidosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterNumDocClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure tsTabelasShow(Sender: TObject);
    procedure frameBDTablesds1DataChange(Sender: TObject; Field: TField);
    procedure btnAjustaDataEmissaoTPClick(Sender: TObject);
    procedure btnAjustaRateiosClick(Sender: TObject);
    procedure pnlAjustaTPClick(Sender: TObject);
    procedure pnlAjustaTRClick(Sender: TObject);
    procedure btnAjustaDATAPAGTOTPClick(Sender: TObject);
    procedure btnLimparEndClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimpaMovDiarioClick(Sender: TObject);

  private
    { Private declarations }
    idOrganizacao: String;
    procedure inicializarDM(Sender: TObject);
    procedure ObterQtdRegistro(pTable : string);
    function ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
    function obterFilhosPorTP(pIdOrganizacao,pIdTP :string): boolean;
    function removeFilhosTP(pIdOrganizacao,pIdTPFilho :string): boolean;

    function AjustarDataEmissaoTP(query :TFDQuery):boolean;
    function AjustaDataPagamentoTitulo(pTable :string; query :TFDQuery):boolean;

    function obterRateioHistorico(pIdOrganizacao,pIdTP, pTable :string): Integer;
    function obterRateioCC(pIdOrganizacao, pIdTP, pTable: string): Integer;
    function obterBaixaBanco(pIdOrganizacao,pIdTP, pTable :string): Boolean;

    function deletaTP(pIdOrganizacao,pID :string) :boolean;

    function ObterTodosTitulosPagarPeriodo(pIdOrganizacao: string; pDataInicio,   pDataFinal: Tdate): Boolean;
    function ObterTodosTitulosReceberPeriodo(pIdOrganizacao: string; pDataInicio,   pDataFinal: Tdate): Boolean;

    function AjustarValorRateioTP(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
    function AjustarValorRateioTR(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
    function insereHistorico(pIdOrganizacao, pIdTP, pIdHistorico,  pTable: string ; pValor :Currency): Boolean;

   ///LIMPAR TABELA ENDERECO
    function obterEndereco (pOrganizacao :string) : Boolean;
    function obterCedentePorEndereco(pOrganizacao, pEndereco: string): Integer;
    function obterSacadoPorEndereco(pOrganizacao, pEndereco: string): Integer;
    function obterFuncionarioPorEndereco(pOrganizacao, pEndereco: string): Integer;
    procedure limparTabelaEndereco;



  public
    { Public declarations }
  end;

var
  frmManutencao: TfrmManutencao;

implementation

{$R *.dfm}
{ TfrmManutencao }

function TfrmManutencao.AjustarValorRateioTR(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
var
 pBarra, qtdCC, qtdHistorico :Integer;
sqlAjusta, labelMSG,  idTR, idHistorico :string;
pValorHist, pValorCC,  pValor :Currency;
alterarCC, alterarHistorico :Boolean;
begin
    qtdHistorico:=0;
    qtdCC :=0;
    pValor := 0;
    pValorCC :=0;
    framePB1.Visible :=True;
    alterarCC :=False;
    alterarHistorico := False;

    if not (ObterTodosTitulosReceberPeriodo(pIdOrganizacao, pDataInicio, pDataFinal)) then begin

       ShowMessage('N�o existem  titulos para o per�odo informado');

    end;

    framePB1.progressBar(0,Trunc(qryObterTodosTRPeriodo.RecordCount));
    lblQryRecordCount.Caption       := 'Existem ' + IntToStr(qryObterTodosTRPeriodo.RecordCount) + ' a serem ajustados ' ;
    framePB1.lblProgressBar.Caption := 'Existem ' + IntToStr(qryObterTodosTRPeriodo.RecordCount) + ' a serem ajustados ' ;


      try
         qryObterTodosTRPeriodo.Open();
         qryObterTodosTRPeriodo.Last;
         qryObterTodosTRPeriodo.First;
        while not (qryObterTodosTRPeriodo.Eof) do begin
          qtdHistorico :=0;
          qtdCC :=0;
          idTR := qryObterTodosTRPeriodo.FieldByName('ID_TITULO_RECEBER').AsString;


          qtdHistorico := obterRateioHistorico(idOrganizacao, idTR, 'TITULO_RECEBER');
          qtdCC        := obterRateioCC(idOrganizacao, idTR, 'TITULO_RECEBER');
          pValor       := qryObterTodosTRPeriodo.FieldByName('VALOR_NOMINAL').AsCurrency;
          idHistorico  := qryObterTodosTRPeriodo.FieldByName('ID_HISTORICO').AsString;

          lbl4.Caption := 'Registro atual N� ' + IntToStr(qryObterTodosTRPeriodo.RecNo) + '  DOC ' +  qryObterTodosTRPeriodo.FieldByName('NUMERO_DOCUMENTO').AsString;
          Application.ProcessMessages;

             // PARTE DO AJUSTE DO RATEIO DE HISTORICOS

              if qtdHistorico = 0 then begin
               //inserir o historico principal
                try
                insereHistorico(idOrganizacao,idTR,idHistorico,'TITULO_RECEBER', pValor ) ;

                except
                    raise Exception.Create('N�o foi poss�vel ajustar o hist�rico do TR ' + idTR );
                end;

              end;


              if qtdHistorico >0 then begin
                 try

                  while not qryObterRateioHistorico.Eof do begin

                    if (qtdHistorico = 1) then begin

                        pValorHist := qryObterRateioHistorico.FieldByName('VALOR').AsCurrency;
                        if pValorHist <> pValor then
                        begin
                          alterarHistorico := True;
                        end;
                    end;

                     if (alterarHistorico)  then begin
                      sqlAjusta := ' UPDATE titulo_receber_historico TPH ' +
                                   ' SET TPH.valor = :PVALOR ' +
                                   ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPH.ID_TITULO_RECEBER = :PIDTR) ' ;


                       qryAjustaHistorico.Close;
                       qryAjustaHistorico.Connection := dmConexao.conn;
                       qryAjustaHistorico.SQL.Clear;
                       qryAjustaHistorico.SQL.Add(sqlAjusta);
                       qryAjustaHistorico.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaHistorico.ParamByName('PIDTR').AsString := idTR;
                       qryAjustaHistorico.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdHistorico);

                       qryAjustaHistorico.ExecSQL;
                       qryAjustaHistorico.Connection.CommitRetaining;

                     end;

                       qryObterRateioHistorico.Next;

                  end;

                 except
                  qryAjustaHistorico.Connection.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o hist�rico do TP  ' + idTR );

                 end;
              end;


               // PARTE DO AJUSTE DO RATEIO DE CENTRO DE CUSTOS


              if qtdCC > 0 then begin
                 try

                  while not qryObterRateioCC.Eof do begin

                    if (qtdCC = 1) then begin

                        pValorCC := qryObterRateioCC.FieldByName('VALOR').AsCurrency;
                        if pValorCC <> pValor then
                        begin
                          alterarCC := True;
                        end;
                    end;


                     if (alterarCC)  then begin

                      sqlAjusta := ' UPDATE titulo_receber_rateio_cc TPC ' +
                                   ' SET TPC.valor = :PVALOR ' +
                                   ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPC.ID_TITULO_RECEBER = :PIDTP)';

                       qryAjustaRateioCC.Close;
                       qryAjustaRateioCC.Connection := dmConexao.conn;
                       qryAjustaRateioCC.SQL.Clear;
                       qryAjustaRateioCC.SQL.Add(sqlAjusta);
                       qryAjustaRateioCC.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaRateioCC.ParamByName('PIDTP').AsString := idTR;
                       qryAjustaRateioCC.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdCC);
                       qryAjustaRateioCC.ExecSQL;
                       qryAjustaRateioCC.Connection.CommitRetaining;


                     end;


                       qryObterRateioCC.Next;

                  end;

                 except
                  dmConexao.conn.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o hist�rico do TP  ' + idTR );

                 end;
              end;

           qryObterTodosTRPeriodo.Next;

           pBarra := qryObterTodosTRPeriodo.RecNo;
          //parte da barra de progresso
          labelMSG := 'Processando os valores dos rateios  do registro ' + IntToStr(pBarra) + ' de ' + IntToStr(qryObterTodosTRPeriodo.RecordCount);
          framePB1.progressBar(1, Trunc(qryObterTodosTRPeriodo.RecordCount ) );
          framePB1.lblProgressBar.Caption := labelMSG;
          Application.ProcessMessages;

        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;

       dmConexao.Conn.CommitRetaining;


    Result :=System.True;

end;



function TfrmManutencao.AjustarValorRateioTP(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
var
pBarraPercent, pBarra, qtdCC, qtdHistorico :Integer;
idHistorico, sqlAjusta, labelMSG,  idTP :string;
pValorHist, pValorCC,  pValor :Currency;
alterarCC, alterarHistorico :Boolean;
begin
    qtdHistorico:=0;
    qtdCC :=0;
    pValor := 0;
    pValorCC :=0;
    framePB1.Visible :=True;
    framePB1.progressBar(0,0);
    alterarCC :=False;
    alterarHistorico := False;

    if not (ObterTodosTitulosPagarPeriodo(pIdOrganizacao, pDataInicio, pDataFinal)) then begin

      raise Exception.Create('Erro ao tentar obter os titulos por periodo');
    end;
    lblQryRecordCount.Caption := 'Existem ' + IntToStr(qryObterTodosTPPeriodo.RecordCount) + ' a serem ajustados ' ;
    framePB1.lblProgressBar.Caption := 'Existem ' + IntToStr(qryObterTodosTPPeriodo.RecordCount) + ' a serem ajustados ' ;


      try
         qryObterTodosTPPeriodo.Open();
         qryObterTodosTPPeriodo.Last;
         qryObterTodosTPPeriodo.First;
        while not (qryObterTodosTPPeriodo.Eof) do begin
          qtdHistorico :=0;
          qtdCC :=0;
          idTP := qryObterTodosTPPeriodo.FieldByName('ID_TITULO_PAGAR').AsString;

          qtdHistorico := obterRateioHistorico(idOrganizacao, idTP, 'TITULO_PAGAR');
          qtdCC        := obterRateioCC(idOrganizacao, idTP, 'TITULO_PAGAR');
          pValor       := qryObterTodosTPPeriodo.FieldByName('VALOR_NOMINAL').AsCurrency;
          idHistorico := qryObterTodosTPPeriodo.FieldByName('ID_HISTORICO').AsString;

          lbl4.Caption := 'Registro atual N� ' + IntToStr(qryObterTodosTPPeriodo.RecNo) + '  DOC ' +  qryObterTodosTPPeriodo.FieldByName('NUMERO_DOCUMENTO').AsString;
          Application.ProcessMessages;

             // PARTE DO AJUSTE DO RATEIO DE HISTORICOS



              if qtdHistorico = 0 then begin
               //inserir o historico principal
                try
                insereHistorico(idOrganizacao,idTP,idHistorico,'TITULO_PAGAR', pValor ) ;
                except
                   raise Exception.Create('N�o foi poss�vel ajustar o hist�rico do TP ' + idTP );

                end;

              end;


              if qtdHistorico >0 then begin
                 try

                  while not qryObterRateioHistorico.Eof do begin

                    if (qtdHistorico = 1) then begin

                        pValorHist := qryObterRateioHistorico.FieldByName('VALOR').AsCurrency;
                        if pValorHist <> pValor then
                        begin
                          alterarHistorico := True;
                        end;
                    end;

                     if (alterarHistorico)  then begin

                      sqlAjusta := ' UPDATE titulo_pagar_historico TPH ' +
                                   ' SET TPH.valor = :PVALOR ' +
                                   ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPH.ID_TITULO_PAGAR = :PIDTP) ' ;


                       qryAjustaHistorico.Close;
                       qryAjustaHistorico.Connection := dmConexao.conn;
                       qryAjustaHistorico.SQL.Clear;
                       qryAjustaHistorico.SQL.Add(sqlAjusta);
                       qryAjustaHistorico.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaHistorico.ParamByName('PIDTP').AsString := idTP;
                       qryAjustaHistorico.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdHistorico);

                       qryAjustaHistorico.ExecSQL;
                       qryAjustaHistorico.Connection.CommitRetaining;

                     end;

                       qryObterRateioHistorico.Next;

                  end;

                 except
                  qryAjustaHistorico.Connection.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o hist�rico do TP  ' + idTP );

                 end;
              end;


               // PARTE DO AJUSTE DO RATEIO DE CENTRO DE CUSTOS


              if qtdCC > 0 then begin
                 try

                  while not qryObterRateioCC.Eof do begin

                    if (qtdCC = 1) then begin

                        pValorCC := qryObterRateioCC.FieldByName('VALOR').AsCurrency;
                        if pValorCC <> pValor then
                        begin
                          alterarCC := True;
                        end;
                    end;

                     if (alterarCC)  then begin

                      sqlAjusta := ' UPDATE titulo_pagar_rateio_cc TPC ' +
                                   ' SET TPC.valor = :PVALOR ' +
                                   ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPC.ID_TITULO_PAGAr = :PIDTP)';

                       qryAjustaRateioCC.Close;
                       qryAjustaRateioCC.Connection := dmConexao.conn;
                       qryAjustaRateioCC.SQL.Clear;
                       qryAjustaRateioCC.SQL.Add(sqlAjusta);
                       qryAjustaRateioCC.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaRateioCC.ParamByName('PIDTP').AsString := idTP;
                       qryAjustaRateioCC.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdCC);
                       qryAjustaRateioCC.ExecSQL;
                       qryAjustaRateioCC.Connection.CommitRetaining;
                     end;

                       qryObterRateioCC.Next;

                  end;

                 except
                  qryAjustaRateioCC.Connection.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o hist�rico do TP  ' + idTP );

                 end;
              end;

           qryObterTodosTPPeriodo.Next;
           pBarra := qryObterTodosTPPeriodo.RecNo;
          //parte da barra de progresso
          labelMSG := 'Processando os valores dos rateios  do registro ' + IntToStr(pBarra) + ' de ' + IntToStr(qryObterTodosTPPeriodo.RecordCount);
          framePB1.progressBar(1, Trunc(qryObterTodosTPPeriodo.RecordCount) );
          framePB1.lblProgressBar.Caption := labelMSG;
          Application.ProcessMessages;


        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;

       dmConexao.Conn.CommitRetaining;

    Result :=System.True;

end;



procedure TfrmManutencao.btn1Click(Sender: TObject);
begin
frameBDTables.obterTabelas;
frameBDTables.dbgrd1.SelectedIndex :=1;
frameBDTables.dbgrd1.SetFocus;
end;

procedure TfrmManutencao.btnAjustaDataEmissaoTPClick(Sender: TObject);
begin

   if( AjustarDataEmissaoTP(ObterTodosTitulosPagar(TOrgAtual.getId))) then begin
    framePB1.lblProgressBar.Visible :=True;
    framePB1.lblProgressBar.Caption := 'Processo conclu�do...';
   end;

  end;


procedure TfrmManutencao.btnAjustaDATAPAGTOTPClick(Sender: TObject);
begin

   dmConexao.conectarBanco;
   framePB1.progressBar(0,0);
   framePB1.Visible :=True;

   lbl4.Caption := 'Ajustando datas';

  if AjustaDataPagamentoTitulo('TITULO_PAGAR', ObterTodosTitulosPagar(idOrganizacao)) then begin
    ShowMessage('Processo conclu�do');
   end;


end;

procedure TfrmManutencao.btnAjustaRateiosClick(Sender: TObject);
begin
//ajusta os valores dos rateios de historico e de centro de custos
  dmConexao.conectarBanco;
  framePB1.progressBar(0,0);
    framePB1.Visible :=True;
  AjustarValorRateioTR(idOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);

end;

procedure TfrmManutencao.btnAlterNumDocClick(Sender: TObject);
begin
// abre uma tela com dados do titulo a ser alterado

end;

procedure TfrmManutencao.btnDeletarExcluidosClick(Sender: TObject);
var
 gerador, idTP, tipoStatus: String;
I, aux, qtd :Integer;
listaExcluidos :TStringList;

begin
  idOrganizacao := TOrgAtual.getId;
  tipoStatus := 'EXCLUIDO';
  framePB1.Visible :=True;
  framePB1.progressBar(0,0);

  listaExcluidos := TStringList.Create;

  aux := 0;
  qtd := qryTodosTP.RecordCount;

  //preecnhe a lista de excluidos
    TFDQuery(dbgrdMain.DataSource.DataSet).Close;
    TFDQuery(dbgrdMain.DataSource.DataSet).Connection := dmConexao.Conn;
    TFDQuery(dbgrdMain.DataSource.DataSet).SQL.Clear;
    TFDQuery(dbgrdMain.DataSource.DataSet).SQL.Add(' SELECT * FROM TITULO_PAGAR TP ' +
                       ' WHERE (TP.ID_ORGANIZACAO =:PIDORGANIZACAO) AND ' +
                       ' (TP.ID_TIPO_STATUS = ''EXCLUIDO'') AND '+
                       ' (TP.ID_TITULO_GERADOR IS NULL) ' );
    TFDQuery(dbgrdMain.DataSource.DataSet).ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    TFDQuery(dbgrdMain.DataSource.DataSet).Open;


    qtd := TFDQuery(dbgrdMain.DataSource.DataSet).RecordCount;

   TFDQuery(dbgrdMain.DataSource.DataSet).Last;
   TFDQuery(dbgrdMain.DataSource.DataSet).First;
   while not TFDQuery(dbgrdMain.DataSource.DataSet).Eof do begin

    if(( TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TIPO_STATUS').AsString).Equals(tipoStatus)) then begin

      listaExcluidos.Add(TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString);
      Inc(aux);

    end;

    TFDQuery(dbgrdMain.DataSource.DataSet).Next;

   end;

   //tirando as rela��es de pai e filho dos titulos excluidos

   if listaExcluidos.Count >0  then begin

     for I := 0 to listaExcluidos.Count -1 do begin
           idTP  := listaExcluidos[I];
          if obterFilhosPorTP(idOrganizacao, idTP) then  begin
               qryObterFilhosTP.First;
                 while not qryObterFilhosTP.Eof do begin
                  removeFilhosTP(idOrganizacao,qryObterFilhosTP.FieldByName('ID_TITULO_PAGAR').AsString);
                  qryObterFilhosTP.Next;
                 end;
           end;
     end;
   end;


 // ObterTodosTitulosPagar(idOrganizacao);

  qtd := TFDQuery(dbgrdMain.DataSource.DataSet).RecordCount;


  try
    if (qtd >0 ) then begin
      try
                 TFDQuery(dbgrdMain.DataSource.DataSet).First;
       while not TFDQuery(dbgrdMain.DataSource.DataSet).Eof do begin
         tipoStatus := TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TIPO_STATUS').AsString;
         idTP       := TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString;

          deletaTP(idOrganizacao,idTP);
          framePB1.progressBar(1,qtd);
          Application.ProcessMessages;
          TFDQuery(dbgrdMain.DataSource.DataSet).Next;
       end;
      Except
          raise Exception.Create
            ('Problemas ao tentar DELETAR_TP ');
        end;

    end;

      ObterTodosTitulosPagar(idOrganizacao);
      qtd := qryTodosTP.RecordCount;
      Application.ProcessMessages;
      framePB1.progressBar(0,0);
      framePB1.Visible :=false;
      ShowMessage('   Processo conclu�do...   ');
  Except
     raise Exception.Create
      ('Problemas ao tentar deletar alguns lan�amentos . ERRO: FRM_DEL_TP-1 TP DOC >>  ' + qryTodosTP.FieldByName('NUMERO_DOCUMENTO').AsString);
  end;

end;

procedure TfrmManutencao.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManutencao.btnLimpaMovDiarioClick(Sender: TObject);
var
qryLimpaMD : TFDQuery;
 cmd :string;
 I :Integer;
begin
  dmConexao.conectarBanco;
  framePB1.Visible :=True;
  framePB1.Visible :=True;
  framePB1.pb1.Visible :=True;
  framePB1.lblProgressBar.Visible :=True;
  framePB1.lblProgressBar.Caption := 'Processo sendo iniciado... por favor, aguarde...';
  Application.ProcessMessages;
  framePB1.progressBar(0,0);
  Sleep(5000);



  try
    cmd := ' DELETE FROM MOVIMENTO_DIARIO MV WHERE MV.DATA_REGISTRO BETWEEN :PDTINICIO AND :PDTFINAL ';
    qryLimpaMD := TFDQuery.Create(Self);
    qryLimpaMD.Close;
    qryLimpaMD.Connection := dmConexao.conn;
    qryLimpaMD.SQL.Clear;
    qryLimpaMD.SQL.Add(cmd);

    qryLimpaMD.ParamByName('PDTINICIO').AsDate := frmPeriodo2.getDataInicial;
    qryLimpaMD.ParamByName('PDTFINAL').AsDate := frmPeriodo2.getDataFinal;
    qryLimpaMD.ExecSQL;
    dmConexao.Conn.CommitRetaining;

      for I := 0 to 100 do
      begin
       framePB1.lblProgressBar.Caption := 'Excluindo registros... por favor, aguarde.';
        framePB1.progressBar(I, 100);
        Application.ProcessMessages;
      end;
    framePB1.lblProgressBar.Caption := 'Processo finalizado...';


  except
    dmConexao.Conn.RollbackRetaining;

    raise Exception.Create('Erro ao tentar limpar o movimento di�rio');

  end;

end;

procedure TfrmManutencao.btnLimparEndClick(Sender: TObject);
var
qryLimpaMD : TFDQuery;
 cmd :string;
 I :Integer;
begin
  dmConexao.conectarBanco;
    limparTabelaEndereco;

end;

function TfrmManutencao.deletaTP(pIdOrganizacao, pID: string): boolean;
begin
  dmConexao.conectarBanco;

     try
         FDSDeletaTP.StoredProcName :='sp_del_tp';
         FDSDeletaTP.Prepare;
         FDSDeletaTP.ParamByName('ID_ORGANIZACAO').AsString := pIdOrganizacao;
         FDSDeletaTP.ParamByName('ID_TITULO_PAGAR').AsString := pID;
         FDSDeletaTP.ExecProc;

         dmConexao.Conn.CommitRetaining;

     except
          dmConexao.Conn.RollbackRetaining;
          raise Exception.Create('Erro ao tentar Deletar Titulos (SP_DEL_TP)');

     end;

   Result := System.True;
end;

procedure TfrmManutencao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmManutencao.FormCreate(Sender: TObject);
begin
inicializarDM(Self);
framePB1.Visible := False;
framePB1.lblProgressBar.Visible :=False;
idOrganizacao := TOrgAtual.getId;
ObterTodosTitulosPagar(idOrganizacao);
pgcAjustes.ActivePageIndex := 0;

end;

procedure TfrmManutencao.frameBDTablesds1DataChange(Sender: TObject;
  Field: TField);
  var
  table: string;

begin
table := frameBDTables.dbgrd1.DataSource.DataSet.FieldByName('TABELA').AsString;

ObterQtdRegistro(table);

end;

procedure TfrmManutencao.inicializarDM(Sender: TObject);
begin
//nada
   frmPeriodo1.inicializa(IncMonth(Now, -1), Now);
   frmPeriodo2.inicializa(IncMonth(Now, -120), IncMonth(Now, -3)); // periodo do movimento di�rio


end;


function TfrmManutencao.obterBaixaBanco(pIdOrganizacao, pIdTP, pTable: string): Boolean;
var
 cmdSql :string;
begin
 dmConexao.conectarBanco;

      cmdSql := ' SELECT CBD.id_conta_bancaria_debito, CBD.id_titulo_pagar, CBD.data_movimento AS DATA ' +
                ' FROM conta_bancaria_debito CBD ' +
                ' WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CBD.ID_TITULO_PAGAR = :PIDTP) ';



      if pTable.Equals('TITULO_RECEBER') then begin

           cmdSql := ' SELECT CBC.id_conta_bancaria_CREDITO, CBC.id_titulo_RECEBER, CBC.data_movimento AS DATA ' +
                ' FROM conta_bancaria_CREDITO CBC ' +
                ' WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CBC.ID_TITULO_RECEBER = :PIDTP) ';

      end;

  try

    qryObterBaixaBCO.Close;
    qryObterBaixaBCO.Connection := dmConexao.Conn;
    qryObterBaixaBCO.SQL.Clear;
    qryObterBaixaBCO.SQL.Add(cmdSql);
    qryObterBaixaBCO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterBaixaBCO.ParamByName('PIDTP').AsString := pIdTP;
    qryObterBaixaBCO.Open;

  except
   raise Exception.Create('Erro ao obter a baixa por ' + pTable);


  end;

    Result := not qryObterBaixaBCO.IsEmpty;

end;


function TfrmManutencao.obterEndereco(pOrganizacao: string): Boolean;
begin
// :PIDORGANIZACAO)
  try
    qryObterEnderecos.Close;
    qryObterEnderecos.Connection := dmConexao.Conn;
    qryObterEnderecos.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterEnderecos.Open;

  except
    raise Exception.Create('Erro ao tentar Obter enderecos ');

  end;

      Result := not qryObterEnderecos.IsEmpty;

end;

function TfrmManutencao.obterSacadoPorEndereco(pOrganizacao, pEndereco: string): Integer;
begin
// :PIDORGANIZACAO)
Result :=0;
  try
    qryObterSacadoPorEndereco.Close;
    qryObterSacadoPorEndereco.Connection := dmConexao.Conn;
    qryObterSacadoPorEndereco.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterSacadoPorEndereco.ParamByName('PIDENDERECO').AsString := pEndereco;
    qryObterSacadoPorEndereco.Open;

  except
    raise Exception.Create('Erro ao tentar obter sacado por enderecos ');

  end;

      Result := qryObterSacadoPorEndereco.RecordCount;

end;



function TfrmManutencao.obterCedentePorEndereco(pOrganizacao, pEndereco: string): Integer;
begin
// :PIDORGANIZACAO)
Result :=0;
  try
    qryObterCedentePorEndereco.Close;
    qryObterCedentePorEndereco.Connection := dmConexao.Conn;
    qryObterCedentePorEndereco.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterCedentePorEndereco.ParamByName('PIDENDERECO').AsString := pEndereco;
    qryObterCedentePorEndereco.Open;

  except
    raise Exception.Create('Erro ao tentar obter cedentes por enderecos ');

  end;

      Result := qryObterCedentePorEndereco.RecordCount;

end;


function TfrmManutencao.obterFilhosPorTP(pIdOrganizacao,  pIdTP: string): boolean;
begin

     try
           qryObterFilhosTP.Close;
           qryObterFilhosTP.Connection := dmConexao.Conn;
           qryObterFilhosTP.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
           qryObterFilhosTP.ParamByName('PIDGERADOR').AsString     :=pIdTP;
           qryObterFilhosTP.Open();

     except
      raise Exception.Create('Erro ao tentar obter Filhos por TP');

     end;


      Result := not qryObterFilhosTP.IsEmpty; //se encotrar filhos retorna true
//fim
end;

function TfrmManutencao.obterFuncionarioPorEndereco(pOrganizacao,
  pEndereco: string): Integer;
begin
  // :PIDORGANIZACAO)
Result :=0;
  try
    qryObterFuncionarioPorEndereco.Close;
    qryObterFuncionarioPorEndereco.Connection := dmConexao.Conn;
    qryObterFuncionarioPorEndereco.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterFuncionarioPorEndereco.ParamByName('PIDENDERECO').AsString := pEndereco;
    qryObterFuncionarioPorEndereco.Open;

  except
    raise Exception.Create('Erro ao tentar Obter funcionario por enderecos ');

  end;

      Result := qryObterFuncionarioPorEndereco.RecordCount;




end;

procedure TfrmManutencao.tsTabelasShow(Sender: TObject);
begin
frameOrgs.listar(Self);

end;


function TfrmManutencao.AjustaDataPagamentoTitulo(pTable: string;
  query: TFDQuery): boolean;
var
  qtd :Integer;
 sql, pID :string;
pDataTitulo,  pDataBaixa : TDateTime;
begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(0, 0);
    Application.ProcessMessages;

   try
        query.Open();
        query.Last;
        query.First;

       if pTable.Equals('TITULO_PAGAR') then begin

          while not (query.Eof) do begin
                  qtd :=qtd + 1;

                  pID := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  pDataTitulo := query.FieldByName('DATA_PAGAMENTO').AsDateTime;

                   lbl4.Caption := 'Registro atual N� ' + IntToStr(query.RecNo) + '  DOC ' +  query.FieldByName('NUMERO_DOCUMENTO').AsString;
                   Application.ProcessMessages;

                 if obterBaixaBanco(idOrganizacao, pID, 'TITULO_PAGAR') then begin

                    pDataBaixa := qryObterBaixaBCO.FieldByName('DATA').AsDateTime;
                     sql := ' UPDATE TITULO_PAGAR TP SET TP.DATA_PAGAMENTO = :PDATA ' +
                            ' WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO ) ' +
                            ' AND (TP.ID_TITULO_PAGAR = :PIDTP )' ;

                   if (DaysBetween(pDataTitulo, pDataBaixa)<>0) then begin


                          try

                              qryAjustaData.Close;
                              qryAjustaData.Connection := dmConexao.Conn;
                              qryAjustaData.SQL.Clear;
                              qryAjustaData.SQL.Add(sql);
                              qryAjustaData.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                              qryAjustaData.ParamByName('PIDTP').AsString := pID;
                              qryAjustaData.ParamByName('PDATA').AsDate := pDataBaixa;
                              qryAjustaData.ExecSQL;
                              dmConexao.Conn.CommitRetaining;
                          except
                            dmConexao.Conn.RollbackRetaining;
                            raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

                          end;

                   end;
               end;
                query.Next;
                framePB1.progressBar(1, query.RecordCount);
                Application.ProcessMessages;
               end;


        end;


        if pTable.Equals('TITULO_RECEBER') then begin

           while not (query.Eof) do begin
                  qtd :=qtd + 1;

                  pID := query.FieldByName('ID_TITULO_RECEBER').AsString;

               if obterBaixaBanco(idOrganizacao, pID, 'TITULO_RECEBER') then begin

                    pDataBaixa := qryObterBaixaBCO.FieldByName('DATA').AsDateTime;

                     sql := ' UPDATE TITULO_RECEBER TR SET TR.DATA_PAGAMENTO = :PDATA ' +
                          ' WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO ) ' +
                          ' AND (TR.ID_TITULO_RECEBER = :PIDTR ) ' ;

                    try

                        qryAjustaData.Close;
                        qryAjustaData.Connection := dmConexao.Conn;
                        qryAjustaData.SQL.Clear;
                        qryAjustaData.SQL.Add(sql);
                        qryAjustaData.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                        qryAjustaData.ParamByName('PIDTR').AsString := pID;
                        qryAjustaData.ParamByName('PDATA').AsDate := pDataBaixa;
                        qryAjustaData.ExecSQL;
                        dmConexao.Conn.CommitRetaining;
                    except
                      dmConexao.Conn.RollbackRetaining;
                      raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

                    end;

               end;

           query.Next;
           framePB1.progressBar(1, query.RecordCount);
           Application.ProcessMessages;
           end;

       end;


      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');
   end;

       dmConexao.Conn.CommitRetaining;
       ShowMessage('Processo conclu�do...');

    Result :=System.True;

end;


function TfrmManutencao.AjustarDataEmissaoTP(query :TFDQuery):boolean;
  var
  qtd :Integer;
begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(1, query.RecordCount);
    Application.ProcessMessages;

     //rever ossp
     // a data de emissao nao pode ser sempre a data de registro

      try
        query.Open();
        query.Last;
        query.First;

        while not (query.Eof) do begin
                  qtd :=qtd + 1;
                  qryAjustaDataEmissao.Close;
                  qryAjustaDataEmissao.Connection := dmConexao.Conn;
                  qryAjustaDataEmissao.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                  qryAjustaDataEmissao.ParamByName('PIDTP').AsString := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  qryAjustaDataEmissao.ParamByName('PDATA').AsDate := query.FieldByName('DATA_REGISTRO').AsDateTime;

            qryAjustaDataEmissao.ExecSQL;
            dbgrdMain.DataSource.DataSet :=query;
            query.Next;

            framePB1.progressBar(1, query.RecordCount);
            if(qtd mod 2 = 0) then begin
              Application.ProcessMessages;
            end;
        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;

       dmConexao.Conn.CommitRetaining;
       ShowMessage('Processo conclu�do...');

    Result :=System.True;

end;



function TfrmManutencao.ObterTodosTitulosPagarPeriodo(pIdOrganizacao :string; pDataInicio, pDataFinal :Tdate ): Boolean;
begin
    qryObterTodosTPPeriodo.Close;
    qryObterTodosTPPeriodo.Connection := dmConexao.Conn;
    qryObterTodosTPPeriodo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryObterTodosTPPeriodo.ParamByName('pDataInicial').AsDate := pDataInicio;
    qryObterTodosTPPeriodo.ParamByName('pDataFinal').AsDate := pDataFinal;
    qryObterTodosTPPeriodo.Open;
    qryObterTodosTPPeriodo.Last;

    Result := not qryObterTodosTPPeriodo.IsEmpty;
end;



function TfrmManutencao.ObterTodosTitulosReceberPeriodo(pIdOrganizacao: string;
  pDataInicio, pDataFinal: Tdate): Boolean;
begin
  dmConexao.conectarBanco;

  try

    qryObterTodosTRPeriodo.Close;
    qryObterTodosTRPeriodo.Connection := dmConexao.Conn;
    qryObterTodosTRPeriodo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryObterTodosTRPeriodo.ParamByName('pDataInicial').AsDate := pDataInicio;
    qryObterTodosTRPeriodo.ParamByName('pDataFinal').AsDate := pDataFinal;
    qryObterTodosTRPeriodo.Open;
    qryObterTodosTRPeriodo.Last;

    Result := not qryObterTodosTRPeriodo.IsEmpty;

  except
   raise Exception.Create('Erro ao obter titulos � receber..');

  end;


end;

procedure TfrmManutencao.pnlAjustaTPClick(Sender: TObject);
begin

  framePB1.lblProgressBar.Visible :=True;
  AjustarValorRateioTP(idOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);

end;

procedure TfrmManutencao.pnlAjustaTRClick(Sender: TObject);
begin
  framePB1.lblProgressBar.Visible :=True;
  AjustarValorRateioTR(idOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);
end;

function TfrmManutencao.ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
begin
  try
    qryTodosTP.Close;
    qryTodosTP.Connection := dmConexao.Conn;
    qryTodosTP.SQL.Clear;
    qryTodosTP.SQL.Add(' SELECT * FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO )  AND (TP.ID_TIPO_STATUS <> ''EXCLUIDO'' ) ' ) ;
    qryTodosTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryTodosTP.Open;
  except

  raise Exception.Create('Erro ao obter todos TP');


  end;

    Result := qryTodosTP;
end;



function TfrmManutencao.removeFilhosTP(pIdOrganizacao, pIdTPFilho: string): boolean;
begin
   try
      qryRemoveFilhoTP.Close;
      qryRemoveFilhoTP.Connection := dmConexao.Conn;
      qryRemoveFilhoTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
      qryRemoveFilhoTP.ParamByName('PIDTPFILHO').AsString := pIdTPFilho; //campo id do titulo a ser alterador

      qryRemoveFilhoTP.ExecSQL;

      dmConexao.Conn.CommitRetaining;
   except
    raise Exception.Create('Erro ao obter filhos TP');

   end;

  Result := System.True;

end;

procedure TfrmManutencao.ObterQtdRegistro(pTable :string);
var
cmd : String;
begin
   cmd :=' SELECT count(*) as REGISTROS '+
        '  FROM  ' +  pTable +
        '  WHERE 1=1 ;' ;

    qryQtdRegistros.Close;
    qryQtdRegistros.Connection := dmConexao.Conn;
    qryQtdRegistros.SQL.Clear;
    qryQtdRegistros.SQL.Add(cmd);
    qryQtdRegistros.Open;

end;


function TfrmManutencao.obterRateioCC(pIdOrganizacao, pIdTP, pTable: string): Integer;
 var
 cmdSql :string;
begin
 dmConexao.conectarBanco;

      cmdSql :=   ' SELECT TPC.id_titulo_pagar_rateio_cc, TPC.id_titulo_pagar, TPC.valor '+
                  ' FROM titulo_pagar_rateio_cc TPC '+
                  ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                  ' AND (TPC.ID_TITULO_PAGAR = :PIDTP) ';

      if pTable.Equals('TITULO_RECEBER') then begin

        cmdSql := ' SELECT TPC.id_titulo_RECEBER_rateio_cc, TPC.id_titulo_receber, TPC.valor '+
                  ' FROM titulo_receber_rateio_cc TPC '+
                  ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                  ' AND (TPC.ID_TITULO_RECEBER = :PIDTP) ';

      end;



  try

    qryObterRateioCC.Close;
    qryObterRateioCC.Connection := dmConexao.Conn;
    qryObterRateioCC.SQL.Clear;
    qryObterRateioCC.SQL.Add(cmdSql);
    qryObterRateioCC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterRateioCC.ParamByName('PIDTP').AsString := pIdTP;
    qryObterRateioCC.Open;

  except
   raise Exception.Create('Erro ao obter o rateio de centro de custos..');


  end;

    Result := qryObterRateioCC.RecordCount;

end;



function TfrmManutencao.obterRateioHistorico(pIdOrganizacao, pIdTP, pTable: string): Integer;
 var
 cmdSql :string;
begin
 dmConexao.conectarBanco;

      cmdSql := ' SELECT TPH.id_titulo_pagar_historico, TPH.valor, TPH.id_titulo_pagar ' +
                ' FROM titulo_pagar_historico TPH ' +
                ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                ' AND (TPH.ID_TITULO_PAGAR = :PIDTP) ' ;

      if pTable.Equals('TITULO_RECEBER') then begin

          cmdSql := ' SELECT TPH.id_titulo_receber_historico, TPH.valor, TPH.id_titulo_receber ' +
                    ' FROM titulo_receber_historico TPH ' +
                    ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                    ' AND (TPH.ID_TITULO_RECEBER = :PIDTP) ' ;

      end;

  try

    qryObterRateioHistorico.Close;
    qryObterRateioHistorico.Connection := dmConexao.Conn;
    qryObterRateioHistorico.SQL.Clear;
    qryObterRateioHistorico.SQL.Add(cmdSql);
    qryObterRateioHistorico.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterRateioHistorico.ParamByName('PIDTP').AsString := pIdTP;
    qryObterRateioHistorico.Open;

  except
   raise Exception.Create('Erro ao obter o rateio de hist�rico..');


  end;

    Result := qryObterRateioHistorico.RecordCount;

end;


function TfrmManutencao.insereHistorico(pIdOrganizacao, pIdTP, pIdHistorico,  pTable: string ; pValor :Currency): Boolean;
var
 sqlCmdInsere,   pIdTituloHistorico :string;

begin

  dmConexao.conectarBanco;


  try

    pIdTituloHistorico := dmConexao.obterNewID;

    sqlCmdInsere := ' INSERT INTO TITULO_PAGAR_HISTORICO (ID_TITULO_PAGAR_HISTORICO, ID_ORGANIZACAO, ID_HISTORICO, ID_TITULO_PAGAR, VALOR )'+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDHISTORICO, :PIDTP, :PVALOR ) ' ;


   if pTable.Equals('TITULO_RECEBER') then begin

    sqlCmdInsere := ' INSERT INTO TITULO_RECEBER_HISTORICO (ID_TITULO_RECEBER_HISTORICO, ID_ORGANIZACAO, ID_HISTORICO, ID_TITULO_RECEBER, VALOR )'+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDHISTORICO, :PIDTP, :PVALOR ) ' ;

   end;

     qryInsereHistorico.Close;
     qryInsereHistorico.Connection := dmConexao.conn;
     qryInsereHistorico.SQL.Clear;
     qryInsereHistorico.SQL.Add(sqlCmdInsere);
     qryInsereHistorico.ParamByName('PID').AsString := pIdHistorico;
     qryInsereHistorico.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryInsereHistorico.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
     qryInsereHistorico.ParamByName('PIDTP').AsString := pIdTP;
     qryInsereHistorico.ParamByName('PVALOR').AsCurrency    := pValor;

     qryInsereHistorico.ExecSQL;
     qryInsereHistorico.Connection.CommitRetaining;


  except
          qryInsereHistorico.Connection.RollbackRetaining;
  raise Exception.Create('Erro ao tentar inserir hist�rico ' + pIdTP );

  end;

  Result := System.True;
end;


procedure TfrmManutencao.limparTabelaEndereco;
var
eliminados, qtdRegistros, liberaDel :Integer;
  pIdEndereco :string;

begin
 dmConexao.conectarBanco;
 liberaDel := 0;
  eliminados := 0;

  try

     if obterEndereco(idOrganizacao) then
      begin
          framePB1.Visible := True;
          framePB1.lblProgressBar.Visible := True;
          framePB1.progressBar(0,0);
          framePB1.lblProgressBar.Caption :=' Progresso da manuten��o ';

        qryObterEnderecos.Last;
        qryObterEnderecos.First;
        qtdRegistros:= qryObterEnderecos.RecordCount;
        while not qryObterEnderecos.Eof do
        begin
         pIdEndereco := qryObterEnderecos.FieldByName('ID_ENDERECO').AsString;
         liberaDel :=0;
          liberaDel := liberaDel + obterCedentePorEndereco(idOrganizacao,pIdEndereco );
          liberaDel := liberaDel + obterSacadoPorEndereco(idOrganizacao, pIdEndereco) ;
          liberaDel := liberaDel + obterFuncionarioPorEndereco(idOrganizacao, pIdEndereco) ;

          if liberaDel = 0 then
          begin

            qryDeletaEndereco.Close;
            qryDeletaEndereco.Connection := dmConexao.conn;
            qryDeletaEndereco.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
            qryDeletaEndereco.ParamByName('PIDENDERECO').AsString := qryObterEnderecos.FieldByName('ID_ENDERECO').AsString;
            qryDeletaEndereco.ExecSQL;
            inc(eliminados);

            dmConexao.conn.CommitRetaining;
          end;

          qryObterEnderecos.Next;
          framePB1.progressBar(1, Trunc(qtdRegistros));
          framePB1.lblProgressBar.Caption :=' Analisando o registro ' +  IntToStr(Trunc(qryObterEnderecos.RecNo)) +  '  /  ' + IntToStr(Trunc(qtdRegistros));
          Application.ProcessMessages;

        end;
      end;

      framePB1.lblProgressBar.Caption :=' Foram eliminados  ' + IntToStr(eliminados) + ' registros. ';

  except
  raise Exception.Create('Erro ao tentar limpar endere�os.');
  end;
end;


end.