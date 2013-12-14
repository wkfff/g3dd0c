unit UnidadeOrcamentaria;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  DBXJSON, DBXJSONReflect, SysUtils,Atributos,BaseModel,Validators.CoreAttributes;

type
  [Entity]
  [Table('UNIDADE_ORCAMENTARIA')]
  [Sequence('GEN_UNIDADE_ORCAMENTARIA_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]

  TUnidadeOrcamentaria = class(TBaseModel)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FNOME: String;
    FCOD_CONTABIL: String;
    FORGAO_ID: Integer;

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
    [validates_size(3,3,'O C�digo Contabil deve ter 3 caracteres')]
    //[validates_integer('O C�digo Contabil dever� ser preenchido com n�meros de 0 a 9')]
    property Cod_Contabil: String read FCOD_CONTABIL write FCOD_CONTABIL;

    [Column('ORGAO_ID', [TColumnProp.Required], 3)]
    [TIndexColumn('ORGAO_ID', 'C�d do �rgao',false)]
    [validates_not_zero('Campo Obr�gat�rio')]
    property Orgao_id: Integer read FORGAO_ID write FORGAO_ID;
  end;

  implementation

end.
