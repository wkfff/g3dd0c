unit UnidadeOrcamentariaController;

interface

uses
Controller,System.Classes,DBXJSON,UnidadeOrcamentaria;

type
  TUnidadeOrcamentariaController = class(TController<TUnidadeOrcamentaria>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
  end;

var

UnidadeOrcamentaria:TUnidadeOrcamentaria;

implementation

{ TTipoDocumentoController }

uses UDm, JSonVO;

class procedure TUnidadeOrcamentariaController.AtualizaGrid(streamResposta: TStringStream);
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

  Dm.cdsUnidadeOrcamentaria.DisableControls;
  Dm.cdsUnidadeOrcamentaria.EmptyDataSet;

  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    UnidadeOrcamentaria := TJSonVO.JSONToObject<TUnidadeOrcamentaria>(jItem);
    Dm.cdsUnidadeOrcamentaria.Append;
    Dm.cdsUnidadeOrcamentaria.Fields[0].AsInteger := UnidadeOrcamentaria.Id;
    Dm.cdsUnidadeOrcamentaria.Fields[1].AsString := UnidadeOrcamentaria.Nome;
    Dm.cdsUnidadeOrcamentaria.Fields[2].AsString := UnidadeOrcamentaria.Cod_Contabil;
    Dm.cdsUnidadeOrcamentaria.Fields[3].AsInteger := UnidadeOrcamentaria.Orgao_id;
    Dm.cdsUnidadeOrcamentaria.Post;
  end;
  Dm.cdsUnidadeOrcamentaria.Open;
  Dm.cdsUnidadeOrcamentaria.EnableControls;
end;

constructor TUnidadeOrcamentariaController.create;
begin
  self.BaseUrl := 'http://localhost/datasnap/restT2Ti/TUnidadeOrcamentariaController/';
  self.ControllerAlias := 'UnidadeOrcamentaria';
end;

end.
