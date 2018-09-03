unit U_ReCollSampTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzButton;

type
  TF_ReCollSampTime = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    RzButton1: TRzButton;
    procedure RzButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_ReCollSampTime: TF_ReCollSampTime;

implementation

uses U_p_dm,U_public;

{$R *.dfm}

procedure TF_ReCollSampTime.RzButton1Click(Sender: TObject);
begin
close;
end;

procedure TF_ReCollSampTime.FormShow(Sender: TObject);
begin
 Edit1.Text:='';
 Edit1.SetFocus;
end;

procedure TF_ReCollSampTime.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then
 begin
   if trim(Edit1.text)<>'' then
   begin
          with p_dm.AQ_temp do
          begin
            Close;
            sql.Clear;
            SQL.add('exec UP_BloodStation_UpdateCollectionInformation :DrawDate,:DrawUserCode,:DrawUserName,:txm');
            Parameters.ParamByName('DrawDate').Value :=puf_serverdatetime;
            Parameters.ParamByName('DrawUserCode').Value :=puv_usercode;
            Parameters.ParamByName('DrawUserName').Value :=puv_username;
            Parameters.ParamByName('txm').Value :=trim(Edit1.text);
            ExecSQL;
          end;
   F_ReCollSampTime.Close;
   end;
end;
end;

end.
