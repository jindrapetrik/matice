object frmOperaceDvou: TfrmOperaceDvou
  Left = 221
  Top = 207
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
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
    Top = 12
    Width = 43
    Height = 13
    Caption = '1. matice'
  end
  object Label2: TLabel
    Left = 8
    Top = 37
    Width = 43
    Height = 13
    Caption = '2. matice'
  end
  object Label3: TLabel
    Left = 8
    Top = 59
    Width = 46
    Height = 13
    Caption = 'V'#253'sledek:'
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
  object cmbMatice1: TComboBox
    Left = 72
    Top = 8
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object cmbMatice2: TComboBox
    Left = 72
    Top = 32
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object edtVysledek: TEdit
    Left = 72
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'V'
  end
end
