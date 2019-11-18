unit uDMDeletaLoteContabil;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uUtil,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;
type
  TdmDeletaLoteContabil = class(TDataModule)
    qryObterTodosLoteContabil: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
   procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }
        function preencheComboLoteContabil(pIdOrganizacao, pAno: string): boolean;
  end;

var
  dmDeletaLoteContabil: TdmDeletaLoteContabil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDeletaLoteContabil.DataModuleCreate(Sender: TObject);
begin
inicializarDM(Self);

end;

procedure TdmDeletaLoteContabil.freeAndNilDM(Sender: TObject);
begin
  //nada
end;

procedure TdmDeletaLoteContabil.inicializarDM(Sender: TObject);
begin

  dmConexao.conectarBanco;

end;

function TdmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao, pAno : string ) :boolean;
var
ano, cmd :string;
pDataInicial, pDataFinal, dataServer :TDateTime;

begin
  dataServer := uUtil.getDataServer;
  ano := FormatDateTime('yyyy', dataServer );
  pDataInicial := StrToDateTime('01/01/'+ano);

  Result := false;
  cmd :=  ' SELECT  LC.ID_LOTE_CONTABIL, LC.LOTE '+
          ' FROM LOTE_CONTABIL LC ' +
          ' WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
          ' (LC.DATA_REGISTRO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) AND ' +
          ' LC.STATUS <> ''EXCLUIDO'' ' +
          ' ORDER BY LC.LOTE ' ;


  dmConexao.conectarBanco;

    try
        qryObterTodosLoteContabil.Close;
        qryObterTodosLoteContabil.Connection := dmConexao.Conn;
        qryObterTodosLoteContabil.SQL.Clear;
        qryObterTodosLoteContabil.SQL.Add(cmd);
        qryObterTodosLoteContabil.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterTodosLoteContabil.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
        qryObterTodosLoteContabil.ParamByName('DTDATAFINAL').AsDate := dataServer;
        qryObterTodosLoteContabil.Open;

      except
        raise(Exception).Create('Problemas ao OBTER LOTE CONTABIL');
      end;

    Result := not qryObterTodosLoteContabil.IsEmpty;

end;


end.