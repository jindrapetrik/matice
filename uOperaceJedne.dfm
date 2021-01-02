object frmOperaceJedne: TfrmOperaceJedne
  Left = 295
  Top = 189
  ClientHeight = 98
  ClientWidth = 211
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
  object Label3: TLabel
    Left = 8
    Top = 35
    Width = 46
    Height = 13
    Caption = 'V'#253'sledek:'
  end
  object Label2: TLabel
    Left = 8
    Top = 12
    Width = 32
    Height = 13
    Caption = 'Matice'
  end
  object cmbMatice: TComboBox
    Left = 72
    Top = 8
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object edtVysledek: TEdit
    Left = 72
    Top = 32
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'V'
  end
  object btnOK: TButton
    Left = 8
    Top = 64
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 120
    Top = 64
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
