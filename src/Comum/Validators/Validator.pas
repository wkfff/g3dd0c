unit Validator;

interface

uses Generics.Collections,RTTI,Atributos,ServerData,Validators.CoreAttributes;

type
  TValitador = class(TObject)
  public
  class function validate(pObject:TOBject;var erros : TObjectList<TServerData>):boolean;
  end;


implementation
{ TBaseModel }

class function TValitador.validate(pObject:TOBject; var erros : TObjectList<TServerData>): boolean;
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
    Tipo := Contexto.GetType(pObject.ClassType);

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
