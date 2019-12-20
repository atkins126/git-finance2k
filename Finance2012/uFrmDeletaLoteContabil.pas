unit uFrmDeletaLoteContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,udmConexao,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uUtil,uDMDeletaLoteContabil,
  FireDAC.Comp.Client, EGauge, Vcl.Mask, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinsDefaultPainters, dxStatusBar;

type
  TfrmDeletaLoteContabil = class(TForm)
    cbbLoteContabil: TComboBox;
    lbl1: TLabel;
    qryObterLoteID: TFDQuery;
    btnLimpar: TButton;
    edtIdLote: TEdit;
    edtDataRegistro: TEdit;
    medtValorDB: TMaskEdit;
    edtTabela: TEdit;
    qryGeneric: TFDQuery;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    medtValorCR: TMaskEdit;
    btnDeletarLote: TButton;
    qryAlteraGeneric: TFDQuery;
    qryAlteraLote: TFDQuery;
    qryObterTPPROV: TFDQuery;
    qryDeletaLote: TFDQuery;
    cbbAno: TComboBox;
    lbl7: TLabel;
    btnFechar: TBitBtn;
    edtTipoLancamento: TEdit;
    qryObterLotePorAno: TFDQuery;
    dbgrd1: TDBGrid;
    dsMega: TDataSource;
    qryObterLoteFNC: TFDQuery;
    dbgrd2: TDBGrid;
    dsFinance: TDataSource;
    pnl1: TPanel;
    btnSincronizaLotes: TBitBtn;
    dxStatusBar: TdxStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbbLoteContabilSelect(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnDeletarLoteClick(Sender: TObject);
    procedure cbbAnoChange(Sender: TObject);
    procedure btnSincronizaLotesClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);

  private
    { Private declarations }

    pid: string;
  indiceCbbAno,  qtd, indice: Integer;
   pAno,  pIdOrganizacao : string;

    FsListaIdLotes: TStringList;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
    procedure obterLotePorAnoMega(pidEmpresa :Integer; pAno :string);
    procedure obterLotePorAnoFinance(pIdOrganizacao :string; pDataInicial, pDataFinal :TDate);
    function obterLoteID(pId, pIdOrganizacao :string):Boolean;
    function preencheAba(pId, pIdOrganizacao :string) :Boolean;
    procedure limpaCampos;
    function obterLancamentosPorLote(pIdLote, pIdOrganizacao, pTable :string):Boolean;
    function deletarLoteContabil() :Boolean;
    function alteraLancamentos(pIdLancamento, idOrganizacao, pTable,pTipo, pIdLote :string ) : Boolean;
    function alteraLoteContabil(idLote, idOrganizacao :string ) : Boolean;
    function obterTituloPagarProvisao(pId, pIdOrganizacao :string): Boolean ;
    function deletaLoteContabil(idLote, idOrganizacao: string): Boolean;
    function compararLotes(pAnoFNC, pLoteFNC: string; pDebitoFNC: Currency;
      pAnoSC, pLoteSC: string; pTotalSC: Currency): Boolean;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);



  public
    { Public declarations }
  end;

var
  frmDeletaLoteContabil: TfrmDeletaLoteContabil;

implementation

{$R *.dfm}

{ TfrmDeletaLoteContabil }

function TfrmDeletaLoteContabil.alteraLancamentos(pIdLancamento, idOrganizacao, pTable, pTipo, pIdLote :string ) : Boolean;
var
cmd :string;
begin

