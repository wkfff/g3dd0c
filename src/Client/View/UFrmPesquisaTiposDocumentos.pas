unit UFrmPesquisaTiposDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPesquisa, bsSkinCtrls, bsSkinGrids,Generics.Collections,
  bsDBGrids, Vcl.StdCtrls, Vcl.Mask, bsSkinBoxCtrls,TipoDocumentoController,ServerData,TipoDocumento,
  Data.DB, BusinessSkinForm;

type
  TFrmPesquisaTiposDocumentos = class(TFrmPesquisa)
    procedure btnPesquisarClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AtualizaCamposPesquisa(campos:TObjectList<TServerData>);
  private
    { Private declarations }
  public
    { Public declarations }
    Controller : TTipoDocumentoController;
    fCamposPesquisa:TObjectList<TServerData>;
    procedure AtualizaGrid(tipos_documentos:TObjectList<TTipoDocumento>);
  end;

var
  FrmPesquisaTiposDocumentos: TFrmPesquisaTiposDocumentos;

implementation

{$R *.dfm}

uses UDm, UFrmBase, UFrmPrincipal;

procedure TFrmPesquisaTiposDocumentos.AtualizaCamposPesquisa(
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

procedure TFrmPesquisaTiposDocumentos.AtualizaGrid(
  tipos_documentos: TObjectList<TTipoDocumento>);
var
 i :integer;
begin
Dm.cdsTipoDOcumento.EmptyDataSet;
for i := 0 to tipos_documentos.Count - 1 do
  begin
    Dm.cdsTipoDocumento.Append;
    Dm.cdsTipoDocumento.Fields[0].AsInteger := tipos_documentos.Items[i].Id;
    Dm.cdsTipoDocumento.Fields[1].AsString := tipos_documentos.Items[i].Nome;
    Dm.cdsTipoDocumento.Post;
  end;
  Dm.cdsTipoDocumento.Open;
  Dm.cdsTipoDocumento.EnableControls;
end;

procedure TFrmPesquisaTiposDocumentos.BtnCancelarClick(Sender: TObject);
begin
    inherited;
    ModalResult :=  mrCancel;
end;

procedure TFrmPesquisaTiposDocumentos.BtnOKClick(Sender: TObject);
begin
    inherited;
    ModalResult :=  mrOK;
end;

procedure TFrmPesquisaTiposDocumentos.btnPesquisarClick(Sender: TObject);
begin
    inherited;
    Dm.cdsTipoDOcumento.EmptyDataSet;
    AtualizaGrid(Controller.Consulta(self.fCamposPesquisa[self.cbbPesquisa.ItemIndex].Key,ePesquisa.Text,'like',0));
end;

procedure TFrmPesquisaTiposDocumentos.FormShow(Sender: TObject);
var
sucesso:boolean;
begin
    inherited;
    Controller := TTipoDocumentoController.Create;
    sucesso := Controller.IndexFields(fCamposPesquisa);
    if sucesso then
       Begin
          AtualizaCamposPesquisa(fCamposPesquisa);
          AtualizaGrid(Controller.Consulta('1','1','ALL',0));
       End
    else
      Begin
        FecharForm;
        Controller.Free;
      End;
   self.dsPesquisa.DataSet := Dm.cdsTipoDOcumento;
end;

end.
