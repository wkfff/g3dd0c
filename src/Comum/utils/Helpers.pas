unit Helpers;

interface

uses
Vcl.Forms, IdHashMessageDigest,Vcl.Controls;

function AbrirForm(ClassType:TFormClass;Form:TForm):TModalResult;

function MD5String(const Value: string): string;

function HttpResponseMessage(Code:Integer):string
;

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

function AbrirForm(ClassType:TFormClass;Form:TForm):TModalResult;
Begin
  Application.CreateForm(ClassType,Form);
  result := Form.ShowModal;
End;

end.