dmConexao.conectarBanco;
  //somente retira a FK vinculada ao LOTE CONTABIL

      cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_CONTABIL = :PSTATUS  ' +
             ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
             ' AND  ID_'+ pTable +' = :PID ';

   if pTable.Equals('TITULO_PAGAR') then begin

      if ( obterTituloPagarProvisao(pIdLancamento, pIdOrganizacao) ) then begin

          if (qryObterTPPROV.FieldByName('ID_LOTE_TPB').AsString).Equals(pIdLote) then begin

          cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_TPB = :PSTATUS ' +
                    ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
                    ' AND  ID_'+ pTable +' = :PID ';
          end ;

      end;

   end;


   if pTable.Equals('TITULO_RECEBER') then begin

      if ( obterTituloPagarProvisao(pIdLancamento, pIdOrganizacao) ) then begin

          if (qryObterTPPROV.FieldByName('ID_LOTE_TRB').AsString).Equals(pIdLote) then begin

          cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_TRB = :PSTATUS ' +
                    ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
                    ' AND  ID_'+ pTable +' = :PID ';
          end ;

      end;

   end;


   try
        qryAlteraGeneric.Close;
        qryAlteraGeneric.Connection := dmConexao.Conn;
        qryAlteraGeneric.SQL.Clear;
        qryAlteraGeneric.SQL.Add(cmd);
        qryAlteraGeneric.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
        qryAlteraGeneric.ParamByName('PID').AsString :=pIdLancamento;
        qryAlteraGeneric.ParamByName('PSTATUS').Value := NULL;

        qryAlteraGeneric.ExecSQL;
        dmConexao.Conn.CommitRetaining;
   except
       dmConexao.Conn.RollbackRetaining;
       raise(Exception).Create('Problemas ao tentar alterar lan�amento cont�bil ');

   end;

    Result := System.True;
end;



function TfrmDeletaLoteContabil.alteraLoteContabil(idLote,  idOrganizacao: string): Boolean;
var
cmd :string;
begin

 cmd := ' UPDATE LOTE_CONTABIL  SET STATUS = :PSTATUS  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO AND  ID_LOTE_CONTABIL = :PIDLOTE ';

    try
    qryAlteraLote.Close;
    qryAlteraLote.Connection := dmConexao.Conn;
    qryAlteraLote.SQL.Clear;
    qryAlteraLote.SQL.Add(cmd);
    qryAlteraLote.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryAlteraLote.ParamByName('PIDLOTE').AsString :=idLote;
    qryAlteraLote.ParamByName('PSTATUS').AsString :='EXCLUIDO';


    qryAlteraLote.ExecSQL;
    dmConexao.conn.CommitRetaining;
    except
  dmConexao.Conn.RollbackRetaining;
    raise(Exception).Create('Problemas ao deletar lote contabil ');

  end;

end;

procedure TfrmDeletaLoteContabil.btnDeletarLoteClick(Sender: TObject);
var
resultado : Boolean;
begin
   resultado := False;

     try
            msgStatusBar(1,' Processando a sua solicita��o. Por favor, aguarde.');

         resultado := deletarLoteContabil;
     except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' deletando lote cont�bil!');
      end;


      if resultado then begin
            msgStatusBar(1,'Solicita��o conclu�da com sucesso.');
      ShowMessage('Lote cancelado com sucesso...! ATEN��O: Os lan�amentos ainda constam no sistema cont�bil...');
      end;

      limpaCampos;

end;

