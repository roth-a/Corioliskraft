object Form3: TForm3
  Left = 329
  Top = 315
  BorderStyle = bsDialog
  Caption = 'Bildgr'#246#223'e eingeben'
  ClientHeight = 142
  ClientWidth = 302
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
    Top = 16
    Width = 206
    Height = 20
    Caption = 'W'#228'hle hier die Bildgr'#246#223'e aus:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 208
    Top = 80
    Width = 7
    Height = 20
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object RadioButton1: TRadioButton
    Left = 32
    Top = 56
    Width = 217
    Height = 17
    Caption = 'Wie im Hauptfenster dargestellt'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 32
    Top = 80
    Width = 137
    Height = 17
    Caption = 'Benutzerdefiniert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 168
    Top = 80
    Width = 41
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = '1000'
  end
  object Edit4: TEdit
    Left = 216
    Top = 80
    Width = 41
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = '1000'
  end
  object Button1: TButton
    Left = 8
    Top = 112
    Width = 137
    Height = 25
    Caption = 'OK'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 152
    Top = 112
    Width = 145
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 5
  end
end
