unit UFrmTiposDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmBase, DB, DBClient, BusinessSkinForm, ComCtrls, bsSkinTabs,
  bsSkinCtrls, StdCtrls, bsSkinBoxCtrls, Mask, bsSkinGrids, bsDBGrids, bsdbctrls;

type
  TFrmTiposDocumentos = class(TFrmBase)
    bsPC: TbsSkinPageControl;
    tsListagem: TbsSkinTabSheet;
    tsDados: TbsSkinTabSheet;
    bsPesquisa: TbsSkinEdit;
    cbbPesquisa: TbsSkinComboBox;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    btnPesquisar: TbsSkinButton;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinDBGrid1: TbsSkinDBGrid;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinScrollBar2: TbsSkinScrollBar;
    btnNovo: TbsSkinButton;
    cdsBaseID: TIntegerField;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinDBText1: TbsSkinDBText;
    dbeDescricao: TbsSkinDBEdit;
    bsSkinStdLabel4: TbsSkinStdLabel;
    cdsBaseDESCRICAO: TStringField;
    btnEditar: TbsSkinButton;
    btnExcluir: TbsSkinButton;
    btnSalvar: TbsSkinButton;
    btnCancelar: TbsSkinButton;
    bsSkinGroupBox2: TbsSkinGroupBox;
    bsSkinDBGrid2: TbsSkinDBGrid;
    bsSkinScrollBar3: TbsSkinScrollBar;
    bsSkinScrollBar4: TbsSkinScrollBar;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    bsSkinGroupBox3: TbsSkinGroupBox;
    bsSkinDBGrid3: TbsSkinDBGrid;
    bsSkinScrollBar5: TbsSkinScrollBar;
    bsSkinScrollBar6: TbsSkinScrollBar;
    bsSkinButton3: TbsSkinButton;
    bsSkinButton4: TbsSkinButton;
    bsSkinEdit1: TbsSkinEdit;
    bsSkinStdLabel5: TbsSkinStdLabel;
    procedure FormCreate(Sender: TObject);
    procedure InsereDados;
    procedure MudaEstado(inserindo,salvando:boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTiposDocumentos: TFrmTiposDocumentos;

implementation

uses UFrmPrincipal;

{$R *.dfm}

procedure TFrmTiposDocumentos.btnEditarClick(Sender: TObject);
begin
  inherited;
  MudaEstado(false,false);
end;

procedure TFrmTiposDocumentos.btnNovoClick(Sender: TObject);
begin
  inherited;
  MudaEstado(true,false);
end;

procedure TFrmTiposDocumentos.btnSalvarClick(Sender: TObject);
begin
  inherited;
  MudaEstado(false,true);
end;

procedure TFrmTiposDocumentos.btnCancelarClick(Sender: TObject);
begin
  inherited;
  MudaEstado(false,false);
end;

procedure TFrmTiposDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  self.cbbPesquisa.ItemIndex := 1;
  self.cdsBase.CreateDataSet;
  InsereDados;
  self.bsPC.TabIndex := 0;
end;

procedure TFrmTiposDocumentos.InsereDados;
begin
   self.cdsBase.Append;
   self.cdsBaseID.Value := 1;
   self.cdsBaseDESCRICAO.Value := 'NOTE DE EMPENHO';
   self.cdsBase.Post;

   self.cdsBase.Append;
   self.cdsBaseID.Value := 2;
   self.cdsBaseDESCRICAO.Value := 'NOTE DE LIQUIDAÇÃO';
   self.cdsBase.Post;
end;

procedure TFrmTiposDocumentos.MudaEstado(inserindo,salvando:boolean);
begin
     self.tsDados.TabVisible := not self.tsDados.TabVisible ;
     self.tsListagem.TabVisible := not self.tsListagem.TabVisible;
     if self.dsBase.State in [dsInsert,dsEdit] then
         Begin
             if salvando then
                 self.cdsBase.Post
             else self.cdsBase.Cancel;
         End
     else
         Begin
             if inserindo then
                 self.cdsBase.Append
             else self.cdsBase.Edit;
         End;

end;

end.
