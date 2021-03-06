unit ORM;

interface

uses Atributos, Rtti, SysUtils, SQLExpr, DBClient, DB, TypInfo, Generics.Collections, DBXCommon;

type
  TORM = class
  private
  public
    class function Inserir(pObjeto: TObject): Integer;
    class function Alterar(pObjeto:TObject): Boolean;
    class function Excluir(pObjeto:TObject): Boolean;
    class function Consultar(pObjeto: TObject;pFiltro: String; pPagina: Integer): TDBXReader;
  end;



implementation

uses
  ConexaoBD, Constantes;

var
  Conexao: TSQLConnection;
  Query: TSQLQuery;


{ TORM }

class function TORM.Alterar(pObjeto:TObject): Boolean;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, FiltroSQL: String;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObjeto.ClassType);

    //localiza o nome da tabela
    for Atributo in Tipo.GetAttributes do
    begin
      if Atributo is TTable then
        ConsultaSQL := 'UPDATE ' + (Atributo as TTable).Name + ' SET ';
    end;

    //preenche os nomes dos campos e filtro
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
          begin
            if Propriedade.GetValue(pObjeto).ToString <> '' then
            begin
              CamposSQL := CamposSQL + (Atributo as TColumn).Name + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString) + ','
            end;
          end;
        end
        else if Atributo is TId then
          FiltroSQL := ' WHERE ' + (Atributo as TId).NameField + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString);
      end;
    end;

    //retirando as v�rgulas que sobraram no final
    Delete(CamposSQL, Length(CamposSQL), 1);

    ConsultaSQL := ConsultaSQL + CamposSQL + FiltroSQL;

    Conexao := TDBExpress.getConexao;
    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL();

    Result := True;
  finally
    Contexto.Free;
  end;

end;

class function TORM.Consultar(pObjeto: TObject;pFiltro: String; pPagina: Integer): TDBXReader;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, FiltroSQL: String;
  DBXConnection: TDBXConnection;
  DBXCommand: TDBXCommand;
  DBXReader: TDBXReader;
begin
  try
    try
      Contexto := TRttiContext.Create;
      Tipo := Contexto.GetType(pObjeto.ClassType);

      //localiza o nome da tabela
      for Atributo in Tipo.GetAttributes do
      begin
        if Atributo is TTable then
          ConsultaSQL := 'SELECT * FROM ' + (Atributo as TTable).Name;
      end;

      if pFiltro <> '' then
        FiltroSQL := ' WHERE ' + pFiltro;

      ConsultaSQL := ConsultaSQL + FiltroSQL;

      if TDBExpress.getBanco = 'MySQL' then
      begin
        ConsultaSQL := ConsultaSQL + ' limit ' + IntToStr(pPagina) + ',' + IntToStr(TConstantes.QUANTIDADE_POR_PAGINA);
      end;

      DBXConnection := TDBExpress.getConexao.DBXConnection;
      DBXCommand := DBXConnection.CreateCommand;
      DBXCommand.Text := ConsultaSQL;
      DBXCommand.Prepare;
      DBXReader := DBXCommand.ExecuteQuery;

      result := DBXReader;
    except
      result := nil;
    end;
  finally
    Contexto.Free;
  end;
end;

class function TORM.Excluir(pObjeto:TObject): Boolean;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, FiltroSQL: String;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObjeto.ClassType);

    //localiza o nome da tabela
    for Atributo in Tipo.GetAttributes do
    begin
      if Atributo is TTable then
        ConsultaSQL := 'DELETE FROM ' + (Atributo as TTable).Name;
    end;

    //preenche o filtro
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TId then
        begin
          FiltroSQL := ' WHERE ' + (Atributo as TId).NameField + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString);
        end;
      end;
    end;

    ConsultaSQL := ConsultaSQL + FiltroSQL;

    Conexao := TDBExpress.getConexao;
    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL();

    Result := True;
  finally
    Contexto.Free;
  end;

end;

class function TORM.Inserir(pObjeto: TObject): Integer;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, ValoresSQL: String;
  UltimoID:Integer;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObjeto.ClassType);

    //localiza o nome da tabela
    for Atributo in Tipo.GetAttributes do
    begin
      if Atributo is TTable then
        ConsultaSQL := 'INSERT INTO ' + (Atributo as TTable).Name;
    end;

    //preenche os nomes dos campos e valores
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          CamposSQL := CamposSQL + (Atributo as TColumn).Name + ',';
          ValoresSQL := ValoresSQL + QuotedStr(Propriedade.GetValue(pObjeto).ToString) + ',';
        end;
      end;
    end;

    //retirando as v�rgulas que sobraram no final
    Delete(CamposSQL, Length(CamposSQL), 1);
    Delete(ValoresSQL, Length(ValoresSQL), 1);

    ConsultaSQL := ConsultaSQL + '(' + CamposSQL + ') VALUES (' + ValoresSQL + ')';

    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := TDBExpress.getConexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL();

    UltimoID := 0;
    if TDBExpress.getBanco = 'MySQL' then
    begin
      Query.sql.Text := 'select LAST_INSERT_ID() as id';
      Query.Open();
      UltimoID := Query.FieldByName('id').AsInteger;
    end;
    Result := UltimoID;
  finally
    Contexto.Free;
  end;

end;

end.
