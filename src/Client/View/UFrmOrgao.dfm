inherited FrmOrgao: TFrmOrgao
  Caption = 'Cadastro de '#211'rg'#227'os'
  ExplicitWidth = 773
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  inherited PCBase: TPageControl
    ActivePage = tsPesquisa
    inherited tsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 749
      ExplicitHeight = 324
      inherited bsSkinPanel1: TbsSkinPanel
        inherited GroupBox1: TGroupBox
          inherited ePesquisa: TbsSkinEdit
            ExplicitWidth = 509
          end
          inherited btnPesquisar: TbsSkinButton
            Left = 654
            OnClick = btnPesquisarClick
            ExplicitLeft = 654
          end
        end
      end
    end
    inherited tsCadastro: TTabSheet
      inherited bsSkinPanel2: TbsSkinPanel
        object bsSkinStdLabel3: TbsSkinStdLabel [0]
          Left = 6
          Top = 7
          Width = 33
          Height = 13
          EllipsType = bsetNone
          UseSkinFont = True
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinData = FrmPrincipal.bsSkinData1
          SkinDataName = 'stdlabel'
          Caption = 'C'#243'digo'
        end
        object bsSkinStdLabel4: TbsSkinStdLabel [1]
          Left = 92
          Top = 7
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
          SkinData = FrmPrincipal.bsSkinData1
          SkinDataName = 'stdlabel'
          Caption = 'Nome'
        end
        object bsSkinStdLabel5: TbsSkinStdLabel [2]
          Left = 598
          Top = 7
          Width = 75
          Height = 13
          EllipsType = bsetNone
          UseSkinFont = True
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinData = FrmPrincipal.bsSkinData1
          SkinDataName = 'stdlabel'
          Caption = 'C'#243'digo Contabil'
        end
        object dbeID: TbsSkinDBEdit
          Left = 6
          Top = 23
          Width = 80
          Height = 19
          TabStop = False
          Text = 'dbeID'
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
          ReadOnly = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 13
          Font.Name = 'Tahoma'
          Font.Style = []
          Enabled = False
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
          DataField = 'ID'
          DataSource = dsBase
        end
        object dbeNome: TbsSkinDBEdit
          Left = 92
          Top = 23
          Width = 500
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
          TabOrder = 3
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
        object dbeCodContabil: TbsSkinDBEdit
          Left = 598
          Top = 23
          Width = 77
          Height = 19
          Text = 'dbeCodContabil'
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
          TabOrder = 4
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
    DataSet = Dm.CDSOrgao
    Left = 704
    Top = 80
  end
  inherited bsBusinessSkinForm1: TbsBusinessSkinForm
    Left = 616
    Top = 80
  end
end
