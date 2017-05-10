object mainForm: TmainForm
  Left = -8
  Top = -8
  BiDiMode = bdLeftToRight
  BorderStyle = bsSingle
  Caption = 'mainForm'
  ClientHeight = 705
  ClientWidth = 1366
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mainImage: TImage
    Left = 16
    Top = 16
    Width = 1001
    Height = 673
    OnMouseDown = mainImageMouseDown
    OnMouseMove = mainImageMouseMove
    OnMouseUp = mainImageMouseUp
  end
  object nodesSizeLabel: TLabel
    Left = 1040
    Top = 312
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
  object editLabel: TLabel
    Left = 1192
    Top = 312
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
  object colorLabel: TLabel
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
  object graphTypeLabel: TLabel
    Left = 1144
    Top = 192
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
  object namingLabel: TLabel
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
  object buildLabel: TLabel
    Left = 1048
    Top = 512
    Width = 79
    Height = 16
    Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object countLabel: TLabel
    Left = 1208
    Top = 512
    Width = 53
    Height = 16
    Caption = #1056#1072#1089#1089#1095#1077#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object backgroundLabel: TLabel
    Left = 1160
    Top = 128
    Width = 30
    Height = 16
    Caption = #1060#1086#1085
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object clearButton: TButton
    Left = 1048
    Top = 456
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 0
    OnClick = clearButtonClick
  end
  object sizeRadioGroup: TRadioGroup
    Left = 1040
    Top = 336
    Width = 137
    Height = 97
    ItemIndex = 1
    Items.Strings = (
      #1052#1072#1083#1077#1085#1100#1082#1080#1081
      #1057#1088#1077#1076#1085#1080#1081
      #1041#1086#1083#1100#1096#1086#1081)
    TabOrder = 1
  end
  object editRadioGroup: TRadioGroup
    Left = 1192
    Top = 336
    Width = 137
    Height = 97
    ItemIndex = 0
    Items.Strings = (
      #1044#1086#1073#1072#1074#1080#1090#1100
      #1057#1086#1077#1076#1080#1085#1080#1090#1100
      #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100
      #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100
      #1059#1076#1072#1083#1080#1090#1100)
    TabOrder = 2
  end
  object mainColorGrid: TColorGrid
    Left = 1040
    Top = 40
    Width = 136
    Height = 72
    ForegroundIndex = 5
    TabOrder = 3
  end
  object openButton: TButton
    Left = 1264
    Top = 456
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = openButtonClick
  end
  object orientationRadioGroup: TRadioGroup
    Left = 1040
    Top = 216
    Width = 137
    Height = 49
    ItemIndex = 1
    Items.Strings = (
      #1054#1088#1080#1077#1085#1090#1077#1088#1080#1074#1072#1085#1085#1099#1081
      #1053#1077#1086#1088#1080#1077#1085#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081)
    TabOrder = 5
  end
  object weightRadioGroup: TRadioGroup
    Left = 1192
    Top = 216
    Width = 137
    Height = 49
    ItemIndex = 1
    Items.Strings = (
      #1042#1079#1074#1077#1096#1072#1085#1085#1099#1081
      #1053#1077#1074#1079#1074#1077#1096#1072#1085#1085#1099#1081)
    TabOrder = 6
  end
  object namingRadioGroup: TRadioGroup
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
  object saveButton: TButton
    Left = 1152
    Top = 456
    Width = 83
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 8
    OnClick = saveButtonClick
  end
  object buildComboBox: TComboBox
    Left = 1048
    Top = 544
    Width = 145
    Height = 21
    DropDownCount = 5
    ItemHeight = 13
    TabOrder = 9
    Text = #1042#1099#1073#1088#1072#1090#1100
    Items.Strings = (
      #1041#1080#1085#1072#1088#1085#1086#1077' '#1076#1077#1088#1077#1074#1086
      #1050#1091#1095#1072
      #1055#1077#1088#1089#1077#1087#1090#1088#1086#1085
      #1050#1072#1088#1090#1072' '#1084#1077#1090#1088#1086
      #1061#1080#1084#1080#1095#1077#1089#1082#1072#1103' '#1084#1086#1076#1077#1083#1100
      #1057#1086#1094#1080#1086#1075#1088#1072#1084#1084#1072
      #1057#1086#1079#1074#1077#1079#1076#1080#1077)
  end
  object buildButton: TButton
    Left = 1088
    Top = 592
    Width = 75
    Height = 25
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
    TabOrder = 10
    OnClick = buildButtonClick
  end
  object countComboBox: TComboBox
    Left = 1208
    Top = 544
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 11
    Text = #1042#1099#1073#1088#1072#1090#1100
    Items.Strings = (
      #1057#1090#1077#1087#1077#1085#1080' '#1074#1077#1088#1096#1080#1085
      #1055#1086#1088#1103#1076#1086#1082' '#1075#1088#1072#1092#1072
      #1056#1072#1079#1084#1077#1088' '#1075#1088#1072#1092#1072
      #1042#1088#1077#1084#1103' '#1087#1086#1083#1085#1086#1075#1086' '#1086#1073#1093#1086#1076#1072)
  end
  object countButton: TButton
    Left = 1240
    Top = 592
    Width = 75
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    TabOrder = 12
    OnClick = countButtonClick
  end
  object shortestWayButton: TButton
    Left = 1040
    Top = 648
    Width = 145
    Height = 25
    Caption = #1055#1086#1080#1089#1082' '#1082#1088#1072#1090#1095#1072#1081#1096#1077#1075#1086' '#1087#1091#1090#1080
    TabOrder = 13
    OnClick = shortestWayButtonClick
  end
  object nodesSearchButton: TButton
    Left = 1208
    Top = 648
    Width = 145
    Height = 25
    Caption = #1055#1086#1080#1089#1082' '#1074#1077#1088#1096#1080#1085#1099
    TabOrder = 14
    OnClick = nodesSearchButtonClick
  end
  object backgroundColorBox: TColorBox
    Left = 1104
    Top = 152
    Width = 145
    Height = 22
    DefaultColorColor = clCream
    NoneColorColor = clCream
    Selected = clCream
    ItemHeight = 16
    TabOrder = 15
    OnChange = backgroundColorBoxChange
  end
  object openDialog: TOpenDialog
    Filter = 'Graph File|*.gr'
    Left = 1336
    Top = 456
  end
  object saveDialog: TSaveDialog
    Filter = 'Graph File|*.gr'
    Left = 1232
    Top = 456
  end
end
