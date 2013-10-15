inherited FrmTipoDocumento: TFrmTipoDocumento
  Caption = 'Cadastro de tipos de documento'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PCBase: TPageControl
    inherited tsPesquisa: TTabSheet
      inherited bsSkinPanel1: TbsSkinPanel
        inherited GroupBox1: TGroupBox
          inherited btnPesquisar: TbsSkinButton
            OnClick = btnPesquisarClick
          end
        end
      end
    end
    inherited tsCadastro: TTabSheet
      inherited bsSkinPanel2: TbsSkinPanel
        object bsSkinStdLabel3: TbsSkinStdLabel [0]
          Left = 3
          Top = 10
          Width = 27
          Height = 13
          EllipsType = bsetNone
          UseSkinFont = True
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinDataName = 'stdlabel'
          Caption = 'Nome'
        end
        object bsSkinStdLabel4: TbsSkinStdLabel [1]
          Left = 380
          Top = 10
          Width = 64
          Height = 13
          EllipsType = bsetNone
          UseSkinFont = True
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinDataName = 'stdlabel'
          Caption = 'Tamanho(KB)'
        end
        object dbeNome: TbsSkinDBEdit
          Left = 3
          Top = 24
          Width = 366
          Height = 19
          Text = 'DBENOME'
          DefaultColor = clWindow
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = False
          SkinDataName = 'edit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 13
          Font.Name = 'Tahoma'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          TabOrder = 2
          ButtonImageIndex = -1
          LeftImageIndex = -1
          LeftImageHotIndex = -1
          LeftImageDownIndex = -1
          RightImageIndex = -1
          RightImageHotIndex = -1
          RightImageDownIndex = -1
          AutoSize = False
          DataField = 'NOME'
          DataSource = dsBase
        end
        object DBETamanhoMaximo: TbsSkinDBEdit
          Left = 380
          Top = 24
          Width = 157
          Height = 19
          Text = 'DBETAMANHOMAXIMO'
          DefaultColor = clWindow
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = False
          SkinDataName = 'edit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 13
          Font.Name = 'Tahoma'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          TabOrder = 3
          ButtonImageIndex = -1
          LeftImageIndex = -1
          LeftImageHotIndex = -1
          LeftImageDownIndex = -1
          RightImageIndex = -1
          RightImageHotIndex = -1
          RightImageDownIndex = -1
          AutoSize = False
          DataSource = dsBase
        end
      end
    end
  end
  inherited dsBase: TDataSource
    DataSet = Dm.cdsTipoDOcumento
  end
end