procedure TfrmDeletaLoteContabil.btnFecharClick(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

function TfrmDeletaLoteContabil.compararLotes(pAnoFNC,pLoteFNC :string; pDebitoFNC: Currency; pAnoSC,pLoteSC :string; pTotalSC : Currency) :Boolean;
var
loteIgual :Boolean;
begin
loteIgual := False;
  if not uutil.Empty(pAnoFNC) then
  begin

    if not uutil.Empty(pLoteFNC) then
    begin

      if pDebitoFNC > 0 then
      begin

        if pAnoFNC.Equals(pAnoSC) then begin

          if pLoteFNC.Equals(pLoteSC) then begin

            if pDebitoFNC = pTotalSC then begin

               loteIgual :=True;

            end;
          end;
        end;


      end;

    end;

  end;


Result := loteIgual;

end;

procedure TfrmDeletaLoteContabil.btnLimparClick(Sender: TObject);
begin
 limpaCampos;
  cbbAno.ItemIndex := indiceCbbAno;


end;

procedure TfrmDeletaLoteContabil.btnSincronizaLotesClick(Sender: TObject);
var
msgFinal, pTipoTable, pIdLoteFNC, pAnoSC, pLoteSC,pAnoFNC, pLoteFNC :string;
pTotalSC, pDebitoFNC :Currency;
resultado, loteExist :Boolean;
lotesExc : TStringList;
  I: Integer;
begin
pAnoSC   :='';
pLoteSC  :='';
pAnoFNC  :='';
pLoteFNC :='';
pTotalSC   :=0;
pDebitoFNC :=0;
loteExist :=False;
resultado :=False;
lotesExc := TStringList.Create;
 msgStatusBar(1,' Ser�o deletados apenas os lotes que existem no Finance 2K e n�o constam no sistema cont�bil.');
 Sleep(5000);
 msgStatusBar(1,'Obtendo dados dos sistemas...');
 Sleep(2000);


  qryObterLoteFNC.First;
  while not qryObterLoteFNC.Eof do begin

     pAnoFNC    := qryObterLoteFNC.FieldByName('ANO').AsString;
     pAno :=  pAnoFNC;
     pLoteFNC   := qryObterLoteFNC.FieldByName('LOTE').AsString;
     pDebitoFNC := qryObterLoteFNC.FieldByName('TOTAL').AsCurrency;
     pIdLoteFNC := qryObterLoteFNC.FieldByName('ID_LOTE_CONTABIL').AsString;
     pTipoTable := qryObterLoteFNC.FieldByName('TABELA').AsString;

     //buscar o lote no mega
      qryObterLotePorAno.First;
     while not qryObterLotePorAno.Eof do begin
       msgStatusBar(1,'Analisando o lote de n�mero ' + pLoteFNC);
       pAnoSC    := qryObterLotePorAno.FieldByName('ANO').AsString;
       pLoteSC   := qryObterLotePorAno.FieldByName('LOTE').AsString;
       pTotalSC  := qryObterLotePorAno.FieldByName('TOTAL').AsCurrency;

       loteExist := compararLotes(pAnoFNC,pLoteFNC,pDebitoFNC,pAnoSC,pLoteSC,pTotalSC);
       if loteExist then begin
        qryObterLotePorAno.Last;
       end;
       qryObterLotePorAno.Next;

     end;

    if not loteExist then
    begin
      msgStatusBar(1,' O lote de n�mero ' + pLoteFNC + ' n�o foi encontrado no sistema cont�bil ou os registros est�o diferentes.');
     if  preencheAba(pIdLoteFNC, pIdOrganizacao) then begin

      if (obterLancamentosPorLote(pIdLoteFNC, pIdOrganizacao, pTipoTable)) then
      begin

        try

          try
            resultado := deletarLoteContabil;
          except
            on e: Exception do
              ShowMessage(e.Message + sLineBreak + ' deletando lote cont�bil!');
          end;

          if resultado then
          begin
           lotesExc.Add(pLoteFNC);
            msgStatusBar(1,'O lote de n�mero ' + pLoteFNC + ' foi deletado com sucesso.' );
          end;

        except
          on e: Exception do
            ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
        end;
      end;


    end;

    end;

     qryObterLoteFNC.Next;

  end;

   limpaCampos;
   cbbAno.ItemIndex := indiceCbbAno;

  for I := 0 to lotesExc.Count - 1 do
  begin

    msgFinal := msgFinal + ' [  ' + lotesExc[I] + ' ]';

  end;

  if lotesExc.Count > 0 then
  begin
    msgStatusBar(1, 'Lotes exclu�dos : ' + msgFinal);
  end
  else
  begin
    msgStatusBar(1, ' Nenhum lote a ser exclu�do ');
  end;

end;

procedure TfrmDeletaLoteContabil.cbbAnoChange(Sender: TObject);
var
ano :string;
idSistemaContabil :Integer;
pDataInicial, pDataFinal, dataServer :TDateTime;

begin

 if cbbAno.ItemIndex > 0 then begin
    cbbLoteContabil.Clear;
    indiceCbbAno := cbbAno.ItemIndex;
    ano := cbbAno.Items[indiceCbbAno];
    idSistemaContabil := StrToInt(uutil.TOrgAtual.getIDSistemaContabil);
    pAno :=ano;

    //mostrar os lotes do sistema cont��abil
    obterLotePorAnoMega(idSistemaContabil,ano);
    //mostrar os lotes do Financeiro
     pDataInicial := StrToDateTime('01/01/'+ano);
     pDataFinal := StrToDateTime('31/12/'+ano);
     obterLotePorAnoFinance(pIdOrganizacao,pDataInicial,pDataFinal);
     msgStatusBar(1,'Obtendo dados dos sistemas...');
     if qryObterLotePorAno.RecordCount >0 then begin
        btnSincronizaLotes.Enabled := True;
     end else begin       btnSincronizaLotes.Enabled := False; end;


  if dmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao, ano) then
    begin
      cbbLoteContabil.Enabled := True;
      dmDeletaLoteContabil.listaLoteContabil(cbbLoteContabil, FsListaIdLotes);
      msgStatusBar(1,' Sistema pronto pra exclus�o de lotes. Selecione um lote ou clique em sincronizar.');

    end;

    cbbAno.ItemIndex := indiceCbbAno;

 end;


