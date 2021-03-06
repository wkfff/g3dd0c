unit Orgao;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  DBXJSON, DBXJSONReflect, SysUtils,Atributos,BaseModel,Validators.CoreAttributes;

type
  [Entity]
  [Table('ORGAO')]
  [Sequence('GEN_ORGAO_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TOrgao = class(TBaseModel)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FNOME: String;
    FCOD_CONTABIL: String;

  public
    [TIndexColumn('ID', 'C�digo',false)]
    property Id: Integer  read FID write FID;

    [Column('NOME', [TColumnProp.Required], 60)]
    [TIndexColumn('NOME', 'Nome',true)]
    [validates_presence('Campo Obr�gat�rio')]
    [validates_size(3,60,'O Nome deve ter no m�nimo 3 caracteres e no m�ximo 60')]
    property Nome: String  read FNOME write FNOME;

    [Column('COD_CONTABIL', [TColumnProp.Required], 3)]
    [TIndexColumn('COD_CONTABIL', 'C�d Contabil',false)]
    [validates_presence('Campo Obr�gat�rio')]
    [validates_size(3,3,'O C�digo Contabil dever� ter 3 caracteres')]
    //[validates_integer('O C�digo Contabil dever� ser preenchido com n�meros')]
    property Cod_Contabil: String read FCOD_CONTABIL write FCOD_CONTABIL;
  end;

implementation

end.
