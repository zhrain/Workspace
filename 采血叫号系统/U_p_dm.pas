unit U_p_dm;

interface

uses
  SysUtils, Classes, DB, ADODB,Dialogs,Forms;

type
  Tp_dm = class(TDataModule)
    AQ_temp: TADOQuery;
    ADO: TADOConnection;
    SP_serverdate: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  p_dm: Tp_dm;

implementation
uses
  U_public;

{$R *.dfm}

procedure Tp_dm.DataModuleCreate(Sender: TObject);
begin
     ADO.Connected:=false;
     ADO.ConnectionString:='FILE NAME='+puv_exepath+'\'+'LisServer.udl';
     try
      ADO.Connected:=true;
     except
      showmessage('连接数据服务异常,服务器连接失败,请检查数据服务后重试...');
      application.Terminate;
      exit;
     end;
end;

end.
