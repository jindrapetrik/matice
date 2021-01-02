object frmNahodnaSoustava: TfrmNahodnaSoustava
  Left = 329
  Top = 269
  BorderStyle = bsDialog
  Caption = 'Vyplnit n'#225'hodn'#283' soustavu'
  ClientHeight = 199
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grbKoeficienty: TGroupBox
    Left = 8
    Top = 8
    Width = 161
    Height = 137
    Caption = 'Koeficienty'
    TabOrder = 0
    object lblRozsah: TLabel
      Left = 16
      Top = 103
      Width = 39
      Height = 13
      Caption = 'Rozsah:'
    end
    object rdbKoefCele: TRadioButton
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Cel'#225' '#269#237'sla'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdbKoefZlomky: TRadioButton
      Left = 16
      Top = 47
      Width = 97
      Height = 17
      Caption = 'Zlomky'
      TabOrder = 1
    end
    object chkKoefKomplex: TCheckBox
      Left = 18
      Top = 70
      Width = 105
      Height = 25
      Caption = 'Komplexn'#237
      TabOrder = 2
    end
    object edtKoefRozsah: TEdit
      Left = 61
      Top = 101
      Width = 76
      Height = 21
      TabOrder = 3
      Text = '10'
      OnExit = edtKoefRozsahExit
    end
  end
  object grbKoreny: TGroupBox
    Left = 175
    Top = 8
    Width = 161
    Height = 137
    Caption = 'Nezn'#225'm'#233
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 103
      Width = 39
      Height = 13
      Caption = 'Rozsah:'
    end
    object rdbKorenyCele: TRadioButton
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Cel'#225' '#269#237'sla'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdbKorenyZlomky: TRadioButton
      Left = 16
      Top = 47
      Width = 97
      Height = 17
      Caption = 'Zlomky'
      TabOrder = 1
    end
    object chkKorenyKomplex: TCheckBox
      Left = 18
      Top = 70
      Width = 105
      Height = 25
      Caption = 'Komplexn'#237
      TabOrder = 2
    end
    object edtKorenyRozsah: TEdit
      Left = 61
      Top = 101
      Width = 76
      Height = 21
      TabOrder = 3
      Text = '10'
      OnExit = edtKoefRozsahExit
    end
  end
  object btnOK: TButton
    Left = 64
    Top = 159
    Width = 81
    Height = 25
    Caption = 'O&K'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnStorno: TButton
    Left = 193
    Top = 159
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 3
    OnClick = btnStornoClick
  end
end
