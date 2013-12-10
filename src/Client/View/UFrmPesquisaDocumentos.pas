unit UFrmPesquisaDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPesquisa, bsSkinCtrls, bsSkinGrids,
  bsDBGrids, Vcl.StdCtrls, Vcl.Mask, bsSkinBoxCtrls, Data.DB, BusinessSkinForm;

type
  TFrmPesquisaDocumentos = class(TFrmPesquisa)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesquisaDocumentos: TFrmPesquisaDocumentos;

implementation

{$R *.dfm}

end.
