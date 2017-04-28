object Form1: TForm1
  Left = 162
  Top = 89
  Width = 1205
  Height = 696
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 8
    Width = 1001
    Height = 673
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Label2: TLabel
    Left = 1040
    Top = 272
    Width = 116
    Height = 16
    Caption = #1056#1072#1079#1084#1077#1088' '#1074#1077#1088#1096#1080#1085#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 1192
    Top = 272
    Width = 112
    Height = 16
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 1040
    Top = 16
    Width = 32
    Height = 16
    Caption = #1062#1074#1077#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 1144
    Top = 152
    Width = 70
    Height = 16
    Caption = #1058#1080#1087' '#1075#1088#1072#1092#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 1192
    Top = 16
    Width = 83
    Height = 16
    Caption = #1048#1084#1077#1085#1086#1074#1072#1085#1080#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 1072
    Top = 416
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 1040
    Top = 296
    Width = 137
    Height = 81
    ItemIndex = 1
    Items.Strings = (
      #1052#1072#1083#1077#1085#1100#1082#1080#1081
      #1057#1088#1077#1076#1085#1080#1081
      #1041#1086#1083#1100#1096#1086#1081)
    TabOrder = 1
  end
  object RadioGroup2: TRadioGroup
    Left = 1192
    Top = 296
    Width = 137
    Height = 81
    ItemIndex = 0
    Items.Strings = (
      #1044#1086#1073#1072#1074#1080#1090#1100
      #1057#1086#1077#1076#1080#1085#1080#1090#1100
      #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100
      #1059#1076#1072#1083#1080#1090#1100)
    TabOrder = 2
  end
  object ColorGrid1: TColorGrid
    Left = 1040
    Top = 40
    Width = 136
    Height = 72
    ForegroundIndex = 5
    TabOrder = 3
  end
  object Button2: TButton
    Left = 1216
    Top = 416
    Width = 75
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 4
    OnClick = Button2Click
  end
  object RadioGroup3: TRadioGroup
    Left = 1040
    Top = 176
    Width = 137
    Height = 49
    ItemIndex = 1
    Items.Strings = (
      #1054#1088#1080#1077#1085#1090#1077#1088#1080#1074#1072#1085#1085#1099#1081
      #1053#1077#1086#1088#1080#1077#1085#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081)
    TabOrder = 5
  end
  object RadioGroup4: TRadioGroup
    Left = 1192
    Top = 176
    Width = 137
    Height = 49
    ItemIndex = 1
    Items.Strings = (
      #1042#1079#1074#1077#1096#1072#1085#1085#1099#1081
      #1053#1077#1074#1079#1074#1077#1096#1072#1085#1085#1099#1081)
    TabOrder = 6
  end
  object RadioGroup5: TRadioGroup
    Left = 1192
    Top = 40
    Width = 137
    Height = 73
    ItemIndex = 0
    Items.Strings = (
      '0, 1, 2...'
      'A, B, C...'
      #1040', '#1041', '#1042'...')
    TabOrder = 7
  end
  object Button3: TButton
    Left = 1104
    Top = 472
    Width = 161
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1089#1090#1077#1087#1077#1085#1100' '#1074#1077#1088#1096#1080#1085
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 1144
    Top = 520
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 9
    OnClick = Button4Click
  end
end
