{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela DOCUMENTO - Lado Servidor

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit DocumentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon, SWSystem;

type
  TDocumentoController = class(TController)
  protected
  public
    //consultar
	Function Documento(pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    Function AcceptDocumento(pObjeto: TJSONValue): TJSONArray;
    //alterar
    Function UpdateDocumento(pObjeto: TJSONValue): TJSONArray;
    //excluir
    Function CancelDocumento(pId: Integer): Boolean;
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
  end;

implementation

uses
  DocumentoVO, ORM, VersaoDocumentoVO;

{ TDocumentoController }

var
  objDocumento: TDocumentoVO;


function TDocumentoController.Documento(pFiltro: String; pPagina: Integer): TJSONArray;
var
  resultSet : TDBXReader;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);

      {TODO -oAlbert -cGED : Qual a forma certa de fazer isso? Exibir apenas os documentos que n�o foram exclu�dos.}
      pFiltro := pFiltro + ' and DATA_EXCLUSAO = "0000-00-00 00:00:00"';
      resultSet := TORM.Consultar(TDocumentoVO.Create, pFiltro, pPagina);

      result := TJSONArray.Create;

      while resultSet.Next do
      begin
        objDocumento := TDocumentoVO.Create;
        objDocumento.Id := resultSet.Value['ID'].AsInt32;
        objDocumento.Nome := resultSet.Value['NOME'].AsString;
        objDocumento.Descricao := resultSet.Value['DESCRICAO'].AsString;
        objDocumento.PalavraChave := resultSet.Value['PALAVRA_CHAVE'].AsString;
        objDocumento.PodeAlterar := resultSet.Value['PODE_ALTERAR'].AsString;
        objDocumento.PodeExcluir := resultSet.Value['PODE_EXCLUIR'].AsString;
        objDocumento.Assinado := resultSet.Value['ASSINADO'].AsString;
        objDocumento.DataFimVigencia := resultSet.Value['DATA_FIM_VIGENCIA'].AsString;

        result.AddElement(objDocumento.ObjectToJSON<TDocumentoVO>(objDocumento));

        objDocumento.Free;
      end;

    except
      result := TJSONArray.Create;
    end;
  finally
    resultSet.Free;
  end;
end;

function TDocumentoController.AcceptDocumento(pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ArrayArquivos: TJSONValue;
  TipoArquivo, ArquivoString, AssinaturaString, MD5: String;
  I, TamanhoArquivo, TamanhoAssinatura: Integer;
  ArrayStringsArquivo, ArrayStringsAssinatura: TStringList;
  ArquivoBytes, AssinaturaBytes: Tbytes;
  ArquivoStream, AssinaturaStream: TStringStream;
  VersaoDocumento: TVersaoDocumentoVO;
begin
  try
    try
      //pega o objeto Documento
      objDocumento := TDocumentoVO.JSONToObject<TDocumentoVO>((pObjeto as TJSONArray).Get(0));

      //pega o array que veio com os dados dos arquivos
      ArrayArquivos := (pObjeto as TJSONArray).Get(1);

      //na posicao cinco temos o MD5 do arquivo enviado
      MD5 := (ArrayArquivos as TJSONArray).Get(5).ToString;
      //retira as aspas do JSON
      Delete(MD5, Length(MD5), 1);
      Delete(MD5, 1, 1);

      //na posicao zero temos o arquivo de assinatura
      AssinaturaString := (ArrayArquivos as TJSONArray).Get(0).ToString;
      //retira as aspas do JSON
      Delete(AssinaturaString, Length(AssinaturaString), 1);
      Delete(AssinaturaString, 1, 1);

      //na posicao um temos o tamanho do arquivo de assinatura
      TamanhoAssinatura := StrToInt((ArrayArquivos as TJSONArray).Get(1).ToString);

      if TamanhoAssinatura > 0 then
      begin
        //salva o arquivo de assinatura em disco
        ArrayStringsAssinatura := TStringList.Create;
        Split(',',AssinaturaString, ArrayStringsAssinatura);

        SetLength(AssinaturaBytes, TamanhoAssinatura);

        for I := 0 to TamanhoAssinatura - 1 do
        begin
          AssinaturaBytes[i] := StrToInt(ArrayStringsAssinatura[i]);
        end;
        AssinaturaStream := TStringStream.Create(AssinaturaBytes);
        AssinaturaStream.SaveToFile(gsAppPath + 'GED\' + MD5 + '.assinatura');
      end;

      //na posicao dois temos o arquivo enviado
      ArquivoString := (ArrayArquivos as TJSONArray).Get(2).ToString;
      //retira as aspas do JSON
      Delete(ArquivoString, Length(ArquivoString), 1);
      Delete(ArquivoString, 1, 1);

      //na posicao tres temos o tamanho do arquivo enviado
      TamanhoArquivo := StrToInt((ArrayArquivos as TJSONArray).Get(3).ToString);

      //na posicao quatro temos o tipo de arquivo enviado
      TipoArquivo := (ArrayArquivos as TJSONArray).Get(4).ToString;
      //retira as aspas do JSON
      Delete(TipoArquivo, Length(TipoArquivo), 1);
      Delete(TipoArquivo, 1, 1);

      //salva o arquivo enviado em disco
      ArrayStringsArquivo := TStringList.Create;
      Split(',',ArquivoString, ArrayStringsArquivo);

      SetLength(ArquivoBytes, TamanhoArquivo);

      for I := 0 to TamanhoArquivo - 1 do
      begin
        ArquivoBytes[i] := StrToInt(ArrayStringsArquivo[i]);
      end;
      ArquivoStream := TStringStream.Create(ArquivoBytes);
      ArquivoStream.SaveToFile(gsAppPath + 'GED\' + MD5 + tipoarquivo);

      UltimoID := TORM.Inserir(objDocumento);

      VersaoDocumento := TVersaoDocumentoVO.Create;
      {TODO -oAlbert -cGED : De onde vamos pegar o ID do Usu�rio?}
      VersaoDocumento.IdUsuario := 1;
      VersaoDocumento.IdDocumento := UltimoID;
      {TODO -oAlbert -cGED : Como devemos controlar essas versoes? Auto-incremento de 1 em 1? Paramatrizavel?}
      VersaoDocumento.Versao := 1;
      VersaoDocumento.DataHora := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
      VersaoDocumento.Hash := MD5;
      VersaoDocumento.Caminho := gsAppPath + 'GED\' + MD5 + tipoarquivo;
      VersaoDocumento.Caminho := StringReplace(VersaoDocumento.Caminho,'\','/',[rfReplaceAll]);
      VersaoDocumento.Acao := 'I';

      TORM.Inserir(VersaoDocumento);

      result := Documento('ID='+IntToStr(UltimoID),0);
    except
      result := TJSONArray.Create;
    end;
  finally
    ArrayStringsArquivo.Free;
    ArrayStringsAssinatura.Free;
    ArquivoStream.Free;
    AssinaturaStream.Free;
  end;
end;

{TODO -oAlbert -cGED : Como fazer o controle de vers�es quando um documento for alterado?}
function TDocumentoController.UpdateDocumento(pObjeto: TJSONValue): TJSONArray;
var
  Filtro : String;
  Pagina : Integer;
begin
  try
    try
      objDocumento := TDocumentoVO.JSONToObject<TDocumentoVO>((pObjeto as TJSONArray).Get(0));
      TORM.Alterar(objDocumento);
      Filtro := (pObjeto as TJSONArray).Get(1).ToString;

      //retira as aspas do JSON
      Delete(Filtro, Length(Filtro), 1);
      Delete(Filtro, 1, 1);

      Pagina := StrToInt((pObjeto as TJSONArray).Get(2).ToString);

      result := Documento(Filtro,Pagina);
    except
      result := TJSONArray.Create;
    end;
  finally
  end;
end;

function TDocumentoController.CancelDocumento(pId: Integer): Boolean;
var
  VersaoDocumento: TVersaoDocumentoVO;
  resultSet : TDBXReader;
  Filtro: String;
begin
  try
    try
      objDocumento := TDocumentoVO.Create;
      objDocumento.Id := pId;
      objDocumento.DataExclusao := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
      TORM.Alterar(objDocumento);

      VersaoDocumento := TVersaoDocumentoVO.Create;

      Filtro := 'ID_DOCUMENTO = ' + IntToStr(pId);
      resultSet := TORM.Consultar(VersaoDocumento, Filtro, 0);

      if resultSet.Next then
      begin
        {TODO -oAlbert -cGED : De onde vamos pegar o ID do Usu�rio?}
        VersaoDocumento.IdUsuario := 1;
        VersaoDocumento.IdDocumento := pId;
        {TODO -oAlbert -cGED : Como devemos controlar essas versoes? Auto-incremento de 1 em 1? Parametrizavel?}
        VersaoDocumento.Versao := 1;
        VersaoDocumento.DataHora := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
        VersaoDocumento.Hash := resultSet.Value['HASH'].AsString;
        VersaoDocumento.Caminho := resultSet.Value['CAMINHO'].AsString;
        VersaoDocumento.Acao := 'E';

        TORM.Inserir(VersaoDocumento);
      end;

      result := True;
    except
      result := False;
    end;
  finally
    objDocumento.Free;
  end;
end;

{TODO -oAlbert -cGED : Onde inserir essas fun��es?}
procedure TDocumentoController.Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;

end.
