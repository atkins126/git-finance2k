object frmSincronizaMega: TfrmSincronizaMega
  Left = 0
  Top = 0
  Caption = 'Sincronizar Mega'
  ClientHeight = 642
  ClientWidth = 752
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
  object lbl1: TLabel
    Left = 24
    Top = 8
    Width = 122
    Height = 13
    Caption = 'Sincroniza Conta Cont'#225'bil'
  end
  object lblNotSinc: TLabel
    Left = 24
    Top = 100
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
  object lbl4: TLabel
    Left = 24
    Top = 160
    Width = 110
    Height = 13
    Caption = 'Plano de Contas Oficial'
  end
  object lbl5: TLabel
    Left = 24
    Top = 331
    Width = 130
    Height = 13
    Caption = 'Plano de Contas Financeiro'
  end
  object panelMega: TRxPanel
    Left = 168
    Top = 27
    Width = 449
    Height = 62
    BevelOuter = bvNone
    TabOrder = 0
    TileImage = False
    object lbl2: TLabel
      Left = 22
      Top = 5
      Width = 51
      Height = 13
      Caption = 'Empresa : '
    end
    object lblEmpresa: TLabel
      Left = 97
      Top = 5
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
    object lbl3: TLabel
      Left = 26
      Top = 26
      Width = 47
      Height = 13
      Caption = 'CNPJ     : '
    end
    object lblCnpj: TLabel
      Left = 97
      Top = 26
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
  end
  object btnBuscarPlanoMega: TBitBtn
    Left = 24
    Top = 27
    Width = 97
    Height = 25
    Caption = 'Plano de Contas do Mega'
    TabOrder = 1
    OnClick = btnBuscarPlanoMegaClick
  end
  object dbgPlanoMega: TDBGrid
    Left = 24
    Top = 179
    Width = 593
    Height = 137
    DataSource = dmMegaContabil.dtsPlanoContas
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA CONT'#193'BIL'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODREDUZ'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO REDUZIDO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NMCONTA'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O DA CONTA'
        Width = 400
        Visible = True
      end>
  end
  object btnBuscarContasContabeis: TBitBtn
    Left = 24
    Top = 64
    Width = 97
    Height = 25
    Caption = 'Contas Contabeis Finance'
    TabOrder = 3
    OnClick = btnBuscarContasContabeisClick
  end
  object btnBuscarPlanos: TBitBtn
    Left = 24
    Top = 119
    Width = 217
    Height = 25
    Caption = 'Buscar Planos de Contas'
    TabOrder = 4
    OnClick = btnBuscarPlanosClick
  end
  object btnVerificar: TBitBtn
    Left = 24
    Top = 503
    Width = 97
    Height = 25
    Caption = 'Sincronizar'
    TabOrder = 5
    OnClick = btnVerificarClick
  end
  object memo: TMemo
    Left = 127
    Top = 509
    Width = 490
    Height = 91
    Lines.Strings = (
      'Painel de Mensagens')
    TabOrder = 6
  end
  object dbgrdContasFinance: TDBGrid
    Left = 24
    Top = 350
    Width = 593
    Height = 137
    DataSource = dmContaContabil.dtsPlanoContas
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA CONT'#193'BIL'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODREDUZ'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO REDUZIDO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O DA CONTA'
        Width = 450
        Visible = True
      end>
  end
  inline framePB1: TframePB
    Left = 127
    Top = 587
    Width = 514
    Height = 41
    TabOrder = 8
    ExplicitLeft = 127
    ExplicitTop = 587
    ExplicitWidth = 514
    ExplicitHeight = 41
    inherited lblProgressBar: TLabel
      Left = 19
      Width = 149
      Caption = 'Progresso da Sincroniza'#231#227'o...  '
      ExplicitLeft = 19
      ExplicitWidth = 149
    end
    inherited pb1: TProgressBar
      Left = 0
      Top = 19
      Width = 490
      Height = 19
      MarqueeInterval = 2
      ExplicitLeft = 0
      ExplicitTop = 19
      ExplicitWidth = 490
      ExplicitHeight = 19
    end
  end
end