unit U_BloodStation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzButton, DB, ADODB, Grids, DBGridEh,
  StdCtrls, RzLabel, RzDBLbl;

type
  TF_BloodStation = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RBB_Confirm: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RBB_Call: TRzBitBtn;
    RBB_ReCall: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    L_TakebNum: TLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RL_ddrs: TRzLabel;
    RL_cxrs: TRzLabel;
    RL_cjbb: TRzLabel;
    RzGroupBox3: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    DS_Apply: TDataSource;
    AQ_Apply: TADOQuery;
    AQ_Call: TADOQuery;
    AQ_Blood: TADOQuery;
    RBB_Next: TRzBitBtn;
    RBB_BigScreen: TRzBitBtn;
    AQ_CallWait: TADOQuery;
    Rzlb_bloodflag: TRzDBLabel;
    RBB_Flag: TRzBitBtn;
    RzLabel1: TRzLabel;
    RL_dqckddrs: TRzLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure RBB_CallClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RBB_ConfirmClick(Sender: TObject);
    procedure RBB_ReCallClick(Sender: TObject);
    procedure RBB_NextClick(Sender: TObject);
    procedure RBB_BigScreenClick(Sender: TObject);
    procedure RBB_FlagClick(Sender: TObject);
  private
    { Private declarations }
    prv_ddrs,prv_rc,prv_bb,prv_dqckddrs:Integer;
    procedure FindCall();  //叫号
    procedure CallInit();  //叫号信息初始化
    procedure FindBloodStr(); //获取当前采血基本信息
    procedure TipinfoInit();  //提示信息初始化

  public
    { Public declarations }

    puv_Callnum:string;

    procedure FindBloodApplyStr(Callnum:string); //获取当前采血者申请信息
  end;

var
  F_BloodStation: TF_BloodStation;

implementation

uses
  U_p_dm,U_Public, U_ReCollSampTime,
  U_FindBloodApplyStr, U_BigScreen;

{$R *.dfm}

procedure TF_BloodStation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree ;
 F_BigScreen.Close;
end;

procedure TF_BloodStation.FormDestroy(Sender: TObject);
begin
 F_BloodStation:=nil;
end;

procedure TF_BloodStation.RzBitBtn4Click(Sender: TObject);
begin
 close;
end;

procedure TF_BloodStation.FindCall();
var
  Cardno,Flag,No:string;
begin
   with AQ_Call do
   begin
     close;
     sql.Clear;
     sql.Add('exec UP_BloodStationFindCall :DateStr,:windowNum');
     Parameters.ParamByName('DateStr').Value :=Copy(puf_serverdatetime,1,10);
     Parameters.ParamByName('windowNum').Value :=puv_windowsnum;
     Open;
     Cardno:=fieldbyname('Cardno').AsString;
     Flag:=fieldbyname('Flag').AsString;
     No:=fieldbyname('No').AsString;
   end;

   with AQ_CallWait do
   begin
     close;
     sql.Clear;
     sql.Add('exec UP_BloodStationFindCallWait :DateStr,:windowNum');
     Parameters.ParamByName('DateStr').Value :=Copy(puf_serverdatetime,1,10);
     Parameters.ParamByName('windowNum').Value :=puv_windowsnum;
     try
     Open;
     except
     end;
   end;

   if AQ_Call.RecordCount>0 then
   begin

   with p_dm.AQ_temp do
   begin
     Close;
     SQL.Clear;
     sql.Add('update BloodStationLIST set printflag=1 where num=:num');
     Parameters.ParamByName('num').Value :=AQ_Call.fieldbyname('Num').Value;
     ExecSQL;
   end;

   //p_dm_ysyyjk.prp_ysyyjk_updateAppointNextLISPatient(p_dm_ysyyjk.ysyy_SectionID,Cardno,p_dm_ysyyjk.ysyy_WindowID,p_dm_ysyyjk.ysyy_WindowName,flag,no);
   end;
end;

