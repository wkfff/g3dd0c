object FServerContainer: TFServerContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 154
  Width = 260
  object DSServer: TDSServer
    AutoStart = False
    Left = 40
    Top = 11
  end
  object DSHTTPService: TDSHTTPService
    RESTContext = 'restT2Ti/'
    Server = DSServer
    Filters = <>
    AuthenticationManager = DSAuthenticationManager1
    Left = 136
    Top = 15
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 104
    Top = 96
  end
end
