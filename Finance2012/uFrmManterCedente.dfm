object frmManterCedente: TfrmManterCedente
  Left = 0
  Top = 0
  Caption = 'Detalhes'
  ClientHeight = 715
  ClientWidth = 837
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
    Width = 837
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de cedentes'
      Groups = <
        item
          Caption = 'Novo'
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarSalvar'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 695
    Width = 837
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
  object dbgrd1: TDBGrid
    Left = 8
    Top = 455
    Width = 821
    Height = 234
    DataSource = dsCedente
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPFCNPJ'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO'
        Width = 80
        Visible = True
      end>
  end
  object cxpgcntrlPage: TcxPageControl
    Left = 0
    Top = 125
    Width = 837
    Height = 324
    Align = alTop
    TabOrder = 0
    Properties.ActivePage = tbTransfereEndereco
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 324
    ClientRectRight = 837
    ClientRectTop = 24
    object tbTransfereCedente: TcxTabSheet
      Caption = 'Cedente'
      ImageIndex = 0
      OnShow = tbTransfereCedenteShow
      object lbl1: TLabel
        Left = 551
        Top = 28
        Width = 62
        Height = 13
        Caption = 'Tipo cedente'
      end
      object lbl2: TLabel
        Left = 34
        Top = 28
        Width = 100
        Height = 13
        Caption = 'Cedente/Fornecedor'
      end
      object lblCPFCNPJ: TLabel
        Left = 34
        Top = 104
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object lbl5: TLabel
        Left = 407
        Top = 28
        Width = 67
        Height = 13
        Caption = 'Personalidade'
      end
      object lbl22: TLabel
        Left = 255
        Top = 104
        Width = 21
        Height = 13
        Caption = 'CGA'
      end
      object lbl3: TLabel
        Left = 407
        Top = 104
        Width = 68
        Height = 13
        Caption = 'Insc. Estadual'
      end
      object lbl4: TLabel
        Left = 551
        Top = 104
        Width = 70
        Height = 13
        Caption = 'Insc. Municipal'
      end
      object edtCNPJCPF: TEdit
        Left = 34
        Top = 129
        Width = 151
        Height = 21
        Alignment = taRightJustify
        Color = 12891332
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnExit = edtCNPJCPFExit
      end
      object edtNomeCedente: TEdit
        Left = 34
        Top = 55
        Width = 340
        Height = 21
        Color = 12891332
        TabOrder = 1
        Text = 'edtNomeCedente'
      end
      inline frmTipoCedente1: TfrmTipoCedente
        Left = 543
        Top = 53
        Width = 201
        Height = 35
        TabOrder = 2
        ExplicitLeft = 543
        ExplicitTop = 53
        ExplicitWidth = 201
        inherited cbbcombo: TComboBox
          Left = 9
          Top = 3
          Width = 168
          Color = 12891332
          OnChange = frmTipoCedente1cbbcomboChange
          ExplicitLeft = 9
          ExplicitTop = 3
          ExplicitWidth = 168
        end
      end
      object cbbPersonalidade: TComboBox
        Left = 407
        Top = 55
        Width = 119
        Height = 21
        Color = 12891332
        TabOrder = 3
        Text = 'cbbPersonalidade'
        OnChange = cbbPersonalidadeChange
        Items.Strings = (
          '<<Selecione>>'
          'P F'
          'P J')
      end
      object edtInscEstadual: TEdit
        Left = 407
        Top = 129
        Width = 119
        Height = 21
        Color = 12891332
        TabOrder = 4
        Text = 'edtNomeCedente'
      end
      object edtCGA: TEdit
        Left = 255
        Top = 129
        Width = 119
        Height = 21
        Color = 12891332
        TabOrder = 5
        Text = 'edtNomeCedente'
      end
      object edtInscMunicipal: TEdit
        Left = 551
        Top = 129
        Width = 119
        Height = 21
        Color = 12891332
        TabOrder = 6
        Text = 'edtNomeCedente'
      end
    end
    object tbTransfereEndereco: TcxTabSheet
      Caption = 'Endere'#231'o'
      ImageIndex = 1
      OnShow = tbTransfereEnderecoShow
      object lbl13: TLabel
        Left = 19
        Top = 202
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object lbl14: TLabel
        Left = 232
        Top = 202
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object lbl15: TLabel
        Left = 485
        Top = 202
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object lbl16: TLabel
        Left = 485
        Top = 86
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lbl17: TLabel
        Left = 19
        Top = 18
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object lbl18: TLabel
        Left = 485
        Top = 18
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object lbl19: TLabel
        Left = 19
        Top = 86
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      inline frmEstado1: TfrmEstado
        Left = 6
        Top = 221
        Width = 195
        Height = 48
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = 221
        ExplicitWidth = 195
        inherited lblID: TLabel
          Left = 131
          Top = 33
          ExplicitLeft = 131
          ExplicitTop = 33
        end
        inherited cbbcombo: TComboBox
          Width = 174
          Color = clInfoBk
          OnChange = frmEstado1cbbcomboChange
          ExplicitWidth = 174
        end
        inherited qryObterPorID: TFDQuery
          Left = 24
          Top = 24
        end
        inherited qryObterTodos: TFDQuery
          Left = 88
          Top = 24
        end
      end
      inline frmCidade1: TfrmCidade
        Left = 221
        Top = 221
        Width = 250
        Height = 58
        TabOrder = 1
        ExplicitLeft = 221
        ExplicitTop = 221
        ExplicitWidth = 250
        inherited cbbcombo: TComboBox
          Left = 11
          Top = 6
          Width = 230
          Color = clInfoBk
          OnChange = frmCidade1cbbcomboChange
          ExplicitLeft = 11
          ExplicitTop = 6
          ExplicitWidth = 230
        end
      end
      inline frmBairro1: TfrmBairro
        Left = 473
        Top = 221
        Width = 254
        Height = 46
        TabOrder = 2
        ExplicitLeft = 473
        ExplicitTop = 221
        inherited cbbcombo: TComboBox
          Top = 6
          Width = 231
          Color = clInfoBk
          OnChange = frmBairro1cbbcomboChange
          ExplicitTop = 6
          ExplicitWidth = 231
        end
      end
      object edtCEP: TEdit
        Left = 485
        Top = 111
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object edtLogradouro: TEdit
        Left = 19
        Top = 45
        Width = 417
        Height = 21
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object edtNumero: TEdit
        Left = 485
        Top = 47
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
      object edtComplemento: TEdit
        Left = 19
        Top = 111
        Width = 417
        Height = 21
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
    end
    object tbTransfereContato: TcxTabSheet
      Caption = 'Contato'
      ImageIndex = 2
      OnShow = tbTransfereContatoShow
      object lbl8: TLabel
        Left = 78
        Top = 26
        Width = 21
        Height = 13
        Caption = 'DDD'
      end
      object lbl9: TLabel
        Left = 185
        Top = 18
        Width = 33
        Height = 13
        Caption = 'Celular'
      end
      object lbl10: TLabel
        Left = 188
        Top = 86
        Width = 65
        Height = 13
        Caption = 'Telefone Fixo'
      end
      object lbl11: TLabel
        Left = 78
        Top = 90
        Width = 21
        Height = 13
        Caption = 'DDD'
      end
      object lbl12: TLabel
        Left = 78
        Top = 154
        Width = 28
        Height = 13
        Caption = 'E-mail'
      end
      object edtCelular: TEdit
        Left = 185
        Top = 45
        Width = 208
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnExit = edtCelularExit
      end
      object edtDDDCEL: TEdit
        Left = 78
        Top = 45
        Width = 75
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object edt1: TEdit
        Left = 185
        Top = 109
        Width = 208
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnExit = edtCelularExit
      end
      object edt2: TEdit
        Left = 78
        Top = 109
        Width = 75
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object edtEmail: TEdit
        Left = 78
        Top = 183
        Width = 315
        Height = 21
        Color = clHighlightText
        TabOrder = 4
      end
    end
    object tbTransfereContaBancaria: TcxTabSheet
      Caption = 'Conta Banc'#225'ria'
      ImageIndex = 3
      OnShow = tbTransfereContaBancariaShow
      object lblAge: TLabel
        Left = 346
        Top = 30
        Width = 38
        Height = 26
        Caption = 'Ag'#234'ncia'#13#10
      end
      object lbl6: TLabel
        Left = 469
        Top = 30
        Width = 29
        Height = 13
        Caption = 'Conta'
      end
      object lbl7: TLabel
        Left = 34
        Top = 28
        Width = 29
        Height = 13
        Caption = 'Banco'
      end
      object lbl23: TLabel
        Left = 35
        Top = 107
        Width = 96
        Height = 13
        Caption = 'Bancos cadastrados'
      end
      inline frmBanco1: TfrmBanco
        Left = 29
        Top = 47
        Width = 311
        Height = 35
        TabOrder = 0
        ExplicitLeft = 29
        ExplicitTop = 47
        ExplicitWidth = 311
        inherited cbbBanco: TComboBox
          Left = 6
          Top = 6
          Width = 278
          Color = clGradientActiveCaption
          ExplicitLeft = 6
          ExplicitTop = 6
          ExplicitWidth = 278
        end
      end
      object edtAgencia: TEdit
        Left = 346
        Top = 53
        Width = 90
        Height = 21
        Alignment = taCenter
        Color = clGradientActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object edtConta: TEdit
        Left = 469
        Top = 53
        Width = 143
        Height = 21
        Alignment = taCenter
        Color = clGradientActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object dbgrdBanco: TDBGrid
        Left = 35
        Top = 135
        Width = 438
        Height = 149
        DataSource = dsBanco
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = dbgrdBancoTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME_BANCO'
            Title.Caption = 'BANCO'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODIGO_BANCO'
            Title.Caption = 'C'#211'DIGO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_BANCO'
            Visible = False
          end>
      end
    end
    object tbTransfereContaContabil: TcxTabSheet
      Caption = 'Conta Cont'#225'bil'
      ImageIndex = 4
      OnShow = tbTransfereContaContabilShow
      object lbl20: TLabel
        Left = 338
        Top = 19
        Width = 80
        Height = 13
        Caption = 'C'#243'digo Reduzido'
      end
      object lbl21: TLabel
        Left = 465
        Top = 19
        Width = 32
        Height = 13
        Caption = 'Conta '
      end
      object edtCODREDUZ: TEdit
        Left = 338
        Top = 42
        Width = 90
        Height = 21
        Alignment = taCenter
        Color = clMoneyGreen
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object edtContaContabil: TEdit
        Left = 465
        Top = 42
        Width = 141
        Height = 21
        Alignment = taRightJustify
        Color = clMoneyGreen
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      inline frmContaContabil1: TfrmContaContabil
        Left = 16
        Top = 19
        Width = 321
        Height = 62
        TabOrder = 1
        ExplicitLeft = 16
        ExplicitTop = 19
        ExplicitWidth = 321
        inherited lbl1: TLabel
          Left = 3
          Top = -3
          ExplicitLeft = 3
          ExplicitTop = -3
        end
        inherited cbbContaContabil: TComboBox
          Left = 3
          Width = 302
          Color = clMoneyGreen
          OnChange = frmContaContabil1cbbContaContabilChange
          ExplicitLeft = 3
          ExplicitWidth = 302
        end
      end
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
    Left = 664
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Editar'
      CaptionButtons = <>
      DockedLeft = 54
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnEditar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarSalvar: TdxBar
      Caption = 'Salvar'
      CaptionButtons = <>
      DockedLeft = 109
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnSalvar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnNovo'
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
      DockedLeft = 433
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
    object dxBarManager1Bar4: TdxBar
      Caption = 'Excluir'
      CaptionButtons = <>
      DockedLeft = 165
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnDeletar'
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
      DockedLeft = 227
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
      OnClick = dxBtnEditarClick
    end
    object dxBtnSalvar: TdxBarLargeButton
      Caption = 'Salvar'
      Category = 0
      Hint = 'Salvar registro. F10'
      Visible = ivAlways
      OnClick = dxBtnSalvarClick
    end
    object dxBtnNovo: TdxBarLargeButton
      Caption = 'Novo'
      Category = 0
      Hint = 'Novo registro. F4'
      Visible = ivAlways
      OnClick = dxBtnNovoClick
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
      OnClick = dxBtnDeletarClick
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Caption = 'Cedente'
      Category = 0
      Hint = 'Cedente'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      PropertiesClassName = 'TcxTextEditProperties'
    end
  end
  object dsCedente: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsCedenteDataChange
    Left = 768
    Top = 525
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT C.ID_CEDENTE, '
      '        C.ID_ORGANIZACAO,'
      '        C.ID_TIPO_CEDENTE, '
      '        TC.DESCRICAO AS TIPO, '
      '        C.ID_ENDERECO,'
      '        C.ID_CONTATO, '
      '        C.NOME, '
      '        C.CPFCNPJ,'
      '        C.PERSONALIDADE, '
      '        C.CONTA_BANCARIA,'
      '        C.AGENCIA, '
      '        C.ID_BANCO, '
      '        C.CGA,'
      '        C.INSCRICAO_ESTADUAL,  '
      '        C.ID_CONTA_CONTABIL,'
      '        C.INSCRICAO_MUNICIPAL, '
      '        C.ID_CARTAO_CREDITO,'
      '        C.DATA_REGISTRO, '
      '        C.SACADO, '
      '        C.STATUS, '
      '        C.DATA_ULTIMA_ATUALIZACAO, '
      '        C.CODIGO'
      'FROM CEDENTE C '
      ''
      
        'INNER JOIN TIPO_CEDENTE TC ON (TC.ID_TIPO_CEDENTE = C.ID_TIPO_CE' +
        'DENTE) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'
      ''
      'WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO ) '
      ''
      'ORDER BY C.NOME   ')
    Left = 768
    Top = 576
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsBanco: TDataSource
    AutoEdit = False
    DataSet = qryGridBanco
    OnDataChange = dsBancoDataChange
    Left = 760
    Top = 309
  end
  object qryGridBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  B.ID_BANCO, B.CODIGO_BANCO, B.NOME_BANCO, B.SIGLA_BANCO'
      ''
      'FROM BANCO B  WHERE ( B.ID_ORGANIZACAO = :PIDORGANIZACAO ) '
      ''
      'ORDER BY B.NOME_BANCO ;')
    Left = 760
    Top = 349
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end