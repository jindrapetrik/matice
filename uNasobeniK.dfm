object frmNasobeniK: TfrmNasobeniK
  Left = 247
  Top = 115
  BorderStyle = bsDialog
  Caption = 'N'#225'soben'#237' konstantou'
  ClientHeight = 121
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 35
    Width = 48
    Height = 13
    Caption = 'Konstanta'
  end
  object Label2: TLabel
    Left = 8
    Top = 12
    Width = 32
    Height = 13
    Caption = 'Matice'
  end
  object Label3: TLabel
    Left = 8
    Top = 59
    Width = 46
    Height = 13
    Caption = 'V'#253'sledek:'
  end
  object edtKonstanta: TEdit
    Left = 72
    Top = 32
    Width = 129
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object cmbMatice: TComboBox
    Left = 72
    Top = 8
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
  end
  object edtVysledek: TEdit
    Left = 72
    Top = 56
    Width = 129
    Height = 21
    TabOrder = 2
    Text = 'V'
  end
  object btnOK: TButton
    Left = 8
    Top = 88
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 120
    Top = 88
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
end
