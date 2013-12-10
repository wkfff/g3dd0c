{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [VERSAO_DOCUMENTO]
                                                                                
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
unit VersaoDocumento;

interface

uses
  JsonVO, Atributos;

type
  [TEntity]
  [TTable('VERSAO_DOCUMENTO')]
  TVersaoDocumentoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_USUARIO: Integer;
    FID_DOCUMENTO: Integer;
    FVERSAO: Integer;
    FDATA_HORA: String;
    FHASH: String;
    FCAMINHO: String;
    FACAO: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;

    [TColumn('ID_USUARIO')]
    property IdUsuario: Integer  read FID_USUARIO write FID_USUARIO;

    [TColumn('ID_DOCUMENTO')]
    property IdDocumento: Integer  read FID_DOCUMENTO write FID_DOCUMENTO;

    [TColumn('VERSAO')]
    property Versao: Integer  read FVERSAO write FVERSAO;

    [TColumn('DATA_HORA')]
    property DataHora: String  read FDATA_HORA write FDATA_HORA;

    [TColumn('HASH')]
    property Hash: String  read FHASH write FHASH;

    [TColumn('CAMINHO')]
    property Caminho: String  read FCAMINHO write FCAMINHO;

    [TColumn('ACAO')]
    property Acao: String  read FACAO write FACAO;

  end;

implementation



end.
