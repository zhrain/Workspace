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

    //�ı�����
   const TTS_CP_GB2312= 1;
   const TTS_CP_GBK = 2;
   const TTS_CP_BIG5 = 3;
   const TTS_CP_UNICODE = 4;

        //��������
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
   Function STTSInit():Boolean;stdcall; external 'STTSApi.dll';//// ��ʼ��
   Function STTSDeinit():Boolean;stdcall; external 'STTSApi.dll';//// ���ʼ��
   Function STTSConnect(sSerialNumber,sServerIp:string):integer;stdcall; external 'STTSApi.dll';//// ������TTS������������
   Function STTSDisconnect(hTTSInstance:Integer):integer; stdcall;external 'STTSApi.dll'; //// �Ͽ���TTS������������
   Function STTSSetParam(hTTSInstance,lngType,lngParam:Integer):Boolean;stdcall;external 'STTSApi.dll'; ////���ñ������ӵĺϳɲ���
   Function STTSGetParam(hTTSInstance,lngType,lngParam:Integer):Boolean;stdcall;external 'STTSApi.dll';// ��ñ������ӵĺϳɲ���
   Function STTSString2AudioFile(hTTSInstance:Integer;sString,sWaveFile:STRING):Boolean;stdcall;external 'STTSApi.dll'; //���ַ����ϳɵ���Ƶ�ļ�
   Function STTSPlayString(hTTSInstance:integer;sString:string;bAsynch:Boolean):boolean;stdcall;external 'STTSApi.dll'; //�����ַ���
   Function STTSPlayStop():boolean;stdcall;external 'STTSApi.dll'; //����ֹͣ
   Function STTSQueryPlayStatus():boolean;stdcall;external 'STTSApi.dll'; //��ѯ����״̬
   Function STTSAbout(nAboutType:Integer;sAboutInfo:string;ninfosize:Integer):integer;stdcall;external 'STTSApi.dll';//TTS�汾��Ϣ
   Function GetLastError():Integer;stdcall;external 'kernel32.dll';// ������ȡ��������Windows API����
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
          if hTTSInstance=0 then showmessage('����STTSʧ��!!!')
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
        else showmessage('��ʼ��STTSʧ��!!!');
    except
      on E:Exception do
      begin
         showmessage('������Ϣ:'+E.Message);
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
         showmessage('���������...'+#13#13+'������Ϣ:'+E.Message);
      end;
       //MessageBox.Show("���������" + err.Message);
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
/// �����ַ������������ļ�
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
/// �ر�����
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
