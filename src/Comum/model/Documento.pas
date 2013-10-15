{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [DOCUMENTO]
                                                                                
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
unit Documento;

interface

uses
  JsonVO, Atributos;

type
  [Entity]
  [Table('DOCUMENTO')]
  [Sequence('GEN_DOCUMENTO_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TDocumentoVO = class(TJsonVO)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FID_EMPRESA: Integer;
    FID_TIPO_DOCUMENTO: Integer;
    FNOME: String;
    FDESCRICAO: String;
    FPALAVRA_CHAVE: String;
    FPODE_EXCLUIR: String;
    FPODE_ALTERAR: String;
    FASSINADO: String;
    FDTA_FIM_VIGENCIA: String;
    FDTA_EXCLUSAO: String;

  public
    property Id: Integer  read FID write FID;
    [Column('ID_EMPRESA', [TColumnProp.Required])]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [Column('ID_TIPO_DOCUMENTO', [TColumnProp.Required])]
    property IdTipoDocumento: Integer  read FID_TIPO_DOCUMENTO write FID_TIPO_DOCUMENTO;
    [Column('NOME', [TColumnProp.Required], 60)]
    property Nome: String  read FNOME write FNOME;
    [Column('DESCRICAO', [TColumnProp.Required], 200)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [Column('PALAVRA_CHAVE', [TColumnProp.Required], 60)]
    property PalavraChave: String  read FPALAVRA_CHAVE write FPALAVRA_CHAVE;
    [Column('PODE_EXCLUIR', [TColumnProp.Required],1)]
    property PodeExcluir: String  read FPODE_EXCLUIR write FPODE_EXCLUIR;
    [Column('PODE_ALTERAR', [TColumnProp.Required],1)]
    property PodeAlterar: String  read FPODE_ALTERAR write FPODE_ALTERAR;
    [Column('ASSINADO', [TColumnProp.Required],1)]
    property Assinado: String  read FASSINADO write FASSINADO;
    [Column('DTA_FIM_VIGENCIA', [TColumnProp.Required])]
    property DataFimVigencia: String  read FDTA_FIM_VIGENCIA write FDTA_FIM_VIGENCIA;
    [Column('DTA_EXCLUSAO', [TColumnProp.Required])]
    property DataExclusao: String  read FDTA_EXCLUSAO write FDTA_EXCLUSAO;

  end;

implementation



end.
