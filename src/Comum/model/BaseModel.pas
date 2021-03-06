unit BaseModel;

interface

uses Generics.Collections,RTTI,Atributos,ServerData,Validators.CoreAttributes;

type
  TBaseModel = class(TObject)
  public
  function IndexColumns:TObjectList<TServerData>;
  function validate(var erros : TObjectList<TServerData>):boolean;
  end;


implementation
{ TBaseModel }

function TBaseModel.IndexColumns: TObjectList<TServerData>;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, ValoresSQL: String;
  UltimoID:Integer;
  i:integer;
  Data:TServerData;
begin
    result := TObjectList<TServerData>.Create;
    Contexto := TRttiContext.Create;
    try
    Tipo := Contexto.GetType(self.ClassType);

    //Preenche os nomes dos campos e valores
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TIndexColumn then
        begin
          Data:=TServerData.Create;
          Data.Key := (Atributo as TIndexColumn).Name;
          Data.Value := (Atributo as TIndexColumn).Display;
          Data.DefaultIndex := (Atributo as TIndexColumn).DefaultIndex;
          result.Add(Data);
          i := i + 1;
        end;
      end;
    end;
    finally
      Contexto.Free;
    end;
end;

function TBaseModel.validate(var erros : TObjectList<TServerData>): boolean;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, ValoresSQL: String;
  UltimoID:Integer;
  i:integer;
  Data:TServerData;
begin
    erros := TObjectList<TServerData>.Create;
    Contexto := TRttiContext.Create;
    try
    Tipo := Contexto.GetType(self.ClassType);

    //Preenche os nomes dos campos e valores
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is validator_attr then
        begin
          if not validator_attr(Atributo).isValid(Propriedade.GetValue(self).ToString) then
              Begin
                  Data:=TServerData.Create;
                  Data.Key := Propriedade.Name;
                  Data.Value := (Atributo as validator_attr).ErrorMessage;
                  Data.DefaultIndex := false;
                  erros.Add(Data);
              End;
          i := i + 1;
        end;
      end;
    end;
    finally
      Contexto.Free;
    end;

end;

end.
