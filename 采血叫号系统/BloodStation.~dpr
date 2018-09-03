program BloodStation;

uses
  Forms,
  Windows,
  IniFiles,
  SysUtils,
  U_BloodStationMain in 'U_BloodStationMain.pas' {F_BloodStationMain},
  U_login in 'U_login.pas' {F_login},
  U_p_dm in 'U_p_dm.pas' {p_dm: TDataModule},
  U_public in 'U_public.pas',
  U_BloodStation in 'U_BloodStation.pas' {F_BloodStation},
  U_ReCollSampTime in 'U_ReCollSampTime.pas' {F_ReCollSampTime},
  U_FindBloodApplyStr in 'U_FindBloodApplyStr.pas' {F_FindBloodApplyStr},
  U_BigScreen in 'U_BigScreen.pas' {F_BigScreen},
  U_WindowsConfig in 'U_WindowsConfig.pas' {F_WindowsConfig};

{$R *.res}
var
     MutexHandle: THandle;
     hPrevInst: Boolean;

begin
  	MutexHandle := CreateMutex(nil, TRUE, PChar(ExtractFileName(Application.ExeName)));
 	if MutexHandle <> 0 then
	begin
          if GetLastError = ERROR_ALREADY_EXISTS then
    	     // -== set hPrevInst property and close the mutex handle ==-
          begin
               Application.Restore;
               MessageBox(0, '【采血叫号系统】已被您或别人打开，正在运行!'+#13#13+'打开多份很消耗资源的！','注意：', mb_IconHand);
 	       hPrevInst := TRUE;
  	       CloseHandle(MutexHandle);
               Halt; // 'Halt' Is the actual one that prevents a second instance
          end
   	     else
              begin
                 hPrevInst := FALSE;
              end;
   	end
     else
         begin
 	   hPrevInst := FALSE;
         end;

  Application.Initialize;
  Application.Title := '采血叫号系统';
  puv_exepath:=ExtractFileDir(Application.ExeName);
  Application.CreateForm(TF_BloodStationMain, F_BloodStationMain);
  Application.CreateForm(Tp_dm, p_dm);
  Application.CreateForm(TF_login, F_login);
  Application.CreateForm(TF_ReCollSampTime, F_ReCollSampTime);
  Application.CreateForm(TF_FindBloodApplyStr, F_FindBloodApplyStr);
  Application.CreateForm(TF_BigScreen, F_BigScreen);
  F_login.ShowModal;
  Application.Run;
end.
