unit U_BigScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLabel,IniFiles, RzCmboBx, ExtCtrls;

type
  TF_BigScreen = class(TForm)
    l_windows: TRzLabel;
    l_Bloodinfo: TRzLabel;
    l_tips: TRzLabel;
    CB: TColorBox;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ScreenAutoSize();
  end;

var
  F_BigScreen: TF_BigScreen;

implementation
uses
  U_public;

{$R *.dfm}

procedure TF_BigScreen.ScreenAutoSize;
begin
  l_windows.Top:=trunc(F_BigScreen.Height/10);
  l_windows.Left:=trunc((F_BigScreen.Width-l_windows.Width)/2);
  l_Bloodinfo.Top:=trunc(F_BigScreen.Height/10*3);
  if l_Bloodinfo.Width<trunc(F_BigScreen.Width/10*9) then
  begin
    l_Bloodinfo.Left:=trunc(F_BigScreen.Width/20);
    l_Bloodinfo.Width:=trunc(F_BigScreen.Width/10*9);
  end
  else
  begin
    l_Bloodinfo.Left:=trunc(F_BigScreen.Width/20);
    l_Bloodinfo.Width:=trunc(F_BigScreen.Width/10*9);
    l_Bloodinfo.Height:=F_BigScreen.Height-l_Bloodinfo.Top*2;
  end;
  l_tips.Top:=trunc(F_BigScreen.Height/10*7);
  l_tips.Left:=trunc(F_BigScreen.Width/20);
  l_tips.Width:=trunc(F_BigScreen.Width/10*9)
end;

procedure TF_BigScreen.FormShow(Sender: TObject);
var
  windowcolor,windowfontcolor:Integer;
begin
  ScreenAutoSize;
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    windowcolor:=ReadInteger('config','windowcolor',0);
    windowfontcolor:=ReadInteger('config','windowfontcolor',0);
  end;

  F_BigScreen.Brush.Color:=CB.Colors[windowcolor];
  l_windows.Color:=CB.Colors[windowcolor];
  l_windows.Font.Color:=CB.Colors[windowfontcolor];
  l_Bloodinfo.Color:=CB.Colors[windowcolor];
  l_Bloodinfo.Font.Color:=CB.Colors[windowfontcolor];
  l_tips.Color:=CB.Colors[windowcolor];
  l_tips.Font.Color:=CB.Colors[windowfontcolor];

end;

procedure TF_BigScreen.FormResize(Sender: TObject);
begin
  ScreenAutoSize;
end;

procedure TF_BigScreen.FormCreate(Sender: TObject);
begin
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    F_BigScreen.Left:=ReadInteger('Bigscreen','left',0);
    F_BigScreen.top:=ReadInteger('Bigscreen','top',0);
    F_BigScreen.width:=ReadInteger('Bigscreen','width',300);
    F_BigScreen.height:=ReadInteger('Bigscreen','height',300);
    l_tips.Caption:=ReadString('Bigscreen','tips','ÎÂÜ°ÌáÊ¾')
  end;
end;

procedure TF_BigScreen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
//  begin
//    writeInteger('Bigscreen','left',F_BigScreen.Left);
//    writeInteger('Bigscreen','top',F_BigScreen.top);
//    writeInteger('Bigscreen','width',F_BigScreen.width);
//    writeInteger('Bigscreen','height',F_BigScreen.height);
//  end;
end;

end.
