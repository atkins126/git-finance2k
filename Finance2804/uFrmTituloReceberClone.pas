unit uFrmTituloReceberClone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, ENumEd, Vcl.StdCtrls, System.Generics.Collections,
  uTituloReceberHistoricoModel, uTituloReceberHistoricoDAO, uTituloReceberCentroCustoModel, uTituloReceberCentroCustoDAO,
  uTituloReceberModel, uTituloReceberDAO, udmConexao, uSacadoModel, uSacadoDAO, uUtil;

type
  TfrmTituloReceberClone = class(TForm)
    lbl3: TLabel;
    edtDoc: TEdit;
    lbl4: TLabel;
    edtDescricao: TEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    edtParcela: TEdit;
    lbl7: TLabel;
    edtValotTR: TEvNumEdit;
    lbl8: TLabel;
    edtSacado: TEdit;
    lbl11: TLabel;
    edtCNPJ: TEdit;
    dtpVcto: TDateTimePicker;
    btnConfirmaCh: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaChClick(Sender: TObject);
  private
  pIdOrganizacao :string;

    procedure preencheForm(pTitulo: TTituloReceberModel);
    { Private declarations }
  public
    { Public declarations }
    tituloClonado :TTituloReceberModel;
    function getTitulo: TTituloReceberModel;
    constructor Create (AOwner :TComponent; pTitulo :TTituloReceberModel);

  end;

var
  frmTituloReceberClone: TfrmTituloReceberClone;

implementation

{$R *.dfm}

{ TfrmTituloReceberClone }

procedure TfrmTituloReceberClone.btnCancelarClick(Sender: TObject);
begin

  tituloClonado                  := TTituloReceberModel.Create;
  tituloClonado.FID              := '';
  tituloClonado.FIDorganizacao   := '';

 PostMessage(Self.Handle, WM_CLOSE, 0, 0);



end;

procedure TfrmTituloReceberClone.btnConfirmaChClick(Sender: TObject);
begin

  tituloClonado.FdataVencimento   := dtpVcto.DateTime;
  tituloClonado.FnumeroDocumento  := uutil.SoNumeros(edtDoc.Text);

  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

constructor TfrmTituloReceberClone.Create(AOwner: TComponent;  pTitulo: TTituloReceberModel);
var
parcela :Integer;
listaHistorico :  TObjectList<TTituloReceberHistoricoModel>;
listaCustos    :  TObjectList<TTituloReceberCentroCustoModel>;
historico : TTituloReceberHistoricoModel  ;
centroCusto : TTituloReceberCentroCustoModel;
 qtdRateioC, qtdRateioH, I :Integer;
 valorNominal, valorAntecipado :Currency;

begin
  inherited Create(AOwner);
  qtdRateioH :=0;
  qtdRateioC  :=0;
  I:=0;
  pIdOrganizacao    := uutil.TOrgAtual.getId;
   valorNominal     := pTitulo.FvalorNominal ;
   valorAntecipado  := pTitulo.FvalorAntecipado;


  tituloClonado := TTituloReceberModel.Create;
  tituloClonado := TTituloReceberDAO.obterPorID(pTitulo);

  if not uUtil.Empty(tituloClonado.FID) then begin
  // parcela := uutil.SoNumeros(pTitulo.Fparcela);

  tituloClonado.FdataUltimaAtualizacao  := Now;
  tituloClonado.FdataRegistro           := Now;
  tituloClonado.FdataProtocolo          := Now;
  tituloClonado.FprevisaoCartorio       := IncMonth(Now);
  tituloClonado.FdataEmissao            := Now;
  tituloClonado.FIDTipoStatus           := 'ABERTO';
  tituloClonado.FnumeroDocumento        := dmConexao.obterIdentificador('',pIdOrganizacao, 'TR');
  tituloClonado.FvalorNominal           := valorNominal;
  tituloClonado.FIDTituloReceberAnterior  := pTitulo.FID;
  tituloClonado.FvalorAntecipado        := valorAntecipado;
  tituloClonado.FID                     := dmConexao.obterNewID;

   qtdRateioH := tituloClonado.listaHistorico.Count;
   qtdRateioC := tituloClonado.listaCustos.Count;

   for I := 0 to qtdRateioH -1  do begin

     historico := TTituloReceberHistoricoModel.Create;
     historico.FID                    := dmConexao.obterNewID;
     historico.FIDorganizacao         := tituloClonado.listaHistorico[I].FIDorganizacao;
     historico.FIDHistorico           := tituloClonado.listaHistorico[I].FIDHistorico;
     historico.FIDContaContabilDebito := tituloClonado.listaHistorico[I].FIDContaContabilDebito;
     historico.FIDTR                  := tituloClonado.FID;
     historico.Fvalor                 := valorNominal;

     tituloClonado.listaHistorico.Clear;
     tituloClonado.AdicionarHST(historico);


   end;

   for I := 0 to qtdRateioC -1  do begin

     centroCusto                        := TTituloReceberCentroCustoModel.Create;

     centroCusto.FID                    := dmConexao.obterNewID;
     centroCusto.FIDorganizacao         := tituloClonado.listaCustos[I].FIDorganizacao;
     centroCusto.FIDCentroCusto         := tituloClonado.listaCustos[I].FIDCentroCusto;
     centroCusto.FIDTR                  := tituloClonado.FID;
     centroCusto.Fvalor                 := valorNominal;
     tituloClonado.listaCustos.Clear;
     tituloClonado.AdicionarCC(centroCusto);

   end;
   preencheForm(tituloClonado);
  end;
end;

function TfrmTituloReceberClone.getTitulo: TTituloReceberModel;
begin
Result := tituloClonado;
end;

procedure TfrmTituloReceberClone.preencheForm(pTitulo :TTituloReceberModel);
var
sacado :TSacadoModel;
parcelaTP, totalParcelaTP  :string;
posicaoPipe :Integer;

begin
  sacado := TSacadoModel.Create;
  sacado.FIDorganizacao :=pTitulo.FIDorganizacao;
  sacado.FID := ptitulo.FIDSacado;
  sacado := TSacadoDAO.obterPorID(sacado);


  edtValotTR.Value  := pTitulo.FvalorNominal;
  edtDoc.Text       := pTitulo.FnumeroDocumento;
  edtDescricao.Text := pTitulo.Fdescricao;
  edtSacado.Text   := sacado.Fnome;
  edtCNPJ.Text      := sacado.FcpfCnpj;
  dtpVcto.DateTime := Now;

   posicaoPipe := uutil.RetornaPosicaoCaracter(pTitulo.Fparcela,'/');
   if posicaoPipe = 0 then begin
     parcelaTP := pTitulo.Fparcela;
     tituloClonado.Fparcela := '1/1/'+ parcelaTP;
     tituloClonado.Fobservacao := 'tr : ' + pTitulo.FnumeroDocumento;
   end;

   if posicaoPipe > 0 then begin
      parcelaTP      := pTitulo.Fparcela.Substring(0,(posicaoPipe-1));
      totalParcelaTP := pTitulo.Fparcela.Substring((posicaoPipe+1));
      tituloClonado.Fparcela := '1/'+ parcelaTP + '/'+totalParcelaTP;
      tituloClonado.Fobservacao := 'tr : ' + pTitulo.FnumeroDocumento;
   end;

    edtParcela.Text   := tituloClonado.Fparcela;


end;


end.
