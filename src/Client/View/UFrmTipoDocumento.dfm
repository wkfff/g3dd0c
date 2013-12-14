inherited FrmTipoDocumento: TFrmTipoDocumento
  Caption = 'Cadastro de tipos de documento'
  ClientWidth = 753
  ExplicitWidth = 769
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  inherited PCBase: TPageControl
    Width = 753
    ActivePage = tsCadastro
    ExplicitWidth = 753
    inherited tsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 745
      ExplicitHeight = 324
      inherited bsSkinPanel1: TbsSkinPanel
        Width = 745
        ExplicitWidth = 745
        inherited GroupBox1: TGroupBox
          Width = 738
          ExplicitWidth = 738
          inherited ePesquisa: TbsSkinEdit
            Width = 505
            ExplicitWidth = 505
          end
          inherited btnPesquisar: TbsSkinButton
            Left = 650
            OnClick = btnPesquisarClick
            ExplicitLeft = 650
          end
          inherited bsSkinGroupBox1: TbsSkinGroupBox
            Width = 722
            ExplicitWidth = 722
            inherited bsSkinDBGrid1: TbsSkinDBGrid
              Width = 687
            end
            inherited bsSkinScrollBar1: TbsSkinScrollBar
              Width = 687
              ExplicitWidth = 687
            end
            inherited bsSkinScrollBar2: TbsSkinScrollBar
              Left = 698
              ExplicitLeft = 698
            end
          end
        end
      end
    end
    inherited tsCadastro: TTabSheet
      ExplicitWidth = 745
      inherited bsSkinPanel2: TbsSkinPanel
        Width = 745
        ExplicitWidth = 745
        object bsSkinVistaGlowLabel1: TbsSkinVistaGlowLabel [0]
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
      end
    end
  end
  inherited dsBase: TDataSource
    DataSet = nil
    Left = 552
    Top = 120
  end
  inherited bsBusinessSkinForm1: TbsBusinessSkinForm
    Left = 480
    Top = 120
  end
end
