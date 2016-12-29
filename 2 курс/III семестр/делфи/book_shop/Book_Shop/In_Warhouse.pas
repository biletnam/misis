unit In_Warhouse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, ExtCtrls, ComCtrls;

type
  TForm_In_Warhouse = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button_Add: TButton;
    Button_Close: TButton;
    Label6: TLabel;
    Bevel1: TBevel;
    Edit_Address: TEdit;
    Edit_Name: TEdit;
    Edit_Phone: TEdit;
    Edit_Manager: TEdit;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_In_Warhouse: TForm_In_Warhouse;

implementation

uses Warhouses;

{$R *.DFM}

procedure fill_result_data;
begin
   with Form_In_Warhouse do begin
      Edit_Name.Text:='Name';
      Edit_Address.Text:='Address';
      Edit_Phone.Text:='000-00-00';
      Edit_Manager.Text:='Manager';
   end;
end;

procedure TForm_In_Warhouse.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_In_Warhouse.Button_AddClick(Sender: TObject);
begin
    Form_Warhouses.Table_Warhouses.Last;

    try
       Form_Warhouses.Table_Warhouses.AppendRecord([
       Form_Warhouses.Table_Warhouses.FieldByName('id').AsInteger+1,
       Edit_Name.Text,
       Edit_Address.Text,
       Edit_Phone.Text,
       Edit_Manager.Text]);
    except
       MessageDlg('В поля формы введены недопустимые данные',
          mtError,[mbOK],0);
       Exit;
    end;

    fill_result_data;
end;

procedure TForm_In_Warhouse.FormCreate(Sender: TObject);
begin
     fill_result_data;
end;

end.
