unit Controller;

interface

uses
  Classes, DBXJSON, Datasnap.DSHTTPClient, Dialogs, SysUtils, DBClient, DB,
  Windows, Forms, superobject,ServerData,
  Usuario, BaseModel, JSonVO, DBXCommon, Generics.Collections;

type


  TController<O: class> = class
  private
    FBaseUrl: String;
    FControllerAlias: String;
    modelList: TObjectList<O>;
    FserverErrors: TObjectList<TServerData>;
    function AtualizaLista(streamResposta: TStringStream): TObjectList<O>;
    procedure SetErrors(streamResposta: TStringStream);
    function AtualizaIndices(streamResposta: TStringStream):  TObjectList<TServerData>;
  public
    property BaseUrl: String read FBaseUrl write FBaseUrl;
    property ControllerAlias: String read FControllerAlias
      write FControllerAlias;
    function Consulta(pCampo: String; pValue:String; pTipo:String; pPagina: Integer): TObjectList<O>;
    function IndexFields(var response: TObjectList<TServerData>): boolean;
    function Insere(pTipoDocumento: O;var errorList:TObjectList<TServerData>): O;
    function Altera(pTipoDocumento: O;var errorList:TObjectList<TServerData>): O;
    Procedure Exclui(pId: Integer);
    function GetErrors:TObjectList<TServerData>;
    function Find(id: Integer): TObjectList<O>;
  end;

implementation

{ TController }

uses UDm, Helpers;

function TController<O>.Altera(pTipoDocumento: O;var errorList:TObjectList<TServerData>): O;
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItem: TJSONValue;
  http : TDSHTTP;
  Lista:TObjectList<O>;
begin
  try
    try
      jItem := TJSonVO.ObjectToJSON<O>(pTipoDocumento);
      http := TDSHTTP.Create;
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);

      dataStream := TStringStream.Create(jItem.ToString);
      streamResposta := TStringStream.Create;
      http.Put(FBaseUrl + FControllerAlias + '/', dataStream, streamResposta);
      self.SetErrors(streamResposta);
      errorList := self.FserverErrors;

      Lista := AtualizaLista(streamResposta);
      if Lista.Count > 0 then
          result := O(Lista.Items[0])
      else result := nil;
      //result := O(AtualizaLista(streamResposta).Items[0]);
    except
      Application.MessageBox('Ocorreu um erro. Inclus�o n�o realizada.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    http.Free;
    dataStream.Free;
  end;
end;

function TController<O>.AtualizaIndices(
  streamResposta: TStringStream): TObjectList<TServerData>;
var
  jObj: TJSONObject;
  jPair: TJSONPair;
  jItems: TJSONArray;
  jItem: TJSONValue;
  i: Integer;
  list: TObjectList<TServerData>;
begin
  jObj := TJSONObject.Create;
  jObj.Parse(streamResposta.Bytes, 0);
  jPair := jObj.Get(0);
  jItems := TJSONArray(TJSONArray(jPair.JsonValue).Get(0));
  list := TObjectList<TServerData>.Create;
  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    try
      if jItem is TJSONObject then
        list.Add(TJSonVO.JSONToObject<TServerData>(jItem));
    except
    end;
  end;
  result := list;
end;

function TController<O>.AtualizaLista(streamResposta: TStringStream)
  : TObjectList<O>;
var
  jObj: TJSONObject;
  jPair: TJSONPair;
  jItems: TJSONArray;
  jItem: TJSONValue;
  i: Integer;
  list: TObjectList<O>;
  vObject: TObjectList<TObject>;
begin
  jObj := TJSONObject.Create;
  jObj.Parse(streamResposta.Bytes, 0);
  jPair := jObj.Get(0);
  jItems := TJSONArray(TJSONArray(jPair.JsonValue).Get(0));
  list := TObjectList<O>.Create;


  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    try
      if jItem is TJSONObject then
        Begin
           if TJSonVO.JSONToObject<TObject>(jItem) is O then
               list.Add(TJSonVO.JSONToObject<O>(jItem));
        End;
    except
    end;
  end;
  result := list;
end;

function TController<O>.Find(id: Integer)
  : TObjectList<O>;
var
  http: TDSHTTP;
  streamResposta: TStringStream;
  modelList: TObjectList<O>;
begin
  try
    try
      http := TDSHTTP.Create;
      try
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);
      streamResposta := TStringStream.Create;
      http.Get(FBaseUrl +'find/' + IntToStr(id), streamResposta);
      modelList := AtualizaLista(streamResposta);
      result := modelList;
      except
        ShowMessage(http.Response.ResponseText);
      end;
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
    http.Free;
  end;
