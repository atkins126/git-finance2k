object frmRecebimentoTitulos: TfrmRecebimentoTitulos
  Left = 0
  Top = 0
  Caption = 'Recebimento de Titulos'
  ClientHeight = 575
  ClientWidth = 894
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
    Width = 894
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object menuBaixaTP: TdxRibbonTab
      Active = True
      Caption = 'Baixa de t'#237'tulos a receber'
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
    Top = 555
    Width = 894
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
  end
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 894
    Height = 430
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
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
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
        Width = 150
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
        Width = 40
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
      DockedLeft = 181
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
      DockedLeft = 256
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
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
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
      '  SELECT TP.ID_TITULO_RECEBER AS ID, '
      '         TP.NUMERO_DOCUMENTO AS DOC,       '
      '         TP.ID_ORGANIZACAO,  '
      '         TP.DESCRICAO,'
      '         TP.VALOR_NOMINAL, '
      '         TP.ID_SACADO,'
      '         TP.DATA_EMISSAO,'
      '         TP.DATA_VENCIMENTO, '
      '         TP.PARCELA,'
      '         C.NOME AS CLIENTE, '
      '         H.DESCRICAO AS DSC_HIST'
      '         '
      '  FROM TITULO_RECEBER TP'
      
        '  LEFT OUTER JOIN SACADO C ON (C.ID_SACADO = TP.ID_SACADO) AND (' +
        'C.id_organizacao = TP.id_organizacao)'
      
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
    Left = 720
    Top = 64
  end
end
