unit TipoDocumentoController;

interface

uses
Controller,TipoDocumento,System.Classes,DBXJSON;

type
  TTipoDocumentoController = class(TController<TTipoDocumento>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
  end;

var
TipoDocumento:TTipoDOcumento;

implementation

{ TTipoDocumentoController }

uses UDm, JSonVO;

class procedure TTipoDocumentoController.AtualizaGrid(streamResposta: TStringStream);
var
  jObj: TJSONObject;
  jPair: TJSONPair;
  jItems: TJSONArray;
  jItem: TJSONValue;
  i: Integer;
begin
  jObj := TJSONObject.Create;
  jObj.Parse(streamResposta.Bytes, 0);
  jPair := jObj.Get(0);
  jItems := TJSONArray(TJSONArray(jPair.JsonValue).Get(0));

  Dm.cdsTipoDocumento.DisableControls;
  Dm.cdsTipoDocumento.EmptyDataSet;

  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    TipoDocumento := TJSonVO.JSONToObject<TTipoDocumento>(jItem);
    Dm.cdsTipoDocumento.Append;
    Dm.cdsTipoDocumento.Fields[0].AsInteger := TipoDocumento.Id;
    Dm.cdsTipoDocumento.Fields[1].AsString := TipoDocumento.Nome;
    Dm.cdsTipoDocumento.Post;
  end;
  Dm.cdsTipoDocumento.Open;
  Dm.cdsTipoDocumento.EnableControls;
end;

constructor TTipoDocumentoController.create;
begin
  self.BaseUrl := 'http://localhost/datasnap/restT2Ti/TTipoDocumentoController/';
  self.ControllerAlias := 'TipoDocumento';
end;

end.
