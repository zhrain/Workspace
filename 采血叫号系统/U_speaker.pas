unit U_speaker;

interface
  uses  SysUtils,Dialogs;
  
   var hTTSInstance:Integer;
   const TTS_ADF_DEFAULT= 0;
   const TTS_ADF_PCM8K8B1C = 1;
   const TTS_ADF_PCM16K8B1C = 2;
   const TTS_ADF_PCM8K16B1C = 3;
   const TTS_ADF_PCM16K16B1C = 4;
   const TTS_ADF_PCM11K8B1C = 5;
   const TTS_ADF_PCM11K16B1C = 6;
   const TTS_ADF_ALAW16K1C = 9;
   const TTS_ADF_ULAW16K1C = 10;
   const TTS_ADF_ALAW8K1C = 11;
   const TTS_ADF_ULAW8K1C = 12;
   const TTS_ADF_ALAW11K1C = 13;
   const TTS_ADF_ULAW11K1C = 14;
   const TTS_ADF_ADPCMG7218K4B1C = 17;
   const TTS_ADF_ADPCMG7216K4B1C = 18;
   const TTS_ADF_ADPCMG7233B1C = 19;
   const TTS_ADF_ADPCMG7235B1C = 20;
   const TTS_ADF_VOX6K1C = 21;
   const  TTS_ADF_VOX8K1C= 22;

    //文本内码
   const TTS_CP_GB2312= 1;
   const TTS_CP_GBK = 2;
   const TTS_CP_BIG5 = 3;
   const TTS_CP_UNICODE = 4;

        //参数类型
   const TTS_PARAM_LOCAL_BASE =0;
   const TTS_PARAM_INBUFSIZE =1;
   const TTS_PARAM_OUTBUFSIZE = 2;
   const TTS_PARAM_VID = 3;
   const TTS_PARAM_CODEPAGE = 4;
   const TTS_PARAM_AUDIODATAFMT = 5;
   const TTS_PARAM_SPEED = 6;
   const TTS_PARAM_AUDIOHEADFMT =7;
   const TTS_PARAM_VOLUME = 8;
   const TTS_PARAM_PITCH = 9;
   const TTS_PARAM_STALL_STYLE = 14;


   type
   PlayingFlags=   // hex  //0x
   (
       SND_SYNC      = $0000,
       SND_ASYNC     = $0001,
       SND_NODEFAULT = $0002,
       SND_MEMORY    = $0004,
       SND_LOOP      = $0008,
       SND_NOSTOP    = $0010,
       SND_NOWAIT    = $00002000,
       SND_ALIAS     = $00010000,
       SND_ALIAS_ID  = $00110000,
       SND_FILENAME  = $00020000,
       SND_RESOURCE  = $00040004
    );
   Function STTSInit():Boolean;stdcall; external 'STTSApi.dll';//// 初始化
   Function STTSDeinit():Boolean;stdcall; external 'STTSApi.dll';//// 逆初始化
   Function STTSConnect(sSerialNumber,sServerIp:string):integer;stdcall; external 'STTSApi.dll';//// 建立与TTS服务器的连接
   Function STTSDisconnect(hTTSInstance:Integer):integer; stdcall;external 'STTSApi.dll'; //// 断开与TTS服务器的连接
   Function STTSSetParam(hTTSInstance,lngType,lngParam:Integer):Boolean;stdcall;external 'STTSApi.dll'; ////设置本次连接的合成参数
   Function STTSGetParam(hTTSInstance,lngType,lngParam:Integer):Boolean;stdcall;external 'STTSApi.dll';// 获得本次连接的合成参数
   Function STTSString2AudioFile(hTTSInstance:Integer;sString,sWaveFile:STRING):Boolean;stdcall;external 'STTSApi.dll'; //从字符串合成到音频文件
   Function STTSPlayString(hTTSInstance:integer;sString:string;bAsynch:Boolean):boolean;stdcall;external 'STTSApi.dll'; //播放字符串
   Function STTSPlayStop():boolean;stdcall;external 'STTSApi.dll'; //播放停止
   Function STTSQueryPlayStatus():boolean;stdcall;external 'STTSApi.dll'; //查询播放状态
   Function STTSAbout(nAboutType:Integer;sAboutInfo:string;ninfosize:Integer):integer;stdcall;external 'STTSApi.dll';//TTS版本信息
   Function GetLastError():Integer;stdcall;external 'kernel32.dll';// 用来获取错误代码的Windows API函数
   Function PlaySound(pszSound:string; hmod:PInteger;fdwSound:PlayingFlags):Boolean;stdcall; external 'winmm.dll';
   procedure Open();
   procedure Play(playText:STRING);
   procedure PlayText(playText:string);
   function CreateFileWithText(playText,fileName:string):string;
   procedure Close();

implementation

procedure Open();
var ls_SerialNo,flagStr:string;
    IniFlag:Boolean ;
begin
    ls_SerialNo:='P4X6HA-BT56KW-1RQ14B';
    flagStr:='';
    try
        IniFlag:=STTSInit();
        if IniFlag then
        begin
          hTTSInstance := STTSConnect(ls_SerialNo, flagStr);
          if hTTSInstance=0 then showmessage('连接STTS失败!!!')
          else
          begin
            STTSSetParam(hTTSInstance, TTS_PARAM_AUDIODATAFMT, 4);
            STTSSetParam(hTTSInstance, TTS_PARAM_CODEPAGE,1);
            STTSSetParam(hTTSInstance, TTS_PARAM_VID, 0);
            STTSSetParam(hTTSInstance, TTS_PARAM_VOLUME, 10);
            STTSSetParam(hTTSInstance, TTS_PARAM_SPEED, -300);
            STTSSetParam(hTTSInstance, TTS_PARAM_PITCH, 0);
          end;
        end
        else showmessage('初始化STTS失败!!!');
    except
      on E:Exception do
      begin
         showmessage('错误信息:'+E.Message);
      end;
    end;
end;

procedure Play(playText:STRING);
begin
  //IFLYSAPILib
end;

procedure PlayText(playText:string);
var filePath:string;
begin
   try
     if (hTTSInstance = 0) then
         Open();
         STTSPlayString(hTTSInstance, playText, false);
         STTSDisconnect(hTTSInstance);
         hTTSInstance := 0;
   except
      on E:Exception do
      begin
         showmessage('语音库出错...'+#13#13+'错误信息:'+E.Message);
      end;
       //MessageBox.Show("语音库出错" + err.Message);
   end;
end;


{function CreateFileWithText(playText:string):STRING;
var fileName:string;
begin
 //  fileName := System.Environment.CurrentDirectory + "\\" + playText + ".wav";
 //  CreateFileWithText(playText,fileName);
 //  return fileName;
end; }

/// <summary>
/// 根据字符串生成语音文件
/// </summary>
function CreateFileWithText(playText,fileName:string):string;
begin
  { if (hTTSInstance = 0) then
      Open();
   if (File.Exists(fileName))  then
       File.Delete(fileName);
   STTSString2AudioFile(hTTSInstance, playText, fileName);
   return fileName; }
end;

/// <summary>
/// 关闭连接
/// </summary>
procedure Close();
 VAR
   ls_SerialNo,flagStr:string;
begin
    ls_SerialNo := 'P4X6HA-BT56KW-1RQ14B';
    flagStr:='' ;
    STTSDisconnect(hTTSInstance);
    hTTSInstance:= 0;
end;

end.
