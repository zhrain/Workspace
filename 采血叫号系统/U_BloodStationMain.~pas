unit U_BloodStationMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls,IniFiles;

type
  TF_BloodStationMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    StatusBar1: TStatusBar;
    N4: TMenuItem;
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    
      function GetBuildInfo: string; //获取版本号
  end;

var
  F_BloodStationMain: TF_BloodStationMain;

implementation

uses U_BloodStation,U_public, U_BigScreen, U_WindowsConfig,U_p_dm;

{$R *.dfm}

procedure TF_BloodStationMain.N3Click(Sender: TObject);
begin
close;
end;

procedure TF_BloodStationMain.N2Click(Sender: TObject);
begin
if not assigned(F_BloodStation) then
   begin
     F_BloodStation:=TF_BloodStation.create(application);
   end
   else F_BloodStation.show;
end;

procedure TF_BloodStationMain.FormShow(Sender: TObject);
begin
 F_BloodStationMain.Caption:='采血叫号系统（'+GetBuildInfo+'）';



 StatusBar1.Panels[0].Text:='当前采血窗口为：'+puv_windows;
 StatusBar1.Panels[1].Text:='当前采血人为：'+puv_username;

 with p_dm.AQ_temp do
  begin
    close;
    sql.Clear;
    sql.Add('select top 1 * from BloodWindowsSet where window=:window');
    Parameters.ParamByName('window').Value :=puv_windows;
    Open;
    if not Eof then
    puv_windowsnum:=fieldbyname('Num').Value;
  end;

  with p_dm.AQ_temp do
  begin
    close;
    SQL.Clear;
    sql.Add('update BloodWindowsSet set Ifuse=1 where num=:num');
    Parameters.ParamByName('num').Value :=puv_windowsnum;
    ExecSQL;
  end;

  //ShowMessage(IntToStr(F_BloodStationMain.Left)+';'+inttostr(F_BloodStationMain.top));

end;

procedure TF_BloodStationMain.FormCreate(Sender: TObject);
begin
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    puv_windows:=Readstring('config','window','测试窗口');
    puv_ifcall:=ReadInteger('call','IfCall',0);
  end;   
end;

procedure TF_BloodStationMain.N4Click(Sender: TObject);
begin
   if not assigned(F_WindowsConfig) then
   begin
     F_WindowsConfig:=TF_WindowsConfig.create(application);
   end
   else F_WindowsConfig.show;
end;

procedure TF_BloodStationMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with p_dm.AQ_temp do
  begin
    close;
    SQL.Clear;
    sql.Add('update BloodWindowsSet set Ifuse=0 where num=:num');
    Parameters.ParamByName('num').Value :=puv_windowsnum;
    ExecSQL;
  end;

end;

function TF_BloodStationMain.GetBuildInfo: string; //获取版本号
var
 verinfosize:DWORD;
 verinfo:pointer;
 vervaluesize:dword;
 vervalue:pvsfixedfileinfo;
 dummy:dword;
 v1,v2,v3,v4:word;
begin
  verinfosize := getfileversioninfosize(pchar(paramstr(0)),dummy);
  if verinfosize = 0 then begin
  dummy := getlasterror;
  result := '0.0.0.0';
  end;
  getmem(verinfo,verinfosize);
  getfileversioninfo(pchar(paramstr(0)),0,verinfosize,verinfo);
  verqueryvalue(verinfo,'\',pointer(vervalue),vervaluesize);
  with vervalue^ do begin
  v1 := dwfileversionms shr 16;
  v2 := dwfileversionms and $ffff;
  v3 := dwfileversionls shr 16;
  v4 := dwfileversionls and $ffff;
  end;
  result := inttostr(v1) + '.' + inttostr(v2) + '.' + inttostr(v3) + '.' + inttostr(v4);
  freemem(verinfo,verinfosize);
end;

end.
