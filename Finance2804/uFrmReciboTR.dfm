object frmReciboTR: TfrmReciboTR
  Left = 0
  Top = 0
  Caption = 'Emitir recibo '
  ClientHeight = 734
  ClientWidth = 1062
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1062
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    ExplicitWidth = 1061
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Emiss'#227'o de recibo de contas  recebidas'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 714
    Width = 1062
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitTop = 580
    ExplicitWidth = 1061
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 135
    Width = 1062
    Height = 579
    Align = alClient
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_PAGO'
        Title.Caption = 'VALOR'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DT_RCBTO'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PARCELA'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 380
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Alignment = taCenter
        Width = 270
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 1062
    Height = 10
    Align = alTop
    TabOrder = 7
    ExplicitWidth = 1061
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
    Left = 664
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 462
      DockedTop = 0
      FloatLeft = 818
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
    object dxBarManager1Bar5: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 144
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'cxbrdtmPesquisaSacado'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar1: TdxBar
      Caption = 'Impress'#227'o'
      CaptionButtons = <>
      DockedLeft = 391
      DockedTop = 0
      FloatLeft = 1095
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnImpimir'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnEditar: TdxBarLargeButton
      Caption = 'Editar'#13#10
      Category = 0
      Hint = 'Editar'#13#10' registro. F2'
      Visible = ivAlways
    end
    object dxBtnSalvar: TdxBarLargeButton
      Caption = 'Salvar'
      Category = 0
      Hint = 'Salvar registro. F10'
      Visible = ivAlways
    end
    object dxBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Novo registro. F4'
      Visible = ivAlways
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnDeletar: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Align = iaRight
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      Width = 120
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object dxBtnImprime: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprime o recibo '
      Visible = ivAlways
    end
    object dxBtnImpimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBtnImpimirClick
    end
    object cxbrdtmPesquisaSacado: TcxBarEditItem
      Align = iaRight
      Caption = 'Cliente'
      Category = 0
      Hint = 'Cliente'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaSacadoCurChange
      Width = 120
    end
  end
  object msgDlg: TEvMsgDlg
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
    Left = 808
    Top = 56
  end
  object dsGrid: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsGridDataChange
    Left = 608
    Top = 168
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.ID_TITULO_RECEBER,'
      '       TR.NUMERO_DOCUMENTO AS DOC,       '
      '       TR.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TR.DESCRICAO) AS DESCRICAO,'
      '       TRB.VALOR_PAGO,'
      '       TR.ID_SACADO,'
      '       TR.data_pagamento,'
      '       C.nome AS CLIENTE,'
      '       TR.PARCELA'
      '       '
      '       '
      ''
      'FROM TITULO_RECEBER TR'
      ''
      
        'LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.id_titulo_RECEB' +
        'ER = TR.id_titulo_RECEBER) AND (TRB.id_organizacao = TR.id_organ' +
        'izacao)'
      
        'LEFT OUTER JOIN SACADO C ON (C.id_SACADO = TR.id_SACADO) AND (C.' +
        'id_organizacao = TR.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TR.id_historic' +
        'o) AND (H.id_organizacao = TR.id_organizacao)'
      'WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TR.ID_TIPO_STATUS IN ('#39'PARCIAL'#39', '#39'QUITADO'#39') )'
      ''
      'ORDER BY TR.DATA_EMISSAO DESC, TR.VALOR_NOMINAL DESC'
      ''
      '')
    Left = 888
    Top = 184
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxReportRecibo: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43827.466410034700000000
    ReportOptions.LastChange = 43928.448210520830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 744
    Top = 176
    Datasets = <
      item
        DataSet = frxDBRecibo
        DataSetName = 'Recibo'
      end
      item
        DataSet = frxTRBBanco
        DataSetName = 'TPBBanco'
      end
      item
        DataSet = frxDBTRBCaixa
        DataSetName = 'TPBCaixa'
      end
      item
        DataSet = frxTRBCheque
        DataSetName = 'TPBCheque'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end
      item
        Name = 'strExtenso'
        Value = Null
      end
      item
        Name = 'strValidate'
        Value = Null
      end>
    Style = <
      item
        Name = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 14211288
      end
      item
        Name = 'Header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 15790320
      end
      item
        Name = 'Group header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 15790320
      end
      item
        Name = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
      end
      item
        Name = 'Group footer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftTop]
      end
      item
        Name = 'Header line'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 124.724490000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        DataSet = frxDBRecibo
        DataSetName = 'Recibo'
        RowCount = 0
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 660.880357520000000000
          Top = 48.472480000000000000
          Width = 53.690568550000000000
          Height = 15.118120000000000000
          DataField = 'PARCELA'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."PARCELA"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 100.391797520000000000
          Top = 46.133890000000000000
          Width = 484.556988550000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."DESCRICAO"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Top = 23.456710000000000000
          Width = 106.862320130000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_PAGO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Recibo."VALOR_PAGO"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = 106.196255840000000000
          Top = 2.779529999999990000
          Width = 606.873973480000000000
          Height = 18.897650000000000000
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."TIPO"]  :  [Recibo."CLIENTE"] ( [Recibo."SAC_CNPJ"] )')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 100.391797520000000000
          Top = 23.456710000000000000
          Width = 503.454638550000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strExtenso]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 589.510227520000000000
          Top = 48.472480000000000000
          Width = 68.808688550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'PARCELA :')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 91.826840000000000000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 14211288
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DO RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 2.779529999999990000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Recebemos do ')
        end
        object Memo62: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 23.456710000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'O valor de :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 46.133890000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Referente a:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 207.094620000000000000
          Top = 28.220470000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 299.260050000000000000
          Top = 28.220470000000000000
          Width = 411.968770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
          VAlign = vaCenter
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 272.039580000000000000
          Top = 58.456710000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 204.094620000000000000
          Top = 58.456710000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 491.016080000000000000
          Top = 58.456710000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 590.622450000000000000
          Top = 58.456710000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 114.063080000000000000
          Width = 585.827150000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 28.015770000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 59.385900000000000000
          Top = 28.015770000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 91.708720000000000000
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 14211288
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 403.630180000000000000
          Top = 93.488250000000000000
          Width = 113.131876040000000000
          Height = 18.897650000000000000
          DataField = 'DOC'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."DOC"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Left = -219.212740000000000000
          Top = -215.433210000000000000
          Width = 200.315090000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 3.779527560000000000
        Top = 204.094620000000000000
        Width = 718.110700000000000000
        Condition = '1=1'
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 154.960730000000000000
        Top = 521.575140000000100000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          AllowVectorExport = True
          Top = 6.000000000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Top = 136.504020000000000000
          Width = 99.648420170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'C'#211'DIGO VALIDA'#199#195'O :')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 103.519790000000000000
          Top = 136.504020000000000000
          Width = 371.774580170000000000
          Height = 15.118120000000000000
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[strValidate]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = 245.008040000000000000
          Top = 86.472480000000000000
          Width = 226.771653540000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
        object Memo60: TfrxMemoView
          AllowVectorExport = True
          Left = 275.905690000000000000
          Top = 88.252010000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Caixa:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 377.990437520000000000
          Top = 36.118120000000000000
          Width = 166.907119240000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PAGAMENTO'
          DataSet = frxDBRecibo
          DataSetName = 'Recibo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Recibo."DATA_PAGAMENTO"]')
          ParentFont = False
        end
        object Line7: TfrxLineView
          AllowVectorExport = True
          Left = 136.063080000000000000
          Top = 51.236240000000000000
          Width = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
        object Line8: TfrxLineView
          AllowVectorExport = True
          Left = 322.157700000000000000
          Top = 51.236240000000000000
          Width = 52.913420000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
        object Memo64: TfrxMemoView
          AllowVectorExport = True
          Left = 309.141930000000000000
          Top = 37.338590000000000000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            ',')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          AllowVectorExport = True
          Left = 567.153486060000000000
          Top = 9.338589999999950000
          Width = 148.437150130000000000
          Height = 15.118120000000000000
          DataSet = frxDBTRBCaixa
          DataSetName = 'TPBCaixa'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TPBCheque."VALOR">,DT_CHEQUE) +'
            'SUM(<TPBBanco."VALOR">,DT_WEB) +'
            'SUM(<TPBCaixa."VALOR">,DT_CAIXA) ]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          AllowVectorExport = True
          Left = 503.000310000000000000
          Top = 9.338589999999950000
          Width = 61.080279240000000000
          Height = 15.118120000000000000
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL ->')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 151.740260000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
          Frame.Width = 0.100000000000000000
        end
      end
      object DT_CHEQUE: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 37.795275590000000000
        Top = 377.953000000000000000
        Width = 718.110700000000000000
        DataSet = frxTRBCheque
        DataSetName = 'TPBCheque'
        RowCount = 0
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 2.779530000000020000
          Width = 144.229939240000000000
          Height = 15.118120000000000000
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'CHEQUE RECEBIDO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 199.212740000000000000
          Top = 2.779530000000020000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO_BANCO'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBCheque."CODIGO_BANCO"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 146.519790000000000000
          Top = 2.779530000000020000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 252.685220000000000000
          Top = 2.779530000000022000
          Width = 57.470098550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'AG'#202'NCIA:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 313.496290000000000000
          Top = 2.779530000000020000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'AGENCIA'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBCheque."AGENCIA"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 366.189240000000000000
          Top = 3.779530000000000000
          Width = 46.131508550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 412.320748550000000000
          Top = 2.779530000000020000
          Width = 76.474861450000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."CONTA"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Left = 488.795610000000000000
          Top = 2.779530000000022000
          Width = 60.472479999999990000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 549.268090000000000000
          Top = 2.779530000000020000
          Width = 61.249628550000000000
          Height = 15.118120000000000000
          DataField = 'CHEQUE'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."CHEQUE"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Top = 2.779530000000020000
          Width = 106.862320130000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCheque."VALOR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 20.677180000000000000
          Width = 65.029158550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'DATA :')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 69.590600000000000000
          Top = 20.677180000000000000
          Width = 125.501638550000000000
          Height = 15.118120000000000000
          DataField = 'DATA_PROTOCOLO'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."DATA_PROTOCOLO"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 252.685220000000000000
          Top = 20.677180000000020000
          Width = 70.954797640000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'PORTADOR:')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 327.640017640000000000
          Top = 20.677180000000020000
          Width = 386.289208550000000000
          Height = 15.118120000000000000
          DataField = 'TITULAR'
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBCheque."TITULAR"]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 37.354360000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
      end
      object DT_WEB: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897640240000000000
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        DataSet = frxTRBBanco
        DataSetName = 'TPBBanco'
        RowCount = 0
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Width = 144.229939240000000000
          Height = 15.118120000000000000
          DataField = 'HISTORICO'
          DataSet = frxTRBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBBanco."HISTORICO"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 197.206842480000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO_BANCO'
          DataSet = frxTRBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBBanco."CODIGO_BANCO"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          AllowVectorExport = True
          Left = 250.679322480000000000
          Width = 57.470098550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'AG'#202'NCIA:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          AllowVectorExport = True
          Left = 311.490392480000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          DataField = 'AGENCIA'
          DataSet = frxTRBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TPBBanco."AGENCIA"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          AllowVectorExport = True
          Left = 364.183342480000000000
          Width = 46.131508550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          AllowVectorExport = True
          Left = 412.301462480000000000
          Width = 72.588218550000000000
          Height = 15.118120000000000000
          DataField = 'CONTA'
          DataSet = frxTRBBanco
          DataSetName = 'TPBBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[TPBBanco."CONTA"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Width = 106.862320130000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxTRBBanco
          DataSetName = 'TPBBanco'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBBanco."VALOR"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          AllowVectorExport = True
          Left = 147.401670000000000000
          Width = 49.911038550000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 15790320
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 16.456710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
      end
      object DT_CAIXA: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897637795275600000
        Top = 480.000310000000000000
        Width = 718.110700000000000000
        DataSet = frxDBTRBCaixa
        DataSetName = 'TPBCaixa'
        RowCount = 0
        object Memo54: TfrxMemoView
          AllowVectorExport = True
          Left = 608.728316060000000000
          Top = 2.779530000000020000
          Width = 106.862320130000000000
          Height = 15.118120000000000000
          DataField = 'VALOR'
          DataSet = frxDBTRBCaixa
          DataSetName = 'TPBCaixa'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TPBCaixa."VALOR"]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          AllowVectorExport = True
          Left = 2.005897520000000000
          Top = 2.779530000000020000
          Width = 185.804769240000000000
          Height = 15.118120000000000000
          DataSet = frxTRBCheque
          DataSetName = 'TPBCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'RECBTO EM ESP'#201'CIE')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 18.897650000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
      end
    end
  end
  object frxDBRecibo: TfrxDBDataset
    UserName = 'Recibo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER'
      'DOC=DOC'
      'PARCELA=PARCELA'
      'DATA_PAGAMENTO=DATA_PAGAMENTO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO=DESCRICAO'
      'VALOR_PAGO=VALOR_PAGO'
      'IDTRB=IDTRB'
      'ID_SACADO=ID_SACADO'
      'CLIENTE=CLIENTE'
      'TIPO=TIPO'
      'SAC_CNPJ=SAC_CNPJ'
      'RAZAO_SOCIAL=RAZAO_SOCIAL'
      'SIGLA=SIGLA'
      'FANTASIA=FANTASIA'
      'CNPJ=CNPJ'
      'ORG_END=ORG_END')
    DataSet = qryObterDados
    BCDToCurrency = False
    Left = 712
    Top = 248
  end
  object qryObterDados: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TR.ID_TITULO_RECEBER,'
      '       TR.NUMERO_DOCUMENTO AS DOC,'
      '       TR.PARCELA,'
      '       TR.data_pagamento,'
      '       TR.ID_ORGANIZACAO,'
      '       (H.descricao || '#39' '#39' ||  TR.DESCRICAO) AS DESCRICAO,'
      ''
      '       TRB.VALOR_PAGO,'
      '       TRB.id_titulo_RECEBER_baixa AS IDTRB,'
      ''
      '       TR.ID_SACADO,'
      '       S.nome AS CLIENTE,'
      '       TS.DESCRICAO as tipo,'
      '       S.cpfcnpj as sac_cnpj,'
      ''
      '       ORG.RAZAO_SOCIAL,'
      '       ORG.SIGLA,'
      '       ORG.FANTASIA,'
      '       ORG.CNPJ,'
      
        '      ( ORG.LOGRADOURO || '#39' '#39' || ORG.COMPLEMENTO || '#39' '#39' || ORG.N' +
        'UMERO || '#39' , '#39' || B.BAIRRO || '#39' - '#39' ||  CID.CIDADE || '#39' - '#39' ||  ' +
        'E.DESCRICAO || '#39' CEP: '#39' ||  ORG.CEP   ) as ORG_END'
      ''
      ''
      'FROM TITULO_RECEBER TR'
      ''
      
        'LEFT OUTER JOIN TITULO_RECEBER_BAIXA TRB ON (TRB.id_titulo_RECEB' +
        'ER = TR.id_titulo_RECEBER) AND (TRB.id_organizacao = TR.id_organ' +
        'izacao)'
      
        'LEFT OUTER JOIN SACADO S ON (S.ID_SACADO = TR.ID_SACADO) AND (S.' +
        'id_organizacao = TR.id_organizacao)'
      
        'LEFT OUTER JOIN TIPO_SACADO TS ON (TS.id_TIPO_SACADO = S.ID_TIPO' +
        '_SACADO) AND (TS.id_organizacao = TR.id_organizacao)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TR.id_historic' +
        'o) AND (H.id_organizacao = TR.id_organizacao)'
      
        'INNER JOIN ORGANIZACAO ORG ON (ORG.ID_ORGANIZACAO = TR.ID_ORGANI' +
        'ZACAO)'
      'INNER JOIN ESTADO E ON (E.ID_ESTADO = ORG.ID_ESTADO)'
      'INNER JOIN CIDADE CID ON (CID.ID_CIDADE = ORG.ID_CIDADE)'
      'INNER JOIN BAIRRO B ON (B.ID_BAIRRO = ORG.ID_BAIRRO)'
      'WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO )'
      ' AND  ( TR.ID_TITULO_RECEBER = :PID )'
      ''
      ''
      '')
    Left = 592
    Top = 256
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCaixa: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT TC.ID_TITULO_RECEBER_BAIXA,'
      '        TC.data_movimento, '
      '        TC.valor_nominal as VALOR,'
      '        TC.descricao,'
      '        H.descricao as DSC_HIST'
      '   FROM TESOURARIA_CREDITO TC'
      
        '   LEFT OUTER JOIN historico h on (h.id_historico = TC.id_histor' +
        'ico) and (h.id_organizacao = TC.id_organizacao)'
      ''
      ' WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '       (TC.ID_TITULO_RECEBER_BAIXA = :PIDTITULOBAIXA)')
    Left = 184
    Top = 312
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBaixaTRCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  TRBC.ID_TITULO_RECEBER_BAIXA_CHEQUE,'
      '        TRBC.ID_ORGANIZACAO,'
      '        TRBC.ID_TITULO_RECEBER_BAIXA,'
      '        TRBC.VALOR as VALOR,'
      '        TRBC.numero_cheque AS CHEQUE,'
      '        TRBC.titular, TRBC.conta, TRBC.AGENCIA, B.codigo_banco,'
      '        TRBC.data_PROTOCOLO'
      ''
      ''
      'FROM TITULO_RECEBER_BAIXA_CHEQUE TRBC'
      'LEFT OUTER JOIN BANCO B ON (B.id_banco = TRBC.id_banco)'
      ''
      ''
      'WHERE (TRBC.id_organizacao = :PIDORGANIZACAO) AND'
      '      (TRBC.ID_TITULO_RECEBER_BAIXA = :PIDTITULOBAIXA)'
      '')
    Left = 56
    Top = 312
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTRBBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TRBI.ID_TITULO_RECEBER_BAIXA,'
      '       TRBI.ID_ORGANIZACAO,'
      '       TRBI.VALOR as VALOR,'
      '       TRBI.id_conta_bancaria,'
      '       TOB.DESCRICAO AS HISTORICO,'
      '       CB.titular, CB.conta, CB.AGENCIA, B.codigo_banco'
      ''
      ''
      '        '
      'FROM TITULO_RECEBER_BAIXA_INTERNET TRBI'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TRBI.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGAN' +
        'IZACAO = TRBI.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN conta_bancaria CB ON (CB.id_conta_bancaria = TRB' +
        'I.id_conta_bancaria) AND (CB.ID_ORGANIZACAO = TRBI.ID_ORGANIZACA' +
        'O)'
      'LEFT OUTER JOIN BANCO B ON (B.id_banco = CB.id_banco)'
      'WHERE (TRBI.ID_ORGANIZACAO = :PIDORGANIZACAO )AND'
      '      (TRBI.ID_TITULO_RECEBER_BAIXA = :PIDTITULOBAIXA)'
      ''
      'ORDER BY TRBI.VALOR;')
    Left = 321
    Top = 320
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object extenso: TEvExtenso
    Currency.Strings = (
      'real'
      'reais'
      'centavo'
      'centavos')
    Left = 992
    Top = 184
  end
  object frxDBTPQuitados: TfrxDBDataset
    UserName = 'TPQUITADOS'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 600
    Top = 368
  end
  object frxDBTRB: TfrxDBDataset
    UserName = 'TPBaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_TITULO_RECEBER=ID_TITULO_RECEBER')
    DataSet = qryObterIDTRB
    BCDToCurrency = False
    Left = 904
    Top = 328
  end
  object frxDBTRBCaixa: TfrxDBDataset
    UserName = 'TPBCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'VALOR=VALOR'
      'DESCRICAO=DESCRICAO'
      'DSC_HIST=DSC_HIST')
    DataSet = qryBaixaTRCaixa
    BCDToCurrency = False
    Left = 192
    Top = 232
  end
  object frxTRBCheque: TfrxDBDataset
    UserName = 'TPBCheque'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA_CHEQUE=ID_TITULO_RECEBER_BAIXA_CHEQUE'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'VALOR=VALOR'
      'CHEQUE=CHEQUE'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO'
      'DATA_PROTOCOLO=DATA_PROTOCOLO')
    DataSet = qryBaixaTRCheque
    BCDToCurrency = False
    Left = 49
    Top = 232
  end
  object frxTRBBanco: TfrxDBDataset
    UserName = 'TPBBanco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TITULO_RECEBER_BAIXA=ID_TITULO_RECEBER_BAIXA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'VALOR=VALOR'
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'HISTORICO=HISTORICO'
      'TITULAR=TITULAR'
      'CONTA=CONTA'
      'AGENCIA=AGENCIA'
      'CODIGO_BANCO=CODIGO_BANCO')
    DataSet = qryObterTRBBanco
    BCDToCurrency = False
    Left = 321
    Top = 232
  end
  object qryObterIDTRB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT FIRST 1 TRB.id_organizacao, '
      '        TRB.id_titulo_receber_baixa,   '
      '        TRB.id_titulo_receber'
      ''
      ''
      ' FROM TITULO_RECEBER_BAIXA TRB         '
      ''
      ''
      ' WHERE (TRB.ID_ORGANIZACAO   = :PIDORGANIZACAO) AND  '
      '       (TRB.id_titulo_RECEBER = :PIDTITULO) AND   '
      '       (TRB.ID_LOTE_CONTABIL IS NULL)           ')
    Left = 904
    Top = 256
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
