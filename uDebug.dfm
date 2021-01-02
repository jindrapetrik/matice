object frmDebug: TfrmDebug
  Left = 0
  Top = 0
  Caption = 'Debug'
  ClientHeight = 269
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    406
    269)
  PixelsPerInch = 96
  TextHeight = 13
  object lblClassName: TLabel
    Left = 304
    Top = 40
    Width = 70
    Height = 13
    Caption = '<Class name>'
  end
  object lblOrigType: TLabel
    Left = 304
    Top = 59
    Width = 89
    Height = 13
    Caption = '<OrigType name>'
  end
  object memLog: TMemo
    Left = 8
    Top = 8
    Width = 281
    Height = 254
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
  end
end
