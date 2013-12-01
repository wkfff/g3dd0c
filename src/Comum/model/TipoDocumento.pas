unit TipoDocumento;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  DBXJSON, DBXJSONReflect, SysUtils,Atributos,BaseModel;

type
  [Entity]
  [Table('TIPO_DOCUMENTO')]
  [Sequence('GEN_TIPO_DOCUMENTO_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]

  TTipoDocumento = class(TBaseModel)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FNOME: String;

  public
    [TIndexColumn('ID', 'Código',false)]
    property Id: Integer  read FID write FID;
    [TIndexColumn('NOME', 'Nome',true)]
    [Column('NOME', [TColumnProp.Required], 60)]
    property Nome: String  read FNOME write FNOME;
  end;

implementation



end.
