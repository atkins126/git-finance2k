unit Util;

interface

uses
  Vcl.Controls, System.Classes, System.IniFiles, System.SysUtils, Vcl.Forms,
   Data.DB, ELibFnc, Datasnap.DBClient, Vcl.StdCtrls, RxLookup,
  Constants, Vcl.ExtCtrls, Vcl.Imaging.Jpeg, Vcl.Graphics, Dialogs,
  WinApi.Messages, WinApi.Windows, Vcl.FileCtrl, uVarGlobais, udmUtil,
  IdIPWatch,  Data.SqlExpr, System.Win.ComObj, Winapi.WinSock,
  FireDAC.Comp.Client,  Vcl.Menus, System.Types, Grids,
  DBGrids, System.RegularExpressions, IdHashMessageDigest;


//  , System.TypInfo, System.Rtti;

type

  TOperacao = (opInserir, opAtualizar, opExcluir, opNenhuma);

  TTipoRegimeTributario = (opMunicipal, opEstadual, opFederal, opConstituicao);

  TTipoAgregacao = (taQuantidade,taSoma,taMedia,taMinimo,taMaximo);

  {$REGION 'TUtilSO: Classe com fun��es de informa��es do Sistema Operacional'}
  TUtilSO = class
  public
    {$REGION 'getNomeComputador...'}
    /// <summary>
    /// Retorna o nome do computador
    /// </summary>
    /// <returns>String contendo o nome do computador</returns>
    {$ENDREGION}
    class function getNomeComputador: string;
    {$REGION 'getNumeroIP...'}
    /// <summary>
    /// Retorna o n�mero IP do computador
    /// </summary>
    /// <returns>String contendo o n�mero ip do computador</returns>
    {$ENDREGION}
    class function getNumeroIP: string;
    {$REGION 'getMacAddress...'}
    /// <summary>
    /// Retorna o Endere�o MAC do computador
    /// </summary>
    /// <returns>String contendo o Endere�o MAC do computador</returns>
    {$ENDREGION}
    class function getMacAddress: string;
  end;
  {$ENDREGION}

  {$REGION 'TUtilMath: Classe com fun��es matem�ticas'}
  TUtilMath = class
  public
    {$REGION 'getInverteSinal...'}
    /// <summary>
    /// Retorna o valor passado por par�metro com o sinal invertido.
    /// Ex: valor 10, retorna -10. Valor -10, retorna 10.
    /// </summary>
    /// <returns>Retorna o valor recebido por par�metro com o sinal invertido</returns>
    {$ENDREGION}
    class function getInvertSinal(pdblValor: Currency): Currency;
    class function IncValue(var value: Integer; piIncremento: Integer = 1): Integer;
    {$REGION 'IncDecAnos...'}
    /// <summary>
    /// Fun��o para incrementar ou decrementar anos a uma data. Ex: Data = 15.07.2016. Anos a incrementar = 4, resultado 15.07.2020
    /// </summary>
    /// <param name="pdData">Par�metro do tipo TDateTime a ser incrementada por piAnos</param>
    /// <param name="piAnos">Par�metro do tipo Integer, com a quantidade de anos a serem incrementados ou decrementados a pdData. Se o valor for positivo, incrementa. Caso contr�rio decrementa</param>
    /// <returns>Vari�vel do tipo TDateTime, incrementada com a quantidade de anos passada atrav�s do par�metro piAnos</returns>
    {$ENDREGION}
    class function IncDecAnos(pdData: TDateTime; piAnos:integer): TDateTime;
    {$REGION 'IncDecMes...'}
    /// <summary>
    /// Fun��o para incrementar meses a uma data. Ex: Data = 15.07.2016. Meses a incrementar = 4, resultado 15.11.2016
    /// </summary>
    /// <param name="pdData">Par�metro do tipo TDateTime a ser incrementada por piMeses</param>
    /// <param name="piMeses">Par�metro do tipo Integer, com a quantidade de meses a serem incrementados ou decrementados a pdData. Se o valor for positivo, incrementa. Caso contr�rio decrementa</param>
    /// <returns>Vari�vel do tipo TDateTime, incrementada com a quantidade de meses passada atrav�s do par�metro piMeses</returns>
    {$ENDREGION}
    class function IncDecMes(pdData:TDateTime;piMeses:Integer): TDateTime;
    {$REGION 'MD5Arquivo...'}
    /// <summary>
    /// Fun��o para retornar o hash no padr�o MD5 de um arquivo
    /// </summary>
    /// <param name="psNomeArquivo">Par�metro do tipo String contendo o path e o nome do arquivo</param>
    /// <returns>Vari�vel do tipo String contendo o hash MD5 do arquivo</returns>
    {$ENDREGION}
    class function MD5Arquivo(const psNomeArquivo: string): string;
    {$REGION 'MD5String...'}
    /// <summary>
    /// Fun��o para retornar o hash no padr�o MD5 de uma String
    /// </summary>
    /// <param name="psString">Par�metro do tipo String</param>
    /// <returns>Vari�vel do tipo String contendo o hash MD5 da String</returns>
    {$ENDREGION}
    class function MD5String(const psString: string): string;

  end;
  {$ENDREGION}

  {$REGION 'TUtilConexao: Classe com fun��es para conex�o com banco de dados'}
  TUtilConexaoFireDac = class
  public
    {FireDac}
    class procedure setConn(poConn: TFDConnection);
    class function  getConn: TFDConnection;
    class procedure setConnUniDirecional(poConn: TFDConnection);
    class function  getConnUniDirecional: TFDConnection;
    class procedure setConnControleUsuarios(poConn: TFDConnection);
    class function  getConnControleUsuarios: TFDConnection;
    class procedure Commit(poConn: TFDConnection);
    class procedure RollBack(poConn: TFDConnection);
    class procedure StartTransaction(poConn: TFDConnection);
  end;
  {$ENDREGION}

  {$REGION 'TUtilControleUsuarios: Classe com fun��es para controle de usu�rios'}
  TUtilControleUsuarios = class
  public
    class function getIdUser(psLogin: String): String;
    class function getLoginUser(psIdUser: String): String;
  end;
  {$ENDREGION}

  {$REGION 'TUtilControleAplicacao: Classe com fun��es para controle da aplica��o'}
  TUtilControleAplicacao = class
  public
//    {$REGION 'ProcessaMsg...'}
//    /// <summary>
//    /// M�todo de classe utilizado para substituir o m�todo Application.OnMessage
//    /// </summary>
//    /// <param name="poMsg">Par�metro do tipo TMsg passado pela automaticamente pela aplica��o</param>
//    /// <param name="pbHandled">Par�metro do tipo Boolean passado pela automaticamente pela aplica��o</param>
//    /// <remarks>
//    ///  Exemplo de utiliza��o:
//    ///  Application.OnMessage := TUtilControleAplicacao.ProcessaMsg;
//    ///
//    ///  Com essa atribui��o o m�todo OnMessage, nativo do Delphi, � substituido
//    ///  pelo m�todo TUtilControleAplicacao.ProcessaMsg.
//    /// </remarks>
//    {$ENDREGION}
//    class procedure ProcessaMsg(var poMsg: TMsg; var pbHandled: Boolean);

    {$REGION 'getAppInfo...'}
    /// <summary>
    /// Alimenta piTimeOut com o valor do campo TIME_OUT da tabela UC_APP_INFO.
    /// </summary>
    /// <param name="piTimeOut">Par�metro do tipo Integer, passado por refer�ncia</param>
    {$ENDREGION}
    class procedure getAppInfo(var piTimeOut: Integer);

    {$REGION 'Explicando o Regex (Nota...)'}
    {*------------------------------------------------------------------------------
      O COMANDO  TRegEx.Match(psVersao,'^\d+\.\d+\.\d+\.\d+$').Success;

      Comando para trocar todos os caracteres que n�o sejam letras ou espa�o em branco por '' (nada).
      O REGEX [^A-Za-z�-�\s]:
      [] Lista/Conjunto
      ^ Simbolo para negar o conte�do do conjunto/lista
      A-Z Todas as letras mai�sculas de A � Z
      a-z Todas as letras min�sculas de a � z
      �-� Todos os caracteres acentuados
      \s Espa�os em bran�o, tabula��es


      ^ iniciar com
      \d numeros
      + 1 ou mais (ref. caractere anterior)
      \. ponto literal, tem que usar a "\" barra para escapar
      $ final da linha

    -------------------------------------------------------------------------------}
    {$ENDREGION}


    {$REGION 'validaVersaoAplicacao...'}
    /// <summary>
    /// Verifica se a string passada pelo par�metro psVers�o comt�m uma vers�o
    /// v�lida de uma aplica��o. Ex: 2.1.1.45.
    /// </summary>
    /// <param name="psVersao">Par�metro do tipo String com a vers�o do aplicativo</param>
    /// <returns>
    ///  Vari�vel do tipo boolean, <c>False</c> caso valor informado seja igual
    ///  a 0 (zero), e <c>True</c> para valores diferentes de 0 (zero).
    /// </returns>
    /// <remarks>
    ///  A fun��o Match().Success retorna true se encontrar o padr�o
    ///  O REGEX '^\d+\.\d+\.\d+\.\d+$'
    ///
    ///  ^ iniciar com
    ///  \d numeros
    ///  + 1 ou mais (ref. caractere anterior)
    ///  \. ponto literal, tem que usar a "\" barra para escapar
    ///  $ final da linha
    /// </remarks>
    {$ENDREGION}
    class function validaVersaoAplicacao(psVersao: String): Boolean;

    {$REGION 'Versao...'}
    /// <summary>
    /// Retorna a vers�o da aplica��o
    /// </summary>
    /// <returns>
    ///  Vari�vel do tipo String contendo a vers�o da aplica��o
    /// </returns>
    {$ENDREGION}
    class function Versao(): String;
  end;
  {$ENDREGION}

  {$REGION 'TUtilConvert: Classe com fun��es para convers�o de dados'}
  TUtilConvert = Class
  public
    {$REGION 'BooleanToInt...'}
    /// <summary>
    /// Fun��o para convers�o de um valor booleano para um integer
    /// </summary>
    /// <param name="pbBoolean">Valor booleano para ser convertido</param>
    /// <returns>Vari�vel do tipo integer, -1 para <c>True</c> e 0 para <c>False</c></returns>
    {$ENDREGION}
    class function BooleanToInt(pbBoolean: Boolean): Integer;
    {$REGION 'BooleanToChar...'}
    /// <summary>
    /// Fun��o para convers�o de um valor booleano para um char (S ou N)
    /// </summary>
    /// <param name="pbBoolean">Valor booleano para ser convertido</param>
    /// <returns>Vari�vel do tipo Char, -1 para <c>S</c> e 0 para <c>N</c></returns>
    {$ENDREGION}
    class function BooleanToChar(pbBoolean: Boolean): Char;
    {$REGION 'IntToBoolean...'}
    /// <summary>
    /// Fun��o para convers�o de um valor inteiro para um booelan
    /// </summary>
    /// <param name="piInteger">Valor inteiro para ser convertido</param>
    /// <returns>
    ///  Vari�vel do tipo boolean, <c>False</c> caso valor informado seja igual
    ///  a 0 (zero), e <c>True</c> para valores diferentes de 0 (zero).
    /// </returns>
    {$ENDREGION}
    class function IntToBoolean(piInteger: Integer): Boolean;
    {$REGION 'StrToCurrency...'}
    /// <summary>
    ///  Fun��o para convers�o de um valor Monet�rio String em um Currency
    /// </summary>
    /// <param name="psValor">String para ser convertida</param>
    /// <param name="pdblValorPadrao">
    ///  Valor opcional de retorno caso a convers�o falhe. Caso n�o seja
    ///  informado e a convers�o falhar, ser� retornado o valor 0 "zero".
    /// </param>
    /// <returns>
    ///  String convertida em Currency
    /// </returns>
    {$ENDREGION}
    class function StrToCurrency(psValor: string; pdblValorPadrao: Currency = 0): Currency;
    {$REGION 'CurrToStr...'}
    /// <summary>
    ///  Fun��o para convers�o de um valor Monet�rio tipo Currency em uma String
    /// </summary>
    /// <param name="psValor">Variav�l tipo Currency para ser convertida em uma String</param>
    /// <param name="piTamanho">Tamanho da String de retorno</param>
    /// <param name="piDecimais">Quantidade de decimais</param>
    /// <param name="pbSeparadorDecimal">Variav�l do tipo Boolean, quando verdadeira retornar� a string com separador de decimais</param>
    /// <param name="pbZerosEsquerda">Variav�l do tipo Boolean - Quando verdadeira, preenche a string de retorno com zeros at� o tamanho definido em piTamanho</param>
    /// <returns>
    ///  Currency convertido em String
    /// </returns>
    {$ENDREGION}
    class function CurrToStr(pdblValor: Currency; piTamanho,piDecimais: Integer;
      pbSeparadorDecimal: Boolean; pbZerosEsquerda: Boolean = true): String;

    {$REGION 'SoNumeros...'}
    /// <summary>
    ///  Fun��o para convers�o de uma string em outra que s� contenha os n�meros
    ///  existentes na primeira
    /// </summary>
    /// <param name="psString">String para ser convertida</param>
    /// </param>
    /// <returns>
    ///  String convertida em somente com n�meros
    /// </returns>
    {$ENDREGION}
    class function SoNumeros(psString: string): String;

   {$REGION 'SoLetras...'}
    /// <summary>
    ///  Fun��o para retornar somente letras (com ou sem espa�os em branco) de uma string
    /// </summary>
    /// <param name="psString">String original</param>
    /// <param name="pbMantemEspaco">
    ///  Parametro do tipo boolean que informa se ser� mantido ou n�o os espa�os
    ///  em branco da string original. Caso n�o seja informado esse parametro,
    ///  ser�o mantidos os espa�os em branco da string original
    /// </param>
    /// <returns>String contendo somente letras e/ou espa�o em branco</returns>
    {$ENDREGION}
    class function SoLetras(psString: string; pbMantemEspaco:Boolean = True): string;

  end;
  {$ENDREGION}

  {$REGION 'TUtilDate: Classe com fun��es para manipula��o de Datas'}
  TUtilDate = Class
//  private
  public
    class procedure getInfoTrimestre(piAno, piTrimestre: Integer;
//      var pdInicioTrimestre, pdFimTrimestre: TDate); static;
      var pdInicioTrimestre, pdFimTrimestre: TDate); overload;
//  public
    {$REGION 'getInfoTrimestre...'}
    /// <summary>
    ///  Atualiza as vari�veis, piTrimestre, pdInicioTrimestre e pdFimTrimestre,
    ///  informando para a data solicitada (pdData), o n�mero do trimestre,
    ///  a data que inicia e termina o trimestre.
    /// </summary>
    /// <param name="pdData">Data para extra��o das informa��es</param>
    /// <param name="piTrimestre">Vari�vel do tipo Inteiro que ser� atualizada com o n�mero do trimestre (1,2,3 ou 4)</param>
    /// <param name="pdInicioTrimestre">Vari�vel do tipo Date que ser� atualizada com a data inical do trimestre</param>
    /// <param name="pdFimTrimestre">Vari�vel do tipo Date que ser� atualizada com a data final do trimestre</param>
    ///  <remarks>
    ///  Ex.: Para a data: 15/05/2013 as variav�s ser�o atualizadas para:
    ///  piTrimestre = 2;
    ///  pdInicioTrimestre = 01/04/2013;
    ///  pdFimTrimestre = 30/06/2013
    ///  </remarks>
    {$ENDREGION}
    class procedure getInfoTrimestre(pdData: TDate; var piTrimestre: Integer; var pdInicioTrimestre, pdFimTrimestre: TDate); overload;
    {$REGION 'getInfoTrimestre...'}
    /// <summary>
    ///  Atualiza as vari�veis, pdInicioTrimestre e pdFimTrimestre,
    ///  informando para o ano e trimestre solicitado (piAno e piTrimestre), o
    ///  a data que inicia e termina o trimestre.
    /// </summary>
    /// <param name="piAno">Ano para extra��o das informa��es</param>
    /// <param name="piTrimestre">para extra��o das informa��es</param>
    /// <param name="pdInicioTrimestre">Vari�vel do tipo Date que ser� atualizada com a data inical do trimestre</param>
    /// <param name="pdFimTrimestre">Vari�vel do tipo Date que ser� atualizada com a data final do trimestre</param>
    ///  <remarks>
    ///  Ex.: Para piAno = 2013 e piTrimestre = 2, as variav�s ser�o atualizadas para:
    ///  pdInicioTrimestre = 01/04/2013;
    ///  pdFimTrimestre = 30/06/2013
    ///  </remarks>
    {$ENDREGION}
    {$REGION 'getInfoTrimestre...'}
    /// <summary>
    ///  Atualiza a vari�vel, piTrimestre com o trimestre correspondente a pdata
    /// </summary>
    /// <param name="pdData">Data para extra��o das informa��es</param>
    /// <param name="piTrimestre">Vari�vel do tipo Inteiro que ser� atualizada com o n�mero do trimestre (1,2,3 ou 4)</param>
    ///  <remarks>
    ///  Ex.: Para a data: 15/05/2013 a vari�vel piTrimestre ser� atualizadas para:
    ///  piTrimestre = 2;
    ///  </remarks>
    {$ENDREGION}
    class procedure getInfoTrimestre(pdData: TDate; var piTrimestre: Integer); overload;
    {$REGION 'getInfoTrimestre...'}
    /// <summary>
    ///  Retorna a quantidade de meses entre duas datas
    /// </summary>
    /// <param name="pdDataInicial">Vari�vel do tipo TDateTime com a data inicial</param>
    /// <param name="pdDataFinal">Vari�vel do tipo TDateTime com a data final</param>
    /// <param name="pbProporcional">Vari�vel do tipo Boolean - quando verdadeira considera 1 m�s a fra��o igual ou superior a 15 dias</param>
    /// <param name="pbMesCalendario">Vari�vel do tipo Boolean - quando verdadeira considera o m�s calend�rio. Quando falsa considera o m�s data a data</param>
    ///  <remarks>
    ///  Ex.: Para a data inicial: 15/05/2013, data final 10.08.2013, proporcional false, m�s calend�rio false:
    ///  retorno = 2;
    ///  Ex.: Para a data inicial: 15/05/2013, data final 10.08.2013, proporcional true, m�s calend�rio false:
    ///  retorno = 3;
    ///  Ex.: Para a data inicial: 15/05/2013, data final 10.08.2013, proporcional false, m�s calend�rio true:
    ///  retorno = 2;
    ///  Ex.: Para a data inicial: 15/05/2013, data final 10.08.2013, proporcional true, m�s calend�rio true:
    ///  retorno = 3;
    ///  </remarks>
    {$ENDREGION}
    class function MyMonthsBetween(pdDataInicial,pdDataFinal: TDateTime; pbProporcional, pbMesCalendario: Boolean): Integer;
  end;
  {$ENDREGION}

  {$REGION 'TUtilDataSet: Classe com fun��es para manipula��o de DataSets'}
  TUtilDataSet = Class
  public
    {$REGION 'ReOpenDataSet...'}
    /// <summary>
    /// Fun��o para reabrir um DataSet, aplicando um Close e depois um Open
    /// </summary>
    /// <param name="pDataSet">
    ///  Variav�l do DataSet do tipo TClientDataSet/TSqlQuery/TFDQuery que para ser
    ///  fechado e aberto em seguida
    /// </param>
    {$ENDREGION}
    class procedure ReOpenDataSet(poDataSet: TClientDataSet); overload;
    {$REGION 'ReOpenDataSet...'}
    /// <summary>
    /// Fun��o para reabrir um DataSet, aplicando um Close e depois um Open
    /// </summary>
    /// <param name="pDataSet">
    ///  Variav�l do DataSet do tipo TClientDataSet/TSqlQuery/TFDQuery que para ser
    ///  fechado e aberto em seguida
    /// </param>
    {$ENDREGION}
    class procedure ReOpenDataSet(poDataSet: TSQLQuery); overload;
    {$REGION 'ReOpenDataSet...'}
    /// <summary>
    /// Fun��o para reabrir um DataSet, aplicando um Close e depois um Open
    /// </summary>
    /// <param name="pDataSet">
    ///  Variav�l do DataSet do tipo TClientDataSet/TSqlQuery/TFDQuery que para ser
    ///  fechado e aberto em seguida
    /// </param>
    {$ENDREGION}
    class procedure ReOpenDataSet(poDataSet: TFDQuery); overload;
    {$REGION 'CriaCds...'}
    /// <summary>
    /// Fun��o para clonar um clientDataset a partir de outro clientDataSet passado
    ///  como par�metro
    /// </summary>
    /// <param name="poCdsOriginal">
    ///  ClientDataset original que ser� "clonado"
    /// </param>
    /// <param name="poCdsNovo">ClientDataset que ser� manipulado para ficar igual ao original</param>
    ///  <remarks>
    ///  Utilizar preferencialmente a fun��o TUtilDataSet.cloneDataSet com finalidade parecida
    ///  </remarks>
    {$ENDREGION}
    class procedure CriaCds(poCdsOriginal: TClientDataSet; var poCdsNovo: TClientDataSet); overload;
    {$REGION 'CriaCds...'}
    /// <summary>
    /// Fun��o para criar um clientDataset a partir de uma FDQuery passada
    ///  como par�metro
    /// </summary>
    /// <param name="poFDQuery">
    ///  poFDQuery original que ser� "clonada" para um ClientDataSet
    /// </param>
    /// <param name="poCdsNovo">ClientDataset que ser� manipulado para ficar igual a FDQuery</param>
    ///  <remarks>
    ///  Utilizar preferencialmente a fun��o TUtilDataSet.cloneDataSet com finalidade parecida
    ///  </remarks>
    {$ENDREGION}
    class procedure CriaCds(poFDQuery: TFDQuery; var poCdsNovo: TClientDataSet); overload;
    {$REGION 'getAggregateValue...'}
    /// <summary>
    ///  Fun��o que cria/retorna o valor de um campo agregado e caso o campo n�o exista
    ///  ele ser� criado em tempo de execu��o.
    /// </summary>
    /// <param name="poDataSet">Vari�vel do tipo TClientDataSet da qual ser�
    ///  retornado o valor do campo agregado
    /// </param>
    /// <param name="psCampo">
    ///  Vari�vel do tipo String com o nome do campo agregado que ser�
    ///  criado/retornado o valor
    ///</param>
    /// <param name="peOperacao">
    ///  Vari�vel do tipo TTipoAgregacao que informa a opera��o de agrega��o desejada
    /// </param>
    /// <returns>Currency com o valor da agrega��o solicitada</returns>
    {$ENDREGION}
    class function  getAggregateValue(var poDataSet: TClientDataSet; psCampo, psNomeCampoAgregacao: string; peOperacao: TTipoAgregacao): Currency;
    {$REGION 'clearSettings...'}
    /// <summary>
    ///  Fun��o parar limpar as defini��es de um ClientDataSet, como os Campos,
    ///  Filtros, �ndices, Campos de agrega��o e Provider
    /// </summary>
    /// <param name="poDataSet">
    ///  Vari�vel do tipo TClientDataSet que ter� suas defini��es resetadas
    /// </param>
    /// <param name="bLimpaTudo">
    ///  Vari�vel do tipo boolean. Caso <c>True</c> ser� resetadas todas as
    ///  defini��es, caso <c>False</c> ser�o resetadas somente as defini��es
    ///  informadas nos par�metros seguintes.
    /// </param>
    /// <param name="bLimpaCampos">
    ///  Vari�vel do tipo boolean, opcional, com valor <c>False</c> como padr�o.
    ///  Caso <c>True</c> ser�o resetadas as defini��es de Campos.
    ///</param>
    /// <param name="bLimpaFiltro">
    ///  Vari�vel do tipo boolean, opcional, com valor <c>False</c> como padr�o.
    ///  Caso <c>True</c> ser�o resetadas as defini��es de Filtros.
    /// </param>
    /// <param name="bLimpaIndice">
    ///  Vari�vel do tipo boolean, opcional, com valor <c>False</c> como padr�o.
    ///  Caso <c>True</c> ser�o resetadas as defini��es de �ndices.
    /// </param>
    /// <param name="bLimpaCampoAgregacao">
    ///  Vari�vel do tipo boolean, opcional, com valor <c>False</c> como padr�o.
    ///  Caso <c>True</c> ser�o resetadas as defini��es de Agrega��o.
    /// </param>
    /// <param name="bLimpaProvider">
    ///  Vari�vel do tipo boolean, opcional, com valor <c>False</c> como padr�o.
    ///  Caso <c>True</c> ser� resetada a defini��o de ProviderName.
    /// </param>
    {$ENDREGION}
    class procedure clearSettings(
      var poDataSet: TClientDataSet; bLimpaTudo: Boolean;
      bLimpaCampos: Boolean = False; bLimpaFiltro: Boolean = False;
      bLimpaIndice: Boolean = False; bLimpaCampoAgregacao: Boolean = False;
      bLimpaProvider: Boolean = False
    );
    {$REGION 'cloneDataSet...'}
    /// <summary>
    ///  Fun��o para clonar/copiar as informa��es de um clientDataSet para outro.
    ///  caso o dataset de origem esteja filtrado, ser� copiado somente dos dados
    ///  do filtro.
    /// </summary>
    /// <param name="poDataSetOrigem">Vari�vel do tipo TClientDataset que possui os dados a ser clonado</param>
    /// <param name="poDataSetDestino">Vari�vel do tipo TClientDataSet que ir� receber os dados</param>
    /// <remarks>Obs.: O dataset destino perderr� todos os dados contido nele.</remarks>
    {$ENDREGION}
    class procedure cloneDataSet(poDataSetOrigem: TClientDataSet; var poDataSetDestino: TClientDataSet);
    {$REGION 'adicionarRegistro...'}
    /// <summary>
    /// Fun��o para copiar os dados de um registro de um DataSet para outro
    /// </summary>
    /// <param name="poDatasetOrigem">
    ///  Vari�vel tipo TSQLQuery. Dataset que cont�m os dados � serem copiados
    /// </param>
    /// <param name="poDataSetDestino">
    ///  Vari�vel tipo TClientDataSet. Dataset onde ser� adicionado os dados
    /// </param>
    ///  <remarks>
    ///  Possui sobrecarga onde o dataset de origem pode ser um TClientDataSet
    ///  </remarks>
    {$ENDREGION}
    class procedure adicionarRegistro(poDatasetOrigem: TSQLQuery; var poDataSetDestino:TClientDataSet); overload;
    {$REGION 'adicionarRegistro...'}
    /// <summary>
    /// Fun��o para copiar os dados de um registro de um DataSet para outro
    /// </summary>
    /// <param name="poDatasetOrigem">
    ///  Vari�vel tipo TClientDataSet. Dataset que cont�m os dados � serem copiados
    /// </param>
    /// <param name="poDataSetDestino">
    ///  Vari�vel tipo TClientDataSet. Dataset onde ser� adicionado os dados
    /// </param>
    ///  <remarks>
    ///  Possui sobrecarga onde o dataset de origem pode ser um TSQLQuery
    ///  </remarks>
    {$ENDREGION}
    class procedure adicionarRegistro(poDatasetOrigem: TClientDataSet; var poDataSetDestino:TClientDataSet); overload;

