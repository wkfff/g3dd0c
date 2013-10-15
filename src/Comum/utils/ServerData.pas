unit ServerData;

interface

uses


   SysUtils,Atributos;

type

  TServerData = class
  private
    FError: Boolean;
    FKey: String;
    FValue: String;
    FDefaultIndex: Boolean;
  public
    property Error: Boolean  read FError write FError;
    property Key    : String  read FKey write FKey;
    property Value  : String  read FValue write FValue;
    property DefaultIndex: Boolean  read FDefaultIndex write FDefaultIndex;

  end;

implementation

end.
