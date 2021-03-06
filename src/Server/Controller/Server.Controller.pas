unit Server.Controller;

interface

uses
  Classes, DSServer, DBXJSON,BaseModel,Generics.Collections,JSonVO,
  Aurelius.Engine.ObjectManager,System.SysUtils,Validator,
  Aurelius.Criteria.Expression,
  Aurelius.Criteria.Linq,
  Aurelius.JSon.DataSnap,
  Aurelius.Criteria.Base,
  superobject;

type
  {$METHODINFO ON}
  TController<O:class,constructor> = class(TPersistent)
  private
    FManager: TObjectManager;
    FSerializer : TDataSnapJsonSerializer;
  public
    //function JsonResponse(sucesso:boolean;mensagem:string;Obj:TBaseModel=nil):TJSONArray;
    property Serializer: TDataSnapJsonSerializer read FSerializer Write FSerializer;
    property Manager: TObjectManager read FManager Write FManager;
    function List(pCampo: String; pValue:String; pTipo:String; pPagina: Integer): TJSONArray;
    function Find(id: integer): TJSONArray;
    function Accept(pObjeto: TJSONValue): TJSONArray;
    function Update(pObjeto: TJSONValue): TJSONArray;
    function Cancel(pId: Integer): Boolean;
    function IndexFields: TJSONArray;
    function Serializar(obj:O):TJsonObject;
    function JsonResponse(sucesso: boolean; mensagem: string;Obj:TBaseModel): TJSONArray;
    constructor Create;
  end;

implementation



uses ORM, DBConnection, SA, ServerContainer, ServerData;

{ TController }

{function TController<O>.JsonResponse(sucesso: boolean;
  mensagem: string;Obj:TBaseModel=nil): TJSONArray;
var
  ja: TJSONArray;
  jo: TJSONObject;
begin
  ja := TJSONArray.Create;
  try
    ja.Add(TJSONObject.Create(TJSONPair.Create('mensagem',mensagem)));
    if sucesso then
        ja.AddElement(TJSONObject.Create(TJSONPair.Create('sucesso',TJSONTrue.Create)))
    else ja.AddElement(TJSONObject.Create(TJSONPair.Create('sucesso',TJSONFalse.Create)));
    ja.AddElement(TJSonVO.ObjectToJSON(Obj).Create);
  except
    ja.Free;
    raise;
  end;
end;}

{ TController<O> }

function TController<O>.Accept(pObjeto: TJSONValue): TJSONArray;
var
  UltimoID,i: Integer;
  obj:O;
  errorList:TObjectList<TServerData>;
begin
  try
      if (FManager = nil) then
           FManager := TDBConnection.GetInstance.CreateObjectManager;
      obj := TJSonVO.JSONToObject<O>(pObjeto);
      result := TJSONArray.Create;
      if TValitador.validate(obj,errorList) then
          Begin
              FManager := TDBConnection.GetInstance.CreateObjectManager;
              FManager.SaveOrUpdate(obj);
              FManager.Flush;
              result.addElement(TJSonVO.ObjectToJson<O>(obj));
          End
      else
          Begin
              for i := 0 to errorList.Count - 1 do
                Begin
                  result.AddElement(TJSonVO.ObjectToJSON<TServerData>(errorList.Items[i]));
                end;
          End;
  finally
     if errorList <> nil then
         errorList.Free;
  end;
end;

function TController<O>.Cancel(pId: Integer): Boolean;
var
obj:O;
begin
  try
    try
      if (FManager = nil) then
           FManager := TDBConnection.GetInstance.CreateObjectManager;
      obj := O.Create;
      if not FManager.IsAttached(obj) then
          obj := FManager.Find<O>(pId);
      FManager.Remove(obj);
      result := True;
    except
      result := False;
    end;
  finally
    //obj.Free;
  end;
end;

constructor TController<O>.Create;
begin
inherited;
end;

