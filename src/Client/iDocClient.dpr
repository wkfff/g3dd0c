program iDocClient;

uses
  Forms,
  UFrmPrincipal in 'View\UFrmPrincipal.pas' {FrmPrincipal},
  JSonVO in '..\Comum\model\JSonVO.pas',
  Usuario in '..\Comum\model\Usuario.pas',
  Atributos in '..\Comum\utils\Atributos.pas',
  UsuarioController in 'Controller\UsuarioController.pas',
  UDm in 'Data\UDm.pas' {Dm: TDataModule},
  UFrmBase in 'View\UFrmBase.pas' {FrmBase},
  Constantes in '..\Comum\utils\Constantes.pas',
  BaseModel in '..\Comum\model\BaseModel.pas',
  Controller in 'Controller\Controller.pas',
  UFrmLogin in 'View\UFrmLogin.pas' {FrmLogin},
  UFrmUsuarios in 'View\UFrmUsuarios.pas' {FrmUsuarios},
  Helpers in '..\Comum\utils\Helpers.pas',
  TipoDocumentoController in 'Controller\TipoDocumentoController.pas',
  DocumentoController in 'Controller\DocumentoController.pas',
  TipoDocumento in '..\Comum\model\TipoDocumento.pas',
  UFrmTipoDocumento in 'View\UFrmTipoDocumento.pas' {FrmTipoDocumento},
  superobject in '..\Comum\utils\superobject.pas',
  ServerData in '..\Comum\utils\ServerData.pas',
  Validators.CoreAttributes in 'Validators\Validators.CoreAttributes.pas',
  UFrmOrgao in 'View\UFrmOrgao.pas' {FrmOrgao},
  Orgao in '..\Comum\model\Orgao.pas',
  OrgaoController in 'Controller\OrgaoController.pas',
  UnidadeOrcamentariaController in 'Controller\UnidadeOrcamentariaController.pas',
  UnidadeOrcamentaria in '..\Comum\model\UnidadeOrcamentaria.pas',
  UFrmUnidadeOrcamentaria in 'View\UFrmUnidadeOrcamentaria.pas' {FrmUnidadeOrcamentaria};
  UFrmDocumento in 'View\UFrmDocumento.pas' {FrmDocumentos},
  UFrmPesquisa in 'View\UFrmPesquisa.pas' {FrmPesquisa},
  Documento in '..\Comum\model\Documento.pas',
  UHelpers in 'Helpers\UHelpers.pas',
  UFrmPesquisaDocumentos in 'View\UFrmPesquisaDocumentos.pas' {FrmPesquisa1},
  UFrmPesquisaTiposDocumentos in 'View\UFrmPesquisaTiposDocumentos.pas' {FrmPesquisaTiposDocumentos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmBase, FrmBase);
  Application.CreateForm(TFrmDocumentos, FrmDocumentos);
  Application.CreateForm(TFrmPesquisa1, FrmPesquisa1);
  Application.CreateForm(TFrmPesquisaTiposDocumentos, FrmPesquisaTiposDocumentos);
  Application.Run;
end.
