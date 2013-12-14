unit UFrmTipoDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Data.DB, Vcl.Buttons, TipoDocumentoController,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,TipoDOcumento,Generics.Collections,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls,
  BusinessSkinForm,ServerData, bsdbctrls, Vcl.DBCtrls, bsSkinExCtrls;

type
  TFrmTipoDocumento = class(TFrmBase)
    dbeNome: TbsSkinDBEdit;
    bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEditaClick(Sender: TObject);
  private
    { Private declarations }
    Controller : TTipoDocumentoController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(tipos_documentos:TObjectList<TTipoDocumento>);
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
  public
    { Public declarations }
  end;

var
  FrmTipoDocumento: TFrmTipoDocumento;

implementation

{$R *.dfm}

uses UDm, UFrmPrincipal;

procedure TFrmTipoDocumento.AtualizaGrid(tipos_documentos: TObjectList<TTipoDocumento>);
var
 i :integer;
begin
Dm.cdsTipoDOcumento.EmptyDataSet;
for i := 0 to tipos_documentos.Count - 1 do
  begin
    Dm.cdsTipoDocumento.Append;
    Dm.cdsTipoDocumento.Fields[0].AsInteger := tipos_documentos.Items[i].Id;
    Dm.cdsTipoDocumento.Fields[1].AsString := tipos_documentos.Items[i].Nome;
    Dm.cdsTipoDocumento.Post;
  end;
  Dm.cdsTipoDocumento.Open;
  Dm.cdsTipoDocumento.EnableControls;
end;

procedure TFrmTipoDocumento.BtnEditaClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.setFocus;
end;

procedure TFrmTipoDocumento.BtnExcluirClick(Sender: TObject);
begin
  try
    if Application.MessageBox(PChar('Tem certeza que deseja excluir esse registro ?'),PChar('Atenção'),MB_YESNO+MB_ICONQUESTION) = ID_YES then
        Begin
            Controller.Exclui(Dm.cdsTipoDOcumentoID.Value);
            inherited;
        End;
  except
      ShowMessage('Erro ao tentar excluir o tipo de documento');
  end;
end;

procedure TFrmTipoDocumento.BtnInserirClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.SetFocus;
end;

procedure TFrmTipoDocumento.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Dm.cdsTipoDocumento.EmptyDataSet;
  AtualizaGrid(Controller.Consulta(self.fCamposPesquisa[self.cbbPesquisa.ItemIndex].Key,ePesquisa.Text,'like',0));
end;

procedure TFrmTipoDocumento.BtnSalvarClick(Sender: TObject);
var
  tipoDocumento:TTipoDocumento;
  list:TObjectList<TTipoDocumento>;
  ServeData:TServerData;
  listErro:TObjectList<TServerData>;
  I:integer;
  messageErro:String;

begin
  tipoDocumento:=TTipoDocumento.Create;
  try
    tipoDocumento.Id := Dm.cdsTipoDOcumentoID.Value;
    tipoDocumento.Nome := Dm.cdsTipoDOcumentoNOME.Value;
    try
      if Dm.cdsTipoDOcumento.State in [dsInsert] then
          tipoDocumento := Controller.Insere(tipoDocumento,listErro)
      else  tipoDocumento := Controller.Altera(tipoDocumento,listErro);
      if not (tipoDocumento = nil) then
        Begin
          Dm.cdsTipoDocumentoID.Value := tipoDocumento.Id;
          inherited;
        End
      else
        Begin
          messageErro := '';
          for I := 0 to listErro.Count - 1 do
            Begin
              messageErro := messageErro + listErro.Items[I].Key+':'+listErro.Items[I].Value+#13;
            End;
          FrmPrincipal.messageDlg.MessageDlg(messageErro,mtWarning,[mbOK],-1);
        End;
    except
      ShowMessage('Erro ao tentar salvar o tipo de documento');
    end;
  finally
    tipoDocumento.Free;
  end;
end;

procedure TFrmTipoDocumento.FormShow(Sender: TObject);
var
sucesso:boolean;
begin
  inherited;
  self.dsBase.DataSet := Dm.CDSTipoDOcumento;
  Controller := TTipoDocumentoController.Create;
  sucesso:=Controller.IndexFields(fCamposPesquisa);
  if sucesso then
     Begin
        AtualizaCamposPesquisa(fCamposPesquisa);
        AtualizaGrid(Controller.Consulta('1','1','ALL',0));
     End
  else
    Begin
      FecharForm;
      Controller.Free;
    End;
end;

procedure TFrmTipoDocumento.AtualizaCamposPesquisa(
  campos: TObjectList<TServerData>);
var
  i,index :integer;
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

end.
