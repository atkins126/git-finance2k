object frmSincronizaMega: TfrmSincronizaMega
  Left = 0
  Top = 0
  Caption = 'Sincronizar contas cont'#225'beis'
  ClientHeight = 734
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNotSinc: TLabel
    Left = 24
    Top = 493
    Width = 46
    Height = 13
    Caption = 'lblNotSinc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3155860
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 24
    Top = 328
    Width = 130
    Height = 13
    Caption = 'Plano de Contas Financeiro'
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 125
    Width = 680
    Height = 567
    Align = alClient
    Color = 12582911
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    TabOrder = 9
    Zoom = 100
  end
  object panelMega: TRxPanel
    Left = 24
    Top = 367
    Width = 630
    Height = 20
    BevelOuter = bvNone
    TabOrder = 0
    TileImage = False
    object lblEmpresa: TLabel
      Left = 15
      Top = 4
      Width = 41
      Height = 13
      Caption = 'empresa'
      Color = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblCnpj: TLabel
      Left = 327
      Top = 4
      Width = 20
      Height = 13
      Caption = 'cnpj'
      Color = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 26
      Top = 26
      Width = 47
      Height = 13
      Caption = 'CNPJ     : '
    end
  end
  object btnBuscarPlanoMega: TBitBtn
    Left = 24
    Top = 129
    Width = 97
    Height = 25
    Caption = 'Plano de Contas do Mega'
    TabOrder = 1
    OnClick = btnBuscarPlanoMegaClick
  end
  object dbgPlanoMega: TDBGrid
    Left = 24
    Top = 206
    Width = 630
    Height = 137
    DataSource = dmMegaContabil.dtsPlanoContas
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA CONT'#193'BIL'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CODREDUZ'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO REDUZIDO'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NMCONTA'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O DA CONTA'
        Width = 360
        Visible = True
      end>
  end
  object btnBuscarContasContabeis: TBitBtn
    Left = 144
    Top = 129
    Width = 97
    Height = 25
    Caption = 'Contas Contabeis Finance'
    TabOrder = 3
    OnClick = btnBuscarContasContabeisClick
  end
  object btnBuscarPlanos: TBitBtn
    Left = 280
    Top = 131
    Width = 217
    Height = 25
    Caption = 'Buscar Planos de Contas'
    TabOrder = 4
    Visible = False
    OnClick = btnBuscarPlanosClick
  end
  object memo: TMemo
    Left = 24
    Top = 582
    Width = 630
    Height = 91
    Lines.Strings = (
      'Painel de Mensagens')
    TabOrder = 5
  end
  object dbgrdContasFinance: TDBGrid
    Left = 24
    Top = 395
    Width = 630
    Height = 137
    DataSource = dmContaContabil.dtsPlanoContas
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA CONT'#193'BIL'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CODREDUZ'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO REDUZIDO'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O DA CONTA'
        Width = 360
        Visible = True
      end>
  end
  inline framePB1: TframePB
    Left = 0
    Top = 692
    Width = 680
    Height = 42
    Align = alBottom
    TabOrder = 7
    ExplicitTop = 692
    ExplicitWidth = 680
    ExplicitHeight = 42
    inherited lblProgressBar: TLabel
      Top = -3
      ExplicitTop = -3
    end
    inherited lbl3: TLabel
      Left = 639
      Top = 19
      ExplicitLeft = 639
      ExplicitTop = 19
    end
    inherited pb1: TProgressBar
      Top = 16
      Width = 620
      Height = 18
      ExplicitTop = 16
      ExplicitWidth = 620
      ExplicitHeight = 18
    end
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 680
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 8
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Sincronizar contas '
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
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
  object RxPanel1: TRxPanel
    Left = 24
    Top = 556
    Width = 630
    Height = 20
    BevelOuter = bvNone
    TabOrder = 10
    TileImage = False
    object Label3: TLabel
      Left = 26
      Top = 26
      Width = 47
      Height = 13
      Caption = 'CNPJ     : '
    end
  end
  object RxPanel2: TRxPanel
    Left = 24
    Top = 180
    Width = 630
    Height = 20
    BevelOuter = bvNone
    TabOrder = 11
    TileImage = False
    object Label1: TLabel
      Left = 26
      Top = 26
      Width = 47
      Height = 13
      Caption = 'CNPJ     : '
    end
    object lbl4: TLabel
      Left = 24
      Top = 3
      Width = 110
      Height = 13
      Caption = 'Plano de Contas Oficial'
    end
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
    Left = 568
    Top = 72
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      Caption = 'Planos'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1091
      FloatTop = 10
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnLoadPlanos'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sincronizar'
      CaptionButtons = <>
      DockedLeft = 70
      DockedTop = 0
      FloatLeft = 1091
      FloatTop = 10
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnSincronizar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 153
      DockedTop = 0
      FloatLeft = 1091
      FloatTop = 10
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarBtnFecharClick
    end
    object dxBarBtnSincronizar: TdxBarLargeButton
      Caption = 'Sincronizar'
      Category = 0
      Hint = 'Sincronizar'
      Visible = ivAlways
      OnClick = dxBarBtnSincronizarClick
    end
    object dxBarBtnLoadPlanos: TdxBarLargeButton
      Caption = 'Carregar'
      Category = 0
      Hint = 'Carregar'
      Visible = ivAlways
      OnClick = dxBarBtnLoadPlanosClick
    end
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
    Left = 448
    Top = 64
  end
end
