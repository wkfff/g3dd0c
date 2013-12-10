unit UFrmPesquisaOrgaos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPesquisa, BusinessSkinForm, Data.DB,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.StdCtrls, Vcl.Mask, bsSkinBoxCtrls, ServerData,
  Generics.Collections,OrgaoController,Orgao;

type
  TFrmPesquisaOrgaos = class(TFrmPesquisa)
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
    procedure btnPesquisarClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Controller : TOrgaoController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(orgao:TObjectList<TOrgao>);
  end;

var
  FrmPesquisaOrgaos: TFrmPesquisaOrgaos;

implementation

{$R *.dfm}

uses UDm, UFrmBase;

{ TFrmPesquisaOrgaos }
procedure TFrmPesquisaOrgaos.AtualizaCamposPesquisa(
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

procedure TFrmPesquisaOrgaos.AtualizaGrid(
  orgao : TObjectList<TOrgao> );
var
 i :integer;
begin
    Dm.cdsOrgao.EmptyDataSet;
    for i := 0 to orgao.Count -1 do
    begin
        Dm.CDSOrgao.Append;
        Dm.CDSOrgao.Fields[0].AsInteger := orgao.Items[i].Id;
        Dm.CDSOrgao.Fields[1].AsString := orgao.Items[i].Nome;
        Dm.CDSOrgao.Fields[2].AsString := orgao.Items[i].Cod_Contabil;
        Dm.CDSOrgao.Post;
    end;
    Dm.cdsOrgao.Open;
    Dm.cdsOrgao.EnableControls;
end;

procedure TFrmPesquisaOrgaos.BtnCancelarClick(Sender: TObject);
begin
    inherited;
    ModalResult := mrCancel;
end;

procedure TFrmPesquisaOrgaos.BtnOKClick(Sender: TObject);
begin
    inherited;
    ModalResult := mrOk;
end;

procedure TFrmPesquisaOrgaos.btnPesquisarClick(Sender: TObject);
begin
    inherited;
    Dm.CDSOrgao.EmptyDataSet;
    AtualizaGrid(Controller.Consulta(self.fCamposPesquisa[self.cbbPesquisa.ItemIndex].Key,ePesquisa.Text,'like',0));
end;

procedure TFrmPesquisaOrgaos.FormShow(Sender: TObject);
var
sucesso : boolean;
begin
    inherited;
    Controller := TOrgaoController.Create;
    sucesso := Controller.IndexFields(fCamposPesquisa);
    if sucesso then
    begin
        AtualizaCamposPesquisa(fCamposPesquisa);
        AtualizaGrid(Controller.Consulta('1','1','ALL',0));
    end
    else
    begin
      FecharForm;
      Controller.Free;
    end;
    self.dsPesquisa.DataSet := Dm.CDSOrgao;
end;

end.
