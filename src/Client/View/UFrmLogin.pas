unit UFrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, StdCtrls, bsSkinCtrls, Mask, bsSkinBoxCtrls,
  bsPngImageList;

type
  TFrmLogin = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    btnLogin: TbsSkinButton;
    EUsuario: TbsSkinEdit;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsPngImageStorage1: TbsPngImageStorage;
    bsPngImageView1: TbsPngImageView;
    bsPngImageView2: TbsPngImageView;
    bsSkinStdLabel2: TbsSkinStdLabel;
    ESenha: TbsSkinPasswordEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure ESenhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    autenticado:boolean;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;


implementation

uses UFrmPrincipal, UDm, UsuarioController;

{$R *.dfm}

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
    autenticado := false;
    if TUsuarioController.Autenticar(EUsuario.Text,ESenha.Text) then
      Begin
         autenticado := true;
         close;
      End;
end;

procedure TFrmLogin.ESenhaKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
        btnLogin.SetFocus;
end;

procedure TFrmLogin.EUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
        ESenha.SetFocus;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if not autenticado then
        Application.Terminate;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  self.EUsuario.SetFocus;
end;

end.
