unit In_Sale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, ExtCtrls, ComCtrls;

type
  TForm_In_Sale = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button_Add: TButton;
    Button_Close: TButton;
    DBLookupComboBox_Warhouse: TDBLookupComboBox;
    Label6: TLabel;
    Table_Warhouse1: TTable;
    DataSource_Warhouse1: TDataSource;
    Table_Warhouse2: TTable;
    DataSource_Warhouse2: TDataSource;
    Label4: TLabel;
    DBLookupComboBox_Book: TDBLookupComboBox;
    Table_Book1: TTable;
    DataSource_Book1: TDataSource;
    Table_Book2: TTable;
    DataSource_Book2: TDataSource;
    Bevel1: TBevel;
    Edit_Cost: TEdit;
    Edit_Amount: TEdit;
    Edit_Date: TEdit;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_In_Sale: TForm_In_Sale;

implementation

uses Sales;

{$R *.DFM}

procedure fill_result_data;
begin
   with Form_In_Sale do begin
        Edit_Date.Text:='01.01.01';
        Edit_Cost.Text:='0';
        Edit_Amount.Text:='0';
   end;
end;

procedure TForm_In_Sale.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_In_Sale.Button_AddClick(Sender: TObject);
begin
    Form_Sales.Table_Sales.Last;

   try
      Form_Sales.Table_Sales.AppendRecord([
      Form_Sales.Table_Sales.FieldByName('id').AsInteger+1,
      StrToDate(Edit_Date.Text),
      StrToInt(Edit_Cost.Text),
      StrToInt(Edit_Amount.Text),
      DBLookUpComboBox_Warhouse.Field.Value,
      DBLookUpComboBox_Book.Field.Value]);
   except
      MessageDlg('В поля формы введены недопустимые данные',
         mtError,[mbOK],0);
      Exit;
   end;

    fill_result_data;
end;

procedure TForm_In_Sale.FormCreate(Sender: TObject);
begin
     fill_result_data;
end;

end.
