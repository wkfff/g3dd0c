unit UFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, Menus, bsSkinCtrls, bsSkinExCtrls;

type
  TFrmPrincipal = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinData1: TbsSkinData;
    bsSkinMainMenuBar1: TbsSkinMainMenuBar;
    MainMenu1: TMainMenu;
    GerenciamentodeDocumentos1: TMenuItem;
    ContabilidadePblica1: TMenuItem;
    RecursosHumanos1: TMenuItem;
    Pblica1: TMenuItem;
    Privada1: TMenuItem;
    Privada2: TMenuItem;
    Privada3: TMenuItem;
    ipodeDocumento1: TMenuItem;
    Digitalizao1: TMenuItem;
    bsSkinMenuEx1: TbsSkinMenuEx;
    procedure ipodeDocumento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses UFrmTiposDocumentos;

{$R *.dfm}

procedure TFrmPrincipal.ipodeDocumento1Click(Sender: TObject);
begin
    Application.CreateForm(TFrmTiposDocumentos,FrmTiposDocumentos);
    FrmTiposDocumentos.ShowModal;
end;

end.
