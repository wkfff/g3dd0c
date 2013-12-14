unit Cargo;

interface

uses
  JsonVO, Atributos,
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,BaseModel,Validators.CoreAttributes;

type
  [Entity]
  [Table('CARGO')]
  [Sequence('GEN_CARGO_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TCargo = class(TBaseModel)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FNOME: String;
    FCODIGO: String;

  public
    [TIndexColumn('ID', 'C�digo',false)]
    property Id: Integer  read FID write FID;

    [Column('NOME', [TColumnProp.Required], 60)]
    [TIndexColumn('NOME', 'Nome',true)]
    [validates_presence('Campo Obrigat�rio')]
    [validates_size(3,60,'O Nome deve ter no m�nimo 3 caracteres e no m�ximo 60')]
    property Nome: String  read FNOME write FNOME;

    [Column('CODIGO',[TColumnProp.Required],4)]
    [TIndexColumn('CODIGO', 'Cod',false)]
    [validates_presence('Campo Obrigat�rio')]
    [validates_size(4,4,'O Nome deve conter 4 caracteres')]
    property Codigo: String read FCODIGO write FCODIGO;
  end;


implementation

end.
