unit UFrmDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, BusinessSkinForm, Data.DB,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls, Vcl.StdCtrls,
  ServerData,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Documento, Generics.Collections,
  DocumentoController, Vcl.DBCtrls;

type
  TFrmDocumentos = class(TFrmBase)
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    DBEdit7: TDBEdit;
    Label10: TLabel;
    DBEdit8: TDBEdit;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    Label12: TLabel;
    DBEdit10: TDBEdit;
    procedure btnPesquisarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBEdit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AtualizaGrid(documentos: TObjectList<TDocumento>);
  public
    { Public declarations }
    Controller: TDocumentoController;
    fCamposPesquisa: TObjectList<TServerData>;
    procedure AtualizaCamposPesquisa(campos: TObjectList<TServerData>);
  end;

var
  FrmDocumentos: TFrmDocumentos;

implementation

{$R *.dfm}

uses UDm, UFrmPrincipal, UFrmPesquisaTiposDocumentos, Helpers;

procedure TFrmDocumentos.AtualizaCamposPesquisa
  (campos: TObjectList<TServerData>);
var
  i, index: integer;
begin
  cbbPesquisa.Items.Clear;
  for i := 0 to campos.Count - 1 do
  begin
    if campos[i].DefaultIndex then
      index := i;
    cbbPesquisa.Items.Add(campos[i].Value);
  end;
  cbbPesquisa.ItemIndex := index;
end;

procedure TFrmDocumentos.AtualizaGrid(documentos: TObjectList<TDocumento>);
var
 i :integer;
begin
Dm.CDSDocumento.EmptyDataSet;
for i := 0 to documentos.Count - 1 do
  begin
    Dm.cdsDocumento.Append;
    Dm.CDSDocumentoID.AsInteger  := Documentos[i].Id;
    Dm.CDSDocumentoNOME.AsString   := Documentos[i].Nome;
    Dm.CDSDocumentoIDTIPODOCUMENTO.AsInteger  := Documentos[i].IdTipoDocumento;
    Dm.CDSDocumentoDESCRICAO.AsString   := Documentos[i].Descricao;
    Dm.CDSDocumentoPALAVRACHAVE.AsString   := Documentos[i].PalavraChave;
    Dm.CDSDocumentoPODEALTERAR.AsString   := Documentos[i].PodeAlterar;
    Dm.CDSDocumentoASSINADO.AsString   := Documentos[i].Assinado;
    Dm.CDSDocumentoDATAFIMVIGENCIA.AsDateTime := Documentos[i].DataFimVigencia;
    Dm.CDSDocumentoDATAEXCLUSAO.AsDateTime := Documentos[i].DataExclusao;
    Dm.cdsDocumento.Post;
  end;
  Dm.cdsDocumento.Open;
  Dm.cdsDocumento.EnableControls;
end;

procedure TFrmDocumentos.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  try
    if Application.MessageBox
      (PChar('Tem certeza que deseja excluir esse registro ?'),
      PChar('Atenção'), MB_YESNO + MB_ICONQUESTION) = ID_YES then
    Begin
      Controller.Exclui(Dm.cdsDOcumentoID.Value);
      inherited;
    End;
  except
    ShowMessage('Erro ao tentar excluir o tipo de documento');
  end;

end;

procedure TFrmDocumentos.BtnInserirClick(Sender: TObject);
begin
  inherited;
  self.DBEdit1.SetFocus;
end;

procedure TFrmDocumentos.btnPesquisarClick(Sender: TObject);
begin
  inherited;

  Dm.CDSDocumento.EmptyDataSet;
  AtualizaGrid(Controller.Consulta(self.fCamposPesquisa
    [self.cbbPesquisa.ItemIndex].Key, ePesquisa.Text, 'like', 0));
end;

procedure TFrmDocumentos.BtnSalvarClick(Sender: TObject);
var
  Documento: TDocumento;
  ServeData: TServerData;
  listErro: TObjectList<TServerData>;
  i: integer;
  messageErro: String;
begin

  Documento := TDocumento.Create;
  try
    Documento.Id := Dm.CDSDocumentoID.Value;
    Documento.Nome := Dm.CDSDocumentoNOME.Value;
    Documento.IdTipoDocumento := Dm.CDSDocumentoIDTIPODOCUMENTO.Value;
    Documento.PalavraChave := Dm.CDSDocumentoPALAVRACHAVE.AsString;
    Documento.Descricao := Dm.CDSDocumentoDESCRICAO.AsString;
    Documento.PodeExcluir := Dm.CDSDocumentoPODEExCLUIR.AsString;
    Documento.PodeAlterar := Dm.CDSDocumentoPODEALTERAR.AsString;
    Documento.Assinado := Dm.CDSDocumentoASSINADO.AsString;
    Documento.DataFimVigencia := Dm.CDSDocumentoDATAFIMVIGENCIA.AsDateTime;
    Documento.DataExclusao := Dm.CDSDocumentoDATAEXCLUSAO.AsDateTime;

    try
      if Dm.CDSDocumento.State in [dsInsert] then
        Documento := Controller.Insere(Documento, listErro)
      else
        Documento := Controller.Altera(Documento);
      if not(Documento = nil) then
      Begin
        Dm.CDSDocumentoID.Value := Documento.Id;
        inherited;
      End
      else
      Begin
        messageErro := '';
        for i := 0 to listErro.Count - 1 do
        Begin
          messageErro := messageErro + listErro.Items[i].Key + ':' +
            listErro.Items[i].Value + #13;
        End;
        FrmPrincipal.messageDlg.messageDlg(messageErro, mtWarning, [mbOK], -1);
      End;

    except
      ShowMessage('Erro ao tentar salvar o documento');
    end;
  finally
    Documento.Free;
  end;
end;

procedure TFrmDocumentos.DBEdit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
      if AbrirForm(TFrmPesquisaTiposDocumentos,FrmPesquisaTiposDocumentos) = mrOk then
          Dm.CDSDocumentoIDTIPODOCUMENTO.AsString := Dm.cdsTipoDOcumentoID.AsString;
end;

procedure TFrmDocumentos.FormShow(Sender: TObject);
var
  sucesso: boolean;
begin
  inherited;
  Controller := TDocumentoController.Create;
  sucesso := Controller.IndexFields(fCamposPesquisa);
  self.dsBase.DataSet := Dm.CDSDocumento;
  if sucesso then
  Begin
    AtualizaCamposPesquisa(fCamposPesquisa);
    AtualizaGrid(Controller.Consulta('1', '1', 'ALL', 0));
    //Dm.cdsTipoDOcumento.Fields[2].Visible := false;
    //self.DBETamanhoMaximo.DataField := 'TAMANHO_MAXIMO';
  End
  else
  Begin
    FecharForm;
    Controller.Free;
  End;
end;

end.
