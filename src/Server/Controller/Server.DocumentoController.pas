unit Server.DocumentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Server.Controller, DBXJSON,
  DBXCommon, Documento;

type
  TDocumentoController = class(TController<TDocumento>)
  protected
  public
    // consultar
    function Documento(pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptDocumento(pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateDocumento(pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelDocumento(pId: Integer): Boolean;
  end;

implementation

uses JSonVO, ORM;

var
  objBanco: TDocumento;

  { TDocumentoController }

function TDocumentoController.AcceptDocumento(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Accept(pObjeto);
end;

function TDocumentoController.CancelDocumento(pId: Integer): Boolean;
begin
  result := self.Cancel(pId);
end;

function TDocumentoController.UpdateDocumento(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Update(pObjeto);
end;

function TDocumentoController.Documento(pFiltro: String;
  pPagina: Integer): TJSONArray;
begin
  //self.List()
end;

end.