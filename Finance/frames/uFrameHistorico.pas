unit uFrameHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameGeneric, FireDAC.Stan.Intf, uHistoricoModel,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,udmConexao,uUtil,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TframeHistorico = class(TframeGeneric)
  private
    idOrganizacao : string;
    FsListaIdHistoricos : TStringList;

  public
    { Public declarations }

 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterHistorico (pIDOrganizacao, pIDHistorico :string) : Boolean;
 function getHistorico (pIDOrganizacao, pIDHistorico :string) : THistoricoModel;


  end;

var
  frameHistorico: TframeHistorico;

implementation

{$R *.dfm}

function TframeHistorico.getHistorico(pIDOrganizacao,
  pIDHistorico: string): THistoricoModel;
begin
//dada

end;

function TframeHistorico.obterHistorico(pIDOrganizacao,
  pIDHistorico: string): Boolean;
begin

end;

function TframeHistorico.obterTodos(pIdValue: string; var combo: TComboBox;
  var listaID: TStringList): boolean;
begin

dmConexao.conectarBanco;
idOrganizacao := TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione um Historico  >>>');

   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTodos.Open;
   qryObterTodos.Last;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('DESCRICAO_HISTORICO').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_HISTORICO').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;

end.
