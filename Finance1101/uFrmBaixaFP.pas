unit uFrmBaixaFP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, uUtil, Data.DB,udmConexao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, uDMBaixaTP,
  dxSkinsDefaultPainters, FireDAC.Stan.Intf, FireDAC.Stan.Option, uChequeModel,uFrmBaixaFPCheque,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxStatusBar, uTituloPagarModel,
  Vcl.Grids, Vcl.DBGrids, uFrameFormaPagamento;

type
  TfrmBaixaFP = class(TForm)
    frmFormaPagto1: TfrmFormaPagto;
    edtValor: TEvNumEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btnSelect: TButton;
    dbgrdFP: TDBGrid;
    dxStatusBar: TdxStatusBar;
    fdmFP: TFDMemTable;
    dsGridFP: TDataSource;
    btnDin: TButton;
    btnCheque: TButton;
    btnWEB: TButton;
    btnLimpar: TButton;
    btnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure btnDinClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnChequeClick(Sender: TObject);
    procedure btnWEBClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FSListaIDFP :TStringList;
    pIdOrganizacao :string;
    valorDevido :Currency;
    cheque : TChequeModel;
    tituloPagar :TTituloPagarModel;

    procedure createTable;
    procedure removeFP(pIndice :Integer);
    function  obterValorPago: Currency;
    procedure validarValor;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpar;

  public
    { Public declarations }
  constructor Create (AOwner :TComponent; pTitulo :TTituloPagarModel);

  end;

var
  frmBaixa :TfrmBaixaFP ;

implementation

{$R *.dfm}

{ TfrmBaixaFP2 }

procedure TfrmBaixaFP.btnCancelarClick(Sender: TObject);
begin
  btnLimpar.Click;
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmBaixaFP.btnChequeClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('CHEQUE') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbFormaPagto.ItemIndex := posicao;
      btnSelect.Click;
      btnCheque.Enabled := False;

end;

procedure TfrmBaixaFP.btnDinClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('ESPECIE') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbFormaPagto.ItemIndex := posicao;
      btnSelect.Click;
      btnDin.Enabled := False;

end;

procedure TfrmBaixaFP.btnLimparClick(Sender: TObject);
begin
 limpar;

end;

procedure TfrmBaixaFP.btnSelectClick(Sender: TObject);
var
chequePagto :TChequeModel;
idFormaPagto :string;

begin
 if frmFormaPagto1.cbbFormaPagto.ItemIndex >0 then begin
     idFormaPagto := FSListaIDFP[frmFormaPagto1.cbbFormaPagto.ItemIndex];

    if idFormaPagto.Equals('CHEQUE') then
    begin

      chequePagto := TChequeModel.Create;
      chequePagto.FIdOrganizacao := pIdOrganizacao;
      chequePagto.FValor := edtValor.Value;
      chequePagto.FPortador := 'RANAN';

      frmBaixaFPCheque := TfrmBaixaFPCheque.Create(Self, chequePagto);
      frmBaixaFPCheque.ShowModal;
      chequePagto := frmBaixaFPCheque.getCheque;
   //   FreeAndNil(frmBaixaFPCheque);

      fdmFP.InsertRecord([frmFormaPagto1.cbbFormaPagto.Text + ' ' + chequePagto.FNumeroCheque, edtValor.Value]);



    end;



  //  fdmFP.InsertRecord([frmFormaPagto1.cbbFormaPagto.Text,edtValor.Value]);
    frmFormaPagto1.cbbFormaPagto.DeleteSelected;
    dbgrdFP.Refresh;


    msgStatusBar(3, formatfloat('R$ ,0.00', (valorDevido)));
    msgStatusBar(3, formatfloat('R$ ,0.00', (obterValorPago)));

    frmFormaPagto1.cbbFormaPagto.ItemIndex := 0;
    edtValor.Clear;
    Application.ProcessMessages;

    edtValor.Value := ( valorDevido - obterValorPago );

    if obterValorPago = valorDevido then begin

      frmFormaPagto1.cbbFormaPagto.Enabled :=False;
      btnDin.Enabled :=False;
      btnWEB.Enabled :=False;
      btnCheque.Enabled :=False;
      edtValor.Enabled :=False;

    end;


 end;

