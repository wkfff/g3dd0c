{*******************************************************************************
Title: T2Ti ERP
Description: Classe TJsonVO padrão de onde herdam todas as classes de VO

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 1.1
*******************************************************************************}
unit JSonVO;

interface

uses
  DBXJSON, DBXJSONReflect, DBXCommon, RTTI, TypInfo, Atributos;

type
  TJSonVO = class
  public
    class function ObjectToJSON<O : class>(objeto: O): TJSONValue;
    class function JSONToObject<O : class>(json: TJSONValue): O;
  end;

implementation

{ TJSonVO }

class function TJSonVO.JSONToObject<O>(json: TJSONValue): O;
var
  deserializa: TJSONUnMarshal;
begin
  if json is TJSONNull then
    exit(nil);

  deserializa := TJSONUnMarshal.Create;
  try
    exit(O(deserializa.Unmarshal(json)))
  finally
    deserializa.Free;
  end;
end;

class function TJSonVO.ObjectToJSON<O>(objeto: O): TJSONValue;
var
  serializa: TJSONMarshal;
begin
  if Assigned(objeto) then
  begin
    serializa := TJSONMarshal.Create(TJSONConverter.Create);
    try
      exit(serializa.Marshal(objeto));
    finally
      serializa.Free;
    end;
  end
  else
    exit(TJSONNull.Create);
end;

end.