function TController<O>.IndexFields: TJSONArray;
var
  UltimoID: Integer;
  obj:O;
  dictionary:TDictionary<String,String>;
  key,value:String;
  ja: TJSONArray;
  jo: TJSONObject;
  jv: TJSONValue;
  objJson: ISuperObject;
  sJson:string;
  oList:TObjectList<TServerData>;
  i:integer;
begin
  try
    obj := o.create;
    oList := TBaseModel(obj).IndexColumns;
    ja := TJSONArray.Create;
    objJson := SO;
    result := TJSONArray.Create;
    for i := 0 to oList.Count - 1 do
      Begin
        result.AddElement(TJSonVO.ObjectToJSON<TServerData>(oList.Items[i]));
      end;
  finally

  end;
end;

function TController<O>.JsonResponse(sucesso: boolean; mensagem: string;
  Obj: TBaseModel): TJSONArray;
var
  ja: TJSONArray;
  jo: TJSONObject;
  jv: TJSONValue;
begin
  ja := TJSONArray.Create;
  try
    ja.Add(TJSONObject.Create(TJSONPair.Create('mensagem',mensagem)));
    if sucesso then
        ja.AddElement(TJSONObject.Create(TJSONPair.Create('sucesso',TJSONTrue.Create)))
    else ja.AddElement(TJSONObject.Create(TJSONPair.Create('sucesso',TJSONFalse.Create)));
    jv := TJSonVO.ObjectToJSON<O>(Obj);
    ja.AddElement(jv);
  except
    ja.Free;
    raise;
  end;
end;

function TController<O>.List(pCampo: String; pValue:String; pTipo:String; pPagina: Integer): TJSONArray;
var
  obj: O;
  oList: TObjectList<O>;
  i:integer;
begin
  try
    try
      FManager := TDBConnection.GetInstance.CreateObjectManager;
      if UpperCase(pTipo) = 'ALL' then
        oList := FManager.FindAll<O>
      else
      if UpperCase(pTipo) = 'EQ' then
          oList := FManager.Find<O>.Add(TExpression.Eq(pCampo, pValue)).List
      else
      if UpperCase(pTipo) = 'LIKE' then
         oList := FManager.Find<O>.Add(TLinq.Sql(pCampo+' like '''+pValue+'%''')).List
      //   TExpression.Like(, +'%')).List
      else oList := FManager.FindAll<O>;

      {.Where.(TLinq.Sql(pFiltro)).List;}
      result := TJSONArray.Create;
      for i := 0 to oList.Count - 1 do
        Begin
          result.AddElement(TJSonVO.ObjectToJSON<O>(oList.Items[i]));
        end;
    except

    end;
  finally
    oList.Free;
    FManager.Free;
  end;
end;

function TController<O>.Find(id: integer): TJSONArray;
var
  obj: O;
  oList: TObjectList<O>;
  i:integer;
begin
  try
    try
      FManager := TDBConnection.GetInstance.CreateObjectManager;
      obj := FManager.Find<O>(ID);
      result := TJSONArray.Create;
      result.AddElement(TJSonVO.ObjectToJSON<O>(obj));
    except
    end;
  finally
    oList.Free;
    FManager.Free;
  end;
end;


function TController<O>.Serializar(obj: O): TJSonObject;
begin
    Serializer := TDataSnapJsonSerializer.Create;
    try
      result := Serializer.ToJson(obj) as TJsonObject;
    finally
      Serializer.Free;
    end;
end;

function TController<O>.Update(pObjeto: TJSONValue): TJSONArray;
var
  Filtro: String;
  Pagina: Integer;
  obj:O;
begin
  try
    try
      obj := TJSonVO.JSONToObject<O>
        ((pObjeto as TJSONArray).Get(0));

      if not (FManager.IsAttached(obj)) then
          FManager.SaveOrUpdate(obj);
      FManager.Flush;
      result := TJSONArray.Create;
      result.addElement(TJSonVO.ObjectToJson<O>(obj));
    except
      result := TJSONArray.Create;
    end;
  finally
  end;
end;

initialization


end.


