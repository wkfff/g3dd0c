{*******************************************************************************
Title: T2Ti ERP
Description: Unit criada pelo DataSnap - Contem os componentes do SA

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF M  RegistrarClasse(TBancoController);
  RegistrarClasse(TPaisController);
  RegistrarClasse(TTipoDocumentoController);
  RegistrarClasse(TDocumentoController);
  RegistrarClasse(TDownloadArquivoController);
ERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com</p>

@author Fábio Thomaz | Albert Eije (T2Ti.COM)
@version 1.1
*******************************************************************************}
unit ServerContainer;

interface

uses
  SysUtils, Classes, DSTCPServerTransport, DSHTTPCommon, DSHTTP, DSServer,
  DSCommonServer, Windows, WideStrings, DB, SqlExpr, ConexaoBD ,DSService,
  IPPeerServer, Datasnap.DSAuth,DataSnap.DsSession,Aurelius.Engine.ObjectManager, Usuario,
  Aurelius.Criteria.Expression,
  Aurelius.Criteria.Linq,
  Aurelius.JSon.DataSnap,Generics.Collections,
  Aurelius.Criteria.Base,
  IdHashMessageDigest;

type
  TFServerContainer = class(TDataModule)
    DSServer: TDSServer;
    DSHTTPService: TDSHTTPService;
    DSAuthenticationManager1: TDSAuthenticationManager;
    procedure DataModuleCreate(Sender: TObject);
    procedure DSHTTPServiceAuthenticationManager1HTTPAuthenticate(
      Sender: TObject; const Protocol, Context, User, Password: string;
      var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
  private
    FLOG: TStrings;
    FManager: TObjectManager;
    procedure RegistrarClasse(pClasse: TPersistentClass);
  public
    property Log: TStrings read FLOG write FLOG;

    procedure RegistrarClasses;
    procedure GravaLog(Valor:String);
    procedure ConectarBD;
    function MD5String(const Value: string): string;
  end;

var
  FServerContainer: TFServerContainer;

implementation

<<<<<<< HEAD
uses  DSServerClass, Server.UsuarioController, Server.TipoDocumentoController,
  Server.OrgaoController, Server.UnidadeOrcamentariaController,
=======
uses  DSServerClass, Server.UsuarioController, Server.TipoDocumentoController,Server.DocumentoController,
>>>>>>> 75af3a46775eeb5ca4a5dacd408ab9347b8a5d82
  DBConnection;//,BancoController, PaisController, TipoDocumentoController,
  //DocumentoController, DownloadArquivoController;
{$R *.dfm}

procedure TFServerContainer.RegistrarClasses;
begin
GravaLog('ServerContainer');
RegistrarClasse(TUsuarioController);
RegistrarClasse(TTipoDocumentoController);
<<<<<<< HEAD
RegistrarClasse(TOrgaoController);
RegistrarClasse(TUnidadeOrcamentariaController);

=======
RegistrarClasse(TDocumentoController);
>>>>>>> 75af3a46775eeb5ca4a5dacd408ab9347b8a5d82
end;

procedure TFServerContainer.ConectarBD;
begin
  try
    //TDBExpress.Conectar('Firebird');
    GravaLog('Banco de dados conectado.');
  finally
  end;
end;

procedure TFServerContainer.DataModuleCreate(Sender: TObject);
begin
  Log := TStringList.Create;
end;

procedure TFServerContainer.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  Roles:String;
  oList:TObjectList<TUsuario>;
begin
   if (FManager = nil) then
       FManager := TDBConnection.GetInstance.CreateObjectManager;
   valid := true;
   if IsLibrary then
       valid := LowerCase(protocol) = 'https'
   else valid := true;

   try

   if valid then
   if TDSSessionManager.GetThreadSession.GetData('UserID') = '' then
   Begin
       oList := FManager.Find<TUsuario>.Add(TExpression.Eq('nome', User)).List;
       if oList.Count = 0 then
           valid := false
       else valid := oList.Items[0].Senha = MD5String(Password);
       if valid then
           Begin
             TDSSessionManager.GetThreadSession.PutData('UserID',IntToStr(oList.Items[0].id));
             UserRoles.Add('manager');
           End;
   End;
   finally
      if oList <> nil then
          oList.Free;
   end;
end;

procedure TFServerContainer.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
var
  Roles:String;
  oList:TObjectList<TUsuario>;
begin
   if (FManager = nil) then
       FManager := TDBConnection.GetInstance.CreateObjectManager;
   valid := true;
   try
   if valid then
   Begin
       oList := FManager.Find<TUsuario>.Add(TExpression.Eq('id', TDSSessionManager.GetThreadSession.GetData('UserID'))).List;
       if oList.Count = 0 then
           valid := false;
   End;
   finally
      if oList <> nil then
          oList.Free;
   end;
end;

procedure TFServerContainer.DSHTTPServiceAuthenticationManager1HTTPAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean);
begin
   valid := (User = 'eric') and (password = '123');
end;

procedure TFServerContainer.GravaLog(Valor:String);
begin
  Log.Add(Valor);
end;

function TFServerContainer.MD5String(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  try
    Result := xMD5.HashStringAsHex(Value);
  finally
    xMD5.Free;
  end;
end;

procedure TFServerContainer.RegistrarClasse(pClasse: TPersistentClass);
var
  DsServerClass: TServerClassPadrao;
begin
  DsServerClass := TServerClassPadrao.Create(Self);
  DsServerClass.RegisterClass := pClasse;
  DsServerClass.Server := DSServer;

  GravaLog('Classe '+pClasse.ClassName+' registrada.');
end;

end.
