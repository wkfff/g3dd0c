program iDocClient;

uses
  Forms,
  JSonVO in '..\Comum\model\JSonVO.pas',
  Usuario in '..\Comum\model\Usuario.pas',
  Atributos in '..\Comum\utils\Atributos.pas',
  UsuarioController in 'Controller\UsuarioController.pas',
  UFrmBase in 'View\UFrmBase.pas' {FrmBase},
  Constantes in '..\Comum\utils\Constantes.pas',
  BaseModel in '..\Comum\model\BaseModel.pas',
  Controller in 'Controller\Controller.pas',
  UFrmLogin in 'View\UFrmLogin.pas' {FrmLogin},
  UFrmUsuarios in 'View\UFrmUsuarios.pas' {FrmUsuarios},
  Helpers in '..\Comum\utils\Helpers.pas',
  TipoDocumento in '..\Comum\model\TipoDocumento.pas',
  superobject in '..\Comum\utils\superobject.pas',
  ServerData in '..\Comum\utils\ServerData.pas',
  Validators.CoreAttributes in 'Validators\Validators.CoreAttributes.pas',
  UFrmOrgao in 'View\UFrmOrgao.pas' {FrmOrgao},
  Orgao in '..\Comum\model\Orgao.pas',
  OrgaoController in 'Controller\OrgaoController.pas',
  UnidadeOrcamentariaController in 'Controller\UnidadeOrcamentariaController.pas',
  UnidadeOrcamentaria in '..\Comum\model\UnidadeOrcamentaria.pas',
  UFrmUnidadeOrcamentaria in 'View\UFrmUnidadeOrcamentaria.pas' {FrmUnidadeOrcamentaria},
  UFrmPesquisa in 'View\UFrmPesquisa.pas' {FrmPesquisa},
  UFrmPesquisaDocumentos in 'View\UFrmPesquisaDocumentos.pas' {FrmPesquisaDocumentos},
  UFrmPesquisaTiposDocumentos in 'View\UFrmPesquisaTiposDocumentos.pas' {FrmPesquisaTiposDocumentos},
  UFrmTipoDocumento in 'View\UFrmTipoDocumento.pas' {FrmTipoDocumento},
  UFrmDocumento in 'View\UFrmDocumento.pas' {FrmDocumentos},
  DocumentoController in 'Controller\DocumentoController.pas',
  TipoDocumentoController in 'Controller\TipoDocumentoController.pas',
  Documento in '..\Comum\model\Documento.pas',
  UHelpers in 'Helpers\UHelpers.pas',
  VersaoDocumento in '..\Comum\model\VersaoDocumento.pas',
  UFrmPrincipal in 'View\UFrmPrincipal.pas' {FrmPrincipal},
  UDm in 'Data\UDm.pas' {Dm: TDataModule},
  UFrmPesquisaOrgaos in 'View\UFrmPesquisaOrgaos.pas' {FrmPesquisaOrgaos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmBase, FrmBase);
  Application.CreateForm(TFrmDocumentos, FrmDocumentos);
  Application.CreateForm(TFrmPesquisaDocumentos, FrmPesquisaDocumentos);
  Application.CreateForm(TFrmPesquisaTiposDocumentos, FrmPesquisaTiposDocumentos);
  Application.CreateForm(TFrmDocumentos, FrmDocumentos);
  Application.CreateForm(TFrmPesquisaOrgaos, FrmPesquisaOrgaos);
  Application.CreateForm(TFrmPesquisaTiposDocumentos, FrmPesquisaTiposDocumentos);
  Application.CreateForm(TFrmTipoDocumento, FrmTipoDocumento);
  Application.CreateForm(TFrmDocumentos, FrmDocumentos);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmPesquisaOrgaos, FrmPesquisaOrgaos);
  Application.Run;
end.
