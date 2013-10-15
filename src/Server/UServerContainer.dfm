object ServerContainer: TServerContainer
  Left = 0
  Top = 0
  Caption = 'ServerContainer'
  ClientHeight = 121
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DSServer: TDSServer
    AutoStart = False
    HideDSAdmin = False
    Left = 40
    Top = 11
  end
  object DSHTTPService: TDSHTTPService
    RESTContext = 'restT2Ti'
    Server = DSServer
    DSHostname = 'localhost'
    DSPort = 211
    Filters = <>
    Active = False
    Left = 136
    Top = 15
  end
end