end;

procedure TfrmDeletaLoteContabil.cbbLoteContabilSelect(Sender: TObject);
begin
    pid:='';
    indice:=0;

if (cbbLoteContabil.ItemIndex > 0 ) then
  begin
    indice := (cbbLoteContabil.ItemIndex );
    pid := FsListaIdLotes[indice];

         msgStatusBar(1,'Obtendo dados dos sistemas...');
  end;

 if  preencheAba(pid, pIdOrganizacao) then begin

      msgStatusBar(1,'Preenchendo a tela com os dados...');

  if (obterLancamentosPorLote(pid,pIdOrganizacao, edtTabela.Text)) then begin
         msgStatusBar(1,'Obtendo os lan�amentos dos lotes. ');
//     if qtd> 0 then begin
     if 1=1 then begin
        btnDeletarLote.Enabled := true;
        btnSincronizaLotes.Enabled := True;
         msgStatusBar(1,'Bot�o para deletar lotes est� ativo...');

      end;

      try
          obterLoteID(pid,pIdOrganizacao);

      except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
      end;
  end;

 end;




end;

function TfrmDeletaLoteContabil.deletarLoteContabil: Boolean;
var
tipo, tabela, idLote  :string;
aux : Integer ;

begin
     tabela := edtTabela.Text;
     idLote  :=  edtIdLote.Text;
     tipo := edtTipoLancamento.Text;

    // obterLancamentosPorLote(idLote,pIdOrganizacao, tabela);

     // a qry � preenchida no evento OnSelect de cbbLoteContabil
    qryGeneric.First;
    aux :=0;

   qryGeneric.RecordCount;

    while not qryGeneric.Eof do begin
          try
               alteraLancamentos(qryGeneric.FieldByName('ID_'+tabela).AsString,
                          qryGeneric.FieldByName('ID_ORGANIZACAO').AsString,
                          tabela,tipo, idLote);
                          Inc(aux);
              qryGeneric.Next;
          except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' alteraLancamentos!');

          end;
    end;

    try
          alteraLoteContabil(idLote, pIdOrganizacao);
          deletaLoteContabil(idLote, pIdOrganizacao);

          //atualizar o combo
          if dmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao,pAno) then
           begin
            dmDeletaLoteContabil.listaLoteContabil(cbbLoteContabil, FsListaIdLotes);
          end;

          btnDeletarLote.Enabled := False;

    except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' alteraLoteContabil!');

    end;



  Result := System.True;

end;

procedure TfrmDeletaLoteContabil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 freeAndNilDM();
 Action := caFree;
end;

procedure TfrmDeletaLoteContabil.FormCreate(Sender: TObject);
var
  I: Integer;
begin
    btnDeletarLote.Enabled := False;
    cbbLoteContabil.Enabled := False;
    cbbAno.ItemIndex :=0;
    limpaStatusBar;
    inicializarDM(Self);
    btnSincronizaLotes.Enabled := False;

end;



procedure TfrmDeletaLoteContabil.freeAndNilDM;
begin
 //ver

   //existe
  if (Assigned(dmDeletaLoteContabil)) then
  begin
       FreeAndNil(dmDeletaLoteContabil);
  end;

end;

procedure TfrmDeletaLoteContabil.inicializarDM(Sender: TObject);
begin
  try
       dmConexao.conectarBanco;

  except on E: Exception do
      ShowMessage(' '+ e.Message);
  end;


   if not Assigned(dmDeletaLoteContabil) then begin
     dmDeletaLoteContabil := TdmDeletaLoteContabil.Create(Self);
   end;

   //carrega o combo
    pIdOrganizacao := Uutil.TOrgAtual.getId;
    cbbAno.ItemIndex := indiceCbbAno;
    btnDeletarLote.Enabled := False;
    cbbAno.ItemIndex := indiceCbbAno;