procedure TF_BloodStation.CallInit();  //叫号信息初始化
begin
  with AQ_Call do
  begin
    L_TakebNum.Caption:=fieldbyname('Cardno').AsString;
    RzLabel2.Caption:='姓名：'+fieldbyname('cPatientName').AsString;
    RzLabel3.Caption:='性别：'+fieldbyname('CSex').AsString;
    RzLabel4.Caption:='年龄：'+fieldbyname('iYearsOld').AsString;

    //大屏
    F_BigScreen.l_Bloodinfo.caption:='采血： '+fieldbyname('cPatientName').AsString;

    if puv_ifcall=1 then
    begin
      with p_dm.AQ_temp do
      begin
        close;
        SQL.Clear;
        SQL.Add('insert into BloodCallLIST(PatientName,WindowName,CallText)');
        SQL.Add('values(:PatientName,:WindowName,:CallText)');
        Parameters.ParamByName('PatientName').Value :=AQ_Call.fieldbyname('cPatientName').AsString;
        Parameters.ParamByName('WindowName').Value :=puv_windows;
        Parameters.ParamByName('CallText').Value :='请患者'+AQ_Call.fieldbyname('cPatientName').AsString+'到'+puv_windows+'采血';
        ExecSQL;
      end;
    end;


  end;

  if AQ_CallWait.Active then
  begin
  with   AQ_CallWait do
  begin
  if RecordCount>0 then
    F_BigScreen.l_Bloodinfo.caption:=F_BigScreen.l_Bloodinfo.caption+#13+#10+#13+#10+
    '等待： '+fieldbyname('cPatientName').AsString;  
  end;
  end;
end;                                                       

procedure TF_BloodStation.RBB_CallClick(Sender: TObject);
begin
 FindCall();
 CallInit();
 if AQ_Call.RecordCount>0 then
 begin
 //RBB_Confirm.Enabled:=True;
 //RBB_ReCall.Enabled:=False;
 RBB_Next.Enabled:=True;
 end
 else
 begin
   L_TakebNum.Caption:='当前无采血队列...';
   F_BigScreen.l_Bloodinfo.Caption:='当前无采血队列...'
 end;

 F_BigScreen.ScreenAutoSize;

 TipinfoInit();
end;

procedure TF_BloodStation.FormShow(Sender: TObject);
var
  flag:Boolean;
begin
 prv_rc:=0;
 prv_bb:=0;
 prv_ddrs:=0;
 prv_dqckddrs:=0;
 TipinfoInit();

 if not assigned(F_BigScreen) then
   begin
     F_BigScreen:=TF_BigScreen.create(application);
   end
   else F_BigScreen.show;
 F_Bigscreen.l_windows.caption:=puv_windows;

 with p_dm.AQ_temp do
 begin
   close;
   sql.Clear;
   SQL.Add('select * from BloodWindowsSet where num=:num');
   Parameters.ParamByName('num').Value :=puv_windowsnum;
   Open;
   flag:=fieldbyname('Ifuse').AsBoolean;
   if flag then
   begin
     Rzlb_bloodflag.Caption:='采血中...';
     Rzlb_bloodflag.Color:=clGreen;
     RBB_Flag.Caption:='暂停采血';
   end
   else
   begin
     Rzlb_bloodflag.Caption:='暂停采血...';
     Rzlb_bloodflag.Color:=clRed;
     RBB_Flag.Caption:='恢复采血';
   end;
 end;
end;

procedure TF_BloodStation.FindBloodStr(); //获取当前采血基本信息
begin
  with AQ_Blood do
  begin
    Close;
    sql.Clear;
    sql.Add('exec UP_BloodStationFindBloodSL :DateStr');
    Parameters.ParamByName('DateStr').Value :=Copy(puf_serverdatetime,1,10);
    Open;
    if not Eof then
    begin
      prv_ddrs:=fieldbyname('sl').AsInteger;
    end;
  end;

  with AQ_Blood do
  begin
    Close;
    sql.Clear;
    sql.Add('exec UP_BloodStationFindBloodSLbyWindow :DateStr,:WindowNum');
    Parameters.ParamByName('DateStr').Value :=Copy(puf_serverdatetime,1,10);
    Parameters.ParamByName('WindowNum').Value :=puv_windowsnum;
    Open;
    if not Eof then
    begin
      prv_dqckddrs:=fieldbyname('sl').AsInteger;
    end;
  end;
end;

procedure TF_BloodStation.TipinfoInit();  //提示信息初始化
begin
  FindBloodStr();
  RL_ddrs.Caption:=IntToStr(prv_ddrs);
  RL_cxrs.Caption:=IntToStr(prv_rc);
  RL_cjbb.Caption:=IntToStr(prv_bb);
  RL_dqckddrs.Caption:=IntToStr(prv_dqckddrs);
end;

