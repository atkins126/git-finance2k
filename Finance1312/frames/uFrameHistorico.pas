unit uFrameHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameGeneric, FireDAC.Stan.Intf, uHistoricoModel,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,udmConexao,uUtil,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uContaContabilModel,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TframeHistorico = class(TframeGeneric)
    qryObterContaContabil: TFDQuery;
  private
    idOrganizacao : string;
    FsListaIdHistoricos : TStringList;
    function obterContaContabil(pIDOrganizacao, pIDHistorico: string): Boolean;

  public
    { Public declarations }

 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterHistorico (pIDOrganizacao, pIDHistorico :string) : Boolean;
 function getHistorico (pIDOrganizacao, pIDHistorico :string) : THistoricoModel;
 function getContaContabil  (pIDOrganizacao, pIDHistorico :string) : TContaContabilModel;


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



function TframeHistorico.getContaContabil(pIDOrganizacao, pIDHistorico: string): TContaContabilModel;
var
conta : TContaContabilModel;

begin
   conta :=TContaContabilModel.Create;

 try
    if obterContaContabil(pIDOrganizacao, pIDHistorico) then begin

        conta.SetFCodigoReduzido(qryObterContaContabil.FieldByName('CODREDUZ').AsString);
        conta.SetFConta(qryObterContaContabil.FieldByName('CONTA').AsString);
        conta.SetFDescricao(qryObterContaContabil.FieldByName('DESCRICAO').AsString);
        conta.SetFDgReduz(qryObterContaContabil.FieldByName('DGREDUZ').AsString);
        conta.SetFDgVer(qryObterContaContabil.FieldByName('DGVER').AsString);
        conta.SetFIdContaContabil(qryObterContaContabil.FieldByName('ID_CONTA_CONTABIL').AsString);
        conta.SetFIdOrganizacao(qryObterContaContabil.FieldByName('ID_ORGANIZACAO').AsString);

    end;

  except

    raise(Exception).Create('N�o foi poss�vel obter a conta cont�bil.');

  end;


  Result := conta;
end;


function TframeHistorico.obterContaContabil(pIDOrganizacao,  pIDHistorico: string): Boolean;
  var
  sqlCC :string;
begin
 dmConexao.conectarBanco;
 idOrganizacao := TOrgAtual.getId;
 pIDOrganizacao := idOrganizacao;

  sqlCC :=  ' SELECT H.ID_HISTORICO, '+
            ' H.ID_ORGANIZACAO, '+
            ' CC.ID_CONTA_CONTABIL,'+
            ' CC.DESCRICAO, '+
            ' CC.CONTA,  '+
            ' CC.DGVER,   '+
            ' CC.CODREDUZ,  '+
            ' CC.DGREDUZ   '+
            ' FROM HISTORICO H '+
            ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
            ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) AND   (H.ID_HISTORICO = :PIDHISTORICO) ' ;


 try

  // qryObterContaContabil := TFDQuery.Create(Self);
   qryObterContaContabil.Close;
   qryObterContaContabil.Connection := dmConexao.conn;
   qryObterContaContabil.SQL.Clear;
   qryObterContaContabil.SQL.Add(sqlCC);
   qryObterContaContabil.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
   qryObterContaContabil.ParamByName('PIDHISTORICO').AsString := pIDHistorico;
   qryObterContaContabil.Open;

 except

    raise(Exception).Create('Problemas ao tentar consultar conta cont�bl');

  end;
 Result := not qryObterContaContabil.IsEmpty;

end;


end.
