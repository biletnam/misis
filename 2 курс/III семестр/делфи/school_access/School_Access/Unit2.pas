unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, ToolWin, ComCtrls;

type
  TUsersForm = class(TForm)
    DBGrid1: TDBGrid;
    ToolBar1: TToolBar;
    Label1: TLabel;
    LoginEdit: TEdit;
    DBNavigator1: TDBNavigator;
    ToolButton1: TToolButton;
    procedure LoginEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UsersForm: TUsersForm;

implementation

uses UserUnit, DataModuleUnit;

{$R *.dfm}

procedure TUsersForm.LoginEditKeyPress(Sender: TObject; var Key: Char);
begin
If Length(LoginEdit.Text)>0 then
   DataModule1.UsersTable.Filtered:=True
else DataModule1.UsersTable.Filtered:=False;
DataModule1.UsersTable.Filter:='Логин>'''+LoginEdit.Text+'''';
end;

end.
