unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SQLite3, SQLiteTable3, StdCtrls, Grids, DBGrids, Unit1, Unit3, unit4, Globals,
  ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    Timer1: TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    StringGrid1: TStringGrid;
    Button5: TButton;
    Button6: TButton;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure Button5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  DB : TSQLiteDatabase;

implementation

{$R *.dfm}

function CalculateComplect(product_id: string): double;
var
  Table: TSQLiteTable;
  summ, product_count, current_count, current_price: double;
  i: integer;
begin
  summ := 0;
  Table := DB.GetTable('SELECT count FROM products WHERE id='+product_id);
  product_count := Table.FieldAsDouble(0);

  Table := DB.GetTable('SELECT count,price FROM complect WHERE product_id='+product_id);
  for i := 0 to Table.Count - 1 do
  begin
    current_count := Table.FieldAsDouble(0);
    current_price := Table.FieldAsDouble(1);

    summ := summ + current_count*current_price;
    Table.Next;
  end;

  summ := summ*product_count;

  result:=summ;
end;

function CalculateWorks(product_id: string): double;
var
  Table: TSQLiteTable;
  summ, product_count, current_norm, current_price: double;
  i: integer;
begin
  summ := 0;
  Table := DB.GetTable('SELECT count FROM products WHERE id='+product_id);
  product_count := Table.FieldAsDouble(0);

  Table := DB.GetTable('SELECT norm,price FROM works WHERE product_id='+product_id);
  for i := 0 to Table.Count - 1 do
  begin
    current_norm := Table.FieldAsDouble(0);
    current_price := Table.FieldAsDouble(1);

    summ := summ + current_norm*current_price;
    Table.Next;
  end;

  summ := summ*product_count;
  result:=summ;
end;

procedure LoadComplect(product_id: string);
var Table: TSQLiteTable;
i: integer;
id,name,prepack,price,count: string;
norm: double;
begin
   Table := DB.GetTable('SELECT * FROM complect WHERE product_id='+product_id);
   with Form2 do
   begin
    StringGrid3.ColCount := 5;
    StringGrid3.RowCount := Table.Count+1;

    StringGrid3.Cells[0,0] := 'id';
    StringGrid3.Cells[1,0] := 'Наименование';
    StringGrid3.Cells[2,0] := 'Полуфабрикат';
    StringGrid3.Cells[3,0] := 'Норма на единицу';
    StringGrid3.Cells[4,0] := 'Стоимость';
    for i := 0 to Table.Count - 1 do
    begin
      id := Utf8ToAnsi(Table.FieldAsString(0)); StringGrid3.Cells[0,i+1] := id;
      name := Utf8ToAnsi(Table.FieldAsString(2)); StringGrid3.Cells[1,i+1] := name;
      prepack := Table.FieldAsString(3); StringGrid3.Cells[2,i+1] := prepack;
      count := Utf8ToAnsi(Table.FieldAsString(4)); StringGrid3.Cells[3,i+1] := count;
      price := Utf8ToAnsi(Table.FieldAsString(5)); StringGrid3.Cells[4,i+1] := price;

      //norm := Table.FieldAsDouble(3);; StringGrid1.Cells[3,i+1] := FloatToStr(norm);
      Table.Next;
    end;
   end;
end;

procedure LoadWorks(product_id: string);
var Table: TSQLiteTable;
i: integer;
id,w_name,price: string;
norm: double;
begin
   Table := DB.GetTable('SELECT * FROM works WHERE product_id='+product_id);
   with Form2 do
   begin
    StringGrid2.ColCount := 4;
    StringGrid2.RowCount := Table.Count+1;

    StringGrid2.Cells[0,0] := 'id';
    StringGrid2.Cells[1,0] := 'Наименование';
    StringGrid2.Cells[2,0] := 'Стоимость(час)';
    StringGrid2.Cells[3,0] := 'Норма на единицу(час)';
     for i := 0 to Table.Count - 1 do
    begin
      id := Utf8ToAnsi(Table.FieldAsString(0)); StringGrid2.Cells[0,i+1] := id;
      w_name := Utf8ToAnsi(Table.FieldAsString(1)); StringGrid2.Cells[1,i+1] := w_name;
      price := Utf8ToAnsi(Table.FieldAsString(2)); StringGrid2.Cells[2,i+1] := price;
      norm := Table.FieldAsDouble(3); StringGrid2.Cells[3,i+1] := FloatToStr(norm);
      Table.Next;
    end;
   end;
end;

procedure LoadProducts();
var Table: TSQLiteTable;
i,nCol: integer;
id,p_name,podr,count,date: string;
complect_price, works_price: double;
begin
  Table := DB.GetTable('SELECT * FROM products');
  with Form2 do
  begin
for nCol := 0 to StringGrid1.ColCount - 1 do
    StringGrid1.Cols[nCol].Clear;

    StringGrid1.ColCount := 7;
    StringGrid1.RowCount := Table.Count+1;

    StringGrid1.Cells[0,0] := 'id';
    StringGrid1.Cells[1,0] := 'Наименование';
    StringGrid1.Cells[2,0] := 'Подразделение';
    StringGrid1.Cells[3,0] := 'Дата';
    StringGrid1.Cells[4,0] := 'Выпущено';
    StringGrid1.Cells[5,0] := 'Комплектующие(стоимость)';
    StringGrid1.Cells[6,0] := 'Работы(стоимость)';

    StringGrid1.ColWidths[0] := 30;
    StringGrid1.ColWidths[1] := 140;
    StringGrid1.ColWidths[2] := 120;
    StringGrid1.ColWidths[3] := 80;

    for i := 0 to Table.Count - 1 do
    begin
      id := Utf8ToAnsi(Table.FieldAsString(0)); StringGrid1.Cells[0,i+1] := id;

      p_name := Utf8ToAnsi(Table.FieldAsString(1)); StringGrid1.Cells[1,i+1] := p_name;
      podr := Utf8ToAnsi(Table.FieldAsString(2)); StringGrid1.Cells[2,i+1] := podr;
      date := Utf8ToAnsi(Table.FieldAsString(3)); StringGrid1.Cells[3,i+1] := date;
      count := Utf8ToAnsi(Table.FieldAsString(4)); StringGrid1.Cells[4,i+1] := count;

      complect_price := CalculateComplect(id);
      StringGrid1.Cells[5,i+1] := FloatToStr(complect_price);

      works_price := CalculateWorks(id);
      StringGrid1.Cells[6,i+1] := FloatToStr(works_price);

      Table.Next;
    end;

  end;
