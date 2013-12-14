inherited FrmCargo: TFrmCargo
  Caption = 'Cadastro de Cargos'
  ExplicitWidth = 773
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  inherited PCBase: TPageControl
    inherited tsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 749
      ExplicitHeight = 324
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
        object bsSkinVistaGlowLabel2: TbsSkinVistaGlowLabel [0]
          Left = 0
          Top = 0
          Width = 55
          Height = 41
          HintImageIndex = 0
          AutoSize = True
          DoubleBuffered = False
          GlowColor = clWhite
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel [1]
          Left = 488
          Top = 0
          Width = 103
          Height = 41
          HintImageIndex = 0
          AutoSize = True
          DoubleBuffered = False
          GlowColor = clWhite
          Caption = 'C'#243'digo Cont'#225'bil'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object dbeNome: TbsSkinDBEdit
          Left = 42
          Top = 11
          Width = 450
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
          SkinData = FrmPrincipal.bsSkinData1
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
        object dbeCodigo: TbsSkinDBEdit
          Left = 578
          Top = 11
          Width = 77
          Height = 19
          Text = 'dbeCodigo'
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
          SkinData = FrmPrincipal.bsSkinData1
          SkinDataName = 'edit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 13
          Font.Name = 'Tahoma'
          Font.Style = []
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
          DataField = 'CODIGO'
          DataSource = dsBase
        end
      end
    end
  end
  inherited dsBase: TDataSource
    DataSet = nil
  end
end
