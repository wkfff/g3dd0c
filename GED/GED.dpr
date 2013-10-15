program GED;

uses
  Forms,
  UFrmPrincipal in 'UFrmPrincipal.pas' {FrmPrincipal},
  UFrmBase in 'UFrmBase.pas' {FrmBase},
  UFrmTiposDocumentos in 'UFrmTiposDocumentos.pas' {FrmTiposDocumentos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmBase, FrmBase);
  Application.CreateForm(TFrmTiposDocumentos, FrmTiposDocumentos);
  Application.Run;
end.
