unit Validators.CoreAttributes;

interface

uses
Variants,RegularExpressions;

type
  validator_attr = class(TCustomAttribute)
  protected
    FErrorMessage:String;
  public
    property ErrorMessage:String read FErrorMessage write FErrorMessage;
    function isValid(pValue:Variant):boolean;virtual;abstract;
  end;

type
  validates_presence = class(validator_attr)
  public
    constructor Create(pErrorMessage:String='');overload;
    function isValid(pValue:Variant):boolean;override;
  end;

  validates_format = class(validator_attr)
  protected
    FFormat:String;
  public
    constructor Create(pFormat:String; pErrorMessage:String='');overload;
    function isValid(pValue:Variant):boolean;override;
  end;


  validates_size = class(validator_attr)
  protected
    FMinSize:Integer;
    FMaxSize:Integer;
  public
    constructor Create(pMinSize:Integer;pMaxSize:Integer;pErrorMessage:String='');overload;
    function isValid(pValue:Variant):boolean;override;
  end;

  implementation


{ TValidator }


{ validates_presence }

constructor validates_presence.Create(pErrorMessage: String);
begin
  if pErrorMessage <> '' then
    self.ErrorMessage := pErrorMessage;
end;

function validates_presence.isValid(pValue:Variant): boolean;
begin
  if (pValue <> null) and  (VarToStr(pValue) <> '') then
    result := true
  else result := false;
end;

{ validates_format }

constructor validates_format.Create(pFormat, pErrorMessage: String);
begin
  self.FFormat := pFormat;
  if pErrorMessage <> '' then
    self.FErrorMessage := pErrorMessage;
end;

function validates_format.isValid(pValue: Variant): boolean;
begin
  if (pValue <> null) and  (VarToStr(pValue) <> '') then
    Begin
        if TRegEx.IsMatch(pValue,FFormat) then
            result := true
        else result := false;
    end;
end;

{ validates_size }

constructor validates_size.Create(pMinSize, pMaxSize: Integer;
  pErrorMessage: String);
begin
   if pErrorMessage <> '' then
      self.FErrorMessage := pErrorMessage;
end;

function validates_size.isValid(pValue: Variant): boolean;
begin
  if (VarToStr(pValue) <> '') then
    Begin
        if (Length(pValue) <= FMaxSize) and (Length(pValue) >= FMinSize) then
            result := true
        else result := false;
    end;
end;

end.