end;

function TController<O>.Consulta(pCampo: String; pValue:String; pTipo:String; pPagina: Integer)
  : TObjectList<O>;
var
  http: TDSHTTP;
  streamResposta: TStringStream;
  modelList: TObjectList<O>;
begin
  try
    try
      http := TDSHTTP.Create;
      try
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);
      streamResposta := TStringStream.Create;
      http.Get(FBaseUrl +'list/' + pCampo + '/' + pValue + '/' + pTipo + '/' +
        IntToStr(pPagina), streamResposta);
      modelList := AtualizaLista(streamResposta);
      result := modelList;
      except
        ShowMessage(http.Response.ResponseText);
      end;
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
    http.Free;
  end;
end;

procedure TController<O>.Exclui(pId: Integer);
var
  http: TDSHTTP;
begin
  try
    try
      http := TDSHTTP.Create;
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);
      http.Delete(FBaseUrl + FControllerAlias + '/' + IntToStr(pId));
    except
      Application.MessageBox('Ocorreu um erro na exclus�o do cliente.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    http.Free;
  end;
end;

function TController<O>.GetErrors: TObjectList<TServerData>;
var
  http: TDSHTTP;
  streamResposta: TStringStream;
  modelList: TObjectList<TServerData>;
begin
  try
    try
      http := TDSHTTP.Create;
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);
      streamResposta := TStringStream.Create;
      http.Get(FBaseUrl +'IndexFields/', streamResposta);
      modelList := AtualizaIndices(streamResposta);
      result := modelList;
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
    http.Free;
  end;

end;

function TController<O>.IndexFields(var response: TObjectList<TServerData>)
  : boolean;
var
  http: TDSHTTP;
  streamResposta: TStringStream;
  responseStr:String;
  modelList: TObjectList<TServerData>;
begin
  try
    try
      http := TDSHTTP.Create;
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);

      try
        streamResposta := TStringStream.Create;
        responseStr :=  http.Get(FBaseUrl +'IndexFields/', streamResposta);

        modelList := AtualizaIndices(streamResposta);
        response := modelList;
        result := true;

      except
        ShowMessage(Helpers.HttpResponseMessage(http.ResponseCode));
        result := false;
      end;
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
    http.Free;
  end;
end;

function TController<O>.Insere(pTipoDocumento: O;var errorList:TObjectList<TServerData>): O;
var
  http: TDSHTTP;
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItem: TJSONValue;
  Lista:TObjectList<O>;
begin
  try
    try
      jItem := TJSonVO.ObjectToJSON<O>(pTipoDocumento);
      http := TDSHTTP.Create;
      http.SetBasicAuthentication(DM.SQLConnection1.Params.Values
        ['DSAuthenticationUser'], DM.SQLConnection1.Params.Values
        ['DSAuthenticationPassword']);

      dataStream := TStringStream.Create(jItem.ToString);
      streamResposta := TStringStream.Create;
      http.Put(FBaseUrl + FControllerAlias + '/', dataStream, streamResposta);
      self.SetErrors(streamResposta);
      errorList := self.FserverErrors;
      Lista := AtualizaLista(streamResposta);
      if Lista.Count > 0 then
          result := O(Lista.Items[0])
      else result := nil;
    except
      Application.MessageBox('Ocorreu um erro. Inclus�o n�o realizada.',
        'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    http.Free;
    dataStream.Free;
  end;
end;

procedure TController<O>.SetErrors(
  streamResposta: TStringStream);
var
  jObj: TJSONObject;
  jPair: TJSONPair;
  jItems: TJSONArray;
  jItem: TJSONValue;
  i: Integer;
  vObject: TObjectList<TObject>;
begin
  jObj := TJSONObject.Create;
  jObj.Parse(streamResposta.Bytes, 0);
  jPair := jObj.Get(0);
  jItems := TJSONArray(TJSONArray(jPair.JsonValue).Get(0));
  if self.FserverErrors = nil then
      self.FserverErrors := TObjectList<TServerData>.Create
  else self.FserverErrors.Clear;


  For i := 0 to jItems.Size - 1 do
  begin
    jItem := jItems.Get(i);
    try
      if jItem is TJSONObject then
        Begin
           if TJSonVO.JSONToObject<TObject>(jItem) is TServerData then
               self.FserverErrors.Add(TJSonVO.JSONToObject<TServerData>(jItem));
        End;
    except
    end;
  end;
end;

end.
