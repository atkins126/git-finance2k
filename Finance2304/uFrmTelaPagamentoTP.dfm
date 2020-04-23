object frmPagamentoTitulos: TfrmPagamentoTitulos
  Left = 0
  Top = 0
  Caption = 'Pagamento de Titulos'
  ClientHeight = 734
  ClientWidth = 1006
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
    Width = 1006
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    ExplicitWidth = 894
    object menuBaixaTP: TdxRibbonTab
      Active = True
      Caption = 'Baixa de t'#237'tulos a pagar'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
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
    Width = 1006
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
    ExplicitTop = 555
    ExplicitWidth = 894
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 1006
    Height = 589
    Align = alClient
    DataSource = dsTitulos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORNECEDOR'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_HIST'
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_EMISSAO'
        Title.Alignment = taCenter
        Title.Caption = 'DATA EMISS'#195'O'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PARCELA'
        Width = 50
        Visible = True
      end>
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
    Left = 824
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 928
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end
        item
          Visible = True
          ItemName = 'cxBarPesquisaCedente'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Pagar t'#237'tulos'
      CaptionButtons = <>
      DockedLeft = 201
      DockedTop = 0
      FloatLeft = 928
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnPagar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 276
      DockedTop = 0
      FloatLeft = 928
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
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnPagar: TdxBarLargeButton
      Caption = 'Baixa'
      Category = 0
      Hint = 'Baixa de t'#237'tulos'
      Visible = ivAlways
      OnClick = dxBtnPagarClick
    end
    object dxBtnPagarAV: TdxBarLargeButton
      Caption = 'Baixa Avan'#231'ada'
      Category = 0
      Hint = 'Baixa de t'#237'tulos avan'#231'ada'
      Visible = ivAlways
      OnClick = dxBtnPagarAVClick
    end
    object cxBarPesquisaCedente: TcxBarEditItem
      Align = iaRight
      Caption = 'Fornecedor'
      Category = 0
      Hint = 'Fornecedor'
      Visible = ivAlways
      OnCurChange = cxBarPesquisaCedenteCurChange
      Width = 120
    end
  end
  object dsTitulos: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsTitulosDataChange
    Left = 408
    Top = 240
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '  SELECT TP.ID_TITULO_PAGAR AS ID, '
      '         TP.NUMERO_DOCUMENTO AS DOC,       '
      '         TP.ID_ORGANIZACAO,  '
      '         TP.DESCRICAO,'
      '         TP.VALOR_NOMINAL, '
      '         TP.ID_CEDENTE,'
      '         TP.DATA_EMISSAO,'
      '         TP.DATA_VENCIMENTO, '
      '         TP.PARCELA,'
      '         C.NOME AS FORNECEDOR, '
      '         H.DESCRICAO AS DSC_HIST'
      '         '
      '  FROM TITULO_PAGAR TP'
      
        '  LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AN' +
        'D (C.id_organizacao = TP.id_organizacao)'
      
        '  LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_histor' +
        'ico) AND (H.id_organizacao = TP.id_organizacao)'
      
        '  WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO )   AND  ( TP.ID_T' +
        'IPO_STATUS IN ('#39'ABERTO'#39'))'
      '  ORDER BY TP.DATA_VENCIMENTO ASC')
    Left = 303
    Top = 240
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
