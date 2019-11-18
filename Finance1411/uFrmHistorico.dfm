object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Hist'#243'ricos'
  ClientHeight = 591
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline frameHistorico1: TframeHistorico
    Left = 8
    Top = 32
    Width = 442
    Height = 89
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 32
    ExplicitHeight = 89
    inherited qryObterPorID: TFDQuery
      Left = 32
      Top = 32
    end
    inherited qryObterTodos: TFDQuery
      Left = 120
      Top = 32
      ParamData = <
        item
          Name = 'PIDORGANIZACAO'
          DataType = ftString
          ParamType = ptInput
          Size = 36
        end>
    end
  end
  object dbgrd1: TDBGrid
    Left = 8
    Top = 160
    Width = 622
    Height = 329
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
  object qryObterHistoricos: TFDQuery
    Active = True
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
      'ORDER BY CC.CONTA'
      ''
      '')
    Left = 388
    Top = 328
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
    Left = 232
    Top = 328
  end
end