unit UFrmUnidadeOrcamentaria;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, BusinessSkinForm, Data.DB,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,UnidadeOrcamentariaController,UnidadeOrcamentaria,ServerData,
  Generics.Collections, bsdbctrls, bsSkinExCtrls;

  {Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, BusinessSkinForm, Data.DB,
   bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls, Vcl.StdCtrls,
   Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, UnidadeOrcamentaria,ServerData,
   Generics.Collections, bsdbctrls, UDm;}

type
  TFrmUnidadeOrcamentaria = class(TFrmBase)
    dbeNome: TbsSkinDBEdit;
    dbeCodContabil: TbsSkinDBEdit;
    dbeOrgao: TbsSkinDBEdit;
    bsSkinVistaGlowLabel4: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel2: TbsSkinVistaGlowLabel;
    edtOrgao: TbsSkinEdit;
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnEditaClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbeOrgaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Controller : TUnidadeOrcamentariaController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(unid_orc:TObjectList<TUnidadeOrcamentaria>);
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
  public
    { Public declarations }
  end;

var
  FrmUnidadeOrcamentaria: TFrmUnidadeOrcamentaria;

implementation

{$R *.dfm}

uses UFrmPrincipal, UDm, Helpers, UFrmPesquisaOrgaos;

procedure TFrmUnidadeOrcamentaria.AtualizaCamposPesquisa(
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

procedure TFrmUnidadeOrcamentaria.AtualizaGrid(unid_orc: TObjectList<TUnidadeOrcamentaria>);
var
 i :integer;
begin
Dm.CDSUnidadeOrcamentaria.EmptyDataSet;
for i := 0 to unid_orc.Count - 1 do
  begin
    Dm.CDSUnidadeOrcamentaria.Append;
    Dm.CDSUnidadeOrcamentaria.Fields[0].AsInteger := unid_orc.Items[i].Id;
    Dm.CDSUnidadeOrcamentaria.Fields[1].AsString  := unid_orc.Items[i].Nome;
    Dm.CDSUnidadeOrcamentaria.Fields[2].AsString  := unid_orc.Items[i].Cod_Contabil;
    Dm.CDSUnidadeOrcamentaria.Fields[3].AsInteger := unid_orc.Items[i].Orgao_id;
    Dm.CDSUnidadeOrcamentaria.Post;
  end;
  Dm.CDSUnidadeOrcamentaria.Open;
  Dm.CDSUnidadeOrcamentaria.EnableControls;
end;

procedure TFrmUnidadeOrcamentaria.BtnEditaClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.setFocus;
end;

procedure TFrmUnidadeOrcamentaria.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  try
    if Application.MessageBox(PChar('Tem certeza que deseja excluir esse registro ?'),PChar('Atenção'),MB_YESNO+MB_ICONQUESTION) = ID_YES then
        Begin
            Controller.Exclui(Dm.CDSUnidadeOrcamentariaID.Value);
            inherited;
        End;
  except
      ShowMessage('Erro ao tentar excluir a Unidade Orçamentária');
  end;
end;

procedure TFrmUnidadeOrcamentaria.BtnInserirClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.SetFocus;
end;

procedure TFrmUnidadeOrcamentaria.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Dm.cdsUnidadeOrcamentaria.EmptyDataSet;
  AtualizaGrid(Controller.Consulta(self.fCamposPesquisa[self.cbbPesquisa.ItemIndex].Key,ePesquisa.Text,'like',0));
end;

procedure TFrmUnidadeOrcamentaria.BtnSalvarClick(Sender: TObject);
var
  unid_orc : TUnidadeOrcamentaria;
  list:TObjectList<TUnidadeOrcamentaria>;
  ServeData:TServerData;
  listErro:TObjectList<TServerData>;
  I:integer;
  messageErro:String;

begin
  unid_orc := TUnidadeOrcamentaria.Create;
  try
    unid_orc.Id := Dm.CDSUnidadeOrcamentariaID.Value;
    unid_orc.Nome := Dm.CDSUnidadeOrcamentariaNOME.Value;
    unid_orc.Cod_Contabil := Dm.CDSUnidadeOrcamentariaCOD_CONTABIL.Value;
    unid_orc.Orgao_id := Dm.CDSUnidadeOrcamentariaORGAO_ID.Value;

    try
      if Dm.CDSUnidadeOrcamentaria.State in [dsInsert] then
          unid_orc := Controller.Insere(unid_orc,listErro)
      else unid_orc := Controller.Altera(unid_orc,listErro);
      if not (unid_orc = nil) then
        Begin
          Dm.cdsUnidadeOrcamentariaID.Value := unid_orc.Id;
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
      ShowMessage('Erro ao tentar salvar o Órgao');
    end;
  finally
    unid_orc.Free;
  end;
end;

procedure TFrmUnidadeOrcamentaria.dbeOrgaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    inherited;
    if Key = VK_F2 then
    begin
        if AbrirForm(TFrmPesquisaOrgaos,FrmPesquisaOrgaos) = mrOk then
        if dm.CDSOrgao.RecordCount > 0 then
        begin
            Dm.CDSUnidadeOrcamentariaORGAO_ID.AsString := Dm.CDSOrgaoID.AsString;
            self.edtOrgao.Text := Dm.CDSOrgaoNOME.AsString;
        end;
    end;
end;

procedure TFrmUnidadeOrcamentaria.FormShow(Sender: TObject);
var
  sucesso : boolean;
begin
  inherited;
  self.dsBase.DataSet := Dm.CDSUnidadeOrcamentaria;

  Controller := TUnidadeOrcamentariaController.Create;
  sucesso := Controller.IndexFields(fCamposPesquisa);
  if sucesso then
     Begin
        AtualizaCamposPesquisa(fCamposPesquisa);
        AtualizaGrid(Controller.Consulta('1','1','ALL',0));
        //Dm.cdsOrgao.Fields[2].Visible := false;
     End
  else
    Begin
      FecharForm;
      Controller.Free;
    End;
end;

end.
