object frmPridat: TfrmPridat
  Left = 339
  Top = 156
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'P'#345'idat'
  ClientHeight = 129
  ClientWidth = 150
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 27
    Width = 45
    Height = 13
    Caption = 'Um'#237'st'#283'n'#237':'
  end
  object Label2: TLabel
    Left = 8
    Top = 60
    Width = 31
    Height = 13
    Caption = 'Po'#269'et:'
  end
  object cmbUmisteni: TComboBox
    Left = 56
    Top = 24
    Width = 81
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 0
    Text = 'Za v'#253'b'#283'r'
    Items.Strings = (
      'Na za'#269#225'tek'
      'P'#345'ed v'#253'b'#283'r'
      'Za v'#253'b'#283'r'
      'Na konec')
  end
  object btnOK: TButton
    Left = 8
    Top = 96
    Width = 65
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnStorno: TButton
    Left = 80
    Top = 96
    Width = 65
    Height = 25
    Cancel = True
    Caption = 'Storno'
    TabOrder = 1
    OnClick = btnStornoClick
  end
  object updPocet: TUpDown
    Left = 119
    Top = 57
    Width = 16
    Height = 21
    Associate = edtPocet
    Min = 1
    Max = 999
    Position = 1
    TabOrder = 3
  end
  object edtPocet: TEdit
    Left = 56
    Top = 57
    Width = 63
    Height = 21
    TabOrder = 4
    Text = '1'
  end
end
