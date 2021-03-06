unit Server.UsuarioController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Server.Controller, DBXJSON,
  DBXCommon, Usuario,DSService,Helpers;
type
  TUsuarioController = class(TController<TUsuario>)
  private

  public
    //consultar
    function Usuarios(pCampo: String; pValue:String; pTipo:String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptUsuarios(pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateUsuarios(pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelUsuarios(pId: Integer): Boolean;

    function Autenticar(usuario,senha: String): Boolean;
  end;

implementation

uses JSonVO, ORM, DBConnection, SA, ServerContainer;

var
  objBanco: TUsuario;

  { TUsuarioController }

function TUsuarioController.AcceptUsuarios(pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  obj:TUsuario;
begin
  //Fazendo um pequeno tratamento no campo Senha para salv�-lo em MD5
  obj := TJSonVO.JSONToObject<TUsuario>(pObjeto);
  obj.Senha := MD5String(obj.Senha);
  pObjeto := TJSonVO.ObjectToJSON<TUsuario>(obj);
  result := self.Accept(pObjeto);
end;

function TUsuarioController.Autenticar(usuario, senha: String): Boolean;
begin
//
end;

function TUsuarioController.CancelUsuarios(pId: Integer): Boolean;
Begin
  result := self.Cancel(pId);
end;
function TUsuarioController.UpdateUsuarios(pObjeto: TJSONValue): TJSONArray;
begin
  result := self.UpdateUsuarios(pObjeto);
end;

function TUsuarioController.Usuarios(pCampo: String; pValue:String; pTipo:String; pPagina: Integer): TJSONArray;
begin
  result := self.List(pCampo, pValue, pTipo, pPagina);
end;

end.
