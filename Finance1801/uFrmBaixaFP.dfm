object frmBaixaFP: TfrmBaixaFP
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Baixa de t'#237'tulos a pagar'
  ClientHeight = 647
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbl3: TLabel
    Left = 8
    Top = 8
    Width = 64
    Height = 16
    Caption = 'Documento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 160
    Top = 8
    Width = 55
    Height = 16
    Caption = 'Descri'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 438
    Top = 8
    Width = 67
    Height = 16
    Caption = 'Vencimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 552
    Top = 8
    Width = 42
    Height = 16
    Caption = 'Parcela'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl7: TLabel
    Left = 8
    Top = 79
    Width = 82
    Height = 16
    Caption = 'Valor principal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl8: TLabel
    Left = 160
    Top = 79
    Width = 126
    Height = 16
    Caption = 'Cedente (Fornecedor)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl9: TLabel
    Left = 160
    Top = 173
    Width = 93
    Height = 16
    Caption = 'Tipo pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl10: TLabel
    Left = 8
    Top = 176
    Width = 94
    Height = 16
    Caption = 'Data pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl11: TLabel
    Left = 504
    Top = 79
    Width = 50
    Height = 16
    Caption = 'INSC/MF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 627
    Width = 666
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object edtDoc: TEdit
    Left = 8
    Top = 32
    Width = 137
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10053171
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object cbbTipoPagto: TComboBox
    Left = 160
    Top = 198
    Width = 126
    Height = 21
    TabOrder = 3
    Text = 'cbbTipoPagto'
    OnChange = cbbTipoPagtoChange
    Items.Strings = (
      'TOTAL'
      'PARCIAL')
  end
  object edtDescricao: TEdit
    Left = 160
    Top = 32
    Width = 257
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtVcto: TEdit
    Left = 438
    Top = 32
    Width = 97
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object edtParcela: TEdit
    Left = 552
    Top = 32
    Width = 97
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object edtValotTP: TEvNumEdit
    Left = 8
    Top = 104
    Width = 137
    Height = 24
    Enabled = False
    Glyph.Data = {
      7E050000424D7E0500000000000036000000280000001A0000000D0000000100
      2000000000004805000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
      2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
      8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
      6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
      5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
      FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
      8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
      FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
      FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
      B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
      FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
      3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
      A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
      FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
      FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
      8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
      7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
      5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
      FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
      8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
      FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
      FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
      B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
      FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
      3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
      A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
      FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
      DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
      9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
      8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
      F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
      FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
      E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
      4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
      FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
      9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00}
    TabOrder = 7
  end
  object edtCedente: TEdit
    Left = 160
    Top = 104
    Width = 321
    Height = 24
    Enabled = False
    TabOrder = 8
  end
  object dtpPagto: TDateTimePicker
    Left = 8
    Top = 198
    Width = 137
    Height = 21
    Date = 43842.811710069450000000
    Time = 43842.811710069450000000
    TabOrder = 0
    OnChange = dtpPagtoChange
  end
  inline frameResponsavel1: TframeResponsavel
    Left = 304
    Top = 173
    Width = 185
    Height = 88
    TabOrder = 9
    ExplicitLeft = 304
    ExplicitTop = 173
    ExplicitWidth = 185
    inherited lblResponsavel: TLabel
      Top = 3
      Width = 71
      Height = 16
      Font.Height = -13
      ParentFont = False
      ExplicitTop = 3
      ExplicitWidth = 71
      ExplicitHeight = 16
    end
    inherited cbbcombo: TComboBox
      Top = 25
      Width = 174
      OnChange = frameResponsavel1cbbcomboChange
      ExplicitTop = 25
      ExplicitWidth = 174
    end
    inherited qryObterPorID: TFDQuery
      Top = 32
    end
    inherited qryObterTodos: TFDQuery
      Top = 32
    end
  end
  object edtCNPJ: TEdit
    Left = 504
    Top = 104
    Width = 145
    Height = 24
    Alignment = taRightJustify
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object cxpgcntrlFP: TcxPageControl
    Left = 0
    Top = 267
    Width = 666
    Height = 360
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 11
    Properties.ActivePage = tbTransfereFP
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 360
    ClientRectRight = 666
    ClientRectTop = 24
    object tbTransfereFP: TcxTabSheet
      Caption = 'Pagamento'
      ImageIndex = 0
      OnShow = tbTransfereFPShow
      object lbl2: TLabel
        Left = 21
        Top = 12
        Width = 102
        Height = 13
        Caption = 'Forma de pagamento'
      end
      object lbl1: TLabel
        Left = 329
        Top = 12
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      inline frmFormaPagto1: TfrmFormaPagto
        Left = 16
        Top = 31
        Width = 254
        Height = 35
        TabOrder = 0
        ExplicitLeft = 16
        ExplicitTop = 31
        ExplicitWidth = 254
        inherited cbbFormaPagto: TComboBox
          Width = 198
          ExplicitWidth = 198
        end
      end
      object dbgrdFP: TDBGrid
        Left = 19
        Top = 72
        Width = 430
        Height = 120
        DataSource = dsGridFP
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clGray
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'FORMA DE PAGAMENTO'
            Width = 300
            Visible = True
          end
          item
            Color = clMoneyGreen
            Expanded = False
            FieldName = 'VALOR'
            Width = 100
            Visible = True
          end>
      end
      object edtValorPago: TEvNumEdit
        Left = 328
        Top = 34
        Width = 121
        Height = 21
        Glyph.Data = {
          7E050000424D7E0500000000000036000000280000001A0000000D0000000100
          2000000000004805000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
          2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
          8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
          6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
          FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
          FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
          FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
          FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
          FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
          8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
          7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
          FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
          FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
          FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
          DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
          9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
          8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
          F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
          FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
          E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
          4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
          FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
          9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00}
        TabOrder = 2
      end
      object btnCancelar: TButton
        Left = 473
        Top = 116
        Width = 121
        Height = 21
        Caption = 'Cancelar'
        TabOrder = 3
        OnClick = btnCancelarClick
      end
      object btnCheque: TButton
        Left = 186
        Top = 198
        Width = 100
        Height = 33
        Caption = 'CHEQUE (F7)'
        TabOrder = 4
        OnClick = btnChequeClick
      end
      object btnDin: TButton
        Left = 21
        Top = 198
        Width = 100
        Height = 33
        Caption = 'DIN (F6)'
        TabOrder = 5
        OnClick = btnDinClick
      end
      object btnLimpar: TButton
        Left = 473
        Top = 76
        Width = 121
        Height = 21
        Caption = 'Limpar'
        TabOrder = 6
        OnClick = btnLimparClick
      end
      object btnSelect: TButton
        Left = 473
        Top = 36
        Width = 121
        Height = 21
        Caption = 'Selecionar'
        TabOrder = 7
        OnClick = btnSelectClick
      end
      object btnWEB: TButton
        Left = 349
        Top = 198
        Width = 100
        Height = 33
        Caption = 'BANK LINE (F8)'
        TabOrder = 8
        OnClick = btnWEBClick
      end
      object btnPagamento: TButton
        Left = 0
        Top = 303
        Width = 666
        Height = 33
        Align = alBottom
        Caption = 'PAGAMENTO  (F10)'
        TabOrder = 9
        OnClick = btnPagamentoClick
        ExplicitLeft = 21
        ExplicitTop = 297
        ExplicitWidth = 573
      end
    end
    object tbTransfereAC: TcxTabSheet
      Caption = 'Acr'#233'scimos'
      ImageIndex = 1
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tbTransfereDE: TcxTabSheet
      Caption = 'Dedu'#231#245'es'
      ImageIndex = 2
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object fdmFP: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 544
    Top = 192
  end
  object dsGridFP: TDataSource
    DataSet = fdmFP
    Left = 192
    Top = 424
  end
end
