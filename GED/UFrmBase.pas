unit UFrmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, DB, DBClient;

type
  TFrmBase = class(TForm)
    bsForm: TbsBusinessSkinForm;
    cdsBase: TClientDataSet;
    dsBase: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBase: TFrmBase;

implementation

uses UFrmPrincipal;

{$R *.dfm}

end.
