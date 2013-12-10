unit Server.UnidadeOrcamentariaController;

interface

uses Classes, SQLExpr, SysUtils, Generics.Collections, Server.Controller, DBXJSON,
  DBXCommon, UnidadeOrcamentaria;

type
  TUnidadeOrcamentariaController = class(TController<TUnidadeOrcamentaria>)
  protected
  public
    // consultar
    function UnidadeOrcamentaria(pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptUnidadeOrcamentaria(pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateUnidadeOrcamentaria(pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelUnidadeOrcamentaria(pId: Integer): Boolean;
  end;

implementation

uses JSonVO, ORM;

var
  objBanco: TUnidadeOrcamentaria;

function TUnidadeOrcamentariaController.AcceptUnidadeOrcamentaria(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Accept(pObjeto);
end;

function TUnidadeOrcamentariaController.CancelUnidadeOrcamentaria(pId: Integer): Boolean;
begin
  result := self.Cancel(pId);
end;

function TUnidadeOrcamentariaController.UpdateUnidadeOrcamentaria(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Update(pObjeto);
end;

function TUnidadeOrcamentariaController.UnidadeOrcamentaria(pFiltro: String;
  pPagina: Integer): TJSONArray;
begin
  //self.List()
end;

end.
