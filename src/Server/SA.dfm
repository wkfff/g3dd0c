object FSA: TFSA
  Left = 226
  Top = 236
  BorderStyle = bsDialog
  Caption = 'T2Ti - Servidor de Aplica'#231#245'es'
  ClientHeight = 300
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MemoLog: TMemo
    Left = 0
    Top = 0
    Width = 742
    Height = 300
    TabStop = False
    Align = alClient
    ReadOnly = True
    TabOrder = 0
  end
end
