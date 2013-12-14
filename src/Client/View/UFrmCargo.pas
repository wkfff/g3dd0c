unit UFrmCargo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, BusinessSkinForm, Data.DB,
  bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask, bsSkinBoxCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, CargoController, UDm, Cargo,Generics.Collections,ServerData,
  bsdbctrls, bsSkinExCtrls, UFrmPrincipal;

type
  TFrmCargo = class(TFrmBase)
    bsSkinVistaGlowLabel2: TbsSkinVistaGlowLabel;
    dbeNome: TbsSkinDBEdit;
    bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel;
    dbeCodigo: TbsSkinDBEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    Controller : TCargoController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(cargo:TObjectList<TCargo>);
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
  end;

var
  FrmCargo: TFrmCargo;

implementation

{$R *.dfm}

procedure TFrmCargo.AtualizaCamposPesquisa(campos: TObjectList<TServerData>);
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

procedure TFrmCargo.AtualizaGrid(cargo: TObjectList<TCargo>);
var
 i :integer;
begin
Dm.CDSCargo.EmptyDataSet;
for i := 0 to cargo.Count - 1 do
  begin
    Dm.CDSCargo.Append;
    Dm.CDSCargoID.AsInteger  := Cargo[i].Id;
    Dm.CDSCargoNOME.AsString   := Cargo[i].Nome;
    Dm.CDSCargoCODIGO.AsString   := Cargo[i].Codigo;
    Dm.CDSCargo.Post;
  end;
  Dm.cdsDocumento.Open;
  Dm.cdsDocumento.EnableControls;

end;

procedure TFrmCargo.BtnExcluirClick(Sender: TObject);
begin
  try
    if Application.MessageBox
      (PChar('Tem certeza que deseja excluir esse registro ?'),
      PChar('Atenção'), MB_YESNO + MB_ICONQUESTION) = ID_YES then
    Begin
      Controller.Exclui(Dm.cdsCargoID.Value);
      inherited;
    End;
  except
    ShowMessage('Erro ao tentar excluir o tipo de documento');
  end;
end;

procedure TFrmCargo.BtnInserirClick(Sender: TObject);
begin
  inherited;
  self.dbeNome.SetFocus;
end;

procedure TFrmCargo.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Dm.CDSCargo.EmptyDataSet;
  AtualizaGrid(Controller.Consulta(self.fCamposPesquisa
  [self.cbbPesquisa.ItemIndex].Key, ePesquisa.Text, 'like', 0));

end;

procedure TFrmCargo.BtnSalvarClick(Sender: TObject);
var
  Cargo : TCargo;
  ServeData: TServerData;
  listErro: TObjectList<TServerData>;
  i: integer;
  messageErro: String;
begin
  Cargo := TCargo.Create;
  try
    Cargo.Id := Dm.CDSCargoID.Value;
    Cargo.Nome := Dm.CDSCargoNOME.Value;
    Cargo.Codigo:= Dm.CDSCargoCODIGO.Value;

    try
      if Dm.CDSCargo.State in [dsInsert] then
        Cargo := Controller.Insere(Cargo, listErro)
      else
        Cargo := Controller.Altera(Cargo, listErro);
      if not(Cargo = nil) then
      Begin
        Dm.CDScargoID.Value := Cargo.Id;
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
    Cargo.Free;
  end;
end;

procedure TFrmCargo.FormShow(Sender: TObject);
var
  sucesso: boolean;
begin
  inherited;
  Controller := TCargoController.Create;
  sucesso := Controller.IndexFields(fCamposPesquisa);
  self.dsBase.DataSet := Dm.CDSCargo;
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
