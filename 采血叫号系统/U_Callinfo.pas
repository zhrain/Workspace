unit U_Callinfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CoolTrayIcon, ImgList,IniFiles, ExtCtrls, DB, ADODB, Grids,
  DBGridEh, Menus, StdCtrls, RzLabel;

type
  TF_Callinfo = class(TForm)
    il1: TImageList;
    il2: TImageList;
    cltrycn1: TCoolTrayIcon;
    Timer: TTimer;
    AQ_Call: TADOQuery;
    AQ_List: TADOQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    l_showinfo: TRzLabel;
    CB: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure cltrycn1DblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    prv_WaitCalls:Integer;
    { Public declarations }
  end;

var
  F_Callinfo: TF_Callinfo;

implementation
uses
  U_public,U_p_dm,U_speaker;

{$R *.dfm}

function NewThread(P:Pointer):DWORD;
 var
   playstr:string;
begin
  playstr:=PChar(p);
  PlayText(playstr);
end;


procedure TF_Callinfo.FormCreate(Sender: TObject);
begin
  //cltrycn1.IconList:=il1;
  //cltrycn1.IconList:=il2;
  cltrycn1.CycleIcons:=True;

  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    Timer.Interval:=ReadInteger('call','CallTime',500);
    puv_NumberofCalls:=ReadInteger('call','NumberofCalls',1);
    prv_WaitCalls:=ReadInteger('Callscreen','WaitCalls',5);
    F_Callinfo.Left:=ReadInteger('Callscreen','left',0);
    F_Callinfo.top:=ReadInteger('Callscreen','top',0);
    F_Callinfo.width:=ReadInteger('Callscreen','width',300);
    F_Callinfo.height:=ReadInteger('Callscreen','height',300);
  end;

  F_Callinfo.Show;

  Timer.Enabled:=True;
end;

procedure TF_Callinfo.cltrycn1DblClick(Sender: TObject);
begin
  F_Callinfo.Show;
end;

procedure TF_Callinfo.TimerTimer(Sender: TObject);
var
  calltext:string;
  param:PChar;
  CThread:Thandle;//声明了一个句柄
  Tid:DWord;
  n:Integer;
begin
  Timer.Enabled:=False;

  with AQ_Call do
  begin
    close;
    sql.Clear;
    sql.Add('select * from BloodCallLIST where callflag=0 ORDER BY Num');
    Open;
    First;
    if Eof then
    begin
      l_showinfo.Caption:='当前无等待患者...';
      
      
    end;
    while not Eof do
    begin
      l_showinfo.caption:='';
      application.ProcessMessages;
      with AQ_List do
      begin
        close;
        sql.Clear;
        sql.Add('select * from BloodCallLIST where callflag=0 ORDER BY Num');
        Open;
        First;
        if AQ_List.RecordCount>prv_WaitCalls then
        begin
          for n:=1 to prv_WaitCalls do
          begin    
            l_showinfo.Caption:=l_showinfo.Caption+fieldbyname('PatientName').AsString+'  →'+fieldbyname('WindowName').AsString+'等待采血'+#13#10;
            Next;
          end;
        end
        else
        begin
          for n:=1 to AQ_List.RecordCount do
          begin
            l_showinfo.Caption:=l_showinfo.Caption+fieldbyname('PatientName').AsString+'  →'+fieldbyname('WindowName').AsString+'等待采血'+#13#10;
            Next;
          end;
        end;
      end;
      application.ProcessMessages;


      cltrycn1.IconList:=il2;

      calltext:=fieldbyname('CallText').Value;
      //param:=PChar(calltext);
      //Cthread:=BeginThread(nil,0,@NewThread,param,0,Tid); //创建一个线程，同时调用线程函数
      application.ProcessMessages;
      for n:=1 to puv_NumberofCalls do
      begin
        PlayText(calltext);
        //Sleep(500);
      end;
      application.ProcessMessages;
      with p_dm.AQ_temp do
      begin
        close;
        sql.Clear;
        sql.Add('update BloodCallLIST set callflag=1 where num=:num');
        Parameters.ParamByName('num').Value :=AQ_Call.fieldbyname('num').Value;
        ExecSQL;
      end;

      cltrycn1.IconList:=il1;
      Next;
    end;
  end;


  Timer.Enabled:=True;
end;


procedure TF_Callinfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    writeInteger('Callscreen','left',F_Callinfo.Left);
    writeInteger('Callscreen','top',F_Callinfo.top);
    writeInteger('Callscreen','width',F_Callinfo.width);
    writeInteger('Callscreen','height',F_Callinfo.height);
  end;

end;

procedure TF_Callinfo.N3Click(Sender: TObject);
begin
close;
end;

procedure TF_Callinfo.N1Click(Sender: TObject);
begin
  F_Callinfo.Show;
end;

procedure TF_Callinfo.FormShow(Sender: TObject);
var
  callcolor,callfontcolor,n:Integer;
begin
  //l_showinfo.Caption:='当前无等待患者...';
  l_showinfo.Caption:='';
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    callcolor:=ReadInteger('Callscreen','callcolor',0);
    callfontcolor:=ReadInteger('Callscreen','callfontcolor',0);
  end;

  F_Callinfo.Brush.Color:=CB.Colors[callcolor];
  l_showinfo.Color:=CB.Colors[callcolor];
  l_showinfo.Font.Color:=CB.Colors[callfontcolor];

  l_showinfo.Top:=trunc(F_Callinfo.Height/10);
  l_showinfo.Left:=trunc(F_Callinfo.Width/20);
  l_showinfo.Width:=trunc(F_Callinfo.Width/20*18);
  l_showinfo.Height:=trunc(F_Callinfo.Width/20*18);

  with AQ_List do
  begin
    close;
    sql.Clear;
    sql.Add('select * from BloodCallLIST where callflag=0 ORDER BY Num');
    Open;
    First;
    if AQ_List.RecordCount>prv_WaitCalls then
    begin
      for n:=1 to prv_WaitCalls do
      begin
        l_showinfo.Caption:=l_showinfo.Caption+fieldbyname('PatientName').AsString+'  →'+fieldbyname('WindowName').AsString+'等待采血'+#13#10;
        Next;
      end;
    end
    else
    begin
      for n:=1 to AQ_List.RecordCount do
      begin
        l_showinfo.Caption:=l_showinfo.Caption+fieldbyname('PatientName').AsString+'  →'+fieldbyname('WindowName').AsString+'等待采血'+#13#10;
        Next;
      end;
    end;
  end;

end;

end.
