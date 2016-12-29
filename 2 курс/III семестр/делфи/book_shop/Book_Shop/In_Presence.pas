unit In_Presence;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, ExtCtrls, ComCtrls;

type
  TForm_In_Presence = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button_Add: TButton;
    Button_Close: TButton;
    DBLookupComboBox_Warhouse: TDBLookupComboBox;
    Label6: TLabel;
    Table_Warhouses1: TTable;
    DataSource_Warhouses1: TDataSource;
    Table_Warhouses2: TTable;
    DataSource_Warhouses2: TDataSource;
    Label4: TLabel;
    DBLookupComboBox_Book: TDBLookupComboBox;
    Table_Books1: TTable;
    DataSource_Books1: TDataSource;
    Table_Books2: TTable;
    DataSource_Books2: TDataSource;
    Bevel1: TBevel;
    Edit_Item_Amount: TEdit;
    Edit_Pack_Amount: TEdit;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_In_Presence: TForm_In_Presence;

implementation

uses Presences;

{$R *.DFM}

procedure fill_result_data;
begin
     with Form_In_Presence do begin
        Edit_Pack_Amount.Text:='0';
        Edit_Item_Amount.Text:='0';
     end;
end;

procedure TForm_In_Presence.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_In_Presence.Button_AddClick(Sender: TObject);
begin
    Form_Presences.Table_Presences.Last;

    try
       Form_Presences.Table_Presences.AppendRecord([
       Form_Presences.Table_Presences.FieldByName('id').AsInteger+1,
       Edit_Pack_Amount.Text,
       Edit_Item_Amount.Text,
       DBLookUpComboBox_Warhouse.Field.Value,
       DBLookUpComboBox_Book.Field.Value]);
    except
       MessageDlg('В поля формы введены недопустимые данные',
          mtError,[mbOK],0);
       Exit;
    end;

    fill_result_data;
end;

procedure TForm_In_Presence.FormCreate(Sender: TObject);
begin
     fill_result_data;
end;

end.