procedure TF_BloodStation.FindBloodApplyStr(Callnum:string); //获取当前采血者申请信息
begin
  with AQ_Apply do
  begin
    close;
    sql.Clear;
    sql.Add('exec UP_BloodStationFindApply :Callnum');
    Parameters.ParamByName('Callnum').Value :=Callnum;
    Open;
  end;

  with p_dm.AQ_temp do
  begin
    Close;
    sql.Clear;
    sql.Add('update BloodStationLIST set PrintFlag=2 where num=:num');
    Parameters.ParamByName('num').Value :=Callnum;
    ExecSQL;
  end;
end;

procedure TF_BloodStation.RBB_ConfirmClick(Sender: TObject);
var
  Applyno,flag,no:string;
begin

 AQ_Apply.Close;
 F_FindBloodApplyStr.ShowModal;

 if puv_Callnum='' then Exit;
 FindBloodApplyStr(puv_Callnum);

 with AQ_Apply do
 begin
   First;
   while not Eof do
   begin
     Applyno:=AQ_Apply.fieldbyname('cbarcode').AsString;
     with P_DM.AQ_temp do
     begin
       Close;
       sql.Clear ;
       SQL.add('exec UP_BloodStation_UpdateCollectionInformation :DrawDate,:DrawUserCode,:DrawUserName,:txm');
       Parameters.ParamByName('DrawDate').Value :=puf_serverdatetime;
       Parameters.ParamByName('DrawUserCode').Value :=puv_usercode;
       Parameters.ParamByName('DrawUserName').Value :=puv_username;
       Parameters.ParamByName('txm').Value :=Applyno;
       ExecSQL;
     end;
     Next;
   end;
 end;    

   prv_rc:=prv_rc+1;
   prv_bb:=prv_bb+aq_apply.RecordCount;

   flag:=Copy(AQ_Apply.fieldbyname('Bloodstr').AsString,1,1);
   no:=AQ_Apply.fieldbyname('Bloodstr').AsString;
   delete(no,1,1);




   TipinfoInit();

   AQ_Call.Close;
 //  AQ_Apply.Close;
   AQ_Blood.Close;
 //  RBB_Confirm.Enabled:=False;
 //  RBB_ReCall.Enabled:=True;
   RBB_Next.Enabled:=False;

end;

procedure TF_BloodStation.RBB_ReCallClick(Sender: TObject);
begin
 F_ReCollSampTime.ShowModal;
end;

procedure TF_BloodStation.RBB_NextClick(Sender: TObject);
begin
 with p_dm.AQ_temp do
   begin
     Close;
     SQL.Clear;
     sql.Add('update BloodStationLIST set printflag=3 where num=:num');
     Parameters.ParamByName('num').Value :=AQ_Call.fieldbyname('Num').Value;
     ExecSQL;
   end;
   TipinfoInit();

   AQ_Call.Close;
   AQ_Apply.Close;
   AQ_Blood.Close;
//   RBB_Confirm.Enabled:=False;
//   RBB_ReCall.Enabled:=True;
   RBB_Next.Enabled:=False;

end;

procedure TF_BloodStation.RBB_BigScreenClick(Sender: TObject);
begin
   if not assigned(F_BigScreen) then
   begin
     F_BigScreen:=TF_BigScreen.create(application);
   end
   else F_BigScreen.show;
end;

procedure TF_BloodStation.RBB_FlagClick(Sender: TObject);
begin
  if RBB_Flag.Caption='暂停采血' then
  begin
    with p_dm.AQ_temp do
    begin
      Close;
      sql.Clear;
      sql.Add('update BloodWindowsSet set Ifuse=0 where num=:num');
      Parameters.ParamByName('num').Value :=puv_windowsnum;
      ExecSQL;
    end;
    Rzlb_bloodflag.Caption:='暂停采血...';
    Rzlb_bloodflag.Color:=clRed;
    RBB_Flag.Caption:='恢复采血';
  end
  else if RBB_Flag.Caption='恢复采血' then
  begin
    with p_dm.AQ_temp do
    begin
      Close;
      sql.Clear;
      sql.Add('update BloodWindowsSet set Ifuse=1 where num=:num');
      Parameters.ParamByName('num').Value :=puv_windowsnum;
      ExecSQL;
    end;
    Rzlb_bloodflag.Caption:='采血中...';
    Rzlb_bloodflag.Color:=clGreen;
    RBB_Flag.Caption:='暂停采血';
  end;   
end;

end.
