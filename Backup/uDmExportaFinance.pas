unit uDMExportaFinance;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,udmConexao, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
   TdmExportaFinance = class(TDataModule)
    qryTitulosProvisionados: TFDQuery;
    qryGravarLoteContabil: TFDQuery;
    qryObterTPHistoricoPorTitulo: TFDQuery;
    qryObterCentroCustoPorTitulo: TFDQuery;
    qryVerificaHistoricoSemContaContabil: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  function obterTPProvisionados(pIdOrganizacao,pIdStatus :String ; pDataInicial, pDataFinal:TDateTime;pProvisao :Integer): Boolean;
  function gravarLoteContabil(pIdLote,pIdOrganizacao,pLote,pStatus,pUsuario,pDataInicial, pDataFinal,pDataRegistro,pDataAtualizacao :String) :Boolean;
  function verificaHistoricoSemConta(pIdOrganizacao:String) : Boolean;

  end;

var
  dmExportaFinance: TdmExportaFinance;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}




{
parte 1
    ID_LOTE_CONTABIL  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO    VARCHAR(36) NOT NULL,
    LOTE              VARCHAR(30),
    STATUS            VARCHAR(30),   EXPORTADO
    ID_USUARIO        NUMERIC(5,0), 1
    DATA_REGISTRO     DATE,
    DATA_ATUALIZACAO  DATE NOT NULL,
    PERIODO_INICIAL   DATE,
    PERIODO_FINAL     DATE               }


       {parte 2 update
    QTD_TIT_PAG       NUMERIC(5,0),
    QTD_TIT_REC       NUMERIC(5,0),
    QTD_TIT_PAG_BX    NUMERIC(5,0),
    QTD_TIT_REC_BX    NUMERIC(5,0),
    QTD_TES_CRED      NUMERIC(5,0),
    QTD_CTA_DEB       NUMERIC(5,0),
    QTD_CTA_TRA       NUMERIC(5,0),
    QTD_CTA_CRE       NUMERIC(5,0),
    QTD_TES_DEB       NUMERIC(5,0), }





function TdmExportaFinance.gravarLoteContabil(pIdLote,pIdOrganizacao,pLote,pStatus,pUsuario,pDataInicial, pDataFinal,pDataRegistro,pDataAtualizacao :String) :Boolean;


  var
   comando,station :string;
   begin
    pUsuario := '1';
    pStatus :='EXPORTADO';
    station := '';

    comando :=  'INSERT INTO LOTE_CONTABIL (ID_LOTE_CONTABIL, ID_ORGANIZACAO, LOTE, STATUS, ' +
                'ID_USUARIO, PERIODO_INICIAL, PERIODO_FINAL, DATA_REGISTRO, DATA_ATUALIZACAO  ) ' +
                'VALUES (:pIdLote, :pIdOrganizacao, :pLote, :pStatus, :pUsuario, ' +
                ':pDataInicial,:pDataFinal,:pDataRegistro,:pDataAtualizacao)';

       try
        qryGravarLoteContabil .Close;
        qryGravarLoteContabil.Connection := dmConexao.Conn;
        qryGravarLoteContabil.SQL.Clear;
        qryGravarLoteContabil.SQL.Add( comando );
        qryGravarLoteContabil.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
        qryGravarLoteContabil.ParamByName('pIdLote').AsString := pIdLote;
        qryGravarLoteContabil.ParamByName('pLote').AsString := pLote;
        qryGravarLoteContabil.ParamByName('pStatus').AsString := pStatus;
        qryGravarLoteContabil.ParamByName('pUsuario').AsString := pUsuario;
        qryGravarLoteContabil.ParamByName('pDataRegistro').AsString := pDataRegistro;
        qryGravarLoteContabil.ParamByName('pDataInicial').AsString := pDataInicial;
        qryGravarLoteContabil.ParamByName('pDataFinal').AsString := pDataFinal;
        qryGravarLoteContabil.ParamByName('pDataAtualizacao').AsString := pDataAtualizacao;

        qryGravarLoteContabil.ExecSQL;
        Result := System.True;

     except
      raise;
     end;
   end;

    //parametros para  obterTPProvisionados
  {WHERE (TP.ID_ORGANIZACAO = :pOrganizacao) AND
         (TP.ID_TIPO_STATUS = 'ABERTO') AND
         (TP.ID_LOTE_CONTABIL IS NULL) AND
         (TP.DATA_PAGAMENTO IS NULL)   AND
         (TP.DATA_EMISSAO BETWEEN :dtDataInicial AND :dtDataFinal) }


function TdmExportaFinance.obterTPProvisionados(pIdOrganizacao,pIdStatus :String; pDataInicial, pDataFinal:TDateTime;pProvisao :Integer): Boolean;
 begin
  Result := false;

   qryTitulosProvisionados.Close;
   if not qryTitulosProvisionados.Connection.Connected then begin
         qryTitulosProvisionados.Connection := dmConexao.Conn;
   end;
    qryTitulosProvisionados.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryTitulosProvisionados.ParamByName('pIdStatus').AsString := pIdStatus;
    qryTitulosProvisionados.ParamByName('pDataInicial').AsDate := pDataInicial;
    qryTitulosProvisionados.ParamByName('pDataFinal').AsDate := pDataFinal;
    qryTitulosProvisionados.ParamByName('pProvisao').AsInteger := pProvisao;
    qryTitulosProvisionados.Open;

    Result := not qryTitulosProvisionados.IsEmpty;

 end;


 function TdmExportaFinance.verificaHistoricoSemConta(pIdOrganizacao :String) : Boolean;
 begin
  Result := false;

    qryVerificaHistoricoSemContaContabil.Close;
    qryVerificaHistoricoSemContaContabil.Connection := dmConexao.Conn;
    qryVerificaHistoricoSemContaContabil.ParamByName('pIdOrganizacao').AsString :=pIdOrganizacao  ;
    qryVerificaHistoricoSemContaContabil.Open;

    Result := not qryVerificaHistoricoSemContaContabil.IsEmpty;
 end;





end.
