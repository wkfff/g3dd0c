unit Validators.CustomAttributes;

interface

uses Validators.CoreAttributes;

type
  validates_email = class(validates_format)
  public
    constructor Create(pErrorMessage:String='');overload;
  end;

  validates_arquivo_imagem = class(validates_format)
  public
    constructor Create(pErrorMessage:String='');overload;
  end;

  validates_ip = class(validates_format)
  public
    constructor Create(pErrorMessage:String='');overload;
  end;

  validates_url = class(validates_format)
  public
    constructor Create(pErrorMessage:String='');overload;
  end;

  validates_fone_br = class(validates_format)
  public
    constructor Create(pErrorMessage:String='');overload;
  end;



implementation

{ validates_email }

constructor validates_email.Create(pErrorMessage: String);
begin
  self.FFormat := '[_a-zA-Z\d\-\.]+@([_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+)';
end;


{ validates_arquivo_imagem }

constructor validates_arquivo_imagem.Create(pErrorMessage: String);
begin
    self.FFormat := '[a-zA-Z0-9-_\.]+\.(jpg|gif|png)$';
end;

{ validates_ip }

constructor validates_ip.Create(pErrorMessage: String);
begin
   self.FFormat := '((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})$';
end;


{ validates_url }

constructor validates_url.Create(pErrorMessage: String);
begin
  self.FFormat := '(http[s]?://|ftp://)?(www\.)?[a-zA-Z0-9-\.]+\.(com|org|net|mil|edu|ca|co.uk|com.au|gov|br)$';
end;

{ validates_fone_br }

constructor validates_fone_br.Create(pErrorMessage: String);
begin
  self.FFormat := '\(?\d{2}\)?[\s-]?\d{4}-?\d{4}$';
end;

end.
