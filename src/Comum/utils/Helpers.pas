unit Helpers;

interface

uses
Vcl.Forms, IdHashMessageDigest;

procedure AbrirForm(ClassType:TFormClass;Form:TForm);

function MD5String(const Value: string): string;

function HttpResponseMessage(Code:Integer):String;

implementation

function HttpResponseMessage(Code:Integer):String;
Begin
  case code of
    401:result := 'Você não possui autorização para executar esta ação.';
  end;
End;

function MD5String(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  try
    Result := xMD5.HashStringAsHex(Value);
  finally
    xMD5.Free;
  end;
End;

procedure AbrirForm(ClassType:TFormClass;Form:TForm);
Begin
  Application.CreateForm(ClassType,Form);
  Form.ShowModal;
End;

end.
