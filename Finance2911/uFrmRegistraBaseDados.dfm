object frmRegistraBaseDados: TfrmRegistraBaseDados
  Left = 0
  Top = 0
  Caption = 'Registra Base de Dados'
  ClientHeight = 300
  ClientWidth = 635
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
  DesignSize = (
    635
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 31
    Top = 115
    Width = 127
    Height = 13
    Caption = 'Ip Servidor Base de Dados'
  end
  object Label1: TLabel
    Left = 342
    Top = 118
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object edtOrigem: TLabeledEdit
    Left = 31
    Top = 75
    Width = 393
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 130
    EditLabel.Height = 13
    EditLabel.Caption = 'Caminho da Base de Dados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnOrigem: TBitBtn
    Left = 446
    Top = 75
    Width = 120
    Height = 31
    Anchors = [akTop, akRight]
    Caption = 'Pesquisar Arquivo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnOrigemClick
  end
  object btnSalvar: TBitBtn
    Left = 446
    Top = 132
    Width = 120
    Height = 31
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object edtIpServerBD: TEdit
    Left = 31
    Top = 137
    Width = 154
    Height = 21
    TabOrder = 3
  end
  object edtPortaBanco: TEdit
    Left = 342
    Top = 137
    Width = 82
    Height = 21
    TabOrder = 4
  end
  object btnVerIP: TBitBtn
    Left = 207
    Top = 135
    Width = 92
    Height = 25
    Caption = 'Pegar IP'
    TabOrder = 5
    OnClick = btnVerIPClick
  end
  object btnFechar: TButton
    Left = 446
    Top = 184
    Width = 120
    Height = 25
    Caption = 'Fechar'
    TabOrder = 6
    OnClick = btnFecharClick
  end
  object dlgOrigem: TOpenDialog
    Left = 247
    Top = 208
  end
end
