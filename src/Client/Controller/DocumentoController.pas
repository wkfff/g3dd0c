unit DocumentoController;

interface

uses
Controller,Documento,System.Classes,DBXJSON;

type
  TDocumentoController = class(TController<TDocumento>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
  end;

var
Documento:TDOcumento;

implementation

{ TTipoDocumentoController }

uses UDm, JSonVO;

class procedure TDocumentoController.AtualizaGrid(streamResposta: TStringStream);
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
    Documento := TJSonVO.JSONToObject<TDocumento>(jItem);
    Dm.cdsTipoDocumento.Append;
    Dm.CDSDocumento.Fields[0].AsInteger  := Documento.Id;
    Dm.CDSDocumento.Fields[1].AsString   := Documento.Nome;
    Dm.CDSDocumento.Fields[3].AsInteger  := Documento.IdTipoDocumento;
    Dm.CDSDocumento.Fields[4].AsString   := Documento.Descricao;
    Dm.CDSDocumento.Fields[5].AsString   := Documento.PalavraChave;
    Dm.CDSDocumento.Fields[6].AsString   := Documento.PodeAlterar;
    Dm.CDSDocumento.Fields[7].AsString   := Documento.Assinado;
    Dm.CDSDocumento.Fields[8].AsDateTime := Documento.DataFimVigencia;
    Dm.CDSDocumento.Fields[9].AsDateTime := Documento.DataExclusao;
    Dm.cdsDocumento.Post;
  end;
  Dm.cdsDocumento.Open;
  Dm.cdsDocumento.EnableControls;
end;

constructor TDocumentoController.create;
begin
  self.BaseUrl := 'http://localhost/datasnap/restT2Ti/TDocumentoController/';
  self.ControllerAlias := 'Documento';

end;

end.
