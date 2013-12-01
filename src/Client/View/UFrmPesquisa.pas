unit UFrmPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls, bsSkinGrids, bsDBGrids,
  Vcl.StdCtrls, Vcl.Mask, bsSkinBoxCtrls,Controller,Generics.Collections,BaseModel,DocumentoCOntroller,
  Data.DB, BusinessSkinForm;

type
  TFrmPesquisa = class(TForm)
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
    BtnOK: TbsSkinButton;
    BtnCancelar: TbsSkinButton;
    dsPesquisa: TDataSource;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FecharForm;
  end;

implementation

{$R *.dfm}

{ TFrmPesquisa }



procedure TFrmPesquisa.BtnCancelarClick(Sender: TObject);
begin
    self.ModalResult := mrCancel;
end;

procedure TFrmPesquisa.BtnOKClick(Sender: TObject);
begin
    self.ModalResult := mrOk;
end;

procedure TFrmPesquisa.FecharForm;
begin
    Close;
    self.bsBusinessSkinForm1.CloseAll;
    PostMessage(Handle, WM_CLOSE, 0, 0);
end;

end.



