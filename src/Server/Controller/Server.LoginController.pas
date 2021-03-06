unit Server.LoginController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Server.Controller, DBXJSON, DBXCommon,Usuario;

type
  TBancoController = class(TController<TUsuario>)
  private

  protected

  public
    //consultar
	  Function Banco(pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    Function AcceptBanco(pObjeto: TJSONValue): TJSONArray;
    //alterar
    Function UpdateBanco(pObjeto: TJSONValue): TJSONArray;
    //excluir
    Function CancelBanco(pId: Integer): Boolean;
  end;

implementation

{ TBancoController }

function TBancoController.AcceptBanco(pObjeto: TJSONValue): TJSONArray;
begin
//
end;

function TBancoController.Banco(pFiltro: String; pPagina: Integer): TJSONArray;
begin
//
end;

function TBancoController.CancelBanco(pId: Integer): Boolean;
begin
//
end;

function TBancoController.UpdateBanco(pObjeto: TJSONValue): TJSONArray;
begin
//
end;

end.
