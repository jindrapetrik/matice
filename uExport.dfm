object frmExport: TfrmExport
  Left = 214
  Top = 269
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Exportovat...'
  ClientHeight = 287
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblFormat: TLabel
    Left = 120
    Top = 20
    Width = 35
    Height = 13
    Caption = 'Form'#225't:'
  end
  object cmbFormat: TComboBox
    Left = 160
    Top = 16
    Width = 169
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Se'#353'it aplikace Excel (XLS)'
    Items.Strings = (
      'Se'#353'it aplikace Excel (XLS)')
  end
  object grbMoznosti: TGroupBox
    Left = 8
    Top = 48
    Width = 425
    Height = 201
    Caption = 'Mo'#382'nosti'
    TabOrder = 1
    object chkNazev: TCheckBox
      Left = 56
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Vlo'#382'it n'#225'zev matice'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkRamecek: TCheckBox
      Left = 56
      Top = 48
      Width = 73
      Height = 25
      Caption = 'R'#225'me'#269'ek'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkOdReseni: TCheckBox
      Left = 56
      Top = 80
      Width = 137
      Height = 17
      Caption = 'Odd'#283'lit '#345'e'#353'en'#237' soustavy'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 2
    end
    object chkOcislovat: TCheckBox
      Left = 56
      Top = 112
      Width = 145
      Height = 17
      Caption = 'O'#269#237'slovat '#345#225'dky a sloupce'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = chkOcislovatClick
    end
    object chkOdsadit: TCheckBox
      Left = 56
      Top = 160
      Width = 137
      Height = 17
      Caption = 'Odsadit o 1 bu'#328'ku'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chkOcisTucne: TCheckBox
      Left = 72
      Top = 136
      Width = 113
      Height = 17
      Caption = 'Tu'#269'n'#233' o'#269#237'slov'#225'n'#237
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object pnlZlomky: TPanel
      Left = 224
      Top = 16
      Width = 185
      Height = 81
      TabOrder = 6
      object lblZlomky: TLabel
        Left = 8
        Top = 8
        Width = 37
        Height = 13
        Caption = 'Zlomky:'
      end
      object rdbZlomkyPrevest: TRadioButton
        Left = 8
        Top = 24
        Width = 153
        Height = 17
        Caption = 'P'#345'ev'#233'st na desetinn'#225' '#269#237'sla'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rdbZlomkyText: TRadioButton
        Left = 8
        Top = 48
        Width = 153
        Height = 17
        Caption = 'Vlo'#382'it jako text'
        TabOrder = 1
      end
    end
    object pnlKomplex: TPanel
      Left = 224
      Top = 103
      Width = 185
      Height = 81
      TabOrder = 7
      object lblKomplex: TLabel
        Left = 8
        Top = 8
        Width = 77
        Height = 13
        Caption = 'Komplexn'#237' '#269#237'sla:'
      end
      object rdbKomplexVlozitText: TRadioButton
        Left = 8
        Top = 24
        Width = 153
        Height = 17
        Caption = 'Vlo'#382'it jako text'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rdbKomplexReaIm: TRadioButton
        Left = 8
        Top = 47
        Width = 169
        Height = 17
        Caption = 'Re'#225'ln'#225' a imagin'#225'rn'#237' '#269#225'st zvl'#225#353#357
        TabOrder = 1
      end
    end
  end
  object btnOK: TButton
    Left = 104
    Top = 255
    Width = 97
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnStorno: TButton
    Left = 256
    Top = 256
    Width = 97
    Height = 25
    Cancel = True
    Caption = 'Storno'
    TabOrder = 3
    OnClick = btnStornoClick
  end
  object dlgExport: TSaveDialog
    DefaultExt = 'mt2'
    Filter = 'Excel se'#353'it (*.xls)|*.xls'
    FilterIndex = 0
    Title = 'Ulo'#382'it matici'
    Left = 384
    Top = 256
  end
end