//    {$REGION 'OnDataChange...'}
//    /// <summary>
//    /// Procedure similar a TDataSource.OnDataChange.
//    /// Usando essa procedure, o TDataSouce pode ficar no dataModule e utiliza-se
//    /// o TDataSource.OnDataChange, passando o TDataSouce e o TRxDBLookupCombo.
//    /// Com isso, retira-se a obrigatoriedade de fazer refer�ncia da unit do
//    /// Form na unit do dataModule (macarronada).
//    /// </summary>
//    /// <param name="poDataSource">
//    ///  Vari�vel tipo TDataSource.
//    /// </param>
//    /// <param name="poClientDataSet">
//    ///  Vari�vel tipo TClientDataSet.
//    /// </param>
//    /// <param name="poRxDBLookupCombo">
//    ///  Vari�vel tipo TRxDBLookupCombo.
//    /// </param>
//    /// <param name="psNomeCampoId">
//    ///  Vari�vel tipo String contendo o nome do campo ID da tabela apontado pelo
//    /// TDataSource.
//    /// </param>
//    ///  <remarks>
//    ///  Atribui a TRxDBLookupCombo.KeyValue o conteudo do campo psNomeCampoId
//    ///  </remarks>
//    {$ENDREGION}
//    class procedure OnDataChange(poDataSource: TDataSource;
//      poClientDataSet: TClientDataSet; var poRxDBLookupCombo: TRxDBLookupCombo;
//      psNomeCampoId: String);
  end;
  {$ENDREGION}

  {$REGION 'TUtilFormat: Classe com fun��es para formata��es de strings'}
  TUtilFormat = Class
  public
    {$REGION 'FormataCEP...'}
    /// <summary>
    ///   Fun��o que recebe os n�meros de um CEP e retorna esse CEP formatado
    /// </summary>
    /// <param name="psNumero">String contendo os caracteres n�mericos do CEP</param>
    /// <returns>String com o CEP formatado</returns>
    /// <remarks>
    /// Caso ocorra algum erro no processo de formata��o do CEP, ser� retornado uma
    /// string vazia
    ///</remarks>
    {$ENDREGION}
    class function FormataCEP(psNumero: string): string;

    {$REGION 'BooleanToInt...'}
    /// <summary>
    /// Fun��o substitui��o de caracteres especiais por caracteres da tabela ASCII padr�o.
    /// </summary>
    /// <param name="psString">String a ser verificada</param>
    /// <param name="pbEliminaBranco">Se os espa�os em branco ser�o retirados</param>
    /// <returns>Vari�vel do tipo String com a string formatada</returns>
    {$ENDREGION}
    class function ValidCaracter(psString: String; pbEliminaBranco: Boolean = False): string;

    {$REGION 'InscMfCMasc...'}
    /// <summary>
    /// Fun��o de formata��o com a m�scara, de Inscri��o no Minist�rio da
    /// Fazenda, CNPJ, CPF, etc.
    /// </summary>
    /// <param name="psInscMf">String com a inscri��o no Minist�rio da Fazenda</param>
    /// <param name="psTipo">String com o tipo da Inscri��o CNPJ/CPF</param>
    /// <returns>Vari�vel do tipo String com a string formatada com a m�scara</returns>
    {$ENDREGION}
    class function InscMfCMasc(psInscMf,psTipo: String):string;

  end;
  {$ENDREGION}

  {$REGION 'TUtilControleFormulario: Classe com fun��es para controle dos objetos de um formul�rio'}
  TUtilControleFormulario = Class
  public
    {$REGION 'habilitarDesabilitarControles...'}
    /// <summary>
    ///   Fun��o para habilitar/desabilitar os controles de determinado objeto
    /// </summary>
    /// <param name="poObjetoPai">
    ///  Objeto do tipo TWinControl que ter� seus objetos filhos habilitados/desabilitados
    /// </param>
    /// <param name="pbHabilita">
    ///  Vari�vel booleana que informa se � para habilitar ou desabilitar os objetos filhos
    /// </param>
    /// <param name="pbRecursivo">
    ///  Vari�vel booleana que informa se � para hahilitar/desabilitar os objetos
    ///  filhos que sejam do tipo TWinControl
    /// </param>
    {$ENDREGION}
    class procedure habilitarDesabilitarControles(poObjetoPai: TWinControl; pbHabilita: Boolean; pbRecursivo: Boolean = False);
    {$REGION 'setTransparencia...'}
    /// <summary>
    ///  Fun��o para adicionar/retirar uma transpar�ncia a um Form
    /// </summary>
    /// <param name="piFormHandle">
    ///  Handle do Form que ser� aplicado a transpar�ncia. (Ex.: Self.Handle)
    /// </param>
    /// <param name="piPencentualTransparencia">
    ///  Valor inteiro para aplicar a transpar�ncia, sendo 0 (zero) para cor
    ///  s�lida e 100 para totalmente transparente.
    /// </param>
    {$ENDREGION}
    class procedure setTransparencia(const piFormHandle: HWND; piPencentualTransparencia: integer);
    {$REGION 'getClicouNoBotaoEspecialDoGrid...'}
    /// <summary>
    ///  Fun��o que verifica se foi clicado na �rea especial do Grid
    /// </summary>
    /// <param name="poGrid">Grid no qual ser� verificado onde foi o clique</param>
    /// <returns>
    ///  Vari�vel do tipo booleana<c>True</c> caso tenha sido clicado na �rea especial do grid do
    ///  contr�rio, ser� retornado <c>False</c>
    /// </returns>
    {$ENDREGION}
    class function  getClicouNoBotaoEspecialDoGrid(poGrid: TDBGrid): Boolean;
    {$REGION 'setAjustarColunasDoGrid...'}
    /// <summary>
    ///  Fun��o para auto ajustar oo tamanhos de todoas as colunas de um Grid
    /// </summary>
    /// <param name="poGrid">Grid que ter� as colunas ajustadas </param>
    {$ENDREGION}
    class procedure setAjustarColunasDoGrid(const poGrid: TDBGrid);
    {$REGION 'moverParaCima...'}
    /// <summary>
    ///  Fun��o para mover para cima o item selecionado de um objeto descendente
    //   de TCustomListBox. Exemplo: ListBox, TCheckListBox
    /// </summary>
    /// <param name="poLista">
    ///   Vari�vel do tipo TCustomListBox
    /// </param>
    ///  <remarks>
    ///  Ex.: TUtilControleFormulario.moverParaCima(TCustomListBox(poLista))
    ///  Onde o objeto poLista � um TCheckListBox
    ///  </remarks>
    {$ENDREGION}
    class procedure moverParaCima(poLista: TCustomListBox);
    {$REGION 'moverParaBaixo...'}
    /// <summary>
    ///  Fun��o para mover para baixo o item selecionado de um objeto descendente
    //   de TCustomListBox. Exemplo: ListBox, TCheckListBox
    /// </summary>
    /// <param name="poLista">
    ///   Vari�vel do tipo TCustomListBox
    /// </param>
    ///  <remarks>
    ///  Ex.: TUtilControleFormulario.moverParaBaixo(TCustomListBox(poLista))
    ///  Onde o objeto poLista � um TCheckListBox
    ///  </remarks>
    {$ENDREGION}
    class procedure moverParaBaixo(poLista: TCustomListBox);
  end;
  {$ENDREGION}

  {$REGION 'TUtil: Classe com fun��es variadas'}
  TUtil = Class
  public
    {DbExpress}
    {Conex�o DbExpress}
    class procedure setConn(loConn: TSQLConnection);
    class function  getConn: TSQLConnection;

//    class procedure setFormControleUsuarios(poFControleUsuarios: TFControleUsuarios);
//    class function  getFormControleUsuarios: TFControleUsuarios;

    class procedure Commit(loConn: TSQLConnection; liTransacao: LongWord);
    class procedure RollBack(loConn: TSQLConnection; liTransacao: LongWord);
    class procedure StartTransaction(loConn: TSQLConnection; liTransacao: LongWord);

    class function  IniFile(psPathAppData: String = ''): string;
    class procedure WriteIni(lsIni, lsSessao, lsSub, lsValor: string);
    class function  ReadIni(lsIni, lsSessao, lsSub: string): string;

    class procedure ReOpenClientDataSet(pDataSet: TClientDataSet);
    class procedure ReOpenSqlQuery(pSqlQuery: TSQLQuery);

    {Localiza todas as strings em um TStrings que contenha a string contida em
    psLocate e substitui toda a string pela string contida em psReplace}

    class function ChangeTStrings(poStrings: TStrings; psLocate,psReplace: string): string;
    {L� o campo piCampo, da linha piLinha, testando e retornando o seu valor
    para o tipo definido em ftTimpoCampo, de uma linha (psLinha) serializada com
    os campos separados por pipe. Ex: Se for socicidado o campo 3 da linha
    abaixo, ser� retornado "SALVADOR":
    |JOS� VIT�RIO|14.10.1960|SALVADOR|BAHIA|}
//    class function LerCampoLayOutPipe(psLinha: String; piNumeroLinha,piCampo: Integer;
    class function LerCampoLayOutPipe(psLinha: String; piCampo: Integer;
      ftTipoCampo: TFieldType): Variant;

//    {Preenche poStrLstCampos e poStrLstTpCampos repectivamente com todos os
//    campos e tipos dos campos da tabela psTable. Preeche psHeadBackup com uma
//    string contendo todos os campos de psTable separados por um pipe, Ex:
//    |CAMPO_1|CAMPO2|CAMPO3|, para ser utilizada no heard do arquivo de backup. E
//    preeche psLineFields com uma string contendo todos os campos de psTable
//    separados por v�rgula, Ex: CAMPO_1,CAMPO2,CAMPO3 para ser utilizada em uma
//    senten�a SQL de uma query}
//    class procedure getFieldsTable(psTable: string; var psHeadBackup: string;
//      var psLineFields: string; var poStrLstFields: TStringList;
//      var poStrLstTpFields: TStringList);

    class function MyStrToInt(lsStr: String): Integer;
    class function MyStrToDouble(lsStr: String): double;
    class function MyStrToCurrency(lsStr: String): Currency;
    class function MyStrToDate(lsStr: String): TDate;
    class function MyStrToDateTime(lsStr: String): TDateTime;
    class function MyBoolToStr(llBoolean: Boolean): String;
    class function Transaction(liTransacao: LongWord): TTransactionDesc;
    class function If_Else(llExp: Boolean; lvTrue,lvFalse: Variant): Variant;
    class function getIDGrupoTabelasGerais(dData:TDate): String;overload;
    class function getIDGrupoTabelasGerais(sIdPessoa:String; dData:TDate): String;overload;
    class function getErrorDetails(E: Exception): string;
    class function getErrorRelevancia(E: Exception): string;

    class procedure setIdPessoa(lsIdPessoa: String);
    class function getIDPessoa: String;
    class procedure setIdPessoaResponsavel(psPrograma,psIdPessoaResponsavel,psIdUsuario: String);
    class function getIDPessoaResponsavel(psPrograma,psIdUsuario: String): String;
    class function getNomeSocio(psIdSocio: String): String;
    class function getQualificacaoSPEDSocio(psIdSocio: String): Integer;
    class function getInscMfSocio(psIdSocio: String): String;

    {$REGION 'setFiscalizacaoSefaz...'}
    /// <summary>
    ///  Fun��o para inicializar a vari�vel (FbFiscalizacaoSefaz) que armazena
    ///  a informa��o se a empresa est� sendo fiscalizada por Roberto
    /// </summary>
    /// <param name="psIdPessoa">Vari�vel do tipo string que informa a Identifica��o da Empresa</param>
    {$ENDREGION}
    class procedure setFiscalizacaoSefaz(psIdPessoa: string);
    {$REGION 'getFiscalizacaoSefaz...'}
    /// <summary>
    /// Fun��o que retorna se a empresa est� sendo fiscalizada por Roberto
    /// </summary>
    /// <returns>
    /// <c>True</c> caso a empresa esteja sendo fiscalizada, e <c>False</c>
    /// caso contr�rio
    /// </returns>
    {$ENDREGION}
    class function getFiscalizacaoSefaz: Boolean;
    //class function getExisteMatriz(pInscMf: String; pbInscMf: Boolean = True): String;
//    class function getEhMatriz(psIdPessoa: String): Boolean;

//    class function getStrCodigoPessoa: String;
    class function getEnderecoPessoa(psIdPessoa: String): String;
    class function getCidadePessoa(psIdPessoa: String): String;
    class function getIdCidadePessoa(psIdPessoa: String): String;
    class function getCodigoMunicipioIBGE(psIdPessoa: String): String;
    class function getCodigoMunicipioSEFAZ(psIdPessoa: String): String;
    class function getEstadoPessoa(psIdPessoa: String; pbExtenso: Boolean): String;
    class function getCepPessoa(psIdPessoa: String): String;
//    class function ValidaCep(psCep: String; peAceitaCampoEmBranco: TAceitaCampoEmBranco): Boolean;
    class function getTipoRegime(psIdPessoa: String; pdData: TDate; pOpRegime: TTipoRegimeTributario): Integer;
    class function getDataConstituicaoPessoa(psIdPessoa: String): TDate;
    class function getIdCNAE(psIdPessoa: String; pdData: TDate): String;
    class function getCNAE(psIdPessoa: String; pdData: TDate): String;
    class function getNIRE(psIdPessoa: String): String;
    class function getTelefonePessoa(psIdPessoa: String): String;
    class function getEmail(psIdPessoa: String): String;

    class function getDataInicioUsoMegaPessoal(psIdPessoa: String; pChecaLancamentosProvisorios: Boolean): TDate;
    class function getDataInicioFimUsoMegaFiscal(psIdPessoa: String; pbInicio: Boolean = True): TDate;
    class function getDataInicioUsoMegaContabil(psIdPessoa: String): TDate;
    class function getDataInicioProgramas(psIdPessoa: String): TDate;
    class procedure preencherComboSignatario(psIdPessoa: string;
      pbIncluiPropriaEmpresa: Boolean; var poComboBox: TComboBox;
      pdData: TDate; var poStrLstListaSignatario: TStringList);

//    class function getDataUltimoRegistroMegaFiscal(psIdPessoa: String): TDate;


    class function getDataCalculoMegaPessoal(psIdPessoa: String;
      pbPrimeiroCalculo: Boolean): TDate;
    class function getDataCalculoMegaFiscal(psIdPessoa: String;
      pbPrimeiroCalculo: Boolean): TDate;
    class function getDataCalculoProgramas(psIdPessoa: String; pbPrimeiroCalculo: Boolean;
      pbTodosEstabelecimentos: Boolean = False; psInscMf: string = ''): TDate;

//    class function getDataPrimeiroCalculo(psIdPessoa: String; pbGeral: Boolean): TDate;

    class procedure setUser(lsId,lsLogin: String);
    class function getUserID: String;
    class function getUserLogin: string;

    class procedure setNomePessoa(value: String);
    class function getNomePessoa(psIdPessoa: string): String; overload;
    class function getNomePessoa(): String; overload;
    class procedure setCodigoPessoa(piValue: Integer);
    class function getCodigoPessoa(): Integer;
    class function getStrCodigoPessoa(): String;

    {O SetInscMfPessoa � uma fun��o porque ela valida a Inscri��o e retorna
    se � v�lida ou n�o}
    //class function setInscMfPessoa(value: String):Boolean;
    class function getInscMfPessoa(): String; overload;
    class function getInscMfPessoa(psIdPessoa: string): String; overload;
    class function getInscMfPessoaContato: String; overload;
    class function getInscMfPessoaContato(psIdPessoa: string): String; overload;
    class function getNomePessoaContato: String; overload;
    class function getNomePessoaContato(psIdPessoa: string): String; overload;
    class function getInscMfMatriz(psIdPessoa: String): String; {Retornar a INSCMF da Matriz}
    //class function getTipoInscMfPessoa: String;
