unit UFrmUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Data.DB, Vcl.Buttons, Generics.Collections,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,Controller,UsuarioController,Usuario,
  Vcl.Mask, Vcl.DBCtrls, bsSkinCtrls, bsSkinGrids, bsDBGrids, bsSkinBoxCtrls,
  BusinessSkinForm,ServerData;

type
  TFrmUsuarios = class(TFrmBase)
    Label3: TLabel;
    Label4: TLabel;
    DBESenha: TDBEdit;
    DBENome: TDBEdit;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Controller : TUsuarioController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(usuarios:TObjectList<TUsuario>);
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
  public
    { Public declarations }


  end;

var
  FrmUsuarios: TFrmUsuarios;

implementation

{$R *.dfm}

uses UDm, UFrmPrincipal;


procedure TFrmUsuarios.AtualizaCamposPesquisa(campos: TObjectList<TServerData>);
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

procedure TFrmUsuarios.AtualizaGrid(usuarios:TObjectList<TUsuario>);
var
 i :integer;
begin
Dm.CDSUsuario.EmptyDataSet;
for i := 0 to usuarios.Count - 1 do
  begin
    Dm.CDSUsuario.Append;
    Dm.CDSUsuario.Fields[0].AsInteger := usuarios.Items[i].Id;
    Dm.CDSUsuario.Fields[1].AsString := usuarios.Items[i].Nome;
    Dm.CDSUsuario.Fields[2].AsString := usuarios.Items[i].Senha;
    Dm.CDSUsuario.Post;
  end;
  Dm.CDSUsuario.Open;
  Dm.CDSUsuario.EnableControls;
end;

procedure TFrmUsuarios.BtnExcluirClick(Sender: TObject);
begin
  try
    Controller.Exclui(Dm.CDSUsuarioID.Value);
    inherited;
  except
      ShowMessage('Erro ao tentar excluir o usuário');
  end;

end;

procedure TFrmUsuarios.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Dm.CDSUsuario.EmptyDataSet;
  AtualizaGrid(Controller.Consulta(self.fCamposPesquisa[self.cbbPesquisa.ItemIndex].Key,ePesquisa.Text,'like',0));
end;

procedure TFrmUsuarios.BtnSalvarClick(Sender: TObject);
var
Usuario:TUsuario;
ServeData:TServerData;
list:TObjectList<TUsuario>;
listErro:TObjectList<TServerData>;
I:integer;
messageErro:String;
begin
   try
    Usuario:=TUsuario.Create;
    Usuario.Id := Dm.CDSUsuarioID.Value;
    Usuario.Nome := Dm.CDSUsuarioNOME.Value;
    Usuario.Senha := Dm.CDSUsuarioSENHA.Value;
    try

      if Dm.CDSUsuario.State in [dsInsert] then
          Usuario := Controller.Insere(Usuario,listErro)
      else  Usuario := Controller.Altera(Usuario);
    if not (Usuario = nil) then
       Begin
          Dm.CDSUsuarioID.Value := Usuario.Id;
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
      ShowMessage('Erro ao tentar salvar o usuário');
    end;
  finally
    Usuario.Free
  end;

end;

procedure TFrmUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
var
key:String;
sucesso :boolean;
begin
  inherited;
  Controller := TUsuarioController.Create;
  sucesso:= Controller.IndexFields(fCamposPesquisa);
  if sucesso then
    Begin
      AtualizaCamposPesquisa(fCamposPesquisa);
      AtualizaGrid(Controller.Consulta('1','1','ALL',0));
      Dm.CDSUsuario.Fields[2].Visible := false;
    End
  else
    Begin
      FecharForm;
      Controller.Free;
    End;

end;

end.

