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
    barProgress: TEvGauge;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbbLoteContabilSelect(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnDeletarLoteClick(Sender: TObject);

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
    function alteraLancamentos(pIdLancamento, idOrganizacao, pTable :string ) : Boolean;
    function alteraLoteContabil(idLote, idOrganizacao :string ) : Boolean;


  public
    { Public declarations }
  end;

var
  frmDeletaLoteContabil: TfrmDeletaLoteContabil;

implementation

{$R *.dfm}

{ TfrmDeletaLoteContabil }


function TfrmDeletaLoteContabil.alteraLancamentos(pIdLancamento, idOrganizacao, pTable :string ) : Boolean;
var
cmd :string;
begin
  //somente retira a FK vinculada ao LOTE CONTABIL

    cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_CONTABIL = :PSTATUS  ' +
           ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO AND  ID_'+ pTable +' = :PID ';

    qryAlteraGeneric.Close;
    qryAlteraGeneric.Connection := dmConexao.Conn;
    qryAlteraGeneric.SQL.Clear;
    qryAlteraGeneric.SQL.Add(cmd);
    qryAlteraGeneric.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryAlteraGeneric.ParamByName('PID').AsString :=pIdLancamento;
    qryAlteraGeneric.ParamByName('PSTATUS').Value :=null;

    qryAlteraGeneric.ExecSQL;

    //dmConexao.Conn.CommitRetaining;

    Result := System.True;
end;



function TfrmDeletaLoteContabil.alteraLoteContabil(idLote,  idOrganizacao: string): Boolean;
var
cmd :string;
begin

 cmd := ' UPDATE LOTE_CONTABIL  SET STATUS = :PSTATUS  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO AND  ID_LOTE_CONTABIL = :PIDLOTE ';

    qryAlteraLote.Close;
    qryAlteraLote.Connection := dmConexao.Conn;
    qryAlteraLote.SQL.Clear;
    qryAlteraLote.SQL.Add(cmd);
    qryAlteraLote.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryAlteraLote.ParamByName('PIDLOTE').AsString :=idLote;
    qryAlteraLote.ParamByName('PSTATUS').AsString :='EXCLUIDO';


    qryAlteraLote.ExecSQL;

end;

procedure TfrmDeletaLoteContabil.btnDeletarLoteClick(Sender: TObject);
begin

barProgress.Visible := True;
barProgress.MaxValue :=qtd;
barProgress.MinValue :=1;
deletarLoteContabil;

end;

procedure TfrmDeletaLoteContabil.btnLimparClick(Sender: TObject);
begin
 limpaCampos;

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
      obterLoteID(pid,pIdOrganizacao);

  end;



end;

function TfrmDeletaLoteContabil.deletarLoteContabil: Boolean;
var
cmd, tabela, idLote  :string;
aux : Integer ;

begin
     tabela := edtTabela.Text;
     idLote  :=  edtIdLote.Text;

    qryGeneric.First;
    aux :=0;

    qryGeneric.RecordCount;

    while not qryGeneric.Eof do begin

     if alteraLancamentos(qryGeneric.FieldByName('ID_'+tabela).AsString,
                          qryGeneric.FieldByName('ID_ORGANIZACAO').AsString,
                          tabela) then  begin
                          Inc(aux);
      end;

      if not ( aux <> qtd ) then begin

       alteraLoteContabil(idLote, pIdOrganizacao);
      end;

    end;


     if alteraLancamentos(idLote, pIdOrganizacao, tabela) then  begin

       alteraLoteContabil(idLote, pIdOrganizacao);

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
barProgress.Visible := False;
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
  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

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

    if dmExportaFinance.preencheComboLoteContabil(pIdOrganizacao) then
    begin
      dmCombos.listaLoteContabil(cbbLoteContabil, FsListaIdLotes);
    end;

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

  if not qryObterLoteID.Connection.Connected then
  begin
    qryObterLoteID.Connection := dmConexao.Conn;
  end;
  qryObterLoteID.Close;
  qryObterLoteID.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterLoteID.ParamByName('PIDLOTE').AsString := pId;
  qryObterLoteID.Open;

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


end.
