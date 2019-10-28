unit uFrmDeletaLoteContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uDMExportaFinance, udmConexao,udmCombos,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uUtil,
  FireDAC.Comp.Client, EGauge, Vcl.Mask;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbbLoteContabilSelect(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnDeletarLoteClick(Sender: TObject);
    procedure cbbAnoChange(Sender: TObject);

  private
    { Private declarations }

    pid: string;
    qtd, indice: Integer;
    pIdOrganizacao : string;

    FsListaIdLotes: TStringList;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
    function obterLoteID(pId, pIdOrganizacao :string):Boolean;
    procedure preencheAba(pId, pIdOrganizacao :string);
    procedure limpaCampos;
    function obterLancamentosPorLote(pIdLote, pIdOrganizacao, pTable :string):Boolean;
    function deletarLoteContabil() :Boolean;
    function alteraLancamentos(pIdLancamento, idOrganizacao, pTable,pIdLote :string ) : Boolean;
    function alteraLoteContabil(idLote, idOrganizacao :string ) : Boolean;
    function obterTituloPagarProvisao(pId, pIdOrganizacao :string): Boolean ;
    function deletaLoteContabil(idLote, idOrganizacao: string): Boolean;


  public
    { Public declarations }
  end;

var
  frmDeletaLoteContabil: TfrmDeletaLoteContabil;

implementation

{$R *.dfm}

{ TfrmDeletaLoteContabil }

function TfrmDeletaLoteContabil.alteraLancamentos(pIdLancamento, idOrganizacao, pTable,pIdLote :string ) : Boolean;
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

   try
        qryAlteraGeneric.Close;
        qryAlteraGeneric.Connection := dmConexao.Conn;
        qryAlteraGeneric.SQL.Clear;
        qryAlteraGeneric.SQL.Add(cmd);
        qryAlteraGeneric.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
        qryAlteraGeneric.ParamByName('PID').AsString :=pIdLancamento;
        qryAlteraGeneric.ParamByName('PSTATUS').Value :=null;

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
         resultado := deletarLoteContabil;
     except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' deletando lote cont�bil!');
      end;


      if resultado then begin
      ShowMessage('Lote cancelado com sucesso...! ATEN��O: Os lan�amentos ainda constam no sistema cont�bil...');
      end;

end;

procedure TfrmDeletaLoteContabil.btnLimparClick(Sender: TObject);
begin
 limpaCampos;

end;

procedure TfrmDeletaLoteContabil.cbbAnoChange(Sender: TObject);
var
ano :string;
begin

 if cbbAno.ItemIndex > (-1) then begin

    ano := cbbAno.Items[cbbAno.ItemIndex];


  if dmExportaFinance.preencheComboLoteContabil(pIdOrganizacao, ano) then
    begin
      dmCombos.listaLoteContabil(cbbLoteContabil, FsListaIdLotes);
    end;


    cbbLoteContabil.Enabled := True;

 end;


end;

procedure TfrmDeletaLoteContabil.cbbLoteContabilSelect(Sender: TObject);
begin
    pid:='';
    indice:=0;

if (cbbLoteContabil.ItemIndex > (-1)) then
  begin
    indice := (cbbLoteContabil.ItemIndex );
    pid := FsListaIdLotes[indice];
  end;

  preencheAba(pid, pIdOrganizacao);

  if (obterLancamentosPorLote(pid,pIdOrganizacao, edtTabela.Text)) then begin

     if qtd> 0 then begin
        btnDeletarLote.Enabled := true;
      end;

      try
          obterLoteID(pid,pIdOrganizacao);

      except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
      end;
  end;



end;

function TfrmDeletaLoteContabil.deletarLoteContabil: Boolean;
var
tabela, idLote  :string;
aux : Integer ;

begin
     tabela := edtTabela.Text;
     idLote  :=  edtIdLote.Text;

    // obterLancamentosPorLote(idLote,pIdOrganizacao, tabela);

     // a qry � preenchida no evento OnSelect de cbbLoteContabil
    qryGeneric.First;
    aux :=0;

   qryGeneric.RecordCount;

    while not qryGeneric.Eof do begin
          try
               alteraLancamentos(qryGeneric.FieldByName('ID_'+tabela).AsString,
                          qryGeneric.FieldByName('ID_ORGANIZACAO').AsString,
                          tabela,idLote);
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
          if dmExportaFinance.preencheComboLoteContabil(pIdOrganizacao,'') then
           begin
            dmCombos.listaLoteContabil(cbbLoteContabil, FsListaIdLotes);
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
    inicializarDM(Self);

end;



procedure TfrmDeletaLoteContabil.freeAndNilDM;
begin
 //ver

   //existe
  if (Assigned(dmExportaFinance)) then
  begin
       FreeAndNil(dmExportaFinance);
  end;

end;

procedure TfrmDeletaLoteContabil.inicializarDM(Sender: TObject);
begin
  try
       dmConexao.conectarBanco;

  except on E: Exception do
      ShowMessage(' '+ e.Message);
  end;

  if not (Assigned(dmExportaFinance)) then
  begin
    dmExportaFinance := TdmExportaFinance.Create(Self);
   end;

   //carrega o combo
   pIdOrganizacao := Uutil.TOrgAtual.getId;

   
    btnDeletarLote.Enabled := False;

end;

procedure TfrmDeletaLoteContabil.limpaCampos;
var x: Integer;
begin
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

  inicializarDM(Self);
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

  if not qryGeneric.Connection.Connected then
  begin
    qryGeneric.Connection := dmConexao.Conn;
  end;
  qryGeneric.Close;
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add(cmd);
  qryGeneric.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryGeneric.ParamByName('PIDLOTE').AsString := pId;
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



procedure TfrmDeletaLoteContabil.preencheAba(pId, pIdOrganizacao :string);
begin

      if obterLoteID(pid,pIdOrganizacao) then begin

       edtIdLote.Text       := qryObterLoteID.FieldByName('ID_LOTE_CONTABIL').AsString;
       edtDataRegistro.Text := qryObterLoteID.FieldByName('DATA_REGISTRO').AsString;
       edtTabela.Text       := qryObterLoteID.FieldByName('TIPO_TABLE').AsString;
       medtValorDB.Text     := (FormatFloat('R$ ###,###,##0.00',qryObterLoteID.FieldByName('VALOR_DB').AsCurrency));
       medtValorCR.Text     := (FormatFloat('R$ ###,###,##0.00',qryObterLoteID.FieldByName('VALOR_CR').AsCurrency));

      end;


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
    raise(Exception).Create('Problemas ao deletar lote contabil ');

  end;

end;




end.
