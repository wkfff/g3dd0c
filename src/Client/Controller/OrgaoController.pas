unit OrgaoController;

interface

uses
Controller,System.Classes,DBXJSON,Orgao,Generics.Collections;

type
  TOrgaoController = class(TController<TOrgao>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
    function findOrgao(id:integer;var retorna : boolean):TOrgao;
  end;

var
Orgao:TOrgao;

implementation

{ TTipoDocumentoController }

uses UDm, JSonVO;

class procedure TOrgaoController.AtualizaGrid(streamResposta: TStringStream);
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

  Dm.cdsOrgao.DisableControls;
  Dm.cdsOrgao.EmptyDataSet;

  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    Orgao := TJSonVO.JSONToObject<TOrgao>(jItem);
    Dm.cdsOrgao.Append;
    Dm.cdsOrgao.Fields[0].AsInteger := Orgao.Id;
    Dm.cdsOrgao.Fields[1].AsString := Orgao.Nome;
    Dm.cdsOrgao.Fields[2].AsString := Orgao.Cod_Contabil;
    Dm.cdsOrgao.Post;
  end;
  Dm.cdsOrgao.Open;
  Dm.cdsOrgao.EnableControls;
end;

constructor TOrgaoController.create;
begin
  self.BaseUrl := 'http://localhost/datasnap/restT2Ti/TOrgaoController/';
  self.ControllerAlias := 'Orgao';
end;



function TOrgaoController.findOrgao(id: integer; var retorna: boolean): TOrgao;
var
  orgaos : TObjectList<TOrgao>;
  orgaoController:TOrgaoController;
begin
  orgaoController := TorgaoController.create;
  inherited;
  retorna := true;
  orgaos := orgaoController.Find(id);
  if orgaos.Count > 0 then
      result := orgaos.Items[0]
  else retorna := false;
end;

end.
