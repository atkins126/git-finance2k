object frmGerarCheques: TfrmGerarCheques
  Left = 0
  Top = 0
  Caption = 'Gerar cheques por conta banc'#225'ria'
  ClientHeight = 400
  ClientWidth = 653
  Color = clInfoBk
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
  object Label1: TLabel
    Left = 306
    Top = 155
    Width = 67
    Height = 13
    Caption = 'Cheque Inicial'
  end
  object Label2: TLabel
    Left = 466
    Top = 155
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label3: TLabel
    Left = 64
    Top = 232
    Width = 69
    Height = 13
    Caption = 'Conta cont'#225'bil'
  end
  object Label4: TLabel
    Left = 64
    Top = 293
    Width = 26
    Height = 13
    Caption = 'Titula'
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 653
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 6
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Gerador de cheques'#13#10
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
    Top = 380
    Width = 653
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 50
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 50
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitTop = 574
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 48
    Top = 155
    Width = 243
    Height = 62
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 155
    ExplicitHeight = 62
    inherited cbbConta: TComboBox
      Tag = 1
      Top = 26
      OnChange = frmContaBancaria1cbbContaChange
      ExplicitTop = 26
    end
    inherited qryObterTodos: TFDQuery
      Left = 136
      Top = 16
    end
  end
  object edtContaContabil: TcxTextEdit
    Left = 64
    Top = 253
    Enabled = False
    ParentFont = False
    Properties.Alignment.Horz = taLeftJustify
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 4
    Width = 200
  end
  object edtChequeInicial: TEdit
    Tag = 1
    Left = 306
    Top = 181
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'edtChequeInicial'
  end
  object edtQtd: TEdit
    Tag = 1
    Left = 466
    Top = 181
    Width = 81
    Height = 21
    Hint = 'Digite a quantidade de folhas de cheques a serem geradas.'
    Color = 10930928
    MaxLength = 99
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = 'edtQtd'
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 306
    Top = 230
    Width = 249
    Height = 97
    TabOrder = 3
    ExplicitLeft = 306
    ExplicitTop = 230
    ExplicitWidth = 249
    ExplicitHeight = 97
    inherited lblResponsavel: TLabel
      Height = 19
      ExplicitHeight = 19
    end
    inherited cbbcombo: TComboBox
      Top = 23
      Width = 238
      OnChange = frameResponsavel1cbbcomboChange
      ExplicitTop = 23
      ExplicitWidth = 238
    end
    inherited qryObterPorID: TFDQuery
      Top = 40
    end
    inherited qryObterTodos: TFDQuery
      Left = 136
      Top = 40
    end
  end
  object edtTitular: TcxTextEdit
    Left = 64
    Top = 312
    Enabled = False
    ParentFont = False
    Properties.Alignment.Horz = taLeftJustify
    Properties.ReadOnly = True
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 7
    Width = 200
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
    Left = 544
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Gerar'#13#10
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnGerar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 53
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnLimpar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 115
      DockedTop = 0
      FloatLeft = 918
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnSair'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnSair: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnSairClick
    end
    object dxBtnLimpar: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBtnLimparClick
    end
    object dxBtnGerar: TdxBarLargeButton
      Caption = 'Gerar'
      Category = 0
      Hint = 'Gerar'
      Visible = ivAlways
      OnClick = dxBtnGerarClick
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
    Top = 56
  end
end
