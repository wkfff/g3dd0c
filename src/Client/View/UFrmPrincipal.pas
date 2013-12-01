unit UFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, bsSkinExCtrls, Menus, bsSkinData, BusinessSkinForm,
  bsSkinCtrls, bsDialogs, bsMessages;

type
  TFrmPrincipal = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinData1: TbsSkinData;
    MainMenu1: TMainMenu;
    GerenciamentodeDocumentos1: TMenuItem;
    ipodeDocumento1: TMenuItem;
    Digitalizao1: TMenuItem;
    ContabilidadePblica1: TMenuItem;
    Pblica1: TMenuItem;
    Privada2: TMenuItem;
    RecursosHumanos1: TMenuItem;
    Privada1: TMenuItem;
    Privada3: TMenuItem;
    bsSkinMenuEx1: TbsSkinMenuEx;
    Usurios1: TMenuItem;
    bsSkinMainMenuBar1: TbsSkinMainMenuBar;
    messageDlg: TbsSkinMessage;
    mOrgao: TMenuItem;
    mUnidadeOramentria: TMenuItem;
    Documentos1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure ipodeDocumento1Click(Sender: TObject);
    procedure mOrgaoClick(Sender: TObject);
    procedure mUnidadeOramentriaClick(Sender: TObject);
    procedure Documentos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses UFrmBase, UFrmLogin, UFrmUsuarios, Helpers, UFrmTipoDocumento, UFrmOrgao,UFrmUnidadeOrcamentaria
  UFrmDocumento;

{$R *.dfm}

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmBase,FrmBase);
  FrmBase.ShowModal;
end;

procedure TFrmPrincipal.Documentos1Click(Sender: TObject);
begin
    AbrirForm(TFrmDocumentos,FrmDocumentos);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  Application.CreateForm(TFrmLogin,FrmLogin);
  FrmLogin.SHowModal;
end;

procedure TFrmPrincipal.ipodeDocumento1Click(Sender: TObject);
begin
  AbrirForm(TFrmTipoDocumento,FrmTipoDocumento);
end;

procedure TFrmPrincipal.mOrgaoClick(Sender: TObject);
begin
  AbrirForm(TFrmOrgao,FrmOrgao);
end;

procedure TFrmPrincipal.mUnidadeOramentriaClick(Sender: TObject);
begin
  AbrirForm(TFrmUnidadeOrcamentaria,FrmUnidadeOrcamentaria);
end;

procedure TFrmPrincipal.Usurios1Click(Sender: TObject);
begin
  AbrirForm(TFrmUsuarios,FrmUsuarios);
end;

end.
