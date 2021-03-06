unit UServerContainer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DSCommonServer, DSHTTPCommon, DSHTTP, DSServer, ConexaoBD,DSServerClass;

type
  TServerContainer = class(TForm)
    DSServer: TDSServer;
    DSHTTPService: TDSHTTPService;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FLOG: TStrings;
    procedure RegistrarClasse(pClasse: TPersistentClass);
  public
    { Public declarations }
    procedure RegistrarClasses;
    procedure GravaLog(Valor:String);
    procedure ConectarBD;
    property Log: TStrings read FLOG write FLOG;
  end;

var
  ServerContainer: TServerContainer;

implementation

uses UsuarioController;

{$R *.dfm}

{ TServerContainer }

procedure TServerContainer.ConectarBD;
begin
  try
    TDBExpress.Conectar('Firebird');
    GravaLog('Banco de dados conectado.');
  finally
  end;
end;

procedure TServerContainer.DataModuleCreate(Sender: TObject);
begin
  Log := TStringList.Create;
end;

procedure TServerContainer.GravaLog(Valor: String);
begin
  Log.Add(Valor);
end;

procedure TServerContainer.RegistrarClasse(pClasse: TPersistentClass);
var
  DsServerClass: TServerClassPadrao;
begin
  DsServerClass := TServerClassPadrao.Create(Self);
  DsServerClass.RegisterClass := pClasse;
  DsServerClass.Server := DSServer;

  GravaLog('Classe '+pClasse.ClassName+' registrada.');
end;

procedure TServerContainer.RegistrarClasses;
begin
  RegistrarClasse(TUsuarioController);
  //RegistrarClasse(TPaisController);
  //RegistrarClasse(TTipoDocumentoController);
  //RegistrarClasse(TDocumentoController);
  //RegistrarClasse(TDownloadArquivoController);
end;

end.