//    class function getTTipoInscMfPessoa: TTipoInscMf;overload;
//    class function getTTipoInscMfPessoa(pIdPessoa: String): TTipoInscMf;overload;
    class function getInscMunicipal(psIdPessoa: String): String;
    //class function getInscEstadual(psIdPessoa: String): String;
    class function getTipoServicoPrestado(psIdPessoa: String; pdData: TDate): String;

//    class procedure PreencheCbxBoxRegimes(var pcbxRegimes: TComboBox; TipoRegime: TTipoRegime; var pstrLstDescricaoRegime: TStringList);
    class procedure PreencheCbxBoxRegimes(var pcbxRegimes: TComboBox; TipoRegime: TTipoRegimeTributario);
    {$REGION 'setTransparencia...'}
    /// <summary>
    ///  Fun��o para adicionar/retirar uma transpar�ncia a um Form
    /// </summary>
    /// <param name="piFormHandle">
    ///  Handle do Form que ser� aplicado a transpar�ncia. (Ex.: Self.Handle)
    /// </param>
    /// <param name="piPencentualTransparencia">
    ///  Valor inteiro para aplicar a transpar�ncia, sendo 0 (zero) para cor
    ///  s�lida e 100 para totalmente transparente.
    /// </param>
    {$ENDREGION}
//    class procedure setTransparencia(const piFormHandle: HWND; piPencentualTransparencia: integer);

    class procedure cbxCloseUp(poTForm: TForm); {Fecha todos os looupComboBox da classe}

    class function getLocalIp: string;

    class procedure CriaCds(poCdsOriginal: TClientDataSet;
      var poCdsNovo: TClientDataSet);

    {Imagens}
    class function  RedimensionaImagem(poImagem: TGraphic;
      poLargura, poAltura: Integer; Tipo: TGraphicClass): TGraphic;
//    class function ValidaTamanhoImagem(psPathImagem: String; piTamMaxImagem: Int64): String;

    class function RecordImage(pimgImage: TImage; psFieldImagem: string;
      pTable: TDataSet; pStrLstCampos: TStringList; pbFireDac: Boolean): Boolean;
//    class procedure LoadImage(pimgImage: TImage; psField: string; pTable:TDataSet);overload;
//    class procedure LoadImage(pimgImage: TRlImage; psField: string; pTable:TDataSet);overload;

    {Altera a largura da lista de um comboBox para um tamanho fixo, determinado
    em piTamanho.
    Para utilizar, chamar a fun��o no evento OnDropDown do comboBox}
    class function setWidthComboBoxFixo(var poCbx: TComboBox;
      piTamanho: NativeUInt): NativeInt;

    {Altera a largura da lista de um comboBox para o tamanho do maior item da
    lista.
    Para utilizar, chamar a fun��o no evento OnDropDown do comboBox}
    class procedure setWidthComboBoxMax(var Sender: TObject);
    {$REGION 'getPathDiretorio...'}
    /// <summary>
    /// Fun��o que exibe uma caixa de di�logo e retorna o diret�rio/pasta selecionado
    /// </summary>
    /// <param name="psTitulo">Vari�vel do tipo string que ser� mostrada no t�tulo da caixa de di�logo</param>
    /// <param name="psDiretorioRaiz">
    ///  Vari�vel 'opcional' do tipo string contendo um caminho padr�o, que dever�
    ///  ter o terminador no final do caminho. Ex.: 'C:\Windows\'. Caso n�o seja
    ///  informado nenhum caminho, a caixa de di�logo ser� carregada com todos os
    ///  drivers dispon�veis do computador.
    /// </param>
    /// <returns>
    ///  Vari�vel do tipo string contendo o caminho do diret�rio selecionado, ou
    ///  uma string vazia caso n�o seja selecionado nenhum diret�rio.
    /// </returns>
    {$ENDREGION}
    class function  getPathDiretorio(psTitulo: string; psDiretorioRaiz: string = ''): string;
    {Percorre todos os itens de um Menu e retorna a propriedade Name no
    stringList poStringList}
    class procedure getItensMenu(poItensMenu: TMenuItem; var poStringList: TStringList);
    class procedure preencheComboBox(var poComboBox: TComboBox; poStringList: TStringList);

    {$REGION 'getUsaUserControl...'}
    /// <summary>
    ///   Fun��o retorna se o serial do computador est� enquadrado para uso
    ///  obrigat�rio do componente de controle de usu�rios UserControl.
    ///  Obs: Esse � um m�todo tempor�rio que dever� ser utilizando durante o
    ///  per�odo de implanta��o do UserControl. Depois que todos os clientes da
    ///  estiverem utilizando o UserControl ele pode ser depreciado.
    /// </summary>
    /// <returns>Boolean</returns>
    /// <remarks>
    ///</remarks>
    {$ENDREGION}
//    class function getUsaUserControl(piSerial: Int64; psSeriais,psFaixaSeriais: String): Boolean;
    class function getUsaUserControl(piSerial: Int64): Boolean;

  end;
  {$ENDREGION}

const
  //Valor da cor s�lida de um objeto
  VALOR_PADRAO_TRANSPARENCIA = 255;

implementation

uses LibMega;

var
  FoConn: TSQLConnection;
  FoFDConn: TFDConnection;
  FoFDConnUniDirecional: TFDConnection;
  FoFDConnControleUsuarios: TFDConnection;
  FsUsuario: String;
  FsLogin: String;
  FsIdPessoa: String;
  FbFiscalizacaoSefaz: Boolean;
  FsIdPessoaResponsavel: String;
  FsNomePessoa: String;
  FsInscMfPessoa: String;
  FiCodigoPessoa: Integer;
  FsCodigoPessoa: String;
//  FtTpInscMfPessoa: TTipoInscMf; {(tpFisica, tpJuridica, tpCEI)}
  FsTpInscMfPessoa: String; {CNPJ,CPJ,CEI}
//  FoControleUsuarios: TFControleUsuarios;

{ TUtil }

{$REGION 'TUtil: Implementa��o...'}
class function TUtil.IniFile(psPathAppData: String = ''): string;
begin
//  result := ExtractFilePath(Application.ExeName) + 'PDV.ini';
//  result := ExtractFilePath(Application.ExeName) + getUserLogin+'.ini';
//  esult := rInfoAplicacao.sPathAppData+getUserLogin+'.ini';
  if psPathAppData.IsEmpty then begin
    result := GetEnvironmentVariable('APPDATA')+'\'+rInfoEmpresa.sNomeAbreviado+'\'+getUserLogin+'.ini';
  end else begin
    result := psPathAppData+getUserLogin+'.ini';
  end;
end;

class function TUtil.ReadIni(lsIni, lsSessao, lsSub: string): string;
var
  loINI: TIniFile;
begin
  loINI := TIniFile.Create(lsIni);
  try
    result := loINI.ReadString(lsSessao, lsSub, '');
  finally
    FreeAndNil(loINI);
  end;
end;

class function TUtil.MyBoolToStr(llBoolean: Boolean): String;
begin
  if llBoolean then
    result := 'S'
  else
    result := 'N';
end;

class function TUtil.MyStrToInt(lsStr: String): Integer;
begin
//  try
//    result := StrToInt(lsStr);
//  except
//    result := 0;
//  end;
  Result := 0;
  TryStrToInt(lsStr,Result);
end;

class procedure TUtil.WriteIni(lsIni, lsSessao, lsSub, lsValor: string);
var
  loINI: TIniFile;
begin
  loINI := TIniFile.Create(lsIni);
  try
    loINI.WriteString(lsSessao, lsSub, lsValor);
  finally
    FreeAndNil(loINI);
  end;
end;

class procedure TUtil.StartTransaction(loConn: TSQLConnection; liTransacao: LongWord);
begin
  if not loConn.InTransaction then
    loConn.StartTransaction(Transaction(liTransacao));
end;

class function TUtil.Transaction(liTransacao: LongWord): TTransactionDesc;
begin
//  result.TransactionID  := 1;
  result.TransactionID  := liTransacao;
  result.IsolationLevel := xilREADCOMMITTED;
end;



class function TUtil.ChangeTStrings(poStrings: TStrings; psLocate,
  psReplace: String): string;
var
  liFor: Integer;
begin
  for liFor := 0 to poStrings.Count-1 do begin
    if (Pos(psLocate,poStrings.Strings[liFor]) > 0) then begin
      poStrings[liFor] := psReplace;
      Break;
    end;
  end;
end;

//class function TUtil.LerCampoLayOutPipe(psLinha: String; piNumeroLinha,piCampo: Integer;
class function TUtil.LerCampoLayOutPipe(psLinha: String; piCampo: Integer;
  ftTipoCampo: TFieldType): Variant;
var
  liPosInicial,liPosFinal,liTamanho: Integer;
  lwDia,lwMes,lwAno: Word;
  lsRegistro,lsData: string;
  ldData: TDateTime;

begin
  liPosInicial := StrPos('|',psLinha,piCampo)+1;
  liPosFinal   := StrPos('|',psLinha,piCampo+1);
  liTamanho    := liPosFinal-liPosInicial;
  Result       := Copy(psLinha,liPosInicial,liTamanho);

  if ftTipoCampo = ftInteger then begin
//    try
//      if Result = '' then begin
//        Result := '0';
//      end;
//      Result := StrToInt(Result);
//    except
//      Result := 0;
//    end;
    Result := MyStrToInt(Result);
  end else if ftTipoCampo = ftCurrency then begin
//    try
//      if Result = '' then begin
//        Result := '0';
//      end;
//      Result := StrToFloat(Result);
//    except
//      Result := 0;
//    end;
    Result := MyStrToCurrency(Result);
  end else if ftTipoCampo = ftDate then begin
    lwDia := StrToInt(Copy(Result,1,2));
    lwMes := StrToInt(Copy(Result,3,2));
    lwAno := StrToInt(Copy(Result,5,4));
//    try
//      Result := EncodeDate(lwAno,lwMes,lwDia);
//    except
//      Result := Date();
//    end;
    lsData := StrZero(lwDia,2,0)+'/'+StrZero(lwMes,2,0)+'/'+StrZero(lwAno,4,0);
    ldData := Date();
    TryStrToDateTime(lsData,ldData);
    Result := ldData;
  end;
end;

class procedure TUtil.Commit(loConn: TSQLConnection; liTransacao: LongWord);
begin
  if loConn.InTransaction then
    loConn.Commit(Transaction(liTransacao));
end;

class procedure TUtil.CriaCds(poCdsOriginal: TClientDataSet;
  var poCdsNovo: TClientDataSet);
var
  liFor: Integer;
begin
  {*------------------------------------------------------------------------------
   Fun��o TUtil.CriaCds mantida por motivos de retro-compatibilidade
   Implementa��o migrada para a fun��o TUtilDataSet.CriaCds
   Obs.: Ver implemenata��o da fun��o TUtilDataSet.cloneDataSet
  -------------------------------------------------------------------------------}
  TUtilDataSet.CriaCds(poCdsOriginal,poCdsNovo);
end;

class procedure TUtil.RollBack(loConn: TSQLConnection; liTransacao: LongWord);
begin
  if loConn.InTransaction then
    loConn.Rollback(Transaction(liTransacao));
end;

class function TUtil.If_Else(llExp: Boolean; lvTrue,
  lvFalse: Variant): Variant;
begin
  if llExp then
    result := lvTrue
  else
    result := lvFalse;
end;

class procedure TUtil.setUser(lsId,lsLogin: String);
begin
  FsUsuario := lsId;
  FsLogin := lsLogin;
end;

class function TUtil.setWidthComboBoxFixo(var poCbx: TComboBox;
  piTamanho: NativeUInt): NativeInt;
begin
   Result := poCbx.Perform(CB_SETDROPPEDWIDTH, piTamanho, 0);
end;

class procedure TUtil.setWidthComboBoxMax(var Sender: TObject);
var
  lsTexto: String;
  liLarguraMaxima: Integer; {largura do maior item}
  liLarguraAtual: Integer; {largura do item corrente}
  liForItens,liPosicao: Integer;
begin
  {Utilize essa fun��o no evento OnDropDown do ComboBox}
  {Garantindo que estamos trabalhando com um Combobox}
  if (Sender is TComboBox) then begin
    {Se existir item no combo...}
    if (TComboBox(Sender).Items.Count > 0) then begin
    {Assume que a maior largura � a largura da combo}
//      liLarguraMaxima := Width;
      liLarguraMaxima := 0;
      lsTexto := TComboBox(Sender).Items[0];
      liPosicao := 0;
      {Verificando a largura de cada item do Combo}
      for liForItens := 0 to TComboBox(Sender).Items.Count - 1 do begin
        {pegando a largura do item atual}
  //      liLarguraAtual := TCustomComboBox(Sender).Canvas.TextWidth(Items[liForItens]);
        liLarguraAtual := length(TComboBox(Sender).Items[liForItens]);
        {Se a largura atual for maior que a largura m�xima, troca}
        if (liLarguraAtual > liLarguraMaxima) then begin
          liPosicao := liForItens;
          liLarguraMaxima := liLarguraAtual;
        end;
      end;
      lsTexto := TComboBox(Sender).Items[liPosicao];
      TComboBox(Sender).Items[liPosicao] := StrSubst(TComboBox(Sender).Items[liPosicao],' ','W',0);
      liLarguraMaxima := TComboBox(Sender).Canvas.TextWidth(TComboBox(Sender).Items[liPosicao]);
      TComboBox(Sender).Items[liPosicao] := lsTexto;

      if (TComboBox(Sender).Items.Count > TComboBox(Sender).DropDownCount) then begin
        Inc(liLarguraMaxima,35);
      end;

      {Enviando mensagem para o Windows, para alterar o tamanho do listbox
      para o tamanho m�ximo, com uma folga de 100 por causa da barra de rolagem
      vertical}
      SendMessage(TComboBox(Sender).Handle, CB_SETDROPPEDWIDTH, liLarguraMaxima, 0);
    end;
  end;
end;

//class function TUtil.getUsaUserControl(piSerial: Int64; psSeriais,psFaixaSeriais: String): Boolean;
class function TUtil.getUsaUserControl(piSerial: Int64): Boolean;
//var
//  lsFinalSerial: string;
begin
//  lsFinalSerial := StrRight(IntToStr(piSerial),2);
//  if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0)
//    or (piSerial = 13328384581156) {BRASCONTE}
//    or (piSerial = 4289145270160) {CMLF}
//    or (piSerial = 8778047833) {Jo�o/Ivan}
//    or (piSerial = 9016621258) {Jo�o/Ivan}
//    or (lsFinalSerial = '45')
//    or (lsFinalSerial = '84') {Roberto Prata}
//  if ((lsFinalSerial >= '00')
//    and (lsFinalSerial <= '70'))
//    or (lsFinalSerial = '84') {Roberto Prata}
//  then begin
    Result := True;
//  end else begin
//    Result := False;
//  end;
end;

class function TUtil.getUserID: String;
begin
  result := FsUsuario;
end;

class function TUtil.getUserLogin: string;
begin
  result := FsLogin;
end;

class function TUtil.MyStrToCurrency(lsStr: String): Currency;
begin
  Result := 0;
  TryStrToCurr(lsStr,Result);
end;

class function TUtil.MyStrToDate(lsStr: String): TDate;
var
  ldData: TDateTime;
begin
  ldData := TP_DATA_EMPTY;
  TryStrToDate(lsStr,ldData);
  Result := ldData;
end;

class function TUtil.MyStrToDateTime(lsStr: String): TDateTime;
var
  ldData: TDateTime;
begin
  ldData := TP_DATA_EMPTY;
  TryStrToDateTime(lsStr,ldData);
  Result := ldData;
end;

class function TUtil.MyStrToDouble(lsStr: String): double;
begin
//  try
//    result := StrToFloat(lsStr);
//  except
//    result := 0;
//  end;
  Result := 0;
  TryStrToFloat(lsStr,Result);
end;

class function TUtil.getErrorDetails(E: Exception): string;
begin
(*
  if E is EValidate then
    result := 'Aten��o! Essa � apenas uma mensagem de valida��o de dados do sistema!'

  else if E is EImpFiscal then
    result := 'Problema no protocolo de comunica��o com a Impressora Fiscal!'

  else if E is EPKException then
    result := 'Aten��o! N�o � permitido registros duplicados na base de dados do sistema!'

  else if E is EFKException then
    result := 'Aten��o! Registros com dependentes devem ser selecionados corretamente. Tamb�m n�o � permitido a exclus�o dos mesmos!'

  else if E is EUKException then
    result := 'Aten��o! N�o � permitido registros duplicados na base de dados do sistema!'

  else if E is ECKException then
    result := 'Aten��o! As regras de checagem do banco de dados devem ser obedecidas!'

  else if E is ENWException then
    result := 'Aten��o! Houve um problema na rede ou na comunica��o com o banco de dados!'

  else if E is EAcessDeny then
    result := 'Aten��o! N�o h� privil�gios suficientes para executar essa rotina!'

  else
    result := 'Erro n�o previsto!';
  *)
end;

class function TUtil.getErrorRelevancia(E: Exception): string;
begin
(*
  if E is EValidate then
    result := 'Baixa!'

  else if E is EImpFiscal then
    result := 'Alta (ImpFiscal)!'

  else if E is EPKException then
    result := 'Baixa (Tentativa de viola��o das regras de neg�cio)!'

  else if E is EFKException then
    result := 'Baixa (Tentativa de viola��o das regras de neg�cio)!'

  else if E is EUKException then
    result := 'Baixa (Tentativa de viola��o das regras de neg�cio)!'

  else if E is ECKException then
    result := 'Baixa (Tentativa de viola��o das regras de neg�cio)!'

  else if E is ENWException then
    result := 'Alta (Infra-Estrutura)!'

  else if E is EAcessDeny then
    result := 'Baixa (Seguran�a)!'

  else
    result := 'Alta (N�o Previsto)!';
    *)
end;

class function TUtil.getIDPessoa: String;
begin
  result := FsIdPessoa;
end;

class function TUtil.getIDPessoaResponsavel(psPrograma,psIdUsuario: String): String;
var
  loqryPessoaResonsavel: TSQLQuery;
begin
  if FsIdPessoaResponsavel = '' then begin
    loqryPessoaResonsavel := TSQLQuery.Create(nil);
    try
      loqryPessoaResonsavel.SQLConnection := TUtil.getConn;
      if psPrograma = 'MEGAPESSOAL.EXE' then begin
        loqryPessoaResonsavel.SQL.Add('SELECT UP.FK_EMPRESA_RESPONSAVEL_PESSOAL FROM CTL_USUARIO_PARAMETROS UP WHERE (UP.FK_CTL_USUARIOS = :pIdUsuario)');
      end;
      loqryPessoaResonsavel.ParamByName('pIdUsuario').AsString := psIdUsuario;
      loqryPessoaResonsavel.Open;
      FsIdPessoaResponsavel :=  loqryPessoaResonsavel.FieldByName('FK_EMPRESA_RESPONSAVEL_PESSOAL').AsString;
    finally
      FreeAndNil(loqryPessoaResonsavel);
    end;
  end;
  Result := FsIdPessoaResponsavel;
end;

class procedure TUtil.setIdPessoa(lsIdPessoa: String);
begin
  FsIdPessoa := lsIdPessoa;
end;

class procedure TUtil.setIdPessoaResponsavel(psPrograma,psIdPessoaResponsavel,psIdUsuario: String);
var
  loqryPessoaResonsavel: TSQLQuery;
begin
  FsIdPessoaResponsavel := psIdPessoaResponsavel;
  loqryPessoaResonsavel := TSQLQuery.Create(nil);
  try
    loqryPessoaResonsavel.SQLConnection := TUtil.getConn;
    if psPrograma = 'MEGAPESSOAL.EXE' then begin
      loqryPessoaResonsavel.SQL.Add('UPDATE CTL_USUARIO_PARAMETROS UP SET UP.FK_EMPRESA_RESPONSAVEL_PESSOAL = :pIdEmpresaResponsavel WHERE (UP.FK_CTL_USUARIOS = :pIdUsuario)');
    end;
    loqryPessoaResonsavel.ParamByName('pIdEmpresaResponsavel').AsString := psIdPessoaResponsavel;
    loqryPessoaResonsavel.ParamByName('pIdUsuario'           ).AsString := psIdUsuario;
    loqryPessoaResonsavel.ExecSQL;
  finally
    FreeAndNil(loqryPessoaResonsavel);
  end;
end;

