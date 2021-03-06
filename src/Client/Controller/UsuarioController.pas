unit UsuarioController;

interface

uses
  Controller,Usuario,System.Classes,DBXJSON,idHTTP,Dialogs,System.SysUtils,IdStack ;



type
  TUsuarioController = class(TController<TUsuario>)
  private

  protected
  public
    constructor create;
    class procedure AtualizaGrid(streamResposta: TStringStream);
    class function Autenticar(usuario,senha: String):boolean;
  end;

implementation

uses UDm, JSonVO;

var
  Usuario: TUsuario;

const
  url = 'http://localhost/datasnap/restT2Ti/TUsuarioController/';

{ TUsuarioController }

class procedure TUsuarioController.AtualizaGrid(
  streamResposta: TStringStream);
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

  Dm.CDSUsuario.DisableControls;
  Dm.CDSUsuario.EmptyDataSet;

  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    Usuario := TJSonVO.JSONToObject<TUsuario>(jItem);

    Dm.CDSUsuario.Append;
    Dm.CDSUsuario.Fields[0].AsInteger := Usuario.Id;
    Dm.CDSUsuario.Fields[1].AsString := Usuario.Nome;
    Dm.CDSUsuario.Fields[2].AsString := Usuario.Senha;
    Dm.CDSUsuario.Post;
  end;
  Dm.CDSUsuario.Open;
  Dm.CDSUsuario.EnableControls;
end;

class function TUsuarioController.Autenticar(usuario, senha: String): boolean;
begin
    try
      Dm.SQLConnection1.Connected := false;
      Dm.SQLConnection1.Params.Values['DSAuthenticationPassword'] := senha;
      Dm.SQLConnection1.Params.Values['DSAuthenticationUser'] := usuario;
      Dm.SQLConnection1.Connected := true;
      result := true;
    except
      on E: Exception  do
      begin
          if Pos('socket',LowerCase(e.Message)) > 0 then
              ShowMessage('O servidor n�o est� dispon�vel')
          else  ShowMessage('Usu�rio ou senha inv�lidos: '+E.Message);
          result := false;
      end;

    end;
end;

constructor TUsuarioController.create;
begin
inherited;
self.BaseUrl := url;
self.ControllerAlias := 'Usuarios'
end;

end.

