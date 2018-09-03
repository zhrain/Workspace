object F_WindowsConfig: TF_WindowsConfig
  Left = 272
  Top = 189
  Width = 760
  Height = 387
  Caption = #31383#21475#20449#24687#35774#32622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 744
    Height = 348
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    OnChange = RzPageControl1Change
    FixedDimension = 19
    object TabSheet1: TRzTabSheet
      Caption = #37319#34880#31383#21475#20449#24687#35774#32622
      object DBGE_Window: TDBGridEh
        Left = 0
        Top = 0
        Width = 740
        Height = 292
        Align = alClient
        Color = clInfoBk
        DataSource = DS_Windows
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clBlue
        FooterFont.Height = -12
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking]
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PM
        RowHeight = 22
        ShowHint = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clNavy
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Window'
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -14
            Font.Name = #24494#36719#38597#40657
            Font.Style = [fsBold]
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #31383#21475#21517#31216
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -16
            Title.Font.Name = #24494#36719#38597#40657
            Title.Font.Style = [fsBold]
            Width = 300
          end
          item
            EditButtons = <>
            FieldName = 'Ifuse'
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -14
            Font.Name = #24494#36719#38597#40657
            Font.Style = [fsBold]
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #26159#21542#22312#29992
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -16
            Title.Font.Name = #24494#36719#38597#40657
            Title.Font.Style = [fsBold]
            Width = 150
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 292
        Width = 740
        Height = 33
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          740
          33)
        object RzLabel1: TRzLabel
          Left = 18
          Top = 8
          Width = 118
          Height = 16
          AutoSize = False
          Caption = #22823#23631#32972#26223#39068#33394#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RzLabel2: TRzLabel
          Left = 266
          Top = 8
          Width = 111
          Height = 16
          AutoSize = False
          Caption = #22823#23631#23383#20307#39068#33394#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ColorBox1: TColorBox
          Left = 130
          Top = 6
          Width = 81
          Height = 22
          ItemHeight = 16
          TabOrder = 0
        end
        object ColorBox2: TColorBox
          Left = 378
          Top = 6
          Width = 81
          Height = 22
          ItemHeight = 16
          TabOrder = 1
        end
        object RzButton1: TRzButton
          Left = 648
          Top = 4
          Default = True
          Anchors = [akRight, akBottom]
          Caption = #36820#22238
          TabOrder = 2
          OnClick = RzButton1Click
        end
        object RzButton2: TRzButton
          Left = 568
          Top = 4
          Default = True
          Anchors = [akRight, akBottom]
          Caption = #20445#23384
          TabOrder = 3
          OnClick = RzButton2Click
        end
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = #21483#21495#20449#24687#35774#32622
      object RzPanel2: TRzPanel
        Left = 0
        Top = 292
        Width = 740
        Height = 33
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          740
          33)
        object RzButton3: TRzButton
          Left = 568
          Top = 4
          Default = True
          Anchors = [akRight, akBottom]
          Caption = #20445#23384
          TabOrder = 0
          OnClick = RzButton3Click
        end
        object RzButton4: TRzButton
          Left = 648
          Top = 4
          Default = True
          Anchors = [akRight, akBottom]
          Caption = #36820#22238
          TabOrder = 1
          OnClick = RzButton4Click
        end
      end
      object RzPanel1: TRzPanel
        Left = 0
        Top = 0
        Width = 740
        Height = 292
        Align = alClient
        TabOrder = 1
        object RzLabel3: TRzLabel
          Left = 72
          Top = 164
          Width = 118
          Height = 16
          AutoSize = False
          Caption = #22823#23631#32972#26223#39068#33394#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object RzLabel4: TRzLabel
          Left = 72
          Top = 195
          Width = 111
          Height = 16
          AutoSize = False
          Caption = #22823#23631#23383#20307#39068#33394#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object RzCheckBox1: TRzCheckBox
          Left = 54
          Top = 34
          Width = 121
          Height = 25
          Caption = #26412#22320#20449#24687#26159#21542#21483#21495
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          State = cbUnchecked
          TabOrder = 0
        end
        object LabeledEdit1: TLabeledEdit
          Left = 142
          Top = 69
          Width = 121
          Height = 21
          EditLabel.Width = 93
          EditLabel.Height = 13
          EditLabel.Caption = #21483#21495#38388#38548#26102#38388#65306'   '
          LabelPosition = lpLeft
          LabelSpacing = 3
          TabOrder = 1
        end
        object LabeledEdit2: TLabeledEdit
          Left = 142
          Top = 100
          Width = 121
          Height = 21
          EditLabel.Width = 81
          EditLabel.Height = 13
          EditLabel.Caption = #21333#27425#21483#21495#25968#65306'   '
          LabelPosition = lpLeft
          LabelSpacing = 3
          TabOrder = 2
        end
        object ColorBox3: TColorBox
          Left = 184
          Top = 159
          Width = 81
          Height = 22
          ItemHeight = 16
          TabOrder = 3
        end
        object ColorBox4: TColorBox
          Left = 184
          Top = 192
          Width = 81
          Height = 22
          ItemHeight = 16
          TabOrder = 4
        end
        object LabeledEdit3: TLabeledEdit
          Left = 142
          Top = 131
          Width = 121
          Height = 21
          EditLabel.Width = 117
          EditLabel.Height = 13
          EditLabel.Caption = #21483#21495#23631#26174#31034#31561#24453#25968#65306'   '
          LabelPosition = lpLeft
          LabelSpacing = 3
          TabOrder = 5
        end
      end
    end
  end
  object AQ_Windows: TADOQuery
    Connection = p_dm.ADO
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from BloodWindowsSet')
    Left = 680
    Top = 24
  end
  object DS_Windows: TDataSource
    DataSet = AQ_Windows
    Left = 680
    Top = 56
  end
  object PM: TPopupMenu
    Left = 680
    Top = 88
    object N1: TMenuItem
      Caption = #35774#20026#26412#22320#31383#21475
      OnClick = N1Click
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 200
    Top = 256
  end
end
