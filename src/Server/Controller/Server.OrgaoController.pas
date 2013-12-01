unit Server.OrgaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, DBXJSON,
  DBXCommon, Orgao, Server.Controller;

type
  TOrgaoController = class(TController<TOrgao>)
  protected
  public
    // consultar
    function Orgao(pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptOrgao(pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateOrgao(pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelOrgao(pId: Integer): Boolean;
  end;

implementation

uses JSonVO;

var
  objBanco: TOrgao;

  { TTipoDocumentoController }

function TOrgaoController.AcceptOrgao(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Accept(pObjeto);
end;

function TOrgaoController.CancelOrgao(pId: Integer): Boolean;
begin
  result := self.Cancel(pId);
end;

function TOrgaoController.UpdateOrgao(pObjeto: TJSONValue)
  : TJSONArray;
begin
  result := self.Update(pObjeto);
end;

function TOrgaoController.Orgao(pFiltro: String;
  pPagina: Integer): TJSONArray;
begin
  //self.List()
end;

end.