class function TUtil.getCodigoMunicipioIBGE(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT C.CODIGO_IBGE FROM PESSOA P ');
    loQryPessoa.SQL.Append('LEFT JOIN CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES) ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      Result := trim(loQryPessoa.FieldByName('CODIGO_IBGE').AsString);
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getCodigoMunicipioSEFAZ(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT C.CODIGO_SEFAZ FROM PESSOA P ');
    loQryPessoa.SQL.Append('LEFT JOIN CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES) ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      Result := trim(loQryPessoa.FieldByName('CODIGO_SEFAZ').AsString);
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getCodigoPessoa: Integer;
begin
  Result := FiCodigoPessoa;
end;

class function TUtil.getStrCodigoPessoa(): String;
begin
  Result := FsCodigoPessoa;
end;

class function TUtil.getConn: TSQLConnection;
begin
  result := FoConn;
end;

class function TUtil.getDataConstituicaoPessoa(psIdPessoa: String): TDate;
var
  loQryVerifica: TSQLQuery;
begin
  Result := 0;
  loQryVerifica := TSQLQuery.Create(nil);
  try
    loQryVerifica.SQLConnection := FoConn;
    loQryVerifica.SQL.Add('SELECT FIRST 1 R.DATA FROM REGISTROS R WHERE (R.FK_PESSOA = :pIdPessoa) AND (R.TIPO = 0)');
    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryVerifica.Open;
    Result := loQryVerifica.FieldByName('DATA').AsDateTime;
  finally
    FreeAndNil(loQryVerifica);
  end;
end;

class function TUtil.getDataInicioProgramas(psIdPessoa: String): TDate;
var
  loQryVerifica: TSQLQuery;
  ldDataInicioMegaFiscal,ldDataInicioMegaPessoal: TDate;
begin
  Result := getDataInicioUsoMegaContabil(psIdPessoa);
  if (Result < TP_DATA_INICIAL) then begin
    Result := TP_DATA_EMPTY;
  end;

  ldDataInicioMegaFiscal := getDataInicioFimUsoMegaFiscal(psIdPessoa);
  if (ldDataInicioMegaFiscal < TP_DATA_INICIAL) then begin
    ldDataInicioMegaFiscal := TP_DATA_EMPTY;
  end;
  if ((ldDataInicioMegaFiscal <> TP_DATA_EMPTY) and ((ldDataInicioMegaFiscal < Result) or (Result = TP_DATA_EMPTY))) then begin
    Result := ldDataInicioMegaFiscal;
  end;

  ldDataInicioMegaPessoal := getDataInicioUsoMegaPessoal(psIdPessoa,true);
  if (ldDataInicioMegaPessoal < TP_DATA_INICIAL) then begin
    ldDataInicioMegaPessoal := TP_DATA_EMPTY;
  end;
  if ((ldDataInicioMegaPessoal <> TP_DATA_EMPTY) and ((ldDataInicioMegaPessoal < Result) or (Result = TP_DATA_EMPTY))) then begin
    Result := ldDataInicioMegaPessoal;
  end;
end;

class function TUtil.getDataInicioUsoMegaPessoal(psIdPessoa: String; pChecaLancamentosProvisorios: Boolean): TDate;
var
  loQryProgramaPessoal: TSQLQuery;
begin
  loQryProgramaPessoal := TSQLQuery.Create(nil);
  try
    loQryProgramaPessoal.SQLConnection := TUtil.getConn;
    loQryProgramaPessoal.SQL.Add('SELECT DATA_MIGRACAO FROM PESSOA_PESSOAL WHERE (FK_PESSOA = :pIdPessoa)');
    loQryProgramaPessoal.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryProgramaPessoal.Open;
    Result := loQryProgramaPessoal.FieldByName('DATA_MIGRACAO').AsDateTime;
  finally
    FreeAndNil(loQryProgramaPessoal);
  end;
//var
//  loQryVerificaCalculos: TSQLQuery;
//begin
//  Result := TP_DATA_EMPTY;
//  loQryVerificaCalculos := TSQLQuery.Create(nil);
//  try
//    loQryVerificaCalculos.SQLConnection := FoConn;
//    loQryVerificaCalculos.SQL.Add('SELECT FIRST 1 PD.DATA FROM (');
//    if pChecaLancamentosProvisorios then begin
//      loQryVerificaCalculos.SQL.Add('SELECT LP.DATA_INICIAL AS DATA FROM PLANCAMENTOS_PROVISORIOS LP WHERE (LP.FK_PESSOA = :pIdPessoa) ');
//      loQryVerificaCalculos.SQL.Add('UNION ');
//      loQryVerificaCalculos.SQL.Add('SELECT ALP.DATA_INICIAL AS DATA FROM PAUTONOMOS_LANCAM_PROVISOR ALP WHERE (ALP.FK_PESSOA = :pIdPessoa) ');
//      loQryVerificaCalculos.SQL.Add('UNION ');
//      loQryVerificaCalculos.SQL.Add('SELECT SLP.DATA_INICIAL AS DATA FROM PSOCIOS_LANCAM_PROVISORIO SLP WHERE (SLP.FK_PESSOA = :pIdPessoa) ');
//      loQryVerificaCalculos.SQL.Add('UNION ');
//    end;
//    loQryVerificaCalculos.SQL.Add('SELECT L.DATA FROM PLANCAMENTOS L WHERE (L.FK_PESSOA = :pIdPessoa) ');
//    loQryVerificaCalculos.SQL.Add('UNION ');
//    loQryVerificaCalculos.SQL.Add('SELECT AL.DATA FROM PAUTONOMOS_LANCAMENTOS AL WHERE (AL.FK_PESSOA = :pIdPessoa) ');
//    loQryVerificaCalculos.SQL.Add('UNION ');
//    loQryVerificaCalculos.SQL.Add('SELECT SL.DATA FROM PSOCIOS_LANCAMENTOS SL WHERE (SL.FK_PESSOA = :pIdPessoa) ');
//    loQryVerificaCalculos.SQL.Add(') PD ');
//    loQryVerificaCalculos.SQL.Add('ORDER BY PD.DATA ');
//    loQryVerificaCalculos.ParamByName('pIdPessoa').AsString := psIdPessoa;
//    loQryVerificaCalculos.Open;
//    if not loQryVerificaCalculos.IsEmpty then begin
//      Result := loQryVerificaCalculos.FieldByName('DATA').AsDateTime;
//    end;
//  finally
//    FreeAndNil(loQryVerificaCalculos);
//  end;
end;

//class function TUtil.getDataUltimoRegistroMegaFiscal(psIdPessoa: String): TDate;
//var
//  loQryVerifica: TSQLQuery;
//begin
//  Result := TP_DATA_EMPTY;
//  loQryVerifica := TSQLQuery.Create(nil);
//  try
//    loQryVerifica.SQLConnection := FoConn;
//    loQryVerifica.SQL.Add('SELECT FIRST 1 D.DATA FROM ( ');
//    loQryVerifica.SQL.Add('SELECT DFE.DATA_ENTRADA AS DATA FROM FDFE DFE WHERE (DFE.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFES.DATA_ENTRADA AS DATA FROM FDFE_SERVICO DFES WHERE (DFES.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFS.DATA_EMISSAO AS DATA FROM FDFS DFS WHERE (DFS.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFSECF.DATA_EMISSAO AS DATA FROM FDFS_ECF DFSECF WHERE (DFSECF.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFSM2.DATA_EMISSAO AS DATA FROM FDFS_M2 DFSM2 WHERE (DFSM2.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFSSE.DATA_EMISSAO AS DATA FROM FDFS_SERVICO DFSSE WHERE (DFSSE.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT R.DATA FROM FOUTRAS_RECEITAS R WHERE (R.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add(' ) D ');
//    loQryVerifica.SQL.Add('ORDER BY D.DATA DESC');
//    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
//    loQryVerifica.Open;
//    if not loQryVerifica.IsEmpty then begin
//      Result := loQryVerifica.FieldByName('DATA').AsDateTime;
//    end;
//  finally
//    FreeAndNil(loQryVerifica);
//  end;
//end;

class function TUtil.getDataInicioFimUsoMegaFiscal(psIdPessoa: String; pbInicio: Boolean = True): TDate;
var
  loQryInicioFimUsoPrograma: TSQLQuery;
begin
  loQryInicioFimUsoPrograma := TSQLQuery.Create(nil);
  try
    Result := 0;
    loQryInicioFimUsoPrograma.SQLConnection := TUtil.getConn;
    loQryInicioFimUsoPrograma.SQL.Add('SELECT FIRST 1 FS.DATA FROM PESSOA_FISCAL_SITUACAO FS ');
    loQryInicioFimUsoPrograma.SQL.Add('WHERE (FS.FK_PESSOA = :pIdPessoa) AND (FS.CODIGO = :pTipo)');
    loQryInicioFimUsoPrograma.ParamByName('pIdPessoa').AsString := psIdPessoa;
    if (pbInicio) then begin
      loQryInicioFimUsoPrograma.ParamByName('pTipo').AsInteger := 0; {Ativa}
    end else begin
      loQryInicioFimUsoPrograma.ParamByName('pTipo').AsInteger := 2; {Baixada}
    end;
    loQryInicioFimUsoPrograma.Open;
    if not loQryInicioFimUsoPrograma.IsEmpty then begin
      Result := loQryInicioFimUsoPrograma.FieldByName('DATA').AsDateTime;
    end else begin
      Result := TP_DATA_EMPTY;
    end;
  finally
    FreeAndNil(loQryInicioFimUsoPrograma);
  end;
end;

class function TUtil.getDataInicioUsoMegaContabil(psIdPessoa: String): TDate;
var
  loQryVerifica: TSQLQuery;
begin
  Result := TP_DATA_EMPTY;

  loQryVerifica := TSQLQuery.Create(nil);
  try
    loQryVerifica.SQLConnection := FoConn;
    {Quando da implementa��o da nova vers�o do MegaContabil, verificar se
    existe a necessidade de incluir outras tabelas}
    loQryVerifica.SQL.Add('SELECT FIRST 1 D.DATA FROM ( ');
    loQryVerifica.SQL.Add('SELECT L.DATA FROM CLANCAMENTOS L WHERE (L.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFES.DATA_ENTRADA AS DATA FROM FDFE_SERVICO DFES WHERE (DFES.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFS.DATA_EMISSAO AS DATA FROM FDFS DFS WHERE (DFS.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFSECF.DATA_EMISSAO AS DATA FROM FDFS_ECF DFSECF WHERE (DFSECF.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFSM2.DATA_EMISSAO AS DATA FROM FDFS_M2 DFSM2 WHERE (DFSM2.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT DFSSE.DATA_EMISSAO AS DATA FROM FDFS_SERVICO DFSSE WHERE (DFSSE.FK_PESSOA = :pIdPessoa) ');
//    loQryVerifica.SQL.Add('UNION ');
//    loQryVerifica.SQL.Add('SELECT R.DATA FROM FOUTRAS_RECEITAS R WHERE (R.FK_PESSOA = :pIdPessoa) ');
    loQryVerifica.SQL.Add(' ) D ');
    loQryVerifica.SQL.Add('ORDER BY D.DATA ');
    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryVerifica.Open;
    if not loQryVerifica.IsEmpty then begin
      Result := loQryVerifica.FieldByName('DATA').AsDateTime;
    end;
  finally
    FreeAndNil(loQryVerifica);
  end;
end;

class procedure TUtil.setCodigoPessoa(piValue: Integer);
begin
  FiCodigoPessoa := piValue;
  FsCodigoPessoa := StrZero(piValue,CODIGO_PESSOA_MIN_LEN,0);
end;

class procedure TUtil.setConn(loConn: TSQLConnection);
begin
  FoConn := loConn;
end;

//class procedure TUtil.setFormControleUsuarios(poFControleUsuarios: TFControleUsuarios);
//begin
//  FoControleUsuarios := poFControleUsuarios;
//end;

class function TUtil.getIDGrupoTabelasGerais(dData:TDate): String;
var
  loQryGrupoTabelasGerais: TSQLQuery;
begin
  result := '';
  loQryGrupoTabelasGerais := TSQLQuery.Create(nil);
  try
    loQryGrupoTabelasGerais.SQLConnection := FoConn;
    loQryGrupoTabelasGerais.SQL.Add('SELECT FIRST 1 A.FK_GRUPO_TABELAS_GERAIS FROM PESSOA_GRUPO_TABELAS_GERAIS A WHERE (A.DATA <= :pData) AND (A.FK_PESSOA = :pIdPessoa) ORDER BY DATA DESC');
    loQryGrupoTabelasGerais.ParamByName('pData'    ).AsDate   := dData;
    loQryGrupoTabelasGerais.ParamByName('pIdPessoa').AsString := FsIdPessoa;
    loQryGrupoTabelasGerais.Open;
    Result := loQryGrupoTabelasGerais.FieldByName('FK_GRUPO_TABELAS_GERAIS').AsString;
  finally
    loQryGrupoTabelasGerais.Close;
    FreeAndNil(loQryGrupoTabelasGerais);
  end;
end;

class function TUtil.getIDGrupoTabelasGerais(sIdPessoa:String; dData:TDate): String;
var
  loQryGrupoTabelasGerais: TSQLQuery;
begin
  result := '';
  loQryGrupoTabelasGerais := TSQLQuery.Create(nil);
  try
    loQryGrupoTabelasGerais.SQLConnection := FoConn;
    loQryGrupoTabelasGerais.SQL.Add('SELECT FIRST 1 A.FK_GRUPO_TABELAS_GERAIS FROM PESSOA_GRUPO_TABELAS_GERAIS A WHERE (A.DATA <= :pData) AND (A.FK_PESSOA = :pIdPessoa) ORDER BY DATA DESC');
    loQryGrupoTabelasGerais.ParamByName('pData').AsDate := dData;
    loQryGrupoTabelasGerais.ParamByName('pIdPessoa').AsString := sIdPessoa;
    loQryGrupoTabelasGerais.Open;
    Result := loQryGrupoTabelasGerais.FieldByName('FK_GRUPO_TABELAS_GERAIS').AsString;
  finally
    FreeAndNil(loQryGrupoTabelasGerais);
  end;
end;

class function TUtil.getNIRE(psIdPessoa: String): String;
var
  loQryNIRE: TFDQuery;
begin
  Result := '';
  loQryNIRE := TFDQuery.Create(nil);
  try
    loQryNIRE.Connection := TUtilConexaoFireDac.getConn;
    loQryNIRE.SQL.Append('SELECT R.NUMERO FROM REGISTROS R WHERE (R.FK_PESSOA = :pIdPessoa) AND (R.TIPO = 0)');
    loQryNIRE.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryNIRE.Open;
    Result := loQryNIRE.FieldByName('NUMERO').AsString;
  finally
    FreeAndNil(loQryNIRE);
  end;
end;

class function TUtil.getNomePessoa(): String;
begin
  Result := FsNomePessoa;
end;

class function TUtil.getNomePessoaContato: String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.CONTATO FROM PESSOA_PESSOAL P ');
    loQryPessoa.SQL.Append('WHERE (P.FK_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := FsIdPessoa;
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('CONTATO').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getNomePessoaContato(psIdPessoa: string): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.CONTATO FROM PESSOA_PESSOAL P ');
    loQryPessoa.SQL.Append('WHERE (P.FK_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('CONTATO').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getNomeSocio(psIdSocio: String): String;
var
  loQryNomeSocio: TFDQuery;
begin
  Result := '';
  loQryNomeSocio := TFDQuery.Create(nil);
  try
    loQryNomeSocio.Connection := TUtilConexaoFireDac.getConn;
    loQryNomeSocio.SQL.Append('SELECT S.NOME FROM SOCIOS S WHERE (S.ID_SOCIOS = :pIdSocio)');
    loQryNomeSocio.ParamByName('pIdSocio').AsString := psIdSocio;
    loQryNomeSocio.Open;
    Result := loQryNomeSocio.FieldByName('NOME').AsString;
  finally
    FreeAndNil(loQryNomeSocio);
  end;
end;

class function TUtil.getNomePessoa(psIdPessoa: string): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.NOME FROM PESSOA P ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('NOME').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;


class procedure TUtil.setNomePessoa(value: String);
begin
  FsNomePessoa := value;
end;

{$REGION 'C�digo antigo (Fun��o movida para TUtilControleFormulario...'}
{ TODO -oIvan -cCodigoAntigo : Lembrar de retirar o c�digo antigo ap�s valida��o do c�digo novo. 14/05/2015 11:06:58}
(*
class procedure TUtil.setTransparencia(const piFormHandle: HWND; piPencentualTransparencia: integer);
var
  liInfoWindow: Longint;
  liValorTransparencia: integer;
begin
  if ((piPencentualTransparencia >= 1) and (piPencentualTransparencia <= 100)) then begin
    liValorTransparencia := VALOR_PADRAO_TRANSPARENCIA - Trunc((VALOR_PADRAO_TRANSPARENCIA * piPencentualTransparencia)/100);
  end else begin
    liValorTransparencia := VALOR_PADRAO_TRANSPARENCIA;
  end;
  liInfoWindow := GetWindowLong(piFormHandle, GWL_EXSTYLE);
  liInfoWindow := liInfoWindow or WS_EX_LAYERED;
  SetWindowLong(piFormHandle, GWL_EXSTYLE, liInfoWindow);
  SetLayeredWindowAttributes(piFormHandle, 0, liValorTransparencia, LWA_ALPHA);
end;
*)
{$ENDREGION}

class function TUtil.getInscMfPessoa: String;
begin
  Result := FsInscMfPessoa;
end;

class function TUtil.getInscMfPessoa(psIdPessoa: string): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.INSCMF FROM PESSOA P ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('INSCMF').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getInscMfPessoaContato: String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.CPF_CONTATO FROM PESSOA_PESSOAL P ');
    loQryPessoa.SQL.Append('WHERE (P.FK_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := FsIdPessoa;
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('CPF_CONTATO').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getInscMfPessoaContato(psIdPessoa: string): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.CPF_CONTATO FROM PESSOA_PESSOAL P ');
    loQryPessoa.SQL.Append('WHERE (P.FK_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('CPF_CONTATO').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getInscMfSocio(psIdSocio: String): String;
var
  loQryInscMfSocio: TFDQuery;
begin
  Result := '';
  loQryInscMfSocio := TFDQuery.Create(nil);
  try
    loQryInscMfSocio.Connection := TUtilConexaoFireDac.getConn;
    loQryInscMfSocio.SQL.Append('SELECT S.INSCMF FROM SOCIOS S WHERE (S.ID_SOCIOS = :pIdSocio)');
    loQryInscMfSocio.ParamByName('pIdSocio').AsString := psIdSocio;
    loQryInscMfSocio.Open;
    Result := loQryInscMfSocio.FieldByName('INSCMF').AsString;
  finally
    FreeAndNil(loQryInscMfSocio);
  end;
end;

class function TUtil.getInscMunicipal(psIdPessoa: String): String;
var
  loQryInscMunicipal: TSQLQuery;
begin
  result := '';
  loQryInscMunicipal := TSQLQuery.Create(nil);
  try
    loQryInscMunicipal.SQLConnection := FoConn;
    loQryInscMunicipal.SQL.Add('SELECT P.INSC_MUNICIPAL FROM PESSOA P WHERE (P.ID_PESSOA = :pIdPessoa)');
    loQryInscMunicipal.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryInscMunicipal.Open;
    Result := loQryInscMunicipal.FieldByName('INSC_MUNICIPAL').AsString;
  finally
    FreeAndNil(loQryInscMunicipal);
  end;
end;

class procedure TUtil.getItensMenu(poItensMenu: TMenuItem; var poStringList: TStringList);
var
  poItem: TMenuItem;
begin
  for poItem in poItensMenu do begin
    poStringList.Add(poItem.Name);
    if (poItem.Count > 0) then begin
       TUtil.getItensMenu(poItem,poStringList);
    end;
  end;
end;

class function TUtil.getLocalIp: string;
var
  loIndyWatchIP: TIdIPWatch; {Palheta Indy Misc}
begin
  loIndyWatchIP := TIdIPWatch.Create(nil);
  Result := loIndyWatchIP.LocalIP;
end;


class function TUtil.getInscMfMatriz(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
  lsInscMf: string;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.INSCMF FROM PESSOA P ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    lsInscMf := loQryPessoa.FieldByName('INSCMF').AsString;

    loQryPessoa.Close;
    loQryPessoa.SQL.Clear;
    loQryPessoa.SQL.Append('SELECT P.INSCMF FROM PESSOA P ');
    loQryPessoa.SQL.Append('WHERE (P.INSCMF LIKE :pInscMf) AND (P.MATRIZ = -1)');
    loQryPessoa.ParamByName('pInscMf').AsString := Copy(lsInscMf,1,10)+'%';
    loQryPessoa.Open;
    Result := loQryPessoa.FieldByName('INSCMF').AsString;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getTelefonePessoa(psIdPessoa: String): String;
var
  loQryTelefone: TFDQuery;
begin
  Result := '';
  loQryTelefone := TFDQuery.Create(nil);
  try
    loQryTelefone.Connection := TUtilConexaoFireDac.getConn;
    loQryTelefone.SQL.Append('SELECT FIRST 1 T.NUMERO FROM TELEFONE T WHERE (T.FK_PESSOA = :pIdPessoa) ORDER BY T.PRINCIPAL');
    loQryTelefone.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryTelefone.Open;
    Result := loQryTelefone.FieldByName('NUMERO').AsString;
  finally
    FreeAndNil(loQryTelefone);
  end;
end;

//class function TUtil.GetTipoInscMfPessoa: String;
//begin
//  Result := FsTpInscMfPessoa;
//end;

//class function TUtil.GetTTipoInscMfPessoa: TTipoInscMf;
//begin
//  Result := FtTpInscMfPessoa;
//end;

//class function TUtil.getDataPrimeiroCalculo(psIdPessoa: String; pbGeral: Boolean): TDate;
//var
//  loQryDataPrimeiroCalculo: TSQLQuery;
//  lsPrograma: String;
//  liPrograma: Integer;
//  ldData: TDate;
//begin
//  loQryDataPrimeiroCalculo := TSQLQuery.Create(nil);
//  try
//    lsPrograma := UpperCase(ExtractFileName(Application.ExeName));
//    liPrograma := -1;
//    ldData     := TP_DATA_MAXIMA_LIMITE+1;
//    if (lsPrograma = 'MEGACONTABIL.EXE') then begin
//      liPrograma := TP_PROGRAMA_CONTABIL;
//    end else if (lsPrograma = 'MEGAFISCAL.EXE') then begin
//      liPrograma := TP_PROGRAMA_FISCAL;
//    end else if (lsPrograma = 'MEGAPESSOAL.EXE') then begin
//      liPrograma := TP_PROGRAMA_PESSOAL;
//    end;
//    loQryDataPrimeiroCalculo.SQLConnection := FoConn;
//    if (pbGeral) or (liPrograma = TP_PROGRAMA_CONTABIL) then begin
//
//    end;
//    if (pbGeral) or (liPrograma = TP_PROGRAMA_FISCAL) then begin
//      loQryDataPrimeiroCalculo.Close;
//      loQryDataPrimeiroCalculo.SQL.Clear;
//      loQryDataPrimeiroCalculo.SQL.Add('SELECT FIRST 1 EC.DATA FROM FEMPRESA_CALCULOS EC WHERE (EC.FK_PESSOA = :pIdPessoa) ORDER BY EC.DATA');
//      loQryDataPrimeiroCalculo.ParamByName('pIdPessoa').AsString := FsIdPessoa;
//      loQryDataPrimeiroCalculo.Open;
//      if (not loQryDataPrimeiroCalculo.IsEmpty) and (ldData > loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime) then begin
//        ldData := loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime;
//      end;
//    end;
//    if (pbGeral) or (liPrograma = TP_PROGRAMA_PESSOAL) then begin
//      loQryDataPrimeiroCalculo.Close;
//      loQryDataPrimeiroCalculo.SQL.Clear;
//      loQryDataPrimeiroCalculo.SQL.Add('SELECT FIRST 1 FC.DATA FROM PFUNCIONARIO_CALCULOS FC WHERE (FC.FK_PESSOA = :pIdPessoa) AND (FC.CALCULADO = -1) ORDER BY FC.DATA');
//      loQryDataPrimeiroCalculo.ParamByName('pIdPessoa').AsString := FsIdPessoa;
//      loQryDataPrimeiroCalculo.Open;
//      if (not loQryDataPrimeiroCalculo.IsEmpty) and (ldData > loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime) then begin
//        ldData := loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime;
//      end;
//
//      loQryDataPrimeiroCalculo.Close;
//      loQryDataPrimeiroCalculo.SQL.Clear;
//      loQryDataPrimeiroCalculo.SQL.Add('SELECT FIRST 1 SC.DATA FROM PSOCIOS_CALCULOS SC WHERE (SC.FK_PESSOA = :pIdPessoa) AND (SC.CALCULADO = -1) ORDER BY SC.DATA');
//      loQryDataPrimeiroCalculo.ParamByName('pIdPessoa').AsString := FsIdPessoa;
//      loQryDataPrimeiroCalculo.Open;
//      if (not loQryDataPrimeiroCalculo.IsEmpty) and (ldData > loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime) then begin
//        ldData := loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime;
//      end;
//
//      loQryDataPrimeiroCalculo.Close;
//      loQryDataPrimeiroCalculo.SQL.Clear;
//      loQryDataPrimeiroCalculo.SQL.Add('SELECT FIRST 1 AC.DATA FROM PAUTONOMOS_CALCULOS AC WHERE (AC.FK_PESSOA = :pIdPessoa) AND (AC.CALCULADO = -1) ORDER BY AC.DATA');
//      loQryDataPrimeiroCalculo.ParamByName('pIdPessoa').AsString := FsIdPessoa;
//      loQryDataPrimeiroCalculo.Open;
//      if (not loQryDataPrimeiroCalculo.IsEmpty) and (ldData > loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime) then begin
//        ldData := loQryDataPrimeiroCalculo.FieldByName('DATA').AsDateTime;
//      end;
//    end;
//  finally
//    loQryDataPrimeiroCalculo.Close;
//    FreeAndNil(loQryDataPrimeiroCalculo);
//    if (ldData >= TP_DATA_INICIAL)
//      and (ldData <= TP_DATA_MAXIMA_LIMITE)
//    then begin
//      Result := ldData;
//    end else begin
//      Result := 0;
//    end;
//  end;
//end;

class function TUtil.getDataCalculoMegaFiscal(
  psIdPessoa: String; pbPrimeiroCalculo: Boolean): TDate;
var
  loQryVerifica: TSQLQuery;
begin
  Result := TP_DATA_EMPTY;
  loQryVerifica := TSQLQuery.Create(nil);
  try
    loQryVerifica.SQLConnection := FoConn;
    loQryVerifica.SQL.Add('SELECT FIRST 1 EC.DATA FROM FEMPRESA_CALCULOS EC WHERE (EC.FK_PESSOA = :pIdPessoa) ');
    loQryVerifica.SQL.Add('ORDER BY EC.DATA ');
    if (pbPrimeiroCalculo) then begin
      loQryVerifica.SQL.Add('DESC');
    end;
    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryVerifica.Open;
    if not loQryVerifica.IsEmpty then begin
      Result := loQryVerifica.FieldByName('DATA').AsDateTime;
    end;
  finally
    FreeAndNil(loQryVerifica);
  end;
end;

class function TUtil.getDataCalculoMegaPessoal(
  psIdPessoa: String; pbPrimeiroCalculo: Boolean): TDate;
var
  loQryVerifica: TSQLQuery;
begin
  Result := TP_DATA_EMPTY;
  loQryVerifica := TSQLQuery.Create(nil);
  try
    loQryVerifica.SQLConnection := FoConn;
    loQryVerifica.SQL.Add('SELECT FIRST 1 EC.DATA FROM PEMPRESA_CALCULOS EC WHERE (EC.FK_PESSOA = :pIdPessoa) ');
    loQryVerifica.SQL.Add('ORDER BY EC.DATA ');
    if (pbPrimeiroCalculo) then begin
      loQryVerifica.SQL.Add('DESC');
    end;
    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryVerifica.Open;
    if not loQryVerifica.IsEmpty then begin
      Result := loQryVerifica.FieldByName('DATA').AsDateTime;
    end;
  finally
    FreeAndNil(loQryVerifica);
  end;
end;

class function TUtil.getDataCalculoProgramas(psIdPessoa: String; pbPrimeiroCalculo: Boolean;
  pbTodosEstabelecimentos: Boolean = False; psInscMf: string = ''): TDate;
var
  loQryEstabelecimentos: TSQLQuery;
  ldDataCalculoMegaFiscal,ldDataCalculoMegaPessoal: TDate;
begin
  if (not pbTodosEstabelecimentos) then begin
    Result := getDataCalculoMegaPessoal(psIdPessoa,pbPrimeiroCalculo);

    ldDataCalculoMegaFiscal := getDataCalculoMegaFiscal(psIdPessoa,pbPrimeiroCalculo);
    if ((pbPrimeiroCalculo) and (ldDataCalculoMegaFiscal < Result))
      or ((not pbPrimeiroCalculo) and (ldDataCalculoMegaFiscal > Result))
    then begin
      Result := ldDataCalculoMegaFiscal;
    end;
  end else begin
    loQryEstabelecimentos := TSQLQuery.Create(nil);
    try
      loQryEstabelecimentos.SQLConnection := getConn;
      loQryEstabelecimentos.SQL.Add('SELECT P.ID_PESSOA,P.INSCMF FROM PESSOA P WHERE (P.INSCMF = :pInscMfBase)');
      loQryEstabelecimentos.ParamByName('pInscMfBase').AsString := Copy(psInscMf,1,10);
      loQryEstabelecimentos.Open;
      while (not loQryEstabelecimentos.Eof) do begin

        ldDataCalculoMegaPessoal := getDataCalculoMegaPessoal(psIdPessoa,pbPrimeiroCalculo);
        if ((pbPrimeiroCalculo) and (ldDataCalculoMegaPessoal < Result))
          or ((not pbPrimeiroCalculo) and (ldDataCalculoMegaPessoal > Result))
        then begin
          Result := ldDataCalculoMegaPessoal;
        end;

        ldDataCalculoMegaFiscal := getDataCalculoMegaFiscal(psIdPessoa,pbPrimeiroCalculo);
        if ((pbPrimeiroCalculo) and (ldDataCalculoMegaFiscal < Result))
          or ((not pbPrimeiroCalculo) and (ldDataCalculoMegaFiscal > Result))
        then begin
          Result := ldDataCalculoMegaFiscal;
        end;

        loQryEstabelecimentos.Next;
      end;
    finally
      FreeAndNil(loQryEstabelecimentos);
    end;
  end;
end;

class procedure TUtil.ReOpenClientDataSet(pDataSet: TClientDataSet);
begin
  pDataSet.Close;
  pDataSet.Open;
end;

class procedure TUtil.ReOpenSqlQuery(pSqlQuery: TSQLQuery);
begin
  pSqlQuery.Close;
  pSqlQuery.Open;
end;

//class procedure TUtil.PreencheCbxBoxRegimes(var pcbxRegimes: TComboBox; TipoRegime: TTipoRegime; var pstrLstDescricaoRegime: TStringList);
class procedure TUtil.PreencheCbxBoxRegimes(var pcbxRegimes: TComboBox; TipoRegime: TTipoRegimeTributario);
begin
  pcbxRegimes.Items.Clear;
//  pstrLstDescricaoRegime.Clear;
//  if TipoRegime = opMunicipal then begin
//    pcbxRegimes.Items.Append('NO');
//    pcbxRegimes.Items.Append('SN');
//    pstrLstDescricaoRegime.Append('Normal');
//    pstrLstDescricaoRegime.Append('Simples Nacional');
//  end else if TipoRegime = opEstadual then begin
//    pcbxRegimes.Items.Add('CC');
//    pcbxRegimes.Items.Add('SN');
//    pstrLstDescricaoRegime.Append('Normal' );
//    pstrLstDescricaoRegime.Append('Simples Nacional');
  if TipoRegime = opFederal then begin
    pcbxRegimes.Items.Add('NENHUM');
    pcbxRegimes.Items.Add('LUCRO PRESUMIDO');
    pcbxRegimes.Items.Add('LUCRO REAL');
    pcbxRegimes.Items.Add('SEM FINS LUCRATIVOS');
    pcbxRegimes.Items.Add('SIMPLES NACIONAL');
    pcbxRegimes.Items.Add('MEI');

//    pcbxRegimes.Items.Add('NE');
//    pcbxRegimes.Items.Add('LP');
//    pcbxRegimes.Items.Add('LR');
//    pcbxRegimes.Items.Add('SF');
//    pcbxRegimes.Items.Add('SN');
//    pcbxRegimes.Items.Add('MEI');
//    pstrLstDescricaoRegime.Append('Nenhum');
//    pstrLstDescricaoRegime.Append('Lucro Presumido');
//    pstrLstDescricaoRegime.Append('Lucro Real');
//    pstrLstDescricaoRegime.Append('Sem Fins Lucrativos');
//    pstrLstDescricaoRegime.Append('Simples Nacional');
//    pstrLstDescricaoRegime.Append('MEI-Microempreendedor Individual');
  end;
end;

class procedure TUtil.preencheComboBox(var poComboBox: TComboBox; poStringList: TStringList);
begin
  poComboBox.Items.AddStrings(poStringList);
end;

class procedure TUtil.preencherComboSignatario(psIdPessoa: string;
      pbIncluiPropriaEmpresa: Boolean; var poComboBox: TComboBox;
      pdData: TDate; var poStrLstListaSignatario: TStringList);
var
  liForLinha: Integer;
begin

  dmUtil.qrySignatarios.Close;
  dmUtil.qrySignatarios.ParamByName('pIdPessoa' ).AsString := psIdPessoa;
  dmUtil.qrySignatarios.ParamByName('pDataFinal').AsDate   := pdData;
  dmUtil.qrySignatarios.Open;

  poStrLstListaSignatario.Clear;
  while not dmUtil.qrySignatarios.Eof do begin
    poStrLstListaSignatario.Add(dmUtil.qrySignatarios.FieldByName('ID_SOCIOS').AsString+'|'+dmUtil.qrySignatarios.FieldByName('NOME').AsString);
    dmUtil.qrySignatarios.Next;
  end;
  {Inclui o nome da pr�ria empresa, sendo que em lugar do ID consta o a palavra
  EMPRESA, pois, caso esse registro seja selecionado, o signat�rio inclu�do no
  registro 0930 ser� a pr�pria empresa, que usar� o e-PJ ou e-CNPJ}
  poStrLstListaSignatario.Add('EMPRESA|'+TUtil.getNomePessoa(TUtil.getIDPessoa));

  if (poStrLstListaSignatario.Count > 0) then begin
    poComboBox.Clear;
    for liForLinha := 0 to poStrLstListaSignatario.Count -1 do begin
      poComboBox.Items.Add(StrToken(poStrLstListaSignatario[liForLinha],'|',2));
    end;
    poComboBox.ItemIndex := 0;
  end;
end;


class procedure TUtil.setFiscalizacaoSefaz(psIdPessoa: string);
var
  loQryPessoa: TSQLQuery;
begin
  FbFiscalizacaoSefaz := False;
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.SEFAZ FROM PESSOA P ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa)');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    FbFiscalizacaoSefaz := IntToBoolean(loQryPessoa.FieldByName('SEFAZ').AsInteger);
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getFiscalizacaoSefaz: Boolean;
begin
  Result := FbFiscalizacaoSefaz;
end;

//class function TUtil.getFormControleUsuarios: TFControleUsuarios;
//begin
//  Result := FoControleUsuarios;
//end;

{$REGION 'getFieldsTable: C�digo antigo...'}
{ TODO -oIvan -cCodigoAntigo : Lembrar de retirar o c�digo antigo ap�s valida��o do c�digo novo. 26/07/2013 17:29:39}
(*
class procedure TUtil.getFieldsTable(psTable: string; var psHeadBackup: string;
      var psLineFields: string; var poStrLstFields: TStringList;
      var poStrLstTpFields: TStringList);
var
  loQryFields: TSQLQuery;
  lsField: string;
begin
  loQryFields := TSQLQuery.Create(nil);
  try
    loQryFields.SQLConnection := TUtil.getConn;
    loQryFields.SQL.Append('SELECT I.R_CAMPO,I.R_TIPO FROM SP_INFORMATION_FIELDS(:pTable) I');
    loQryFields.ParamByName('pTable').AsString := psTable;
    loQryFields.Open;

    while not loQryFields.Eof do begin
      lsField := trim(loQryFields.FieldByName('R_CAMPO').AsString);
      if Pos(lsField,'FOTO*LOGO') = 0 then begin
        loQryFields.Next;
        Continue;
      end;
      psHeadBackup := psHeadBackup+lsField+'|';
      psLineFields := psLineFields+lsField;
      poStrLstFields.Append(lsField);
      poStrLstTpFields.Append(trim(loQryFields.FieldByName('R_TIPO').AsString));
      loQryFields.Next;
      if not loQryFields.Eof then begin
        psLineFields := psLineFields+',';
      end;
    end;
    if copy(psLineFields,length(psLineFields),1) = ',' then begin
      psLineFields := copy(psLineFields,1,length(psLineFields)-1);
    end;
  finally
    FreeAndNil(loQryFields);
  end;
end;
*)
{$ENDREGION}


class function TUtil.getEmail(psIdPessoa: String): String;
var
  loQryEmail: TFDQuery;
begin
  Result := '';
  loQryEmail := TFDQuery.Create(nil);
  try
    loQryEmail.Connection := TUtilConexaoFireDac.getConn;
    loQryEmail.SQL.Append('SELECT FIRST 1 E.ENDERECO FROM EMAIL E WHERE (E.FK_PESSOA = :pIdPessoa) ORDER BY E.PRINCIPAL');
    loQryEmail.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryEmail.Open;
    Result := loQryEmail.FieldByName('ENDERECO').AsString;
  finally
    FreeAndNil(loQryEmail);
  end;
end;

class function TUtil.getEnderecoPessoa(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT TL.SIGLA AS TP_LOGRADOURO,P.LOGRADOURO,P.NUMERO,P.BAIRRO,');
    loQryPessoa.SQL.Append('P.COMPLEMENTO,C.DESCRICAO AS CIDADE,E.SIGLA AS ESTADO FROM PESSOA P ');
    loQryPessoa.SQL.Append('LEFT JOIN TP_LOGRADOUROS TL ON (P.FK_TP_LOGRADOURO = TL.ID_TP_LOGRADOUROS) ');
    loQryPessoa.SQL.Append('LEFT JOIN CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES) ');
    loQryPessoa.SQL.Append('LEFT JOIN ESTADOS E ON (C.FK_ESTADO = E.ID_ESTADOS) ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      Result := trim(loQryPessoa.FieldByName('TP_LOGRADOURO').AsString);
      if trim(loQryPessoa.FieldByName('LOGRADOURO').AsString) <> '' then begin
        Result := Result+' '+trim(loQryPessoa.FieldByName('LOGRADOURO').AsString);
      end;
      if trim(loQryPessoa.FieldByName('NUMERO').AsString) <> '' then begin
        Result := Result+', '+trim(loQryPessoa.FieldByName('NUMERO').AsString);
      end;
      if trim(loQryPessoa.FieldByName('BAIRRO').AsString) <> '' then begin
        Result := Result+', '+trim(loQryPessoa.FieldByName('BAIRRO').AsString);
      end;
      if trim(loQryPessoa.FieldByName('COMPLEMENTO').AsString) <> '' then begin
        Result := Result+', '+trim(loQryPessoa.FieldByName('COMPLEMENTO').AsString);
      end;
      Result := Result+', '+trim(loQryPessoa.FieldByName('CIDADE').AsString);
      Result := Result+', '+trim(loQryPessoa.FieldByName('ESTADO').AsString);
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getCepPessoa(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT P.CEP FROM PESSOA P ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      Result := trim(loQryPessoa.FieldByName('CEP').AsString);
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getIdCidadePessoa(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT C.ID_CIDADES AS ID_CIDADE FROM PESSOA P ');
    loQryPessoa.SQL.Append('LEFT JOIN CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES) ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      Result := trim(loQryPessoa.FieldByName('ID_CIDADE').AsString);
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getCidadePessoa(psIdPessoa: String): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    loQryPessoa.SQL.Append('SELECT C.DESCRICAO AS CIDADE FROM PESSOA P ');
    loQryPessoa.SQL.Append('LEFT JOIN CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES) ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      Result := trim(loQryPessoa.FieldByName('CIDADE').AsString);
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

class function TUtil.getCNAE(psIdPessoa: String; pdData: TDate): String;
var
  loQryVerifica: TSQLQuery;
begin
  Result := '';
  loQryVerifica := TSQLQuery.Create(nil);
  try
    loQryVerifica.SQLConnection := FoConn;
    loQryVerifica.SQL.Add('SELECT C.CODIGO FROM PESSOA_CNAE PC LEFT JOIN CNAE C ON (PC.FK_CNAE = C.ID_CNAE) ');
    loQryVerifica.SQL.Add('WHERE (PC.FK_PESSOA = :pIdPessoa) AND (PC.DATA <= :pData) ORDER BY PC.DATA DESC ');
    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryVerifica.ParamByName('pData'    ).AsDate   := pdData;
    loQryVerifica.Open;
    Result := Trim(loQryVerifica.FieldByName('CODIGO').AsString);
  finally
    FreeAndNil(loQryVerifica);
  end;
end;

class function TUtil.getIdCNAE(psIdPessoa: String; pdData: TDate): String;
var
  loQryVerifica: TSQLQuery;
begin
  Result := '';
  loQryVerifica := TSQLQuery.Create(nil);
  try
    loQryVerifica.SQLConnection := FoConn;
    loQryVerifica.SQL.Add('SELECT C.ID_CNAE FROM PESSOA_CNAE PC LEFT JOIN CNAE C ON (PC.FK_CNAE = C.ID_CNAE) ');
    loQryVerifica.SQL.Add('WHERE (PC.FK_PESSOA = :pIdPessoa) AND (PC.DATA <= :pData) ORDER BY PC.DATA DESC ');
    loQryVerifica.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryVerifica.ParamByName('pData'    ).AsDate   := pdData;
    loQryVerifica.Open;
    Result := loQryVerifica.FieldByName('ID_CNAE').AsString;
  finally
    FreeAndNil(loQryVerifica);
  end;
end;

class function TUtil.getEstadoPessoa(psIdPessoa: String; pbExtenso: Boolean): String;
var
  loQryPessoa: TSQLQuery;
begin
  Result := '';
  loQryPessoa := TSQLQuery.Create(nil);
  try
    loQryPessoa.SQLConnection := getConn;
    if pbExtenso then begin
      loQryPessoa.SQL.Append('SELECT E.DESCRICAO FROM PESSOA P ');
    end else begin
      loQryPessoa.SQL.Append('SELECT E.SIGLA FROM PESSOA P ');
    end;
    loQryPessoa.SQL.Append('LEFT JOIN CIDADES C ON (P.FK_CIDADE = C.ID_CIDADES) ');
    loQryPessoa.SQL.Append('JOIN ESTADOS E ON (C.FK_ESTADO = E.ID_ESTADOS) ');
    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
    loQryPessoa.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryPessoa.Open;
    if not loQryPessoa.Eof then begin
      if pbExtenso then begin
        Result := trim(loQryPessoa.FieldByName('DESCRICAO').AsString);
      end else begin
        Result := trim(loQryPessoa.FieldByName('SIGLA'    ).AsString);
      end;
    end;
  finally
    FreeAndNil(loQryPessoa);
  end;
end;

{ TODO -oROBERTO -cURGENTE :
Colocar para chamar esse m�todo no onClose, antes do inherited, de todos os forms
que tiverem a RxDbLookupCombo. }
class procedure TUtil.cbxCloseUp(poTForm: TForm);
var
  liFor: Integer;
begin
  for liFor := 0 to poTForm.ComponentCount-1 do begin
    if (poTForm.Components[liFor] is TRxDBLookupCombo) then begin
      TRxDBLookupCombo(poTForm.Components[liFor]).CloseUp(True);
    end;
  end;
end;

class function TUtil.getPathDiretorio(psTitulo, psDiretorioRaiz: string): string;
var
  lsDiretorio: string;
begin
  if (Trim(psDiretorioRaiz) = '') then begin
     psDiretorioRaiz := {$IFDEF MSWINDOWS} '\'; {$ELSE} '/'; {$ENDIF}
  end;
  SelectDirectory(psTitulo,psDiretorioRaiz,lsDiretorio);
  Result := lsDiretorio;
end;

class function TUtil.getQualificacaoSPEDSocio(psIdSocio: String): Integer;
var
  loQryQualificacaoSocio: TFDQuery;
begin
  Result := 2; {Administrador}
  loQryQualificacaoSocio := TFDQuery.Create(nil);
  try
    loQryQualificacaoSocio.Connection := TUtilConexaoFireDac.getConn;
    loQryQualificacaoSocio.SQL.Append('SELECT S.QUALIFICACAO FROM SOCIOS S WHERE (S.ID_SOCIOS = :pIdSocio)');
    loQryQualificacaoSocio.ParamByName('pIdSocio').AsString := psIdSocio;
    loQryQualificacaoSocio.Open;
    Result := loQryQualificacaoSocio.FieldByName('QUALIFICACAO').AsInteger;
  finally
    FreeAndNil(loQryQualificacaoSocio);
  end;
end;

//class function TUtil.getStrCodigoPessoa: String;
//var
//  loQryPessoa: TSQLQuery;
//begin
//  Result := '';
//  loQryPessoa := TSQLQuery.Create(nil);
//  try
//    loQryPessoa.SQLConnection := getConn;
//    loQryPessoa.SQL.Append('SELECT P.CODIGO FROM PESSOA P ');
//    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
//    loQryPessoa.ParamByName('pIdPessoa').AsString := TUtil.getIDPessoa;
//    loQryPessoa.Open;
//    Result := StrZero(loQryPessoa.FieldByName('CODIGO').AsInteger,CODIGO_PESSOA_MIN_LEN,0);
//  finally
//    FreeAndNil(loQryPessoa);
//  end;
//end;

{ Padroniza tamanho de uma imagem conforme a Largura e Altura informados }
class function TUtil.RedimensionaImagem(poImagem: TGraphic;
  poLargura, poAltura: Integer; Tipo: TGraphicClass): TGraphic;
var
  poBitmap: Vcl.Graphics.TBitmap;
begin
  poBitmap := Vcl.Graphics.TBitmap.Create;

  try
    poBitmap.Width := poLargura;
    poBitmap.Height := poAltura;
    poBitmap.Canvas.StretchDraw(Rect(0, 0, poLargura, poAltura), poImagem);
    if (Tipo = nil) then begin
      Result := TGraphic(poImagem.ClassType.Create)
    end else begin
      Result := Tipo.Create;
    end;
    Result.Assign ( poBitmap ) ;
  finally
    poBitmap.Free;
  end;
end;

class function TUtil.RecordImage(pimgImage: TImage; psFieldImagem: string;
  pTable: TDataSet; pStrLstCampos: TStringList; pbFireDac: Boolean): Boolean;
var
  lmsImage: TMemoryStream;
  liFor: Integer;
begin
  Result := True;
  try
    lmsImage := TMemoryStream.Create;

    if pimgImage.Picture.Graphic <> nil then begin
      if TClientDataSet(pTable).IsEmpty then begin
        {Se a tabela est� vazia, chama o insert}
        TClientDataSet(pTable).Insert;
      end else begin
        {Se a tabela n�o est� vazia, chama o edit}
        TClientDataSet(pTable).Edit;
      end;
      for liFor := 0 to pStrLstCampos.Count-1 do begin
        {Faz um loop no StrLst dos campos}
        if (TClientDataSet(pTable).State = dsInsert) and (UpperCase(Copy(Trim(pStrLstCampos.Names[liFor]),1,3)) = 'ID_') then begin
          {Se a tabela est� em modo de inser��o e o nome do campo come�a com
          ID_, atribui a ele o CreateClassID}
          TClientDataSet(pTable).FieldByName(trim(pStrLstCampos.Names[liFor])).AsString := CreateClassID;
        end else if UpperCase(trim(pStrLstCampos.Names[liFor])) = UpperCase(Trim(psFieldImagem)) then begin
          {Caso seja o campo da imagem, atribui a imagem}
          pimgImage.Picture.Graphic.SaveToStream(lmsImage);
          lmsImage.Position:=0;
          TBlobField(TClientDataSet(pTable).FieldByName(psFieldImagem)).LoadFromStream(lmsImage);
        end else begin
          {Caso seja qualquer outro campo, atribui a ele o respectivo cont�udo,
          passado como par�metro atrav�s da vari�vel pStrLst}
          TClientDataSet(pTable).FieldByName(trim(pStrLstCampos.Names[liFor])).AsString := pStrLstCampos.ValueFromIndex[liFor];
        end;
      end;
    end else if (not TClientDataSet(pTable).IsEmpty) then begin
      {Se a tabela n�o est� vazia, chama o edit}
//      TClientDataSet(pTable).Edit;
      {Se a imagem passada est� vazia e a tabela n�o est� vazia, limpa o campo
      imagem}
//      TBlobField(TClientDataSet(pTable).FieldByName(psFieldImagem)).Clear;
//      {Se a imagem passada est� vazia e a tabela n�o est� vazia, exclui o
//      registro}
      try
        TClientDataSet(pTable).Delete;
        if (not pbFireDac)
          and (TClientDataSet(pTable).ApplyUpdates(0) <> 0)
        then begin
          Result := False;
        end;
      except
        Result := False;
      end;
    end;
    if (TClientDataSet(pTable).State = dsInsert) or (TClientDataSet(pTable).State = dsEdit) then begin
      {Se a tabela est� em modo de inser��o ou edi��o, chama o Post e o
      ApplayUpdates}
      try
        TClientDataSet(pTable).Post;
        if (not pbFireDac)
          and (TClientDataSet(pTable).ApplyUpdates(0) <> 0)
        then begin
          Result := False;
        end;
      except
        Result := False;
      end;
    end;
  finally
    FreeAndNil(lmsImage);
  end;
end;

////class procedure TUtil.LoadImage(pimgImage: TImage; psField: string;
////  pTable: TDataSet);
////var
////  lmsImage: TMemoryStream;
////  lJpgImage: TJPEGImage;
////begin
////  if not(pTable.IsEmpty) then begin
////    try
////      lmsImage  := TMemoryStream.Create;
////      lJpgImage := TJPEGImage.Create;
////
////      TBlobField(pTable.FieldByName(psField)).SaveToStream(lmsImage);
////
////      lmsImage.Position:=0;
////
////      if TBlobField(pTable.FieldByName(psField)).BlobSize > 0 then begin
////        lJpgImage.LoadFromStream(lmsImage);
////        pimgImage.Picture.Graphic := lJpgImage;
////      end else begin
////        pimgImage.Picture.Graphic := nil;
////      end;
////    finally
////      FreeAndNil(lmsImage);
////      FreeAndNil(lJpgImage);
////    end;
////  end else begin
////    pimgImage.Picture.Graphic := nil;
////  end;
////end;
//
//class procedure TUtil.LoadImage(pimgImage: TRlImage; psField: string;
//  pTable: TDataSet);
//var
//  lmsImage: TMemoryStream;
//  lJpgImage: TJPEGImage;
//begin
//  if not(pTable.IsEmpty) then begin
//    try
//      lmsImage  := TMemoryStream.Create;
//      lJpgImage := TJPEGImage.Create;
//
//      TBlobField(pTable.FieldByName(psField)).SaveToStream(lmsImage);
//
//      lmsImage.Position:=0;
//
//      if TBlobField(pTable.FieldByName(psField)).BlobSize > 0 then begin
//        lJpgImage.LoadFromStream(lmsImage);
//        pimgImage.Picture.Graphic := lJpgImage;
//      end;
//    finally
//      FreeAndNil(lmsImage);
//      FreeAndNil(lJpgImage);
//    end;
//  end;
//end;

//class function TUtil.getTTipoInscMfPessoa(pIdPessoa: String): TTipoInscMf;
//var
//  loQryPessoa: TSQLQuery;
//  oCheckInscMf : TCheckDoc;
//begin
//  loQryPessoa := TSQLQuery.Create(nil);
//  oCheckInscMf := TCheckDoc.Create(nil);
//  try
//    loQryPessoa.SQLConnection := getConn;
//    loQryPessoa.SQL.Append('SELECT P.INSCMF FROM PESSOA P ');
//    loQryPessoa.SQL.Append('WHERE (P.ID_PESSOA = :pIdPessoa) ');
//    loQryPessoa.ParamByName('pIdPessoa').AsString := pIdPessoa;
//    loQryPessoa.Open;
//
//    oCheckInscMf.Mode := moAutoDetect;
//    oCheckInscMf.ModeResult := moAutoDetect;
//    oCheckInscMf.Input := loQryPessoa.FieldByName('INSCMF').AsString;
//    if oCheckInscMf.ModeResult = moCPF then begin
//      Result := TTipoInscMf.tp_cpf;
//    end else if oCheckInscMf.ModeResult = moCGC then begin
//      Result := TTipoInscMf.tp_cnpj;
//    end else begin
//      Result := TTipoInscMf.tp_cei;
//    end;
//  finally
//    FreeAndNil(loQryPessoa);
//  end;
//end;

class function TUtil.getTipoRegime(psIdPessoa: String; pdData: TDate;
  pOpRegime: TTipoRegimeTributario): Integer;
var
  loQryRegime: TSQLQuery;
  lsTabela,lsCampo: string;
begin
  loQryRegime := TSQLQuery.Create(nil);
  try
    lsCampo  := 'R.TIPO';
    if pOpRegime = opMunicipal then begin
      lsTabela := 'REGIME_MUNICIPAL';
    end else if pOpRegime = opEstadual then begin
      lsTabela := 'REGIME_ESTADUAL';
    end else if pOpRegime = opFederal then begin
      lsTabela := 'REGIME_FEDERAL';
    end else if pOpRegime = opConstituicao then begin
      lsTabela := 'REGISTROS';
      lsCampo  := 'R.REGIME_CONSTITUICAO';
    end;
    loQryRegime.SQLConnection := getConn;
    loQryRegime.SQL.Append('SELECT FIRST 1 '+lsCampo+' AS TIPO FROM '+lsTabela+' R WHERE (R.FK_PESSOA = :pIdPessoa) AND (R.DATA <= :pData) ORDER BY R.DATA DESC');
    loQryRegime.ParamByName('pIdPessoa').AsString := psIdPessoa;
    if (pdData <> TP_DATA_EMPTY) then begin
      loQryRegime.ParamByName('pData'    ).AsDate := pdData;
    end else begin
      loQryRegime.ParamByName('pData'    ).AsDate := Date();
    end;
    loQryRegime.Open;
    Result := loQryRegime.FieldByName('TIPO').AsInteger;
  finally
    FreeAndNil(loQryRegime);
  end;
end;

class function TUtil.getTipoServicoPrestado(psIdPessoa: String; pdData: TDate): String;
var
  loQryTipoServicoPrestado: TSQLQuery;
  lsTipoServicoPrestado: String;
begin
  result := '';
  loQryTipoServicoPrestado := TSQLQuery.Create(nil);
  try
    loQryTipoServicoPrestado.SQLConnection := FoConn;
    loQryTipoServicoPrestado.SQL.Add('SELECT FIRST 1 PFP.TIPO_SERVICO_PRESTADO FROM PESSOA_FISCAL_PARAMETROS PFP WHERE (PFP.FK_PESSOA = :pIdPessoa) AND (PFP.DATA <= :pData) ORDER BY PFP.DATA DESC');
    loQryTipoServicoPrestado.ParamByName('pIdPessoa').AsString := psIdPessoa;
    loQryTipoServicoPrestado.ParamByName('pData'    ).AsDate   := pdData;
    loQryTipoServicoPrestado.Open;
    if (not loQryTipoServicoPrestado.IsEmpty) then begin
      case loQryTipoServicoPrestado.FieldByName('INSC_MUNICIPAL').AsInteger of
        0 : lsTipoServicoPrestado := 'SG';
        1 : lsTipoServicoPrestado := 'AD';
        2 : lsTipoServicoPrestado := 'ED';
        3 : lsTipoServicoPrestado := 'NP';
        4 : lsTipoServicoPrestado := 'SU';
        5 : lsTipoServicoPrestado := 'CC';
        6 : lsTipoServicoPrestado := 'PP';
      end;
      Result := lsTipoServicoPrestado;
    end;
  finally
    FreeAndNil(loQryTipoServicoPrestado);
  end;
end;
{$ENDREGION}

{ TUtilDate }

{$REGION 'TUtilDate: Implementa��o...}
class procedure TUtilDate.getInfoTrimestre(pdData: TDate; var piTrimestre: Integer; var pdInicioTrimestre, pdFimTrimestre: TDate);
var
  liAno, liMes, liDia: Word;
begin
  DecodeDate(pdData, liAno, liMes, liDia);
  piTrimestre       := ((liMes-1) div 3) + 1;
  pdInicioTrimestre := EncodeDate(liAno,((piTrimestre * 3)-2),1);
  pdFimTrimestre    := EndOfMonth(EncodeDate(liAno,(piTrimestre * 3),1));
end;

class procedure TUtilDate.getInfoTrimestre(piAno: Integer;
  piTrimestre: Integer; var pdInicioTrimestre, pdFimTrimestre: TDate);
var
  liMes, liDia: Word;
  ldData: TDate;
begin
  liDia := 1;
  liMes := piTrimestre*3;
  ldData := EncodeDate(piAno,liMes,liDia);
  TUtilDate.getInfoTrimestre(ldData,piTrimestre,pdInicioTrimestre,pdFimTrimestre);
end;

class procedure TUtilDate.getInfoTrimestre(pdData: TDate;
  var piTrimestre: Integer);
var
  liAno, liMes, liDia: Word;
begin
  DecodeDate(pdData, liAno, liMes, liDia);
  piTrimestre := ((liMes-1) div 3) + 1;
end;

class function TUtilDate.MyMonthsBetween(pdDataInicial, pdDataFinal: TDateTime;
  pbProporcional, pbMesCalendario: Boolean): Integer;
var
  liMeses, liCont : integer;
  liDias : Extended;
  lwDia, lwMes, lwAno : word;
  ldDataTeste, ldData, ldDataAnterior : TDateTime;
begin
  ldData := pdDataInicial;
  ldDataAnterior := pdDataInicial;
  liDias := 0;
  liCont := 0;
  liMeses := 0;
  DecodeDate(pdDataInicial,lwAno,lwMes,lwDia);
  if pbMesCalendario then begin
    ldDataAnterior := pdDataInicial;
    lwDia  := 1;
    lwMes  := month(pdDataInicial)+1;
    if month(pdDataInicial) = 12 then begin
      lwAno := lwAno+1;
      lwMes := 1;
    end;
    liCont := 1;
    if mesAno(pdDataFinal,false) = mesAno(pdDataInicial,false) then begin
      if (((pdDataFinal - pdDataInicial)+ 1) >= 15) and (pbProporcional) then begin
        inc(liMeses);
      end;
    end else if pdDataFinal > pdDataInicial then begin
      if ((EndOfMonth(pdDataInicial)- pdDataInicial)+1 >= 15) and (pbProporcional) then begin
        inc(liMeses);
      end;
    end;
    ldData := EncodeDate(lwAno,lwMes,lwDia);
    while EndOfMonth(ldData) < BeginOfMonth(pdDataFinal) do begin
      ldDataAnterior := ldData;
      inc(lwMes);
      if lwMes > 12 then begin
         lwMes := 1;
         inc(lwAno);
      end;
      if lwDia > day(EndOfMonth(EncodeDate(lwAno,lwMes,1))) then begin
        lwDia := day(EndOfMonth(EncodeDate(lwAno,lwMes,1)));
      end;
      ldData := EncodeDate(lwAno,lwMes,lwDia);
      if ldData <= pdDataFinal then begin
         inc(liMeses);
      end;
    end;
    if (pbProporcional) then begin
      liDias := (pdDataFinal-EndOfMonth(ldDataAnterior));
      if liDias >= 15 then begin
        inc(liMeses);
      end;
    end;
  end else begin
    liCont := 1;
    while ldData < pdDataFinal do begin
      ldDataAnterior := ldData;
      inc(lwMes);
      if lwMes > 12 then begin
         lwMes := 1;
         inc(lwAno);
      end;
      if lwDia > day(EndOfMonth(EncodeDate(lwAno,lwMes,1))) then begin
        lwDia := day(EndOfMonth(EncodeDate(lwAno,lwMes,1)));
      end;
      ldData := EncodeDate(lwAno,lwMes,lwDia);
      if ((ldData-1) <= pdDataFinal) then begin
         inc(liMeses);
      end;
    end;

    if (pbProporcional) and ((ldData-1) > pdDataFinal) then begin
      liDias := (pdDataFinal - ldDataAnterior )+1;
      if (liDias >= 15) then begin
        inc(liMeses);
      end;
    end;
  end;
  Result := liMeses;
end;

{$ENDREGION}

{ TUtilDataSet }

{$REGION 'TUtilDataSet: Implementa��o...}
class procedure TUtilDataSet.ReOpenDataSet(poDataSet: TClientDataSet);
begin
  poDataSet.Close;
  poDataSet.Open;
end;

class procedure TUtilDataSet.ReOpenDataSet(poDataSet: TSQLQuery);
begin
  poDataSet.Close;
  poDataSet.Open;
end;

class function TUtilDataSet.getAggregateValue(var poDataSet: TClientDataSet;
  psCampo, psNomeCampoAgregacao: string; peOperacao: TTipoAgregacao): Currency;
var
  loAggregateField: TAggregateField;  { declarar o objeto Tfield }
  lsOperacao: string;
begin
  Result := 0;
  { Fechando o clientdataset }
  poDataSet.Close;
  case peOperacao of
    taQuantidade: lsOperacao := 'Count('+psCampo+')';
    taSoma      : lsOperacao := 'Sum('+psCampo+')';
    taMedia     : lsOperacao := 'Avg('+psCampo+')';
    taMinimo    : lsOperacao := 'Min('+psCampo+')';
    taMaximo    : lsOperacao := 'Max('+psCampo+')';
  end;
  {Criando um nome para o campo de agrega��o}
//  lsNomeCampo := Copy(lsOperacao,1,2) + '_'+ psCampo;
  { Verificando se o campo agregado j� existe}
  if (poDataSet.FindField(psNomeCampoAgregacao) = nil) then begin
    { Instanciando o Objeto Tfield }
    loAggregateField := TAggregateField.Create(poDataSet);
    { Configurando as propriedades desse Objeto }
    loAggregateField.FieldKind    := fkAggregate;
    loAggregateField.FieldName    := psNomeCampoAgregacao;
    loAggregateField.DataSet      := poDataSet;
    loAggregateField.DisplayLabel := psNomeCampoAgregacao;
    loAggregateField.Name         := poDataSet.Name + psNomeCampoAgregacao;
    loAggregateField.Expression   := lsOperacao;
    loAggregateField.Active       := True;
  end;
  poDataSet.AggregatesActive := True;
  { Abrindo o clientdataset j� contendo o novo TField }
  poDataSet.Open;
  TryStrToCurr(poDataSet.FieldByName(psNomeCampoAgregacao).AsString,Result);
end;

//class procedure TUtilDataSet.OnDataChange(poDataSource: TDataSource;
//  poClientDataSet: TClientDataSet;  var poRxDBLookupCombo: TRxDBLookupCombo;
//  psNomeCampoId: String);
//begin
//  poRxDBLookupCombo.KeyValue := poClientDataSet.FieldByName(psNomeCampoId).AsString;
//end;

class procedure TUtilDataSet.ReOpenDataSet(poDataSet: TFDQuery);
begin
  poDataSet.Close;
  poDataSet.Open;
end;

class procedure TUtilDataSet.cloneDataSet(poDataSetOrigem: TClientDataSet; var poDataSetDestino: TClientDataSet);
var
  loDataSet: TClientDataSet;
begin
  poDataSetDestino.Close;
  if (poDataSetOrigem.RecordCount > 0) then begin
    {Dataset tempor�rio criado para receber os registros do dataset de Origem}
    loDataSet := TClientDataSet.Create(nil);
    try
      {Copiando os registros do dataset de Origem para o dataset tempor�rio.}
      loDataSet.SetProvider(poDataSetOrigem);
      loDataSet.Open;

      {Copiando o dataset temporario para o dataset de destino}
      poDataSetDestino.CloneCursor(loDataSet,False,True);
    finally
      {Destruindo o dataset tempor�rio}
      FreeAndNil(loDataSet);
    end;
  end;
end;

class procedure TUtilDataSet.CriaCds(poFDQuery: TFDQuery;
  var poCdsNovo: TClientDataSet);
var
  liFor: Integer;
begin
  poCdsNovo.Close;
  poCdsNovo.Fields.Clear;
  poCdsNovo.FieldDefs.Clear;
  for liFor := 0 to poFDQuery.FieldCount-1 do begin
    poCdsNovo.FieldDefs.Add(poFDQuery.Fields[liFor].FieldName,
    poFDQuery.Fields[liFor].DataType,
    poFDQuery.Fields[liFor].Size,
    poFDQuery.Fields[liFor].Required);
  end;
  poCdsNovo.CreateDataSet;
end;

class procedure TUtilDataSet.CriaCds(poCdsOriginal: TClientDataSet; var poCdsNovo: TClientDataSet);
var
  liFor: Integer;
begin
  poCdsNovo.Close;
  poCdsNovo.Fields.Clear;
  poCdsNovo.FieldDefs.Clear;
  for liFor := 0 to poCdsOriginal.FieldCount-1 do begin
    poCdsNovo.FieldDefs.Add(poCdsOriginal.Fields[liFor].FieldName,
    poCdsOriginal.Fields[liFor].DataType,
    poCdsOriginal.Fields[liFor].Size,
    poCdsOriginal.Fields[liFor].Required);
  end;
  poCdsNovo.CreateDataSet;
end;

class procedure TUtilDataSet.adicionarRegistro(poDatasetOrigem: TSQLQuery;  var poDataSetDestino: TClientDataSet);
var
  liForColuna: Integer;
begin
  poDataSetOrigem.First;
  while not poDataSetOrigem.Eof do begin
    poDataSetDestino.Insert;
    for liForColuna := 0 to poDataSetOrigem.FieldCount-1 do begin
      poDataSetDestino.Fields[liForColuna].Value := poDataSetOrigem.Fields[liForColuna].Value;
    end;
    poDataSetDestino.Post;
    poDataSetOrigem.Next;
  end;
end;

class procedure TUtilDataSet.adicionarRegistro(poDatasetOrigem: TClientDataSet; var poDataSetDestino: TClientDataSet);
var
  liForColuna: Integer;
begin
  poDataSetOrigem.First;
  while not poDataSetOrigem.Eof do begin
    poDataSetDestino.Insert;
    for liForColuna := 0 to poDataSetOrigem.FieldCount-1 do begin
      poDataSetDestino.Fields[liForColuna].Value := poDataSetOrigem.Fields[liForColuna].Value;
    end;
    poDataSetDestino.Post;
    poDataSetOrigem.Next;
  end;
end;

class procedure TUtilDataSet.clearSettings(var poDataSet: TClientDataSet;
  bLimpaTudo, bLimpaCampos, bLimpaFiltro, bLimpaIndice, bLimpaCampoAgregacao,
  bLimpaProvider: Boolean);
begin
  if bLimpaTudo then begin
    bLimpaCampos := True;
    bLimpaFiltro := True;
    bLimpaIndice := True;
    bLimpaCampoAgregacao := True;
    bLimpaProvider := True;
  end;
  if bLimpaCampos then begin
    poDataSet.FieldDefs.Clear;
    poDataSet.Fields.Clear;
  end;
  if bLimpaFiltro then begin
    poDataSet.Filtered := False;
    poDataSet.Filter := '';
  end;
  if bLimpaIndice then begin
    poDataSet.IndexFieldNames := '';
    poDataSet.IndexDefs.Clear;
    poDataSet.IndexName := '';
  end;
  if bLimpaCampoAgregacao then begin
    poDataSet.AggregatesActive := False;
    poDataSet.AggFields.Clear;
    poDataSet.Aggregates.Clear;
  end;
  if bLimpaProvider then begin
    poDataSet.ProviderName := '';
  end;
end;
{$ENDREGION}

{ TUtilConvert }

{$REGION 'TUtilConvert: Implementa��o...'}
class function TUtilConvert.BooleanToChar(pbBoolean: Boolean): Char;
begin
  if pbBoolean then begin
    Result := 'S';
  end else begin
    Result := 'N';
  end;
end;

class function TUtilConvert.BooleanToInt(pbBoolean: Boolean): Integer;
begin
  if pbBoolean then begin
    Result := -1;
  end else begin
    Result := 0;
  end;
end;

class function TUtilConvert.CurrToStr(pdblValor: Currency; piTamanho,piDecimais: Integer;
  pbSeparadorDecimal: Boolean; pbZerosEsquerda: Boolean = true): String;
var
  liPos,liParteInteira,liParteDecimal,liFor,liTamanho: Integer;
  lsValor,lsParteInteira,lsParteDecimal,lsDecimalSeparador: string;
begin
  Result := '';
  lsParteInteira := '';
  lsParteDecimal := '';

  if pbSeparadorDecimal then begin
    lsDecimalSeparador := FormatSettings.DecimalSeparator;
    liTamanho := piTamanho;
  end else begin
    lsDecimalSeparador := '';
    liTamanho := piTamanho+1;
  end;

  lsValor := strzero(pdblValor,liTamanho,piDecimais);
  lsValor := StrSubst(lsValor,'.',',',0);
  liPos   := Pos(',',lsValor);

  if liPos <> 0 then begin
    lsParteInteira := copy(lsValor,1,liPos-1);
    if piDecimais > 0 then begin
      lsParteDecimal := Copy(lsValor,liPos+1,piDecimais);
      while Length(lsParteDecimal) < piDecimais do begin
        lsParteDecimal := lsParteDecimal+'0';
      end;
    end;
  end else begin
    lsParteInteira := lsValor;
    if piDecimais > 0 then begin
      while Length(lsParteDecimal) < piDecimais do begin
        lsParteDecimal := lsParteDecimal+'0';
      end;
    end;
  end;

  Result := lsParteInteira+lsDecimalSeparador+lsParteDecimal;

  if (not pbZerosEsquerda) then begin
    {Retira os zeros a esquerda}
    while (Copy(Result,1,1) = '0') do begin
      Result := StrSubst(Result,'0','',1);
    end;
  end;
end;

class function TUtilConvert.IntToBoolean(piInteger: Integer): Boolean;
begin
  if piInteger = 0 then begin
    Result := false;
  end else begin
    Result := true;
  end;
end;

class function TUtilConvert.SoLetras(psString: string;
  pbMantemEspaco: Boolean): string;
begin
  {$REGION 'Explicando o Regex (Nota...)'}
  {*------------------------------------------------------------------------------
    O COMANDO TRegEx.Replace(psString, '[^A-Za-z�-�\s]',''):
    Comando para trocar todos os caracteres que n�o sejam letras ou espa�o em branco por '' (nada).
    O REGEX [^A-Za-z�-�\s]:
    [] Lista/Conjunto
    ^ Simbolo para negar o conte�do do conjunto/lista
    A-Z Todas as letras mai�sculas de A � Z
    a-z Todas as letras min�sculas de a � z
    �-� Todos os caracteres acentuados
    \s Espa�os em bran�o, tabula��es
  -------------------------------------------------------------------------------}
  {$ENDREGION}
  if pbMantemEspaco then begin
    Result := TRegEx.Replace(psString, '[^A-Za-z�-�\s]','');
  end else begin
    Result := TRegEx.Replace(psString, '[^A-Za-z�-�]','');
  end;
end;

class function TUtilConvert.SoNumeros(psString: string): String;
begin
 {TRegEx precisa da declara��o em uses de
  System.RegularExpressions}
  Result := TRegEx.Replace(psString, '\D','');
end;

class function TUtilConvert.StrToCurrency(psValor: string; pdblValorPadrao: Currency = 0): Currency;
begin
  Result  := pdblValorPadrao;
  psValor := StringReplace(psValor, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
  psValor := StringReplace(psValor, FormatSettings.CurrencyString   , '', [rfReplaceAll]);
  TryStrToCurr(psValor,Result);
end;

{$ENDREGION}

{ TUtilSO }

{$REGION 'TUtilSO: Implementa��o...'}
class function TUtilSO.getNomeComputador: string;
var
  Name: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: DWord;
begin
  Result := '';
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  if GetComputerName(Name, Size) then begin
    Result := Name;
  end;
end;

class function TUtilSO.getNumeroIP: string;
var
  loWSAData: TWSAData;
  loHostEnt: PHostEnt;
  lsName :string;
begin
  WSAStartup(2, loWSAData);
  SetLength(lsName, 255);
  Gethostname(PAnsiChar(lsName), 255);
  SetLength(lsName, StrLen(PChar(lsName)));
  loHostEnt := gethostbyname(PAnsiChar(lsName));
  with loHostEnt^ do begin
    Result := Format('%d.%d.%d.%d',
    [Byte(h_addr^[0]),Byte(h_addr^[1]),
    Byte(h_addr^[2]),Byte(h_addr^[3])]);
  end;
  WSACleanup;
end;
class function TUtilSO.getMacAddress: string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;
begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then begin
    @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then begin
      if (Func(@GUID1) = 0) and
         (Func(@GUID2) = 0) and
         (GUID1.D4[2] = GUID2.D4[2]) and
         (GUID1.D4[3] = GUID2.D4[3]) and
         (GUID1.D4[4] = GUID2.D4[4]) and
         (GUID1.D4[5] = GUID2.D4[5]) and
         (GUID1.D4[6] = GUID2.D4[6]) and
         (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result :=
          IntToHex(GUID1.D4[2], 2) + '-' +
          IntToHex(GUID1.D4[3], 2) + '-' +
          IntToHex(GUID1.D4[4], 2) + '-' +
          IntToHex(GUID1.D4[5], 2) + '-' +
          IntToHex(GUID1.D4[6], 2) + '-' +
          IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;
{$ENDREGION}


{ TUtilConexaoFireDac }

class procedure TUtilConexaoFireDac.Commit(poConn: TFDConnection);
begin
  if poConn.InTransaction then
    poConn.Commit;
end;

class function TUtilConexaoFireDac.getConn: TFDConnection;
begin
  Result := FoFDConn;
end;

class function TUtilConexaoFireDac.getConnControleUsuarios: TFDConnection;
begin
  Result := FoFDConnControleUsuarios;
end;

class function TUtilConexaoFireDac.getConnUniDirecional: TFDConnection;
begin
  Result := FoFDConnUniDirecional;
end;

class procedure TUtilConexaoFireDac.RollBack(poConn: TFDConnection);
begin
  if poConn.InTransaction then
    poConn.Rollback;
end;

class procedure TUtilConexaoFireDac.setConn(poConn: TFDConnection);
begin
  FoFDConn := poConn;
end;

class procedure TUtilConexaoFireDac.setConnControleUsuarios(
  poConn: TFDConnection);
begin
  FoFDConnControleUsuarios := poConn;
end;

class procedure TUtilConexaoFireDac.setConnUniDirecional(poConn: TFDConnection);
begin
  FoFDConnUniDirecional := poConn;
end;

class procedure TUtilConexaoFireDac.StartTransaction(poConn: TFDConnection);
begin
  if not poConn.InTransaction then
    poConn.StartTransaction;
end;

{ TUtilMath }

class function TUtilMath.getInvertSinal(pdblValor: Currency): Currency;
begin
  Result := pdblValor*(-1);
end;

class function TUtilMath.IncDecAnos(pdData: TDateTime;
  piAnos: integer): TDateTime;
var
  lwDia, lwMes, lwAno: Word;
begin
  decodeDate(pdData,lwAno,lwMes,lwDia);
  lwAno := lwAno+piAnos;
  if (DateStr(pdData,dtsDM) = '2902') and (not IsLeapYear(lwAno)) then begin
    {Se o dia/m�s de pdData � 29/02 e o ano depois de incrementado por piAnos
    n�o � bissexto, diminui um dia de wDia para ficar 28/02/}
    Dec(lwDia);
  end;
  Result := EncodeDate(lwAno,lwMes,lwDia);
end;

class function TUtilMath.IncDecMes(pdData: TDateTime;
  piMeses: Integer): TDateTime;
var
  lwDia, lwMes, lwAno: Word;
  liFor, liUltimoDia : integer;
  lsData: String;
begin
  Result := pdData;

  decodeDate(pdData,lwAno,lwMes,lwDia);
//  lwDia := Day(pdData);
//  lwMes := Month(pdData);
//  lwAno := Year(pdData);
  if piMeses > 0 Then begin
    for liFor := 1 to piMeses do begin
      inc(lwMes);
      if lwMes = 13 then begin
         lwMes := 1;
         inc(lwAno);
      end;
    end;
  end else begin
    for liFor := abs(piMeses) downto 1 do begin
      dec(lwMes);
      if lwMes = 0 then begin
         lwMes := 12;
         dec(lwAno);
      end;
    end;
  end;
  liUltimoDia := DaysInMonth(lwMes,lwAno);
  if lwDia > liUltimoDia then begin
    lwDia := liUltimoDia;
  end;

//  try
//    Result := StrToDateTime(StrZero(lwDia,2,0)+'/'+StrZero(lwMes,2,0)+'/'+StrZero(lwAno,4,0));
//  except
//    Result := 0;
//  end;
//  lsData := StrZero(lwDia,2,0)+'/'+StrZero(lwMes,2,0)+'/'+StrZero(lwAno,4,0);
//  Result := 0;
//  TryStrToDateTime(lsData,Result);
  Result := EncodeDate(lwAno,lwMes,lwDia);
end;

class function TUtilMath.IncValue(var value: Integer; piIncremento: Integer): Integer;
begin
  inc(value,piIncremento);
  Result := value;
end;

class function TUtilMath.MD5Arquivo(const psNomeArquivo: string): string;
var
  loMD5: TIdHashMessageDigest5;
  loArquivo: TFileStream;
begin
  loMD5     := TIdHashMessageDigest5.Create;
  loArquivo := TFileStream.Create(psNomeArquivo, fmOpenRead OR fmShareDenyWrite);
  try
    Result := loMD5.HashStreamAsHex(loArquivo);
  finally
    loArquivo.Free;
    loMD5.Free;
  end;
end;

class function TUtilMath.MD5String(const psString: string): string;
var
  lIdmd5 : TIdHashMessageDigest5;
begin
  lIdmd5 := TIdHashMessageDigest5.Create;
  try
    result := lIdmd5.HashStringAsHex(psString);
  finally
    lIdmd5.Free;
  end;
end;

{ TEnumAttribute }

//constructor TEnumAttribute.Create(ANomeEnum, ANomeReduzido, ANomeCompleto: String);
//begin
//  Self.FNomeEnum     := ANomeEnum;
//  Self.FNomeReduzido := ANomeReduzido;
//  Self.FNomeCompleto := ANomeCompleto;
//end;

{ TConvert<T> }

//class function TUtilEnumerator<T>.GetAtributoEnum(const eEnum: T; const peAtributo: TAtributoEnum): string;
//var
//  PEnum         :PInteger;
//  liPosicao     :integer;
//  loRttiContext :TRttiContext;
//  loRttiType    :TRttiType;
//  loItem        :TCustomAttribute;
//begin
//  Result        := 'Tipo n�o encontrado';
//  loRttiContext := TRttiContext.Create;
//  try
//    loRttiType := loRttiContext.GetType(TypeInfo(T));
//    if Assigned(loRttiType) then begin
//      if (Length(loRttiType.GetAttributes) > 0) then begin
//        PEnum     := @eEnum;
//        liPosicao := integer(TGenericoEnum((PEnum^)));
//        loItem    := loRttiType.GetAttributes[liPosicao];
//        if (loItem is TEnumAttribute) then begin
//          case peAtributo of
//            taNomeReduzido: Result := TEnumAttribute(loItem).NomeReduzido;
//            taNomeCompleto: Result := TEnumAttribute(loItem).NomeCompleto;
//          end;
//        end;
//      end;
//    end;
//  finally
//    loRttiContext.Free;
//  end;
//end;
//
//class function TUtilEnumerator<T>.GetAtributosEnum(const peAtributo: TAtributoEnum): TStringList;
//var
//  loRttiContext :TRttiContext;
//  loRttiType    :TRttiType;
//  loItem        :TCustomAttribute;
//begin
//  Result        := TStringList.Create;
//  loRttiContext := TRttiContext.Create;
//  try
//    loRttiType := loRttiContext.GetType(TypeInfo(T));
//    if Assigned(loRttiType) then begin
//      for loItem in loRttiType.GetAttributes do begin
//        if (loItem is TEnumAttribute) then begin
//          case peAtributo of
//            taNomeReduzido: Result.Add(TEnumAttribute(loItem).NomeReduzido);
//            taNomeCompleto: Result.Add(TEnumAttribute(loItem).NomeCompleto);
//          end;
//        end;
//      end;
//    end;
//  finally
//    loRttiContext.Free;
//  end;
//end;
//
//class function TUtilEnumerator<T>.GetEnum(const peAtributo: TAtributoEnum; psDescricao: String): T;
//var
//  loRttiContext :TRttiContext;
//  loRttiType    :TRttiType;
//  loItem        :TCustomAttribute;
//  lbEncontrou   :Boolean;
//begin
//  lbEncontrou := False;
//  loRttiContext := TRttiContext.Create;
//  try
//    loRttiType := loRttiContext.GetType(TypeInfo(T));
//    if Assigned(loRttiType) then begin
//      for loItem in loRttiType.GetAttributes do begin
//        if (loItem is TEnumAttribute) then begin
//          case peAtributo of
//            taNomeReduzido: begin
//              if (CompareText(psDescricao,TEnumAttribute(loItem).NomeReduzido) = 0) then begin
//                Result := StrToEnum(TEnumAttribute(loItem).NomeEnum);
//                lbEncontrou := True;
//                Break;
//              end;
//            end;
//            taNomeCompleto: begin
//              if (CompareText(psDescricao,TEnumAttribute(loItem).NomeCompleto) = 0) then begin
//                Result := StrToEnum(TEnumAttribute(loItem).NomeEnum);
//                lbEncontrou := True;
//                Break;
//              end;
//            end;
//          end;
//        end;
//      end;
//    end;
//  finally
//    loRttiContext.Free;
//    if not(lbEncontrou) then begin
//      raise Exception.Create('Enumerador n�o contrado!');
//    end;
//  end;
//end;
//
//class function TUtilEnumerator<T>.StrToEnum(peEnumName: string): T;
//var
//  P: ^T;
//  liPosicao: Integer;
//begin
//  try
//    liPosicao := GetEnumValue(TypeInfo(T),peEnumName);
//    if (liPosicao = -1) then begin
//      abort;
//    end;
//    P := @liPosicao;
//    Result := P^;
//  except
//    raise EConvertError.Create('O Par�metro "'+peEnumName+'" passado n�o '+sLineBreak+' corresponde a um Tipo Enumerado');
//  end;
//end;
//
//class function TUtilEnumerator<T>.EnumToStr(const eEnum: T): String;
//var
//  P :PInteger;
//  liPosicao :integer;
//begin
//  try
//    P := @eEnum;
//    liPosicao := integer(TGenericoEnum((P^)));
//    Result := GetEnumName(TypeInfo(T),liPosicao);
//  except
//    raise EConvertError.Create('Erro ao tentar recuperar o nome do Enum!');
//  end;
//end;

{ TUtilControleUsuarios }

class function TUtilControleUsuarios.getIdUser(psLogin: String): String;
var
  loQry: TFDQuery;
begin
  Result := '';
  loQry := TFDQuery.Create(nil);
  try
    loQry.Connection := TUtilConexaoFireDac.getConnControleUsuarios;
    loQry.SQL.Add('SELECT U.UCIDUSER FROM UCTABUSERS U WHERE (U.UCLOGIN = :pLogin)');
    loQry.ParamByName('pLogin').AsString := LowerCase(rInfoEmpresa.sNomeAbreviado);
    loQry.Open;
    Result := loQry.FieldByName('UCIDUSER').AsString;
  finally
    FreeAndNil(loQry);
  end;
end;

class function TUtilControleUsuarios.getLoginUser(psIdUser: String): String;
var
  loQry: TFDQuery;
begin
  Result := '';
  loQry := TFDQuery.Create(nil);
  try
    loQry.Connection := TUtilConexaoFireDac.getConnControleUsuarios;
    loQry.SQL.Add('SELECT U.UCLOGIN FROM UCTABUSERS U WHERE (U.UCIDUSER = :pIdUser)');
    loQry.ParamByName('pIdUser').AsString := psIdUser;
    loQry.Open;
    Result := loQry.FieldByName('UCLOGIN').AsString;
  finally
    FreeAndNil(loQry);
  end;
end;

{ TUtilFormat }

class function TUtilFormat.FormataCEP(psNumero: string): string;
begin
  Result := fSoNumeros(psNumero);
  if (Result.Length <> 8) then begin
    Result := EmptyStr;
  end else begin
    Result := Format('%s.%s-%s',[Copy(Result,1,2),Copy(Result,3,3),Copy(Result,6,3)]);
  end;
end;

class function TUtilFormat.InscMfCMasc(psInscMf, psTipo: String): string;
begin
  psInscMf := fSoNumeros(psInscMf);
  if Trim(psTipo) = 'CNPJ' then begin
    psInscMf := StrZero(StrToInt64(psInscMf),TAMANHO_CNPJ_SEM_MASCARA,0);
    psInscMf := Copy(psInscMf,1,2) + '.' + Copy(psInscMf,3,3) + '.' + Copy(psInscMf,6,3) + '/' + Copy(psInscMf,9,4) + '-' + Copy(psInscMf,13,2);
  end else if Trim(psTipo) = 'CPF' then begin
    psInscMf := StrZero(StrToInt64(psInscMf),TAMANHO_CPF_SEM_MASCARA,0);
    psInscMf := Copy(psInscMf,1,3) + '.' + Copy(psInscMf,4,3) + '.' + Copy(psInscMf,7,3) + '-' + Copy(psInscMf,10,2);
  end else if Trim(psTipo) = 'CEI' then begin
    psInscMf := StrZero(StrToInt64(psInscMf),TAMANHO_CEI_SEM_MASCARA,0);
    psInscMf := Copy(psInscMf,1,2) + '.' + Copy(psInscMf,3,3) + '.' + Copy(psInscMf,6,2) + '.' + Copy(psInscMf,8,3) + '/' + Copy(psInscMf,11,2);
  end;
  Result := psInscMf;
end;

class function TUtilFormat.ValidCaracter(psString: String;
  pbEliminaBranco: Boolean): string;
var
   lsAcentos1, lsAcentos2 : String;
   liFor, liAux : Integer;
begin
  lsAcentos1 := '����� ����� ����� �� ������ ����� ����� ����� �� ������ �窺!@#$%^&*()_+-=[]\{}|:";<>?,./�';
  lsAcentos2 := 'AIOUE AIOUE AIOUE AO AIOUEN aioue aioue aioue ao aiouen Ccao                              ';
  for liFor := 1 to Length(psString) do begin
    liAux := Pos(psString[liFor], lsAcentos1);
    if (liAux > 0) then begin
      psString[liFor] := lsAcentos2[liAux];
    end;
  end;
  Result := psString;
  if pbEliminaBranco then begin
    Result := SubstText(psString,' ','');
  end;

  {Retira os caracteres de controle}
  Result := TRegEx.Replace(Result, '[[:cntrl:]]',''); {utiliza��o da classe POSIX [[:cntrl:]]}
end;

{ TUtilControleFormulario }

class procedure TUtilControleFormulario.setAjustarColunasDoGrid(const poGrid: TDBGrid);
var
  liForColuna, liLarguraTotal, liEspacoVazio, liQtdTotalColuna : Integer;
begin
  // Quantidade de colunas
  liQtdTotalColuna := poGrid.Columns.Count;

  // Largura total de todas as colunas antes de redimensionar
  liLarguraTotal := 0;
  for liForColuna := 0 to liQtdTotalColuna -1 do begin
    liLarguraTotal := liLarguraTotal + poGrid.Columns[liForColuna].Width;
  end;

  // Adiciona 1px para a linha de separador de coluna
  if (dgColLines in poGrid.Options) then begin
    liLarguraTotal := liLarguraTotal + poGrid.Columns.Count;
  end;

  // Adiciona a largura da coluna indicadora
  if (dgIndicator in poGrid.Options) then begin
    liLarguraTotal := liLarguraTotal + IndicatorWidth;
  end;

  //Largura do espa�o vazio no Grid
  liEspacoVazio := poGrid.ClientWidth - liLarguraTotal;

  // Calculo para destribuir o espa�o vazio do Grid entre as colunas
  if (liQtdTotalColuna > 0) then begin
    liEspacoVazio := liEspacoVazio div liQtdTotalColuna;
  end;

  //Ajustando o tamanho das colunas do Grid
  for liForColuna := 0 to -1 + poGrid.Columns.Count do begin
    poGrid.Columns[liForColuna].Width := poGrid.Columns[liForColuna].Width + liEspacoVazio;
  end;
end;

class function TUtilControleFormulario.getClicouNoBotaoEspecialDoGrid(poGrid: TDBGrid): Boolean;
const
  {$REGION 'Nota explicativa sobre as constantes...'}
  {*------------------------------------------------------------------------------
    Constantes que guardam os valores m�nimos e m�ximos do local do bot�o do grid
    ilustrado pela letra "X" abaixo:
    +-+------+--------+--------|
    |X|title1|title2  |title3  |
    | |      |        |        |
    | |      |        |        |
    +-+------+--------+--------|
  -------------------------------------------------------------------------------}
  {$ENDREGION}
  MinX = 0;
  MaxX = 10;
  MinY = 0;
  MaxY = 15;
var
  Pt: TPoint;
begin
  Pt := poGrid.ScreenToClient(SmallPointToPoint(SmallPoint(GetMessagePos)));
  Result := (((Pt.X >= MinX) and (Pt.X <= MaxX)) and ((Pt.Y >= MinY) and (Pt.Y <= MaxY)));
end;

class procedure TUtilControleFormulario.habilitarDesabilitarControles(
  poObjetoPai: TWinControl; pbHabilita, pbRecursivo: Boolean);
var
  liForControles: Integer;
  loControle    : TControl;
begin
  for liForControles := 0 to Pred(poObjetoPai.ControlCount) do begin
    loControle         := poObjetoPai.Controls[liForControles];
    loControle.Enabled := pbHabilita;
    if ((loControle is TWinControl) and pbRecursivo) then begin
      habilitarDesabilitarControles(TWinControl(loControle), pbHabilita, pbRecursivo);
    end;
  end;
end;

class procedure TUtilControleFormulario.moverParaBaixo(poLista: TCustomListBox);
var
  liPosicaoOriginal: integer;
begin
  if (poLista.Items.Count > 0) then begin
    if (poLista.ItemIndex >= 0) then begin
      if (poLista.ItemIndex < poLista.Items.Count - 1) then begin
        liPosicaoOriginal := poLista.ItemIndex;
        poLista.Items.Move(liPosicaoOriginal,liPosicaoOriginal + 1);
        poLista.ItemIndex := liPosicaoOriginal + 1;
      end else begin
        ShowMessage('O item selecionado j� est� no final!');
      end;
    end else begin
      ShowMessage('Selecione um item para ordernar.');
    end;
  end else begin
    ShowMessage('Nenhum item para ordenar!');
  end;
end;

class procedure TUtilControleFormulario.moverParaCima(poLista: TCustomListBox);
var
  liPosicaoOriginal: integer;
begin
  if (poLista.Items.Count > 0) then begin
    if (poLista.ItemIndex > 0) then begin
      liPosicaoOriginal := poLista.ItemIndex;
      poLista.Items.Move(liPosicaoOriginal,liPosicaoOriginal - 1);
      poLista.ItemIndex := liPosicaoOriginal - 1;
    end else begin
      if (poLista.ItemIndex = 0) then begin
        ShowMessage('O item selecionado j� est� no inicio!');
      end else begin
        ShowMessage('Selecione um item para ordernar.');
      end;
    end;
  end else begin
    ShowMessage('Nenhum item para ordenar!');
  end;
end;

class procedure TUtilControleFormulario.setTransparencia(const piFormHandle: HWND;
piPencentualTransparencia: integer);
var
  liInfoWindow: Longint;
  liValorTransparencia: integer;
begin
  if ((piPencentualTransparencia >= 1) and (piPencentualTransparencia <= 100)) then begin
    liValorTransparencia := VALOR_PADRAO_TRANSPARENCIA - Trunc((VALOR_PADRAO_TRANSPARENCIA * piPencentualTransparencia)/100);
  end else begin
    liValorTransparencia := VALOR_PADRAO_TRANSPARENCIA;
  end;
  liInfoWindow := GetWindowLong(piFormHandle, GWL_EXSTYLE);
  liInfoWindow := liInfoWindow or WS_EX_LAYERED;
  SetWindowLong(piFormHandle, GWL_EXSTYLE, liInfoWindow);
  SetLayeredWindowAttributes(piFormHandle, 0, liValorTransparencia, LWA_ALPHA);
end;

{ TUtilControleAplicacao }

class procedure TUtilControleAplicacao.getAppInfo(var piTimeOut: Integer);
begin
  dmUtil.qryAppInfo.Close;
  dmUtil.qryAppInfo.Connection := TUtilConexaoFireDac.getConn;
  dmUtil.qryAppInfo.Open;
  piTimeOut := dmUtil.qryAppInfo.FieldByName('TIME_OUT').AsInteger;
  dmUtil.qryAppInfo.Close;
end;

//class procedure TUtilControleAplicacao.ProcessaMsg(var poMsg: TMsg;
//  var pbHandled: Boolean);
//var
//  liFor: Integer;
//  leShiftState: TShiftState;
//  lwKey: word;
//  loWinActiveControl: TWinControl;
//  loRxCalculator: TRxCalculator;
//  lbProcessaMsg: Boolean;
//begin
//  lbProcessaMsg := rInfoAplicacao.bProcessaMsg;
//  try
//    if Msg.message = WM_KEYDOWN then begin
//      lwKey := Msg.wParam;
//      rInfoAplicacao.iOriginalLastKey := Msg.wParam;
//
//      if (lwKey = VK_CONTROL) or (not rInfoAplicacao.bProcessaMsg) then begin
//        Exit;
//      end;
//
//      leShiftState := KeyDataToShiftState(Msg.lParam);
//
//      {$REGION 'Implementa��o do listener para combina��o de tecla CTRL+L...'}
//      {*------------------------------------------------------------------------------
//      Trecho que verifica se foi pressionado a combina��o de teclas CTRL+L.
//      Caso tenha sido pressionado, verifica se no Form ativo existe o Bot�o
//      "Limpa" (btnLimpa) e caso exista, executa o evento OnClick desse
//      bot�o, conforme o seu tipo (TButton, TBitBtn, TSpeedButton e etc)
//      -------------------------------------------------------------------------------}
//      if ((leShiftState = [ssCtrl]) and (lwKey = Ord('L'))) then begin
//        for liFor := 0 to Screen.ActiveForm.ComponentCount-1 do begin
//          {Verificando se existe algum componente com o nome "btnLimpa"}
//          if (UpperCase(Screen.ActiveForm.Components[liFor].Name) = 'BTNLIMPA') then begin
//            if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBUTTON') then begin
//              TButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBITBTN') then begin
//              TBitBtn(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TSPEEDBUTTON') then begin
//              TSpeedButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end;
//            Handled := True;
//          end;
//        end;
//      end;
//      {$ENDREGION}
//
//      {$REGION 'Implementa��o do listener para combina��o de tecla CTRL+T...'}
//      {*------------------------------------------------------------------------------
//      Trecho que verifica se foi pressionado a combina��o de teclas CTRL+T.
//      Caso tenha sido pressionado, verifica se no Form ativo existe o Bot�o
//      "Todos" (btnTodos) e caso exista, executa o evento OnClick desse
//      bot�o, conforme o seu tipo (TButton, TBitBtn, TSpeedButton e etc)
//      -------------------------------------------------------------------------------}
//      if ((leShiftState = [ssCtrl]) and (lwKey = Ord('T'))) then begin
//        for liFor := 0 to Screen.ActiveForm.ComponentCount-1 do begin
//          {Verificando se existe algum componente com o nome "btnTodos"}
//          if (UpperCase(Screen.ActiveForm.Components[liFor].Name) = 'BTNTODOS') then begin
//            if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBUTTON') then begin
//              TButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBITBTN') then begin
//              TBitBtn(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TSPEEDBUTTON') then begin
//              TSpeedButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end;
//            Handled := True;
//          end;
//        end;
//      end;
//      {$ENDREGION}
//
//      {$REGION 'Implementa��o do listener para combina��o de tecla CTRL+P...'}
//      {*------------------------------------------------------------------------------
//      Trecho que verifica se foi pressionado a combina��o de teclas CTRL+P.
//      Caso tenha sido pressionado, verifica se no Form ativo existe algum
//      bot�o imprimir (btnImprimir) e caso exista, executa o evento OnClick desse
//      bot�o, conforme o seu tipo (TButton, TBitBtn, TSpeedButton e etc)
//      -------------------------------------------------------------------------------}
//      if ((leShiftState = [ssCtrl]) and (lwKey = Ord('P'))) then begin
//        for liFor := 0 to Screen.ActiveForm.ComponentCount-1 do begin
//          {Verificando se existe algum componente com o nome "btnImprimir"}
//          if (UpperCase(Screen.ActiveForm.Components[liFor].Name) = 'BTNIMPRIMIR') then begin
//            if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBUTTON') then begin
//              TButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBITBTN') then begin
//              TBitBtn(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TSPEEDBUTTON') then begin
//              TSpeedButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end;
//            Handled := True;
//          end;
//        end;
//      end;
//      {$ENDREGION}
//
//      {$REGION 'Implementa��o do listener para combina��o de tecla CTRL+X...'}
//      {*------------------------------------------------------------------------------
//      Trecho que verifica se foi pressionado a combina��o de teclas CTRL+X.
//      Caso tenha sido pressionado, verifica se no Form ativo existe algum
//      bot�o imprimir (btnExportar) e caso exista, executa o evento OnClick desse
//      bot�o, conforme o seu tipo (TButton, TBitBtn, TSpeedButton e etc)
//      -------------------------------------------------------------------------------}
//      if ((leShiftState = [ssCtrl]) and (lwKey = Ord('X'))) then begin
//        for liFor := 0 to Screen.ActiveForm.ComponentCount-1 do begin
//          {Verificando se existe algum componente com o nome "btnExportar"}
//          if (UpperCase(Screen.ActiveForm.Components[liFor].Name) = 'BTNEXPORTAR') then begin
//            if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBUTTON') then begin
//              TButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TBITBTN') then begin
//              TBitBtn(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end else if (UpperCase(Screen.ActiveForm.Components[liFor].ClassName) = 'TSPEEDBUTTON') then begin
//              TSpeedButton(Screen.ActiveForm.Components[liFor]).OnClick(Screen.ActiveForm);
//            end;
//            Handled := True;
//          end;
//        end;
//      end;
//      {$ENDREGION}
//
//      {$REGION 'Implementa��o do listener para combina��o de tecla CTRL+UP dento de um ListBox...'}
//      {*------------------------------------------------------------------------------
//      Trecho que verifica se foi pressionado a combina��o de teclas CTRL+UP (seta para cima).
//      Caso tenha sido pressionado, verifica se o objeto ativo � descendente do TCustomListBox,
//      e caso seja executa a fun��o "TUtilControleFormulario.moverParaCima".
//      -------------------------------------------------------------------------------}
//      if ((leShiftState = [ssCtrl]) and (lwKey = VK_UP)) then begin
//        if Screen.ActiveControl.InheritsFrom(TCustomListBox) then begin
//          TUtilControleFormulario.moverParaCima(TCustomListBox(Screen.ActiveControl));
//          Handled := True;
//        end;
//      end;
//      {$ENDREGION}
//
//      {$REGION 'Implementa��o do listener para combina��o de tecla CTRL+DOWN dento de um ListBox...'}
//      {*------------------------------------------------------------------------------
//      Trecho que verifica se foi pressionado a combina��o de teclas CTRL+DOWN (seta para baixo).
//      Caso tenha sido pressionado, verifica se o objeto ativo � descendente do TCustomListBox,
//      e caso seja executa a fun��o "TUtilControleFormulario.moverParaCima".
//      -------------------------------------------------------------------------------}
//      if ((leShiftState = [ssCtrl]) and (lwKey = VK_DOWN)) then begin
//        if Screen.ActiveControl.InheritsFrom(TCustomListBox) then begin
//          TUtilControleFormulario.moverParaBaixo(TCustomListBox(Screen.ActiveControl));
//          Handled := True;
//        end;
//      end;
//      {$ENDREGION}
//
//      if Msg.wParam = VK_ESCAPE then begin
//        if (UpperCase(Screen.ActiveForm.Name) =  'FSELEMPRESA')
//          or (UpperCase(Screen.ActiveForm.Name) = UpperCase('F'+rInfoAplicacao.sNome))
//        then begin
//          Application.Terminate;
//        end else begin
//          try
//            for liFor := 0 to Screen.ActiveForm.ComponentCount-1 do begin
//              if (Screen.ActiveForm.Components[liFor] is TRxDBLookupCombo) then begin
//                TRxDBLookupCombo(Screen.ActiveForm.Components[liFor]).CloseUp(true);
//              end;
//            end;
//            Screen.ActiveForm.Close;
//          except
//            Application.Terminate;
//          end;
//        end;
//      end else if (not (Screen.ActiveControl is TCustomMemo)
//        and (not (Screen.ActiveControl is TCheckListBox))
//        and  not (Screen.ActiveControl is TButtonControl)
//        and (not (Screen.ActiveControl is TListBox)))
//        or (Screen.ActiveControl is TCustomRichEdit)
//        or (Screen.ActiveControl is TCheckBox)
//        or (Screen.ActiveControl is TDBCheckBox)
//      then begin
//        try
//          for liFor := 0 to Screen.ActiveForm.ComponentCount-1 do begin
//            if (Screen.ActiveForm.Components[liFor] is TRxDBLookupCombo) and (not TRxDBLookupCombo(Screen.ActiveForm.Components[liFor]).Focused) then begin
//              TRxDBLookupCombo(Screen.ActiveForm.Components[liFor]).CloseUp(true);
//            end;
//          end;
//        except
//        end;
//        if (Msg.wParam = VK_F9) and (rInfoAplicacao.bF9) then begin
//  //      Application.OnMessage := nil;
//          {Atribui False a rInfoAplicacao.bProcessaMsg para n�o obstrui a
//          atribui��o efetuada abaixo por rInfoAplicacao.dblResultCalc. No
//          Finally desse try � atribuido o valor anterior de
//          rInfoAplicacao.bProcessaMsg que foi armazenado no in�cio desse
//          m�todo em lbProcessaMsg.}
//          rInfoAplicacao.bProcessaMsg := False;
//          {Instancia a loRxCalculator}
//          loRxCalculator := TRxCalculator.Create(nil);
//          try
//            loRxCalculator.Execute;
////            Application.OnMessage := ProcessaMsg;
//            if (Screen.ActiveControl is TEvNumEdit) then begin
//              TEvNumEdit(Screen.ActiveControl).Value := rInfoAplicacao.dblResultCalc;
//            end;
//          finally
//            FreeAndNil(loRxCalculator);
//          end;
//        end;
//        {Se combobox box estiver DroppedDow n�o aceita o VK_Tab, por isso
//        coloquei para ele o WM_NextDlg. Para os demais o WM_NextDlg pula 2
//        campos, ent�o tem que usar o VK_TAB}
//        if (Screen.ActiveControl is TComboBox) and (Msg.wParam = VK_Tab) then begin
//          TComboBox(Screen.ActiveControl).DroppedDown := false;
//        end;
//        if (Screen.ActiveControl is TDateEdit) and ((Msg.wParam = VK_Return) or (Msg.wParam = VK_TAB)) then begin
//          if not ValidaData(TDateEdit(Screen.ActiveControl)) then begin
//            TDateEdit(Screen.ActiveControl).Date := 0;
//            TDateEdit(Screen.ActiveControl).SetFocus;
//            Msg.wParam := 0;
//          end else if (Msg.wParam = VK_Return) then begin
//            Msg.wParam := VK_Tab;
//          end;
//        end else if (not (Screen.ActiveControl is TComboBox)) and (Msg.wParam = VK_Return) then begin
//          Msg.wParam := VK_Tab;
//        end else if (Screen.ActiveControl is TComboBox) and (Msg.wParam = VK_Return) then begin
//          Screen.ActiveForm.Perform(WM_NextDlgCtl,0,0);
//        end;
//      end;
//    end else if (Screen.ActiveControl is TDateEdit)
//      and (TDateEdit(Screen.ActiveControl).Focused)
//      and ((Msg.message = WM_LBUTTONDOWN)
//      or (Msg.message = WM_LBUTTONDBLCLK)
//      or (Msg.message = WM_RBUTTONDOWN)
//      or (Msg.message = WM_RBUTTONDBLCLK)
//      or (Msg.message = WM_RBUTTONDBLCLK))
//    then begin
//      if not ValidaData(TDateEdit(Screen.ActiveControl)) then begin
//        TDateEdit(Screen.ActiveControl).Date := 0;
//        TDateEdit(Screen.ActiveControl).SetFocus;
//        Msg.wParam := 0;
//      end;
//    end;
//  finally
//    rInfoAplicacao.bProcessaMsg := lbProcessaMsg;
//    rInfoAplicacao.iLastKey     := Msg.wParam;
//  end;
//end;

class function TUtilControleAplicacao.validaVersaoAplicacao(psVersao: String): Boolean;
begin
  Result := TRegEx.Match(psVersao,'^\d+\.\d+\.\d+\.\d+$').Success;
end;

class function TUtilControleAplicacao.Versao: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  lpF: PFFI;
  liHandle: Dword;
  liLen: Longint;
  lpData: Pchar;
  lpBuffer: Pointer;
  liTamanho: Dword;
  lpParquivo: Pchar;
  lsArquivo: String;
begin
  lsArquivo := Application.ExeName;
  lpParquivo := StrAlloc(Length(lsArquivo) + 1);
  StrPcopy(lpParquivo, lsArquivo);
  liLen := GetFileVersionInfoSize(lpParquivo, liHandle);
  Result := '';
  if liLen > 0 then begin
    lpData:=StrAlloc(liLen+1);
    if GetFileVersionInfo(lpParquivo,liHandle,liLen,lpData) then begin
      VerQueryValue(lpData, '\',lpBuffer,liTamanho);
      lpF := PFFI(lpBuffer);
      Result := Format('%d.%d.%d.%d',[HiWord(lpF^.dwFileVersionMs),LoWord(lpF^.dwFileVersionMs),HiWord(lpF^.dwFileVersionLs),Loword(lpF^.dwFileVersionLs)]);
    end;
    StrDispose(lpData);
  end;
  StrDispose(lpParquivo);
end;

end.

