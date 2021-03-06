unit TipoDocumento;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  DBXJSON, DBXJSONReflect, SysUtils,Atributos,BaseModel,Validators.CoreAttributes;

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
    [TIndexColumn('ID', 'C�digo',false)]
    property Id: Integer  read FID write FID;

    [Column('NOME', [TColumnProp.Required], 60)]
    [TIndexColumn('NOME', 'Nome',true)]
    [validates_presence('Campo Obr�gat�rio')]
    [validates_size(3,60,'O Nome deve ter no m�nimo 3 caracteres e no m�ximo 60')]
    property Nome: String  read FNOME write FNOME;
  end;

implementation



end.
