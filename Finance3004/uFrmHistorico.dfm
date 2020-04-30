object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  Caption = 'Lintagem de hist'#243'ricos'
  ClientHeight = 348
  ClientWidth = 844
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
  object btnImprimirHistorico: TButton
    Left = 650
    Top = 163
    Width = 161
    Height = 35
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = btnImprimirHistoricoClick
  end
  object dbgrd1: TDBGrid
    Left = 16
    Top = 32
    Width = 622
    Height = 217
    DataSource = ds1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_HISTORICO'
        Title.Caption = 'HIST'#211'RICO'
        Width = 175
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Width = 25
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_CONTA'
        Title.Caption = 'CONTA CONT'#193'BIL'
        Width = 180
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CODIGO_REDUZ'
        Title.Caption = 'C'#211'D. REDUZ'
        Width = 80
        Visible = True
      end>
  end
  object btnFechar: TButton
    Left = 650
    Top = 214
    Width = 161
    Height = 35
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btnFecharClick
  end
  object rgTipos: TRadioGroup
    Left = 650
    Top = 32
    Width = 172
    Height = 113
    Caption = 'Tipos'
    ItemIndex = 0
    Items.Strings = (
      'Nenhum'
      'Centro de Custo'
      'Opera'#231#227'o banc'#225'ria'
      'Todos')
    TabOrder = 3
  end
  object qryObterHistoricos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT H.ID_HISTORICO,'
      '       H.ID_ORGANIZACAO,'
      '       H.DESCRICAO AS DESCRICAO_HISTORICO,'
      '       H.TIPO, '
      '       H.CODIGO,'
      '       H.DESCRICAO_REDUZIDA, '
      '       CC.CONTA, '
      '       CC.DESCRICAO AS DESCRICAO_CONTA, '
      '       CC.CODREDUZ AS CODIGO_REDUZ'
      ''
      'FROM HISTORICO H'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '
      ''
      'WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      ''
      'ORDER BY H.CODIGO DESC'
      ''
      '')
    Left = 228
    Top = 272
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object ds1: TDataSource
    DataSet = qryObterHistoricos
    Left = 264
    Top = 176
  end
  object frxRepHistorico: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43784.577237638900000000
    ReportOptions.LastChange = 43791.515224421300000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 132
    Top = 272
  end
  object frxDBHistorico: TfrxDBDataset
    UserName = 'Historico'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_HISTORICO=ID_HISTORICO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO_HISTORICO=DESCRICAO_HISTORICO'
      'TIPO=TIPO'
      'CODIGO=CODIGO'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'CONTA=CONTA'
      'DESCRICAO_CONTA=DESCRICAO_CONTA'
      'CODIGO_REDUZ=CODIGO_REDUZ')
    DataSet = qryObterHistoricos
    BCDToCurrency = False
    Left = 132
    Top = 272
  end
  object qryObterCC: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CC.ID_CENTRO_CUSTO,'
      '       CC.DESCRICAO,'
      '       CC.CODIGO,'
      '       CC.SIGLA'
      ''
      'FROM CENTRO_CUSTO CC'
      ''
      'WHERE (CC.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      ''
      'ORDER BY CC.DESCRICAO'
      ''
      '')
    Left = 180
    Top = 272
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxDBCC: TfrxDBDataset
    UserName = 'CENTRO_CUSTO'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'DESCRICAO=DESCRICAO'
      'CODIGO=CODIGO'
      'SIGLA=SIGLA')
    DataSet = qryObterCC
    BCDToCurrency = False
    Left = 232
    Top = 272
  end
  object qryObterTOB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TOB.id_tipo_operacao_bancaria,'
      '       TOB.id_organizacao,'
      '       TOB.descricao,'
      '       TOB.tipo,'
      '       TOB.codigo,'
      '       TOB.id_conta_contabil,'
      '       CC.conta,'
      '       CC.descricao AS DSC_CONTA,'
      '       CC.codreduz'
      ''
      'FROM TIPO_OPERACAO_BANCARIA TOB'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = TOB' +
        '.id_conta_contabil) AND (CC.id_organizacao = TOB.id_organizacao)'
      ''
      'WHERE (TOB.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      'ORDER BY TOB.DESCRICAO')
    Left = 132
    Top = 272
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxTOB: TfrxDBDataset
    UserName = 'TOB'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO=DESCRICAO'
      'TIPO=TIPO'
      'CODIGO=CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CONTA=CONTA'
      'DSC_CONTA=DSC_CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryObterTOB
    BCDToCurrency = False
    Left = 272
    Top = 272
  end
end
