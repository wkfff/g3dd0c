unit SA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Generics.Collections,ServerData,DBXJSON,superobject;

type
  TFSA = class(TForm)
    MemoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSA: TFSA;

implementation

uses
  ServerContainer, ConnectionDialog,DBConnection, Usuario, JSonVO;

{$R *.dfm}

procedure TFSA.FormActivate(Sender: TObject);
begin
  if not TDBConnection.GetInstance.HasConnection then
  Begin
       TfrmConnectionDialog.ConfigureConnection;
  End
  else FServerContainer.GravaLog('Banco de dados conectado');
end;

procedure TFSA.FormCreate(Sender: TObject);
var
 Usuario:TUsuario;
 dict:TObjectList<TServerData>;
 i:integer;
 JObj  : TJSONValue;
 JPair  : TJSONPair;
 obj: ISuperObject;
begin
  Application.CreateForm(TFServerContainer, FServerContainer);

  MemoLog.Lines.Clear;

  FServerContainer.Log := MemoLog.Lines;

  FServerContainer.RegistrarClasses;
  FServerContainer.DSServer.Start;
  FServerContainer.ConectarBD;

  {Usuario := TUsuario.Create;
  Usuario.Nome := '123';
  Usuario.Senha:= '123';
  Usuario.validate(dict);
  for i := 0 to dict.Count - 1 do
     Begin
        Self.MemoLog.Lines.Add('Campo:'+dict.Items[i].Key+' erro :'+dict.Items[i].Value);
     End;
  JObj := TJSonVO.ObjectToJSON(Usuario);
  obj := SO(JObj.ToString);
  Self.MemoLog.Lines.Add(obj['type'].AsString);}
end;

end.




