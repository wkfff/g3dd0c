inherited FrmPesquisaOrgaos: TFrmPesquisaOrgaos
  Caption = 'Pesquisa de '#211'rg'#227'os'
  OnShow = FormShow
  ExplicitWidth = 668
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 13
  inherited bsSkinPanel1: TbsSkinPanel
    inherited GroupBox1: TGroupBox
      inherited btnPesquisar: TbsSkinButton
        OnClick = btnPesquisarClick
      end
    end
  end
  inherited bsBusinessSkinForm1: TbsBusinessSkinForm
    SkinData = FrmPrincipal.bsSkinData1
    Left = 288
    Top = 224
  end
end
