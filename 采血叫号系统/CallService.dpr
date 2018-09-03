program CallService;

uses
  Forms,
  Windows,
  IniFiles,
  SysUtils,
  U_Callinfo in 'U_Callinfo.pas' {F_Callinfo},
  U_p_dm in 'U_p_dm.pas' {p_dm: TDataModule},
  U_public in 'U_public.pas',
  U_speaker in 'U_speaker.pas';

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
               MessageBox(0, '【叫号服务系统】已被您或别人打开，正在运行!'+#13#13+'打开多份很消耗资源的！','注意：', mb_IconHand);
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
  Application.Title := '叫号服务系统';
  puv_exepath:=ExtractFileDir(Application.ExeName);    
  Application.CreateForm(Tp_dm, p_dm);
  Application.CreateForm(TF_Callinfo, F_Callinfo);
  Application.Run;
end.
