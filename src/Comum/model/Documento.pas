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
  JsonVO, Atributos,
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,BaseModel;

type
  [Entity]
  [Table('DOCUMENTO')]
  [Sequence('GEN_DOCUMENTO_ID')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TDocumento = class(TBaseModel)
  private
    [Column('ID', [TColumnProp.Unique, TColumnProp.Required, TColumnProp.NoUpdate])]
    FID: Integer;
    FID_TIPO_DOCUMENTO: Integer;
    FNOME: String;
    FDESCRICAO: String;
    FPALAVRA_CHAVE: String;
    FPODE_EXCLUIR: String;
    FPODE_ALTERAR: String;
    FASSINADO: String;
    FDTA_FIM_VIGENCIA: TDateTime;
    FDTA_EXCLUSAO: TDateTime;

  public
    property Id: Integer  read FID write FID;
    [TIndexColumn('ID', 'Código',false)]
    [Column('TIPO_DOCUMENTO_ID', [TColumnProp.Required])]
    property IdTipoDocumento: Integer  read FID_TIPO_DOCUMENTO write FID_TIPO_DOCUMENTO;
    [TIndexColumn('NOME', 'Nome',true)]
    [Column('NOME', [TColumnProp.Required], 60)]
    property Nome: String  read FNOME write FNOME;
    [TIndexColumn('DESCRICAO', 'Descrição',true)]
    [Column('DESCRICAO', [TColumnProp.Required], 200)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [Column('FPALAVRA_CHAVE', [TColumnProp.Required], 60)]
    property PalavraChave: String  read FPALAVRA_CHAVE write FPALAVRA_CHAVE;
    [Column('PODE_EXCLUIR', [TColumnProp.Required],1)]
    property PodeExcluir: String  read FPODE_EXCLUIR write FPODE_EXCLUIR;
    [Column('PODE_ALTERAR', [TColumnProp.Required],1)]
    property PodeAlterar: String  read FPODE_ALTERAR write FPODE_ALTERAR;
    [Column('ASSINADO', [TColumnProp.Required],1)]
    property Assinado: String  read FASSINADO write FASSINADO;
    [Column('DTA_FIM_VIGENCIA', [TColumnProp.Required])]
    property DataFimVigencia: TDateTime  read FDTA_FIM_VIGENCIA write FDTA_FIM_VIGENCIA;
    [Column('DTA_EXCLUSAO', [TColumnProp.Required])]
    property DataExclusao: TDateTime  read FDTA_EXCLUSAO write FDTA_EXCLUSAO;

  end;

implementation



end.
