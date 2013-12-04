inherited FrmPesquisaTiposDocumentos: TFrmPesquisaTiposDocumentos
  Caption = 'Busca de Tipos de Dcumento'
  OnShow = FormShow
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
    Left = 72
    Top = 80
  end
end
