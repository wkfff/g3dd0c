unit UDm;

interface

uses
  SysUtils, Classes, Dialogs, ImgList,
  Controls, DB, DBClient,DSHTTPLayer, WideStrings, DbxDatasnap, SqlExpr,
  IPPeerClient, Data.DBXCommon, Data.DbxHTTPLayer, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Datasnap.DSHTTPClient;

type
  TDm = class(TDataModule)
    CDSUsuario: TClientDataSet;
    DSUsuario: TDataSource;
    ImagensCadastros: TImageList;
    ImagensCadastrosD: TImageList;
    SaveDialog: TSaveDialog;
    CDSVersaoDocumento: TClientDataSet;
    DSVersaoDocumento: TDataSource;
    CDSDocumento: TClientDataSet;
    DSDocumento: TDataSource;
    OpenDialog: TOpenDialog;
    CDSUsuarioID: TIntegerField;
    CDSUsuarioNOME: TStringField;
    CDSUsuarioSENHA: TStringField;
    cdsTipoDOcumento: TClientDataSet;
    cdsTipoDOcumentoID: TIntegerField;
    cdsTipoDOcumentoNOME: TStringField;
    dsTipoDocumento: TDataSource;
    SQLConnection1: TSQLConnection;
    cdsTipoDOcumentoTAMANHO_MAXIMO: TIntegerField;
    CDSDocumentoID: TIntegerField;
    CDSDocumentoNOME: TStringField;
    CDSDocumentoIDEMPRESA: TIntegerField;
    CDSDocumentoIDTIPODOCUMENTO: TIntegerField;
    CDSDocumentoDESCRICAO: TStringField;
    CDSDocumentoPALAVRACHAVE: TStringField;
    CDSDocumentoPODEALTERAR: TStringField;
    CDSDocumentoASSINADO: TStringField;
    CDSDocumentoDATAEXCLUSAO: TDateField;
    CDSDocumentoDATAFIMVIGENCIA: TDateField;
    CDSDocumentoPODEEXCLUIR: TStringField;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    HTTP:TDSHTTP;
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
begin
self.CDSUsuario.CreateDataSet;
self.cdsTipoDOcumento.CreateDataSet;
self.CDSDocumento.CreateDataSet;
HTTP := TDSHTTP.Create;

end;

end.
