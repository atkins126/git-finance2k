object formEspelhoTP: TformEspelhoTP
  Left = 0
  Top = 0
  Caption = 'Espelho de t'#237'tulo a pagar'
  ClientHeight = 627
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 144
  TextHeight = 19
  object statStatusEsp: TStatusBar
    Left = 0
    Top = 608
    Width = 852
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 400
      end>
    ExplicitTop = 434
    ExplicitWidth = 1033
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 852
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    ExplicitWidth = 1033
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Espelho de t'#237'tulo a pagar'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end>
      Index = 0
    end
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 852
    Height = 483
    Align = alClient
    DataSource = dsTitulos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'VENCIMENTO'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORNECEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_HST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_TP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 150
        Visible = True
      end>
  end
  object qryBusca: TFDQuery
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.ID_CEDENTE,'
      '       TP.ID_HISTORICO,'
      '       TP.ID_CENTRO_CUSTO,'
      '       TP.ID_TIPO_STATUS,'
      '       TP.ID_TIPO_COBRANCA,'
      '       TP.ID_RESPONSAVEL,'
      '       TP.ID_LOCAL_PAGAMENTO,'
      '       TP.ID_TITULO_GERADOR,'
      '       TP.ID_LOTE_CONTABIL,'
      '       TP.ID_LOTE_PAGAMENTO,'
      '       TP.ID_USUARIO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DESCRICAO,'
      '       TP.DATA_REGISTRO,'
      '       TP.DATA_EMISSAO,'
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.DATA_ULTIMA_ATUALIZACAO,'
      '       TP.PREVISAO_CARTORIO,'
      '       TP.VALOR_NOMINAL,'
      '       TP.VALOR_ANTECIPADO,'
      '       TP.PARCELA,'
      '       TP.OBSERVACAO,'
      '       TP.REGISTRO_PROVISAO,'
      '       TP.ID_CONTA_CONTABIL_DEBITO,'
      '       TP.ID_CONTA_CONTABIL_CREDITO,'
      '       TP.ID_LOTE_TPB,'
      '       H.DESCRICAO AS DSC_HIST,'
      '       H.CODIGO AS COD_HIST,'
      '       TS.DESCRICAO AS STATUS,'
      '       CCD.CONTA AS CONTA_DB,'
      '       CCD.CODREDUZ AS CODRED_DB,'
      '       CCC.CONTA AS CONTA_CR,'
      '       CCC.CODREDUZ AS CODRED_CR,'
      '       F.NOME AS RESPONSAVEL'
      ''
      ''
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN FUNCIONARIO F ON (F.ID_FUNCIONARIO = TP.ID_RESPO' +
        'NSAVEL) AND (F.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TIPO_STATUS TS ON (TS.ID_TIPO_STATUS = TP.ID_TIP' +
        'O_STATUS) AND (TS.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON   (H.ID_HISTORICO = TP.ID_HISTORI' +
        'CO)  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_DEBITO) AND (CCD.ID_ORGANIZACAO = TP.ID_ORGA' +
        'NIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_CREDITO) AND (CCC.ID_ORGANIZACAO = TP.ID_ORG' +
        'ANIZACAO)'
      ''
      
        'WHERE ((TP.numero_documento = :PNUMDOC) OR (TP.ID_TITULO_PAGAR =' +
        ' :PIDTP))'
      'AND    (TP.ID_ORGANIZACAO   = :PIDORGANIZACAO);'
      ''
      '')
    Left = 720
    Top = 73
    ParamData = <
      item
        Name = 'PNUMDOC'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'PIDTP'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object PempecMsg: TEvMsgDlg
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWindowText
    ButtonFont.Height = -11
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = []
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -11
    MessageFont.Name = 'Tahoma'
    MessageFont.Style = []
    Left = 424
    Top = 66
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 512
    Top = 72
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Pesquisa'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1018
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Imprimir'
      CaptionButtons = <>
      DockedLeft = 181
      DockedTop = 0
      FloatLeft = 1018
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImprimir'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 252
      DockedTop = 0
      FloatLeft = 1018
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Sair'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBtnImprimirClick
    end
    object dxBarEdit1: TdxBarEdit
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      PropertiesClassName = 'TcxTextEditProperties'
    end
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR as ID, '
      '       TP.ID_ORGANIZACAO, '
      '       TP.ID_CEDENTE, '
      '       TP.ID_HISTORICO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.VALOR_NOMINAL, '
      '       TP.DESCRICAO as dsc_tp, '
      '       TP.DATA_VENCIMENTO,'
      '       C.NOME as fornecedor,'
      '       H.DESCRICAO as dsc_hst'
      '--       '#39'0'#39' as PAGAR'
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (TP.ID_HISTORICO = H.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '       AND   (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39')'
      '       ORDER BY TP.DATA_PAGAMENTO DESC ')
    Left = 175
    Top = 328
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsTitulos: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsTitulosDataChange
    Left = 280
    Top = 320
  end
end
