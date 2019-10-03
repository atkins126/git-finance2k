object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 347
  Width = 558
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 216
    Top = 256
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 112
    Top = 256
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 328
    Top = 256
  end
  object ConnMega: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evMode, evDetailDelay]
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    ResourceOptions.AssignedValues = [rvCmdExecMode, rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Left = 416
    Top = 160
  end
  object qryEstacoesConectadas: TFDQuery
    SQL.Strings = (
      'SELECT DISTINCT'
      '  MA.MON$ATTACHMENT_ID AS ID,'
      '  MA.MON$REMOTE_PROTOCOL AS PROTOCOLO,'
      '  MA.MON$REMOTE_ADDRESS AS ENDERECO,'
      '  MA.MON$REMOTE_PROCESS AS PROCESSO'
      'FROM'
      '  MON$ATTACHMENTS MA'
      'WHERE'
      '  (MA.MON$ATTACHMENT_ID <> CURRENT_CONNECTION)'
      '')
    Left = 216
    Top = 160
  end
  object qryObterGUID: TFDQuery
    SQL.Strings = (
      'select createguid() as newID from rdb$database')
    Left = 216
    Top = 88
  end
  object conn: TFDConnection
    ConnectionName = 'conn'
    Params.Strings = (
      'ConnectionDef=FINANCE')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    Left = 416
    Top = 40
  end
end
