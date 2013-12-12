inherited FrmPesquisaOrgaos: TFrmPesquisaOrgaos
  Caption = 'Pesquisa de '#211'rg'#227'os'
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
  end
end
