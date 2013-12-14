program iDocServer;

uses
  Forms,
  ConexaoBD in 'ConexaoBD.pas',
  SA in 'SA.pas' {FSA},
  Server.LoginController in 'Controller\Server.LoginController.pas',
  Server.Controller in 'Controller\Server.Controller.pas',
  Usuario in '..\Comum\model\Usuario.pas',
  Server.UsuarioController in 'Controller\Server.UsuarioController.pas',
  ORM in 'ORM\ORM.pas',
  Atributos in '..\Comum\utils\Atributos.pas',
  Constantes in '..\Comum\utils\Constantes.pas',
  TipoDocumento in '..\Comum\model\TipoDocumento.pas',
  Server.TipoDocumentoController in 'Controller\Server.TipoDocumentoController.pas',
  ServerContainer in 'ServerContainer.pas' {FServerContainer: TDataModule},
  DBConnection in 'ConnectionManager\DBConnection.pas',
  ConnectionDialog in 'ConnectionManager\VCL\ConnectionDialog.pas' {frmConnectionDialog},
  JSonVO in '..\Comum\model\JSonVO.pas',
  BaseModel in '..\Comum\model\BaseModel.pas',
  ServerData in '..\Comum\utils\ServerData.pas',
  superobject in '..\Comum\utils\superobject.pas',
  Documento in '..\Comum\model\Documento.pas',
  Generics.Factory in '..\Comum\utils\Generics.Factory.pas',
  Validator in 'Validators\Validator.pas',
  Validators.CoreAttributes in 'Validators\Validators.CoreAttributes.pas',
  Validators.CustomAttributes in 'Validators\Validators.CustomAttributes.pas',
  Helpers in '..\Comum\utils\Helpers.pas',
  Server.OrgaoController in 'Controller\Server.OrgaoController.pas',
  Orgao in '..\Comum\model\Orgao.pas',
  Server.UnidadeOrcamentariaController in 'Controller\Server.UnidadeOrcamentariaController.pas',
  UnidadeOrcamentaria in '..\Comum\model\UnidadeOrcamentaria.pas',
  Server.DocumentoController in 'Controller\Server.DocumentoController.pas',
  Server.CargoController in 'Controller\Server.CargoController.pas',
  VersaoDocumento in '..\Comum\model\VersaoDocumento.pas',
  Cargo in '..\Comum\model\Cargo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFSA, FSA);
  Application.CreateForm(TFServerContainer, FServerContainer);
  Application.Run;
end.
