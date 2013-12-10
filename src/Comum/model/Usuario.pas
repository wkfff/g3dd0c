unit Usuario;
interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  DBXJSON, DBXJSONReflect, SysUtils,Atributos,BaseModel,Validators.CoreAttributes;

type
  [Entity]
  [Table('USUARIO')]
  [Sequence('GEN_USUARIO_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TUsuario = class(TBaseModel)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FNOME: String;
    FSENHA: String;
  public
    property Id: Integer  read FID write FID;

    [Column('NOME', [TColumnProp.Required], 60)]
    [TIndexColumn('NOME', 'Nome',true)]
    [validates_size(1,20,'O nome do usu�rio deve estar entre 1 e 20')]
    property Nome: String  read FNOME write FNOME;

    [Column('SENHA', [TColumnProp.Required], 20)]
    property Senha: String  read FSENHA write FSENHA;

    function ToJSON(usuario: TUsuario): TJSONValue;
    function JsonToObject(json: TJSONValue): TUsuario;
  end;


implementation


{ TUsuario }


function TUsuario.JsonToObject(json: TJSONValue): TUsuario;
 var
   unm : TJSONUnMarshal;
  begin

    if json is TJSONNull then
      exit(nil);
    unm := TJSONUnMarshal.Create;
    try
      exit(unm.Unmarshal(json) as TUsuario)
    finally
      unm.Free;
    end;
end;

function TUsuario.ToJSON(usuario: TUsuario): TJSONValue;
 var
   m : TJSONMarshal;
  begin
    m := TJSONMarshal.Create(TJSONConverter.Create);
    try
      exit(m.Marshal(usuario) as TJsonValue)
    finally
      m.Free;
    end;


end;

end.