end;

procedure TfrmDeletaLoteContabil.limpaCampos;
var x: Integer;
begin
 limpaStatusBar;
for x := 0 to (ComponentCount) - 1 do
  begin

     if (TComponent(Components[x]).Tag<>100) then
       begin
         if (Components[x] is TCustomEdit) then
            (Components[x] as TCustomEdit).Clear;
         if (Components[x] is TComboBox) then
           Begin
             (Components[x] as TComboBox).ItemIndex:= 0;
             (Components[x] as TComboBox).Text:=EmptyStr;
           End;
         if (Components[x] is TCheckBox) then
           (Components[x] as TCheckBox).Checked := False;
       end;
  end;

     btnSincronizaLotes.Enabled := false;

end;



function TfrmDeletaLoteContabil.obterLancamentosPorLote(pIdLote, pIdOrganizacao, pTable : string): Boolean;
var
cmd :string;

begin
 pIdOrganizacao := Uutil.TOrgAtual.getId;
  Result := false;
  qtd :=0;
   //pegar todos os lancamentos do tipo que veio e preenhcer a query
     cmd := ' SELECT  *  FROM ' + pTable  +  ' TB ' +
            ' WHERE   (TB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
            ' (TB.ID_LOTE_CONTABIL = :PIDLOTE ) ' ;



  if (pTable = 'TITULO_PAGAR') then begin //se for titulo pagar provisionado sem baixa
      cmd := ' SELECT  *  FROM ' + pTable  +  ' TB ' +
             ' WHERE   (TB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
             ' ((TB.ID_LOTE_CONTABIL = :PIDLOTE ) OR (TB.ID_LOTE_TPB = :PIDLOTE )) ' ;
  end;


  if (pTable = 'TITULO_RECEBER') then begin

     cmd := ' SELECT  *  FROM ' + pTable  +  ' TB ' +
             ' WHERE   (TB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
             ' ((TB.ID_LOTE_CONTABIL = :PIDLOTE ) OR (TB.ID_LOTE_TRB = :PIDLOTE )) ' ;
  end;




  if not qryGeneric.Connection.Connected then
  begin
    qryGeneric.Connection := dmConexao.Conn;
  end;
  qryGeneric.Close;
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add(cmd);
  qryGeneric.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryGeneric.ParamByName('PIDLOTE').AsString := pIdLote;
  qryGeneric.Open;

  qtd := qryGeneric.RecordCount;

  Result := not qryGeneric.IsEmpty;


end;

function TfrmDeletaLoteContabil.obterLoteID(pId,
  pIdOrganizacao: string): Boolean;
begin
 pIdOrganizacao := Uutil.TOrgAtual.getId;

  Result := false;
  try
        qryObterLoteID.Close;
        qryObterLoteID.Connection := dmConexao.Conn;
        qryObterLoteID.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterLoteID.ParamByName('PIDLOTE').AsString := pId;
        qryObterLoteID.Open;
  except

  raise Exception.Create('Erro ao obter lote por ID ');

  end;

  Result := not qryObterLoteID.IsEmpty;

end;



procedure TfrmDeletaLoteContabil.obterLotePorAnoFinance(pIdOrganizacao: string;  pDataInicial, pDataFinal: TDate);
var
ano, cmd :string;

begin

  dmConexao.conectarBanco;

  try
    qryObterLoteFNC.Close;

    qryObterLoteFNC.Connection := dmConexao.conn;
    qryObterLoteFNC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterLoteFNC.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
    qryObterLoteFNC.ParamByName('DTDATAFINAL').AsDate := pDataFinal;

    qryObterLoteFNC.Open;
    qryObterLoteFNC.Last;
    qryObterLoteFNC.First;

  except
  raise Exception.Create('Erro ao obter lotes no FNC');

  end;


end;

procedure TfrmDeletaLoteContabil.obterLotePorAnoMega(pidEmpresa: Integer;
  pAno: string);
