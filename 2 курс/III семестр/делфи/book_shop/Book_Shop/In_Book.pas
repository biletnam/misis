unit In_Book;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, ExtCtrls, ComCtrls;

type
  TForm_In_Book = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button_Add: TButton;
    Button_Close: TButton;
    Label6: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Edit_Author: TEdit;
    Edit_Circuation: TEdit;
    Edit_Year: TEdit;
    Edit_Publisher: TEdit;
    Edit_Name: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    Edit_Knowledge: TEdit;
    Edit_Cost: TEdit;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_In_Book: TForm_In_Book;

implementation

uses Books;

{$R *.DFM}

procedure fill_result_data;
begin
     with Form_In_Book do begin
         Edit_Name.Text:='Name';
         Edit_Author.Text:='Author';
         Edit_Publisher.Text:='Publisher';
         Edit_Year.Text:='1900';
         Edit_Circuation.Text:='0';
         Edit_Knowledge.Text:='Knowledge';
         Edit_Cost.Text:='0';
     end;
end;

procedure TForm_In_Book.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_In_Book.Button_AddClick(Sender: TObject);
begin
    Form_Books.Table_Books.Last;

    try
       Form_Books.Table_Books.AppendRecord([
       Form_Books.Table_Books.FieldByName('id').AsInteger+1,
       Edit_Name.Text,
       Edit_Author.Text,
       Edit_Publisher.Text,
       StrToInt(Edit_Year.Text),
       StrToInt(Edit_Circuation.Text),
       Edit_Knowledge.Text,
       StrToInt(Edit_Cost.Text)]);
    except
       MessageDlg('В поля формы введены недопустимые данные',
          mtError,[mbOK],0);
       Exit;
    end;

    fill_result_data;
end;

procedure TForm_In_Book.FormCreate(Sender: TObject);
begin
     fill_result_data;
end;

end.
