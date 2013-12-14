unit Server.CargoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Server.Controller, DBXJSON,
  DBXCommon, Cargo;

type
  TCargoController = class(TController<TCargo>)
  protected
  public
    // consultar
    function Cargo(pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptCargo(pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateCargo(pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelCargo(pId: Integer): Boolean;
  end;

implementation

uses JSonVO, ORM;

var
  objBanco: TCargo;

  { TTipoDocumentoController }

function TCargoController.AcceptCargo(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Accept(pObjeto);
end;

function TCargoController.CancelCargo(pId: Integer): Boolean;
begin
  result := self.Cancel(pId);
end;

function TCargoController.UpdateCargo(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Update(pObjeto);
end;

function TCargoController.Cargo(pFiltro: String;
  pPagina: Integer): TJSONArray;
begin
  //self.List()
end;
end.
