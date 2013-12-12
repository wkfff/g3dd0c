unit UFrmDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, BusinessSkinForm, Data.DB,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls, Vcl.StdCtrls,
  ServerData,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Documento, Generics.Collections,
  DocumentoController, Vcl.DBCtrls, bsdbctrls, bsSkinExCtrls, bsSkinHint, JvHint,
  JvComponentBase, JvBalloonHint;

type
  TFrmDocumentos = class(TFrmBase)
    dbeNome: TbsSkinDBEdit;
    bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel2: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel4: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel5: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel6: TbsSkinVistaGlowLabel;
    dbeDescricao: TbsSkinDBEdit;
    bsSkinVistaGlowLabel7: TbsSkinVistaGlowLabel;
    dbeTipoDocumento: TbsSkinDBEdit;
    dbePalavraChave: TbsSkinDBEdit;
    dbeAssinado: TbsSkinDBEdit;
    bsSkinVistaGlowLabel8: TbsSkinVistaGlowLabel;
    dbePodeAlterar: TbsSkinDBEdit;
    bsSkinGroupBox2: TbsSkinGroupBox;
    bsSkinVistaGlowLabel9: TbsSkinVistaGlowLabel;
    dtVigencia: TbsSkinDBDateEdit;
    bsSkinDBDateEdit1: TbsSkinDBDateEdit;
    bsSkinDBEdit1: TbsSkinDBEdit;
    bsSkinLabel1: TbsSkinLabel;
    edtTipoDocumento: TbsSkinEdit;
    bHint: TBalloonHint;
    procedure btnPesquisarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeTipoDocumentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeTipoDocumentoChange(Sender: TObject);
    procedure BtnEditaClick(Sender: TObject);

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

uses UDm, UFrmPrincipal, UFrmPesquisaTiposDocumentos, Helpers, Orgao,
  TipoDocumento;

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

procedure TFrmDocumentos.BtnEditaClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.SetFocus;
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
  self.dbeNome.SetFocus;
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
        Documento := Controller.Altera(Documento, listErro);
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

procedure TFrmDocumentos.dbeTipoDocumentoChange(Sender: TObject);
var
tipoDocumentos : TObjectList<TTipoDocumento>;
TipoDocumento:TTipoDocumento;
begin
  inherited;
  //if edtTipoDocumento.Text <> '' then
  //TipoDocumento := Controller.findTipoDocumento(StrToInt(dbeTipoDocumento.Text));
  //if not (TipoDocumento = nil) then
  //    edtTipoDocumento.Text := TipoDocumento.Nome;
end;

procedure TFrmDocumentos.dbeTipoDocumentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
      if AbrirForm(TFrmPesquisaTiposDocumentos,FrmPesquisaTiposDocumentos) = mrOk then
  if dm.CDSTipoDOcumento.RecordCount > 0 then
      begin
          Dm.CDSDocumentoIDTIPODOCUMENTO.AsString := Dm.cdsTipoDOcumentoID.AsString;
          self.edtTipoDocumento.Text:= Dm.CDSTipoDOcumentoNOME.AsString;
      end;
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
  End
  else
  Begin
    FecharForm;
    Controller.Free;
  End;
end;

end.
