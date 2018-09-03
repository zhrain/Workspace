unit U_WindowsConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, RzTabs, DBGridEh, Menus,IniFiles,
  StdCtrls, RzCmboBx, RzLabel, ExtCtrls, RzButton, RzPanel, RzRadChk;

type
  TF_WindowsConfig = class(TForm)
    AQ_Windows: TADOQuery;
    DS_Windows: TDataSource;
    PM: TPopupMenu;
    N1: TMenuItem;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    DBGE_Window: TDBGridEh;
    Panel1: TPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    TabSheet2: TRzTabSheet;
    RzButton1: TRzButton;
    RzButton2: TRzButton;
    RzPanel2: TRzPanel;
    RzButton3: TRzButton;
    RzButton4: TRzButton;
    RzPanel1: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzCheckBox1: TRzCheckBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    LabeledEdit3: TLabeledEdit;
    FontDialog1: TFontDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
    procedure RzButton4Click(Sender: TObject);
    procedure RzButton3Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_WindowsConfig: TF_WindowsConfig;

implementation

uses
  U_p_dm,U_Public;

{$R *.dfm}

procedure TF_WindowsConfig.FormShow(Sender: TObject);
begin


  RzPageControl1.ActivePageIndex:=0;
 

end;

procedure TF_WindowsConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin   
  action:=caFree ;
end;

procedure TF_WindowsConfig.FormDestroy(Sender: TObject);
begin
 F_WindowsConfig:=nil;
end;


procedure TF_WindowsConfig.N1Click(Sender: TObject);
var
  windowstr:string;
begin
  windowstr:=DBGE_Window.DataSource.DataSet.fieldbyname('Window').AsString;
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    WriteString('config','window',windowstr);
  end;
end;

procedure TF_WindowsConfig.RzButton1Click(Sender: TObject);
begin
  close;
end;

procedure TF_WindowsConfig.RzButton2Click(Sender: TObject);
begin
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    WriteInteger('config','windowcolor',ColorBox1.itemindex);
    WriteInteger('config','windowfontcolor',ColorBox2.itemindex);
  end;

  AQ_Windows.Edit;
  AQ_Windows.post;
end;

procedure TF_WindowsConfig.RzButton4Click(Sender: TObject);
begin
  close;
end;

procedure TF_WindowsConfig.RzButton3Click(Sender: TObject);
var
  IfCall:Integer;
begin
  if RzCheckBox1.Checked then IfCall:=1
  else ifcall:=0;
  
  with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
  begin
    WriteInteger('Callscreen','callcolor',ColorBox3.itemindex);
    WriteInteger('Callscreen','callfontcolor',ColorBox4.itemindex);
    WriteInteger('call','IfCall',ifcall);
    WriteString('call','CallTime',LabeledEdit1.Text);
    WriteString('call','NumberofCalls',LabeledEdit2.Text);
    WriteString('Callscreen','WaitCalls',LabeledEdit3.Text);
  end;

  
end;

procedure TF_WindowsConfig.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex=0 then
  begin
    with AQ_Windows do
    begin
      close;
      SQL.Clear;
      sql.Add('select * from BloodWindowsSet');
      Open;
    end;

    with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
    begin
      ColorBox1.itemindex:=ReadInteger('config','windowcolor',0);
      ColorBox2.itemindex:=ReadInteger('config','windowfontcolor',0);
    end;
  end
  else  if RzPageControl1.ActivePageIndex=1 then
  begin
    
    with TiniFile.Create(puv_exepath+'\BloodStation.ini') do
    begin
      ColorBox3.itemindex:=ReadInteger('Callscreen','callcolor',0);
      ColorBox4.itemindex:=ReadInteger('Callscreen','callfontcolor',0);
      if ReadInteger('call','IfCall',0)=1 then RzCheckBox1.Checked:=True
      else RzCheckBox1.Checked:=False;
      LabeledEdit1.Text:=ReadString('call','CallTime','500');
      LabeledEdit2.Text:=ReadString('call','NumberofCalls','1');
      LabeledEdit3.Text:=ReadString('Callscreen','WaitCalls','5');
    end;

  end
end;

end.
