object Form1: TForm1
  Left = 414
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Simple File Editor'
  ClientHeight = 207
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 240
    Top = 168
    Width = 3
    Height = 13
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Symbol'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 32
    Top = 168
    Width = 65
    Height = 13
    Caption = #22320#22336#20462#27491'   '
  end
  object Button3: TButton
    Left = 368
    Top = 168
    Width = 107
    Height = 25
    Caption = 'Patch!'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Symbol'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button3Click
  end
  object Panel1: TPanel
    Left = 32
    Top = 24
    Width = 441
    Height = 129
    BevelInner = bvLowered
    BevelOuter = bvSpace
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 84
      Height = 13
      Caption = #38656#35201#20462#25913#30340#25991#20214
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Symbol'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 64
      Width = 48
      Height = 13
      Caption = #21015#34920#25991#20214
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Symbol'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 24
      Top = 36
      Width = 289
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'z.dat'
    end
    object Edit2: TEdit
      Left = 24
      Top = 84
      Width = 289
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'list1.txt'
    end
    object Button1: TButton
      Left = 334
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Browse...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 334
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Browse...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object Edit3: TEdit
    Left = 120
    Top = 165
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '-0x400c00'
  end
  object OpenDialog1: TOpenDialog
    InitialDir = '.'
    Left = 328
  end
  object OpenDialog2: TOpenDialog
    InitialDir = '.'
    Left = 384
  end
  object XPManifest1: TXPManifest
    Left = 464
    Top = 16
  end
end
