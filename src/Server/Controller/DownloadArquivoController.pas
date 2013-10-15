{*******************************************************************************
Title: T2Ti ERP
Description: Unit que controla o download de arquivos solicitados - Lado Servidor

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
unit DownloadArquivoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon, SWSystem;

type
  TDownloadArquivoController = class(TController)
  protected
  public
    //consultar
  	Function DownloadArquivo(pFiltro: String): TJSONArray;
    function FileSize(FileName: string): Int64;
  end;

implementation

uses
  ORM, VersaoDocumentoVO;

{ TDownloadArquivoController }


function TDownloadArquivoController.DownloadArquivo(pFiltro: String): TJSONArray;
var
  resultSet: TDBXReader;
  Caminho, BytesArquivo, TipoArquivo: String;
  ArquivoStream: TStringStream;
  TamanhoArquivo, I: Integer;
begin
  try
    try
      resultSet := TORM.Consultar(TVersaoDocumentoVO.Create, pFiltro, 0);

      result := TJSONArray.Create;

      if resultSet.Next then
        Caminho := resultSet.Value['CAMINHO'].AsString;

      ArquivoStream := TStringStream.Create;
      ArquivoStream.LoadFromFile(Caminho);
      TamanhoArquivo := FileSize(Caminho);

      BytesArquivo := '';

      //laço pra pegar os bytes do arquivo ou imagem
      for I := 0 to TamanhoArquivo - 1 do
      begin
        BytesArquivo := BytesArquivo + IntToStr(ArquivoStream.Bytes[i]) + ', ';
      end;
      //Tira a ultima virgula
      Delete(BytesArquivo, Length(BytesArquivo)-1, 2);

      //adiciona o arquivo no array do json (posicao zero do array)
      result.Add(BytesArquivo);
	  
      //adiciona o tamanho do arquivo no array do json (posicao um do array)
      result.AddElement(TJSONNumber.Create(TamanhoArquivo));
	  
	    TipoArquivo := ExtractFileExt(Caminho);

      //adiciona o tipo do arquivo no array (posicao dois do array)
      result.AddElement(TJSONString.Create(TipoArquivo));

    except
      result := TJSONArray.Create;
    end;
  finally
    resultSet.Free;
  end;
end;

{TODO -oAlbert -cGED : Essa função aparece no lado cliente e no lado servidor. Devemos ter uma única biblioteca com as funções?}
function TDownloadArquivoController.FileSize(FileName: string): Int64;
var
 SearchRec: TSearchRec;
begin
 if FindFirst(FileName, faAnyFile, SearchRec) = 0 then //se achou o arquivo
   //SearchRec.Size funciona legal para arquivos menores que 2GB
   Result := Int64(SearchRec.FindData.nFileSizeHigh) shl Int64(32) + //calcula o tamanho
             Int64(SearchRec.FindData.nFileSizeLow)
 else
   Result := 0;
 FindClose(SearchRec); //fecha
end;

end.
