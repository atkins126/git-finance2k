unit uFrmHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameGeneric, uFrameHistorico, udmConexao, uUtil,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmHistorico = class(TForm)
    frameHistorico1: TframeHistorico;
    dbgrd1: TDBGrid;
    qryObterHistoricos: TFDQuery;
    ds1: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
  pIdOrganizacao :string;
  FsListaIdHistorico: TStringList;
    procedure inicializarDM(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

{$R *.dfm}

procedure TfrmHistorico.FormCreate(Sender: TObject);
begin

  inicializarDM(Self);
end;



procedure TfrmHistorico.inicializarDM(Sender: TObject);
begin

pIdOrganizacao := uUtil.TOrgAtual.getId;

frameHistorico1.obterTodos(pIdOrganizacao, frameHistorico1.cbbcombo,FsListaIdHistorico );

end;

end.
