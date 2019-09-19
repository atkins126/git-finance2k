unit uFrmContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids,uDMContasPagar,uDMContasPagarManter,uDMContasPagarDTS,
  Vcl.ComCtrls, Vcl.StdCtrls, uUtil, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmContasPagar = class(TForm)
    barNavegaTP: TDBNavigator;
    dbgTP: TDBGrid;
    pgcTiuloPagar: TPageControl;
    tsConsulta: TTabSheet;
    tsCadastro: TTabSheet;
    cbbColunas: TComboBox;
    edtConsulta: TEdit;
    btnConsultar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgTPDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmContasPagar: TfrmContasPagar;

implementation




{$R *.dfm}

procedure TfrmContasPagar.btnConsultarClick(Sender: TObject);
var
  sql,coluna:string;
  i : Integer;
begin
sql := 'SELECT * FROM  TITULO_PAGAR TP ';
  coluna := EmptyStr;
  for i := 0 to Pred(dmContasPagarDTS.dtsTituloPagar.DataSet.FieldCount) do
  begin
    if dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].DisplayLabel = cbbColunas.Text then
       coluna := dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].FieldName;
  end;
  dmContasPagarDTS.dtsTituloPagar.DataSet.Close();
   (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).SQL.Clear;
  (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).SQL.Text := sql + ' WHERE (TP.ID_ORGANIZACAO  = :PIDORGANIZACAO)'+
   ' AND ' + coluna+ ' = :valor ';
  (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).ParamByName('valor').AsString := edtConsulta.Text;
    (dmContasPagarDTS.dtsTituloPagar.DataSet as TFDQuery).ParamByName('PIDORGANIZACAO').AsString := TOrgAtual.getId;

  dmContasPagarDTS.dtsTituloPagar.DataSet.Open();
end;

procedure TfrmContasPagar.dbgTPDblClick(Sender: TObject);
begin
pgcTiuloPagar.ActivePageIndex := 1;
end;

procedure TfrmContasPagar.FormShow(Sender: TObject);
var
  i:Integer;
begin
 dmContasPagar.obterTodos(TOrgAtual.getId);


  for i := 0 to Pred(dmContasPagarDTS.dtsTituloPagar.DataSet.FieldCount) do
  begin
    if dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].DisplayLabel = 'NUMERO_DOCUMENTO' then
       cbbColunas.Items.Add(dmContasPagarDTS.dtsTituloPagar.DataSet.Fields[i].DisplayLabel);
  end;

 // SQL := (dsGeral.DataSet as TADOQuery).SQL.Text;

end;

procedure TfrmContasPagar.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmContasPagarManter)) then
  begin
    dmContasPagarManter := TdmContasPagarManter.Create(Self);
  end ;

   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end ;

   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end  ;

  if not(Assigned(dmContasPagarDTS)) then
  begin
    dmContasPagarDTS := TdmContasPagarDTS.Create(Self);
  end  ;

end;


end.
