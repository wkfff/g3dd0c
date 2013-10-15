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
HTTP := TDSHTTP.Create;

end;

end.
