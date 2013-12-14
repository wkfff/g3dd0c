unit UnidadeOrcamentariaController;

interface

uses
Controller,System.Classes,DBXJSON,UnidadeOrcamentaria,Orgao,Generics.Collections;

type
  TUnidadeOrcamentariaController = class(TController<TUnidadeOrcamentaria>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
    function findOrgao(id:integer;var retorna : boolean):TOrgao;
  end;

var

UnidadeOrcamentaria:TUnidadeOrcamentaria;

implementation

{ TTipoDocumentoController }

uses UDm, JSonVO, OrgaoController;

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

function TUnidadeOrcamentariaController.findOrgao(id: integer; var retorna : boolean): TOrgao;
var
  orgaos : TObjectList<TOrgao>;
  orgaoController:TOrgaoController;
begin
  orgaoController := TOrgaoController.create;
  retorna := true;
  inherited;
  orgaos := orgaoController.Find(id);
  if orgaos.Count > 0 then
      result := orgaos.Items[0]
  else retorna := false;
end;

end.
