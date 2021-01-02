object frmFormat: TfrmFormat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form'#225't matice'
  ClientHeight = 151
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblVyberteObor: TLabel
    Left = 72
    Top = 8
    Width = 138
    Height = 13
    Caption = 'Vyberte obor hodnot matice:'
  end
  object btnOK: TButton
    Left = 24
    Top = 113
    Width = 89
    Height = 25
    Caption = 'O&K'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnStorno: TButton
    Left = 176
    Top = 113
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Storno'
    TabOrder = 2
    OnClick = btnStornoClick
  end
  object lsbFormat: TListBox
    Left = 24
    Top = 32
    Width = 241
    Height = 65
    ItemHeight = 13
    Items.Strings = (
      'R - Re'#225'ln'#225' '#269#237'sla'
      'C - Komplexn'#237' '#269#237'sla'
      'Z2 - Cel'#225' bin'#225'rn'#237' '#269#237'sla')
    TabOrder = 0
    OnDblClick = btnOKClick
  end
end
