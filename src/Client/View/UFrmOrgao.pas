unit UFrmOrgao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, BusinessSkinForm, Data.DB,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,OrgaoController,Orgao,ServerData,
  Generics.Collections, bsdbctrls, bsSkinExCtrls;

type
  TFrmOrgao = class(TFrmBase)
    dbeNome: TbsSkinDBEdit;
    dbeCodContabil: TbsSkinDBEdit;
    bsSkinVistaGlowLabel4: TbsSkinVistaGlowLabel;
    bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnEditaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    Controller : TOrgaoController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(orgao:TObjectList<TOrgao>);
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
  public
    { Public declarations }
  end;

var
  FrmOrgao: TFrmOrgao;

implementation

{$R *.dfm}

uses UDm,UFrmPrincipal;

procedure TFrmOrgao.AtualizaCamposPesquisa(campos: TObjectList<TServerData>);
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

procedure TFrmOrgao.AtualizaGrid(orgao: TObjectList<TOrgao>);
var
 i :integer;
begin
Dm.cdsOrgao.EmptyDataSet;
for i := 0 to orgao.Count - 1 do
  begin
    Dm.cdsOrgao.Append;
    Dm.cdsOrgao.Fields[0].AsInteger := orgao.Items[i].Id;
    Dm.cdsOrgao.Fields[1].AsString := orgao.Items[i].Nome;
    Dm.cdsOrgao.Fields[2].AsString := orgao.Items[i].Cod_Contabil;
    Dm.cdsOrgao.Post;
  end;
  Dm.cdsOrgao.Open;
  Dm.cdsOrgao.EnableControls;
end;

procedure TFrmOrgao.BtnEditaClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.setFocus;
end;

procedure TFrmOrgao.BtnExcluirClick(Sender: TObject);
begin
try
    if Application.MessageBox(PChar('Tem certeza que deseja excluir esse registro ?'),PChar('Aten��o'),MB_YESNO+MB_ICONQUESTION) = ID_YES then
        Begin
            Controller.Exclui(Dm.cdsOrgaoID.Value);
            inherited;
        End;
  except
      ShowMessage('Erro ao tentar excluir o �rgao');
  end;
end;

procedure TFrmOrgao.BtnInserirClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.SetFocus;
end;

procedure TFrmOrgao.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Dm.cdsOrgao.EmptyDataSet;
  AtualizaGrid(Controller.Consulta(self.fCamposPesquisa[self.cbbPesquisa.ItemIndex].Key,ePesquisa.Text,'like',0));
end;

procedure TFrmOrgao.BtnSalvarClick(Sender: TObject);
var
orgao : TOrgao;
list:TObjectList<TOrgao>;
ServeData:TServerData;
listErro:TObjectList<TServerData>;
I:integer;
messageErro:String;
begin
  orgao := TOrgao.Create;
  try
    orgao.Id := Dm.cdsOrgaoID.Value;
    orgao.Nome := Dm.cdsOrgaoNOME.Value;
    orgao.Cod_Contabil := Dm.cdsOrgaoCod_Contabil.Value;
    try
      if Dm.cdsOrgao.State in [dsInsert] then
          orgao := Controller.Insere(orgao,listErro)
      else  orgao := Controller.Altera(orgao,listErro);
      if not (orgao = nil) then
        Begin
          Dm.cdsOrgaoID.Value := orgao.Id;
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
      ShowMessage('Erro ao tentar salvar o �rgao');
    end;
  finally
    orgao.Free;
  end;
end;

procedure TFrmOrgao.FormShow(Sender: TObject);
var
sucesso : boolean;
begin
  inherited;
  self.dsBase.DataSet := Dm.CDSOrgao;
  Controller := TOrgaoController.Create;
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
