object frmDeletaLoteContabil: TfrmDeletaLoteContabil
  Left = 0
  Top = 0
  Caption = '  Deleta Lote Contabil'
  ClientHeight = 399
  ClientWidth = 727
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
    Left = 246
    Top = 25
    Width = 63
    Height = 13
    Caption = 'Lote Cont'#225'bil'
  end
  object lbl2: TLabel
    Left = 66
    Top = 104
    Width = 42
    Height = 13
    Caption = 'ID LOTE '
  end
  object lbl3: TLabel
    Left = 27
    Top = 154
    Width = 81
    Height = 13
    Caption = 'DATA REGISTRO'
  end
  object lbl4: TLabel
    Left = 13
    Top = 204
    Width = 95
    Height = 13
    Caption = 'TIPO LAN'#199'AMENTO'
  end
  object lbl5: TLabel
    Left = 35
    Top = 254
    Width = 73
    Height = 13
    Caption = 'VALOR D'#201'BITO'
  end
  object lbl6: TLabel
    Left = 27
    Top = 304
    Width = 81
    Height = 13
    Caption = 'VALOR CR'#201'DITO'
  end
  object lbl7: TLabel
    Left = 130
    Top = 25
    Width = 77
    Height = 11
    Caption = 'Selecione o ano'
  end
  object cbbLoteContabil: TComboBox
    Left = 246
    Top = 44
    Width = 110
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12582911
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnSelect = cbbLoteContabilSelect
  end
  object btnLimpar: TButton
    Left = 492
    Top = 42
    Width = 102
    Height = 28
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = btnLimparClick
  end
  object edtIdLote: TEdit
    Left = 130
    Top = 100
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 4
  end
  object edtDataRegistro: TEdit
    Left = 130
    Top = 150
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 5
  end
  object medtValorDB: TMaskEdit
    Left = 130
    Top = 250
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Color = clMoneyGreen
    Enabled = False
    TabOrder = 7
    Text = ''
  end
  object edtTabela: TEdit
    Left = 130
    Top = 200
    Width = 230
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 6
  end
  object medtValorCR: TMaskEdit
    Left = 130
    Top = 300
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Color = 13619199
    Enabled = False
    TabOrder = 8
    Text = ''
  end
  object btnDeletarLote: TButton
    Left = 378
    Top = 42
    Width = 102
    Height = 28
    Caption = 'Deletar'
    TabOrder = 2
    OnClick = btnDeletarLoteClick
  end
  object cbbAno: TComboBox
    Left = 130
    Top = 46
    Width = 110
    Height = 21
    TabOrder = 0
    Text = '>>Selecione <<'
    OnChange = cbbAnoChange
    Items.Strings = (
      '2019'
      '2018'
      '2017'
      '2016'
      '2015'
      '2014')
  end
  object btnFechar: TBitBtn
    Left = 612
    Top = 42
    Width = 102
    Height = 28
    Caption = 'Fechar'
    TabOrder = 9
    OnClick = btnFecharClick
  end
  object edtTipoLancamento: TEdit
    Left = 378
    Top = 200
    Width = 102
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 10
  end
  object qryObterLoteID: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      ''
      'SELECT  LC.ID_LOTE_CONTABIL,'
      '        LC.ID_ORGANIZACAO,'
      '        LC.LOTE,'
      '        LC.STATUS,'
      '        LC.DATA_REGISTRO,'
      '        LC.DATA_ATUALIZACAO,'
      '        LC.PERIODO_INICIAL,'
      '        LC.PERIODO_FINAL,'
      '        LC.TIPO_TABLE, '
      '        LC.TIPO_LANCAMENTO, '
      '        LC.VALOR_CR, '
      '        LC.VALOR_DB,'
      '        LC.QTD_REGISTROS'
      ''
      ''
      ' FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (LC.ID_LOTE_CONTABIL = :PIDLOTE)'
      '      ')
    Left = 536
    Top = 312
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 624
    Top = 320
  end
  object qryAlteraGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 456
    Top = 312
  end
  object qryAlteraLote: TFDQuery
    Connection = dmConexao.conn
    Left = 456
    Top = 248
  end
  object qryObterTPPROV: TFDQuery
    Connection = dmConexao.conn
    Left = 536
    Top = 248
  end
  object qryDeletaLote: TFDQuery
    Connection = dmConexao.conn
    Left = 616
    Top = 248
  end
end
