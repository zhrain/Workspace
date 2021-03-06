unit U_FindBloodApplyStr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls;

type
  TF_FindBloodApplyStr = class(TForm)
    Edit1: TEdit;
    AQ: TADOQuery;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_FindBloodApplyStr: TF_FindBloodApplyStr;

implementation

uses
  U_Public,U_p_dm, U_BloodStation;

{$R *.dfm}

procedure TF_FindBloodApplyStr.Edit1KeyPress(Sender: TObject; var Key: Char);
begin

  if Key=#13 then
  begin
    if Trim(Edit1.Text)<>'' then
    begin

      with aq do
      begin
        close;
        sql.Clear;
        SQL.Add('SELECT Num FROM BloodStationLIST where date=:date and cardno=:cardno and PrintFlag=1 order by num');
        Parameters.ParamByName('date').Value :=Copy(puf_serverdatetime,1,10);
        Parameters.ParamByName('cardno').Value :=Trim(Edit1.Text);
        Open;
        F_bloodstation.puv_Callnum:='';
        if not Eof then
        begin
          F_bloodstation.puv_Callnum:=fieldbyname('Num').AsString;
        end;

      end;
    end
    else
    begin
      F_bloodstation.puv_Callnum:='';
    end;

    Close;
  end;
end;

procedure TF_FindBloodApplyStr.FormShow(Sender: TObject);
begin
 Edit1.Text:='';
 edit1.SetFocus;
end;

end.
