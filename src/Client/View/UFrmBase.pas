unit UFrmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, BaseModel,
  Dialogs, Grids, DBGrids, StdCtrls,DBClient, DB, ComCtrls, Buttons, Controller,Usuario,
  BusinessSkinForm, bsSkinCtrls, bsSkinGrids, bsDBGrids, Vcl.Mask,ServerData,Generics.Collections,
  bsSkinBoxCtrls;

type
  TFrmBase = class(TForm)
    Enome: TEdit;
    Label1: TLabel;
    ESenha: TEdit;
    Label2: TLabel;
    BtnInserirOld: TButton;
    Button1: TButton;
    DBGrid1: TDBGrid;
    dsBase: TDataSource;
    PCBase: TPageControl;
    tsPesquisa: TTabSheet;
    tsCadastro: TTabSheet;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    GroupBox1: TGroupBox;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    cbbPesquisa: TbsSkinComboBox;
    ePesquisa: TbsSkinEdit;
    btnPesquisar: TbsSkinButton;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinDBGrid1: TbsSkinDBGrid;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinScrollBar2: TbsSkinScrollBar;
    BtnExcluir: TbsSkinButton;
    BtnEditar: TbsSkinButton;
    BtnInserir: TbsSkinButton;
    bsSkinPanel2: TbsSkinPanel;
    BtnSalvar: TbsSkinButton;
    BtnCancelar: TbsSkinButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnEditaClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FecharForm;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ePesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
   FController:TController<TBaseModel>;
  public
    { Public declarations }
    property Controller:TController<TBaseModel> read FController write FController;
  end;

var
  FrmBase: TFrmBase;

implementation

uses UDm, UsuarioController,  Constantes, UFrmPrincipal;

var
  Operacao:Integer; //1-Inserir | 2-Alterar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}
procedure TFrmBase.BitBtn1Click(Sender: TObject);
begin
  self.dsBase.DataSet.Cancel;
    tsPesquisa.TabVisible := true;
  tsCadastro.TabVisible := false;
end;

procedure TFrmBase.BtnEditaClick(Sender: TObject);
begin
  self.dsBase.DataSet.Edit;
  tsPesquisa.TabVisible := false;
  tsCadastro.TabVisible := true;
end;

procedure TFrmBase.BtnExcluirClick(Sender: TObject);
begin
  self.dsBase.DataSet.Delete;
end;

procedure TFrmBase.BtnInserirClick(Sender: TObject);
begin
  self.dsBase.DataSet.Append;
  tsPesquisa.TabVisible := false;
  tsCadastro.TabVisible := true;
end;

procedure TFrmBase.BtnSalvarClick(Sender: TObject);
begin
  self.dsBase.DataSet.Post;
  tsPesquisa.TabVisible := true;
  tsCadastro.TabVisible := false;
end;

procedure TFrmBase.ePesquisaKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
        btnPesquisar.SetFocus;
end;

procedure TFrmBase.FecharForm;
begin
    Close;
    self.bsBusinessSkinForm1.CloseAll;
    PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TFrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TFrmBase.FormCreate(Sender: TObject);
begin
  self.tsCadastro.TabVisible := false;
end;

procedure TFrmBase.FormShow(Sender: TObject);
begin
  self.ePesquisa.SetFocus;
end;

end.