end;

procedure TfrmBaixaFP.btnWEBClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('INTERNET BANK') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbFormaPagto.ItemIndex := posicao;
      btnSelect.Click;
      btnWEB.Enabled := False;


end;

constructor TfrmBaixaFP.Create(AOwner: TComponent; pTitulo :TTituloPagarModel);
begin
 inherited Create(AOwner);
  if not Assigned(dmBaixaTP) then
  begin
    dmBaixaTP := TdmBaixaTP.Create(Self, pIdOrganizacao);
  end;


  tituloPagar := TTituloPagarModel.Create;
  tituloPagar := dmBaixaTP.obterTitulo(pTitulo);
  valorDevido := tituloPagar.FvalorNominal;


  msgStatusBar(1,formatfloat('R$ ,0.00', (valorDevido)));
  edtValor.MinValue := 0.1;
  edtValor.MaxValue := valorDevido;


end;

procedure TfrmBaixaFP.createTable;
begin

  if not Assigned(dmBaixaTP) then
  begin
    dmBaixaTP := TdmBaixaTP.Create(Self, pIdOrganizacao);
  end;


fdmFP.FieldDefs.Add('DESCRICAO', ftString, 60,false);
fdmFP.FieldDefs.Add('VALOR', ftCurrency, 0,false);
fdmFP.FieldDefs.Add('ID_FORMA_PAGAMENTO', ftString, 36,false);
fdmFP.CreateDataSet;

end;

procedure TfrmBaixaFP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(dmBaixaTP) then
  begin
    FreeAndNil(dmBaixaTP);
  end;

 Action := caFree;
end;

procedure TfrmBaixaFP.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;



procedure TfrmBaixaFP.FormCreate(Sender: TObject);
begin

 pIdOrganizacao := uutil.TOrgAtual.getId;
 msgStatusBar(0, 'Valor devido ');
 msgStatusBar(2, 'Valor pago ');

createTable;
frmFormaPagto1.obterTodos(pIdOrganizacao, frmFormaPagto1.cbbFormaPagto, FSListaIDFP);
 edtValor.Value := ( valorDevido  );

end;

procedure TfrmBaixaFP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F6 : btnDin.Click;
    VK_F7 : btnCheque.Click;
    VK_F8 : btnWEB.Click;

  end;
end;

function TfrmBaixaFP.obterValorPago: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmFP.Open;
 fdmFP.First;
 while not fdmFP.Eof do begin

 total := total + fdmFP.FieldByName('VALOR').AsCurrency;

 fdmFP.Next;
 end;


  Result := total;

end;

procedure TfrmBaixaFP.removeFP(pIndice: Integer);
begin
if pIndice >0 then begin

     frmFormaPagto1.cbbFormaPagto.DeleteSelected ;

 end;

end;

procedure TfrmBaixaFP.validarValor;
begin
  btnSelect.Enabled := False;
  frmFormaPagto1.Enabled := False;
  edtValor.Enabled := False;

  if obterValorPago < valorDevido then
  begin

    btnSelect.Enabled := True;
    frmFormaPagto1.Enabled := True;
    edtValor.Enabled := True;
  end;

end;


procedure TfrmBaixaFP.limpar;
begin
 fdmFP.Open;
  fdmFP.First;
  while not fdmFP.Eof do
  begin
    fdmFP.Delete;
    fdmFP.Next;
  end;

  dbgrdFP.DataSource.DataSet.Close;
  dbgrdFP.Refresh;
  btnDin.Enabled := True;
  btnCheque.Enabled := True;
  btnWEB.Enabled := True;
  msgStatusBar(3,'0');
  frmFormaPagto1.obterTodos(pIdOrganizacao, frmFormaPagto1.cbbFormaPagto, FSListaIDFP);
  frmFormaPagto1.cbbFormaPagto.Enabled :=True;

  edtValor.Value := ( valorDevido  );


  Application.ProcessMessages;
  validarValor;

end;




end.