begin
  dmConexao.conectarMega;
  //obter todos os lotes do ano que estejam no sistema cont�bil

  try

    qryObterLotePorAno.Close;
    qryObterLotePorAno.Connection :=dmConexao.ConnMega;
    qryObterLotePorAno.ParamByName('PIDEMPRESA').AsInteger := pidEmpresa;
    qryObterLotePorAno.ParamByName('PANO').AsString := pAno;
    qryObterLotePorAno.Open;
    qryObterLotePorAno.Last;
    qryObterLotePorAno.First;

  except
  raise Exception.Create('Erro ao obter a lista de lotes do Sistema Cont�bil');

  end;

end;

function TfrmDeletaLoteContabil.preencheAba(pId, pIdOrganizacao :string) :Boolean;
var
abaPreenchida :Boolean;
begin
      abaPreenchida := False;

      if obterLoteID(pid,pIdOrganizacao) then begin

       edtIdLote.Text         := qryObterLoteID.FieldByName('ID_LOTE_CONTABIL').AsString;
       edtDataRegistro.Text   := qryObterLoteID.FieldByName('DATA_REGISTRO').AsString;
       edtTabela.Text         := qryObterLoteID.FieldByName('TIPO_TABLE').AsString ;
       edtTipoLancamento.Text := qryObterLoteID.FieldByName('TIPO_LANCAMENTO').AsString ;
       medtValorDB.Text       := (FormatFloat('R$ ###,###,##0.00',qryObterLoteID.FieldByName('VALOR_DB').AsCurrency));
       medtValorCR.Text       := (FormatFloat('R$ ###,###,##0.00',qryObterLoteID.FieldByName('VALOR_CR').AsCurrency));

        if uutil.Empty(qryObterLoteID.FieldByName('TIPO_TABLE').AsString) then
        begin
          edtTabela.Text := 'NC';
          edtTipoLancamento.Text := 'NC';

          medtValorDB.Text := (FormatFloat('R$ ###,###,##0.00', 0));
          medtValorCR.Text := (FormatFloat('R$ ###,###,##0.00', 0));

          btnDeletarLote.Enabled := False;
        end else begin       abaPreenchida := True;
        btnDeletarLote.Enabled := True; end;


      end;

   Result :=  abaPreenchida;
end;

function TfrmDeletaLoteContabil.obterTituloPagarProvisao(pId, pIdOrganizacao :string): Boolean;
var
cmd :string;

begin

      cmd := ' SELECT  *  FROM TITULO_PAGAR  TP ' +
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
             ' (TP.ID_TITULO_PAGAR = :PID ) AND ' +
             ' (TP.REGISTRO_PROVISAO IS NOT NULL) ' ;

       try
            qryObterTPPROV.Close;
            qryObterTPPROV.Connection := dmConexao.Conn;
            qryObterTPPROV.SQL.Clear;
            qryObterTPPROV.SQL.Add(cmd);
            qryObterTPPROV.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
            qryObterTPPROV.ParamByName('PID').AsString :=pId;
            qryObterTPPROV.Open();

       except
         raise Exception.Create('N�o foi poss�vel consultar o TP PROV');

       end;

       Result := not qryObterTPPROV.IsEmpty;
end;


function TfrmDeletaLoteContabil.deletaLoteContabil(idLote,  idOrganizacao: string): Boolean;
 var
cmd :string;

begin

 cmd := ' DELETE FROM LOTE_CONTABIL   WHERE ID_ORGANIZACAO = :PIDORGANIZACAO AND  ID_LOTE_CONTABIL = :PIDLOTE ';
    try
    qryAlteraLote.Close;
    qryAlteraLote.Connection := dmConexao.Conn;
    qryAlteraLote.SQL.Clear;
    qryAlteraLote.SQL.Add(cmd);
    qryAlteraLote.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryAlteraLote.ParamByName('PIDLOTE').AsString :=idLote;

    qryAlteraLote.ExecSQL;
    dmConexao.conn.CommitRetaining;
    except
  dmConexao.Conn.RollbackRetaining;
    raise(Exception).Create('Problemas ao deletar lote cont�bil ');

  end;

end;

procedure TfrmDeletaLoteContabil.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Deleta um ou todos os lotes exporta��o existentes no sistema. ';
end;


procedure TfrmDeletaLoteContabil.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;




end.
