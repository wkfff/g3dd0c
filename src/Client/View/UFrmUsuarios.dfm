inherited FrmUsuarios: TFrmUsuarios
  Caption = 'FrmUsuarios'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PCBase: TPageControl
    ActivePage = tsCadastro
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited bsSkinPanel2: TbsSkinPanel
        object Label3: TLabel [0]
          Left = 3
          Top = 3
          Width = 27
          Height = 13
          Align = alCustom
          Caption = 'Nome'
        end
        object Label4: TLabel [1]
          Left = 147
          Top = 3
          Width = 27
          Height = 13
          Align = alCustom
          Caption = 'Nome'
        end
        object DBESenha: TDBEdit
          Left = 147
          Top = 20
          Width = 137
          Height = 21
          DataField = 'SENHA'
          DataSource = dsBase
          TabOrder = 2
        end
        object DBENome: TDBEdit
          Left = 3
          Top = 20
          Width = 137
          Height = 21
          DataField = 'NOME'
          DataSource = dsBase
          TabOrder = 3
        end
      end
    end
  end
end
