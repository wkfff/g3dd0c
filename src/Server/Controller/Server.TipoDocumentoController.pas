unit Server.TipoDocumentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Server.Controller, DBXJSON,
  DBXCommon, TipoDocumento;

type
  TTipoDocumentoController = class(TController<TTipoDocumento>)
  protected
  public
    // consultar
    function TipoDocumento(pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptTipoDocumento(pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateTipoDocumento(pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelTipoDocumento(pId: Integer): Boolean;
  end;

implementation

uses JSonVO, ORM;

var
  objBanco: TTipoDocumento;

  { TTipoDocumentoController }

function TTipoDocumentoController.AcceptTipoDocumento(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Accept(pObjeto);
end;

function TTipoDocumentoController.CancelTipoDocumento(pId: Integer): Boolean;
begin
  result := self.Cancel(pId);
end;

function TTipoDocumentoController.UpdateTipoDocumento(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Update(pObjeto);
end;

function TTipoDocumentoController.TipoDocumento(pFiltro: String;
  pPagina: Integer): TJSONArray;
begin
  //self.List()
end;

end.
