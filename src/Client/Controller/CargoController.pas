unit CargoController;

interface

uses Controller,System.Classes,DBXJSON,Cargo,Generics.Collections, JSonVO;

type
  TCargoController = class(TController<TCargo>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
  end;

var
Cargo : TCargo;

implementation

{ TOrgaoController }

uses UDm;

class procedure TCargoController.AtualizaGrid(streamResposta: TStringStream);
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

  Dm.CDSCargo.DisableControls;
  Dm.CDSCargo.EmptyDataSet;

  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    Cargo := TJSonVO.JSONToObject<TCargo>(jItem);
    Dm.CDSCargo.Append;
    Dm.CDSCargo.Fields[0].AsInteger  := Cargo.Id;
    Dm.CDSCargo.Fields[1].AsString   := Cargo.Nome;
    Dm.CDSCargo.Fields[2].AsString  := Cargo.Codigo;
    Dm.CDSCargo.Post;
  end;
  Dm.cdsCargo.Open;
  Dm.cdsCargo.EnableControls;
end;

constructor TCargoController.create;
begin
  self.BaseUrl := 'http://localhost/datasnap/restT2Ti/TCargoController/';
  self.ControllerAlias := 'Cargo';
end;

end.
