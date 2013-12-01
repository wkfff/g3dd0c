inherited FrmDocumentos: TFrmDocumentos
  Caption = 'Documentos'
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
      inherited bsSkinPanel2: TbsSkinPanel
        object Label3: TLabel [0]
          Left = 6
          Top = 8
          Width = 29
          Height = 13
          Caption = 'NOME'
          FocusControl = DBEdit1
        end
        object Label5: TLabel [1]
          Left = 5
          Top = 88
          Width = 99
          Height = 13
          Caption = 'IDTIPODOCUMENTO'
          FocusControl = DBEdit3
        end
        object Label6: TLabel [2]
          Left = 6
          Top = 48
          Width = 59
          Height = 13
          Caption = 'DESCRICAO'
          FocusControl = DBEdit4
        end
        object Label7: TLabel [3]
          Left = 144
          Top = 88
          Width = 78
          Height = 13
          Caption = 'PALAVRACHAVE'
          FocusControl = DBEdit5
        end
        object Label8: TLabel [4]
          Left = 290
          Top = 88
          Width = 72
          Height = 13
          Caption = 'PODEALTERAR'
          FocusControl = DBEdit6
        end
        object Label9: TLabel [5]
          Left = 232
          Top = 88
          Width = 52
          Height = 13
          Caption = 'ASSINADO'
          FocusControl = DBEdit7
        end
        object Label10: TLabel [6]
          Left = 368
          Top = 88
          Width = 93
          Height = 13
          Caption = 'DATAFIMVIGENCIA'
          FocusControl = DBEdit8
        end
        object Label11: TLabel [7]
          Left = 508
          Top = 88
          Width = 79
          Height = 13
          Caption = 'DATAEXCLUSAO'
          FocusControl = DBEdit9
        end
        object Label12: TLabel [8]
          Left = 656
          Top = 88
          Width = 69
          Height = 13
          Caption = 'PODEEXCLUIR'
          FocusControl = DBEdit10
        end
        object DBEdit1: TDBEdit
          Left = 6
          Top = 24
          Width = 736
          Height = 21
          DataField = 'NOME'
          DataSource = dsBase
          TabOrder = 2
        end
        object DBEdit3: TDBEdit
          Left = 5
          Top = 104
          Width = 134
          Height = 21
          DataField = 'IDTIPODOCUMENTO'
          DataSource = dsBase
          TabOrder = 3
          OnKeyDown = DBEdit3KeyDown
        end
        object DBEdit4: TDBEdit
          Left = 6
          Top = 64
          Width = 784
          Height = 21
          DataField = 'DESCRICAO'
          DataSource = dsBase
          TabOrder = 4
        end
        object DBEdit5: TDBEdit
          Left = 145
          Top = 104
          Width = 17
          Height = 21
          DataField = 'PALAVRACHAVE'
          DataSource = dsBase
          TabOrder = 5
        end
        object DBEdit6: TDBEdit
          Left = 290
          Top = 104
          Width = 17
          Height = 21
          DataField = 'PODEALTERAR'
          DataSource = dsBase
          TabOrder = 6
        end
        object DBEdit7: TDBEdit
          Left = 232
          Top = 104
          Width = 17
          Height = 21
          DataField = 'ASSINADO'
          DataSource = dsBase
          TabOrder = 7
        end
        object DBEdit8: TDBEdit
          Left = 368
          Top = 104
          Width = 134
          Height = 21
          DataField = 'DATAFIMVIGENCIA'
          DataSource = dsBase
          TabOrder = 8
        end
        object DBEdit9: TDBEdit
          Left = 508
          Top = 104
          Width = 134
          Height = 21
          DataField = 'DATAEXCLUSAO'
          DataSource = Dm.DSDocumento
          TabOrder = 9
        end
        object DBEdit10: TDBEdit
          Left = 656
          Top = 104
          Width = 17
          Height = 21
          DataField = 'PODEEXCLUIR'
          DataSource = dsBase
          TabOrder = 10
        end
      end
    end
  end
  inherited dsBase: TDataSource
    DataSet = nil
    Left = 256
    Top = 168
  end
end
