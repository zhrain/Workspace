object F_BloodStationMain: TF_BloodStationMain
  Left = 207
  Top = 131
  Width = 1079
  Height = 533
  Caption = #37319#34880#21483#21495#31995#32479
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 445
    Width = 1063
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 200
      end>
    ParentShowHint = False
    ShowHint = False
    SimplePanel = False
    UseSystemFont = False
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 192
    object N1: TMenuItem
      Caption = #37319#34880#21483#21495
      object N2: TMenuItem
        Caption = #37319#34880#21483#21495
        OnClick = N2Click
      end
      object N4: TMenuItem
        Caption = #20449#24687#35774#32622
        OnClick = N4Click
      end
      object N3: TMenuItem
        Caption = #36864#20986
        OnClick = N3Click
      end
    end
  end
end
