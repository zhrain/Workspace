unit U_public;

interface

uses
  Windows,SysUtils;

var
  puv_exepath,puv_usercode,puv_username,puv_windows:string;
  puv_windowsnum,puv_ifcall,puv_NumberofCalls:Integer;

  function puf_serverdatetime:string;  //取服务器日期时间

  const con_datetimeformat:string='yyyy-mm-dd hh:mm:ss';

implementation

uses
  u_p_dm;

function puf_serverdatetime:string;  //取服务器日期时间
begin
try
  if p_dm.ADO.Connected then
    begin
      p_dm.SP_serverdate.ExecProc;
      Result:= formatdatetime(con_datetimeformat,p_dm.sp_serverdate.Parameters[1].value);
    end;
except
end;
//  result:='2005-03-09 16:01';
end;


end.