end;

procedure SaveActiveProductId();
var row,i:integer;
Table: TSQLiteTable;
begin
   row := Form2.StringGrid1.Selection.Top; // номер строки
    Table := DB.GetTable('SELECT * FROM products');
    for i := 0 to row - 2 do
    begin
      Table.Next;
    end;
    CurrentProductId := Table.FieldAsString(0);
    //ShowMessage(CurrentProductId);
end;

procedure SaveActiveWorkId();
var row,i:integer;
Table: TSQLiteTable;
begin
   row := Form2.StringGrid2.Selection.Top; // номер строки
    Table := DB.GetTable('SELECT * FROM works WHERE product_id='+CurrentProductId);
    for i := 0 to row - 2 do
    begin
      Table.Next;
    end;
    CurrentWorkId := Table.FieldAsString(0);

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  form1.Button1.Show;
  Form1.Button2.Hide;
  Form1.Button3.Hide;
  Form1.Show;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  LoadProducts();
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  LoadWorks(CurrentProductId);
end;

procedure TForm2.Button4Click(Sender: TObject);
var Table: TSQLiteTable;
begin
  //редактировать работы
  SaveActiveWorkId();

  // Заполняем поля
  Table := Db.GetTable('SELECT * FROM works WHERE id='+CurrentWorkId);
  Form1.Edit1.Text := Utf8ToAnsi(Table.FieldAsString(1));
  Form1.Edit2.Text := Utf8ToAnsi(Table.FieldAsString(2));
  Form1.Edit3.Text := Utf8ToAnsi(Table.FieldAsString(3));

  form1.Button1.hide;
  Form1.Button2.show;
  Form1.Button3.show;

  Form1.Show;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  // Добавить продукцию
  SaveActiveProductId();
  Form3.Button1.Show;
  Form3.Button2.Hide;
  Form3.Button3.Hide;
  Form3.Show;
end;

procedure TForm2.Button6Click(Sender: TObject);
var Table: TSQLiteTable;
begin
  // Редактировать продукцию
  SaveActiveProductId();
  Form3.Button1.Hide;
  Form3.Button2.Show;
  Form3.Button3.Show;
  // Заполняем поля
  Table := Db.GetTable('SELECT * FROM products WHERE id='+CurrentProductId);
  Form3.Edit1.Text := Utf8ToAnsi(Table.FieldAsString(1));
  Form3.Edit2.Text := Utf8ToAnsi(Table.FieldAsString(2));
  Form3.Edit3.Text := Utf8ToAnsi(Table.FieldAsString(3));
  Form3.Edit4.Text := Utf8ToAnsi(Table.FieldAsString(4));


  Form3.Show;
end;

procedure TForm2.Button7Click(Sender: TObject);
var
  Table: TSQLiteTable;
  summ, product_count, work_current_norm, work_current_price,complect_current_count,complect_current_price: double;
  work_name, complect_name: string;
  i: integer;
begin
  SaveActiveProductId();
  // Диаграмма продукции
  summ := 0;
  Form4.Chart1.Series[0].Clear;
  Table := DB.GetTable('SELECT count FROM products WHERE id='+CurrentProductId);
  product_count := Table.FieldAsDouble(0);

  Table := DB.GetTable('SELECT norm,price, name FROM works WHERE product_id='+CurrentProductId);
  for i := 0 to Table.Count - 1 do
  begin
    work_current_norm := Table.FieldAsDouble(0);
    work_current_price := Table.FieldAsDouble(1);
    work_name := Utf8ToAnsi(Table.FieldAsString(2));
    summ := work_current_norm*work_current_price;
    Form4.Chart1.Series[0].Add(summ, work_name);
    Table.Next;
  end;

  Table := DB.GetTable('SELECT count,price,name FROM complect WHERE product_id='+CurrentProductId);
  for i := 0 to Table.Count - 1 do
  begin
    complect_current_count := Table.FieldAsDouble(0);
    complect_current_price := Table.FieldAsDouble(1);
    complect_name := Utf8ToAnsi(Table.FieldAsString(2));

    summ := complect_current_count*complect_current_price;
    Form4.Chart1.Series[0].Add(summ, complect_name);
    Table.Next;
  end;

  Form4.Show;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  DB := TSQLiteDatabase.Create('base.sqlite');
  PageControl1.ActivePageIndex := 0;
  LoadProducts();
end;





procedure TForm2.PageControl1Change(Sender: TObject);
var active: integer;
begin
  SaveActiveProductId();
  active := PageControl1.ActivePageIndex;
  if (active=0) then LoadProducts();
  if (active=1) then LoadWorks(CurrentProductId);
  if (active=2) then LoadComplect(CurrentProductId);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  if(NeedLoadProducts = true) then
  begin
     LoadProducts();
     NeedLoadProducts := false;
  end;

  if(NeedLoadWorks = true) then
  begin
     LoadWorks(CurrentProductId);
     NeedLoadWorks := false;
  end;
end;

end.
