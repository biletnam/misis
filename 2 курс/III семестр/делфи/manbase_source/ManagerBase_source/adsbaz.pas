unit adsbaz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Grids, Printers;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Previous: TButton;
    Next: TButton;
    New: TButton;
    Delete: TButton;
    Save: TButton;
    Button1: TButton;
    Label5: TLabel;
    RichEdit1: TRichEdit;
    Button2: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Button4: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit6: TEdit;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Bevel2: TBevel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit7: TEdit;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel4: TBevel;
    Label6: TLabel;
    Bevel7: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure PreviousClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

uses usprint, paswd;

type
 TNote=record
  org: string[200];
  adr: string[255];
  tel: string[150];
  kontl: string[150];
  email: string[100];
  reg: string[200];
  vidd: string[200];
  osnprod: string[200];
  meneg: string[150];
end;

var
 NoteFile: file of TNote;
 NoteData: TNote;
 _Pos: integer;

procedure ShowRecord;
begin
 Form3.Edit1.Text:=NoteData.org;
 Form3.RichEdit1.Text:=NoteData.adr;
 Form3.Edit2.Text:=NoteData.tel;
 Form3.Edit3.Text:=NoteData.kontl;
 Form3.Edit6.Text:=NoteData.email;
 Form3.ComboBox2.Text:=Notedata.reg;
 Form3.ComboBox3.Text:=Notedata.vidd;
 Form3.ComboBox4.Text:=Notedata.osnprod;
 Form3.ComboBox5.Text:=Notedata.meneg;
end;

procedure ClearData;
begin
 Form3.Edit1.Text:='';
 Form3.RichEdit1.Text:='';
 Form3.Edit2.Text:='';
 Form3.Edit3.Text:='';
 Form3.Edit6.Text:='';
 Form3.ComboBox2.Text:='';
 Form3.ComboBox3.Text:='';
 Form3.ComboBox4.Text:='';
 Form3.ComboBox5.Text:='';
end;

// Pos начинается с нуля - 0,1,2,3,4,5,6,...
// FileSize начинается с единицы - 1,2,3,4,5,6,7,8,...

function GetProgramPath : String;
begin
 GetProgramPath:=ExtractFilePath(ParamStr(0));
end;

procedure TForm3.FormCreate(Sender: TObject);
var
 pPos, cPos, i, j: integer;
 s: string;
begin
 AssignFile(NoteFile,GetProgramPath+'data\'+'adsbaz.dat'); // связываем переменную с файлом
 if not FileExists(GetProgramPath+'data\'+'adsbaz.dat') then // если файл не существует
  begin
   ForceDirectories(GetProgramPath+'\data');
   Rewrite(NoteFile);  // создание файла
   _Pos:=0;
  end
  else
   begin   // если файл существует, то... (CopyFile - резервное копирование)
    CopyFile(pchar(GetProgramPath+'data\'+'adsbaz.dat'),pchar(GetProgramPath+'data\'+'adsbaz_.dat'),false);
    Reset(NoteFile); // открытие файла
    _Pos:=0;
    if not Eof(NoteFile) then // если в файле есть данные
     begin
      Seek(NoteFile,_Pos); // перемещение на Pos
      Read(NoteFile,NoteData); // чтение данных
      ShowRecord; // показать данные
      if _Pos=0 then Previous.Enabled:=false;
      Delete.Enabled:=true;
      if FileSize(NoteFile)>=2
      then Next.Enabled:=true; // если данных больше или равно 2
     end;
   end;
///////////////////// Регион  //////////////////////////////////
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // чтение данных
 s:=NoteData.reg;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox2.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.reg;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.reg;
   if s<>'' then
    begin
     for i:=0 to ComboBox2.Items.Count-1 do
      if pos(s,ComboBox2.Items.Strings[i])=0
      then j:=2
      else
       begin
        j:=1;
        Break;
       end;
    end;
   if j=2 then ComboBox2.Items.Add(s);
   j:=0;
  end;
 ComboBox2.Sorted:=true;
////////////  Вид деят-ти
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // чтение данных
 s:=NoteData.vidd;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox3.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.vidd;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.vidd;
   if s<>'' then
    begin
     for i:=0 to ComboBox3.Items.Count-1 do
     if pos(s,ComboBox3.Items.Strings[i])=0
     then j:=2
     else
      begin
       j:=1;
       Break;
      end;
    end;
   if j=2 then ComboBox3.Items.Add(s);
   j:=0;
  end;
 ComboBox3.Sorted:=true;
////////////  Осн. продукция
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // чтение данных
 s:=NoteData.osnprod;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox4.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.osnprod;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.osnprod;
   if s<>'' then
    begin
     for i:=0 to ComboBox4.Items.Count-1 do
     if pos(s,ComboBox4.Items.Strings[i])=0
     then j:=2
     else
      begin
       j:=1;
       Break;
      end;
    end;
   if j=2 then ComboBox4.Items.Add(s);
   j:=0;
  end;
 ComboBox4.Sorted:=true;
////////////  Менеджер
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // чтение данных
 s:=NoteData.meneg;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox5.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.meneg;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // чтение данных
   s:=NoteData.meneg;
   if s<>'' then
    begin
     for i:=0 to ComboBox5.Items.Count-1 do
     if pos(s,ComboBox5.Items.Strings[i])=0
     then j:=2
     else
      begin
       j:=1;
       Break;
      end;
    end;
   if j=2 then ComboBox5.Items.Add(s);
   j:=0;
  end;
 ComboBox5.Sorted:=true;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // определение кол-ва компонентов файла   end;
 Label4.Caption:='Запись №  '+IntToStr(_pos+1)+' из '+IntToStr(pPos);
end;

procedure TForm3.NewClick(Sender: TObject);
var
 pPos: integer;
begin
 ClearData; //очистка окна
 Edit1.SetFocus;
 _Pos:=FileSize(NoteFile); //определение кол-ва компонентов файла
 Seek(NoteFile,_Pos); //перемещ. указателя на конец файла
 Button2.Enabled:=false;
 Previous.Enabled:=false;
 Next.Enabled:=false;
 Delete.Enabled:=false;
 Save.Enabled:=true;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); //определение кол-ва компонентов файла   end;
 Label4.Caption:='Запись №  '+IntToStr(_pos+1)+' из '+IntToStr(pPos+1);
end;

procedure TForm3.SaveClick(Sender: TObject);
begin
 NoteData.org:=Edit1.Text;
 NoteData.adr:=RichEdit1.Text;
 NoteData.tel:=Edit2.Text;
 NoteData.kontl:=Edit3.Text;
 NoteData.email:=Edit6.Text;
 Notedata.reg:=ComboBox2.Text;
 Notedata.vidd:=ComboBox3.Text;
 Notedata.osnprod:=ComboBox4.Text;
 Notedata.meneg:=ComboBox5.Text;
 Write(NoteFile,NoteData); // запись в файл
 Button2.Enabled:=true;
 Next.Enabled:=false;
 Save.Enabled:=false;
 Delete.Enabled:=true;
 if FileSize(NoteFile)>=2 then
 Previous.Enabled:=true;
end;

procedure TForm3.PreviousClick(Sender: TObject);
var
 pPos: integer;
begin
 Next.Enabled:=true;
 if _Pos<>0 then dec(_Pos); // если указатель не равен 0, то Роs-1
 Seek(NoteFile,_Pos); // перемещение на Pos-1
 Read(NoteFile,NoteData); // чтение Pos-1
 ShowRecord; // показать запись
 if _Pos=0 then Previous.Enabled:=false; //если номер-0, то...
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // определение кол-ва компонентов файла   end;
 Label4.Caption:='Запись №  '+IntToStr(_Pos+1)+' из '+IntToStr(pPos);
end;

procedure TForm3.NextClick(Sender: TObject);
var
  pPos:integer;
begin
 Previous.Enabled:=true;
 if _Pos=FileSize(NoteFile)-2  // если номер позиции=кол-ву
 then Next.Enabled:=false;     // номеров, то...
 inc(_Pos); // Pos+1
 Seek(NoteFile,_Pos); // перемещ указателя на Pos+1
 Read(NoteFile,NoteData); // чтение данных
 ShowRecord; // показать запись
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // определение кол-ва компонентов файла   end;
 Label4.Caption:='Запись №  '+IntToStr(_Pos+1)+' из '+IntToStr(pPos);
end;

procedure TForm3.DeleteClick(Sender: TObject);
var
 i:integer;
 pPos: integer;
begin
 if MessageDlg('Вы действительно хотите удалить запись?', mtWarning,
    [mbYes, mbNo],0)=mrYes
 then
  begin
   if _Pos=FileSize(NoteFile)-1 then // если удаляемый эл-т последний
    begin
     Seek(NoteFile,_Pos);
     Truncate(NoteFile);
     Next.Enabled:=false;
     if _Pos<>0
     then dec(_Pos) // если есть данные, то Pos-1
     else
      begin
       Delete.Enabled:=false;
       ClearData;
       exit;
      end;
    end
   else
    begin
     for i:=_Pos+1 to FileSize(NoteFile)-1 do
      begin
       Seek(NoteFile,i); // переход на Pos+1
       Read(NoteFile,NoteData); // чтение
       Seek(NoteFile,i-1); // переход на Pos
       Write(NoteFile,Notedata); // запись Pos+1 в Pos
      end;
     Seek(NoteFile,FileSize(NoteFile)-1);
     Truncate(NoteFile);
    end;
   Seek(NoteFile,_Pos);
   Read(NoteFile,NoteData);
   ShowRecord;
   if _Pos=0 then Previous.Enabled:=false;
   /////////////////////////////////////////////////////////////
   pPos:=FileSize(NoteFile); // определение кол-ва компонентов файла   end;
   Label4.Caption:='Запись №  '+IntToStr(_Pos+1)+' из '+IntToStr(pPos);
  end
 else
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
 NoteData.org:=Edit1.Text;
 NoteData.adr:=RichEdit1.Text;
 NoteData.tel:=Edit2.Text;
 NoteData.kontl:=Edit3.Text;
 NoteData.email:=Edit6.Text;
 Notedata.reg:=ComboBox2.Text;
 Notedata.vidd:=ComboBox3.Text;
 Notedata.osnprod:=ComboBox4.Text;
 Notedata.meneg:=ComboBox5.Text;
 if _Pos=0
 then _Pos:=0
 else _Pos:=FilePos(NoteFile)-1; // определение располож. указателя
 Seek(NoteFile,_Pos);
 Write(NoteFile,NoteData); // запись в файл
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
  CloseFile(NoteFile);
 except
  MessageDlg('Ошибка закрытия файла!',mtError,[mbOK],0);
 end;
 Form2.Close;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
 Form1.Show;
end;

procedure TForm3.Button7Click(Sender: TObject);
var
 pPos, p: integer;
begin
 ClearData; // очистка окна
 Edit1.SetFocus;
 _Pos:=0; // определение кол-ва компонентов файла
 Seek(NoteFile,_Pos); // перемещ. указателя на конец файла
 Read(NoteFile,NoteData); // чтение Pos-1
 ShowRecord; // показать запись
 Previous.Enabled:=false;
 Next.Enabled:=true;
 Delete.Enabled:=true;
 Save.Enabled:=false;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile)-1; // определение кол-ва компонентов файла
 Label4.Caption:='Запись №  '+IntToStr(_Pos+1)+' из '+IntToStr(pPos+1);
end;

procedure TForm3.Button6Click(Sender: TObject);
var
 pPos: integer;
begin
 ClearData; // очистка окна
 Edit1.SetFocus;
 _Pos:=FileSize(NoteFile)-1;
 Seek(NoteFile,_Pos); // перемещ. указателя на конец файла
 Read(NoteFile,NoteData);
 ShowRecord;
 Previous.Enabled:=true;
 Next.Enabled:=false;
 Delete.Enabled:=true;
 Save.Enabled:=false;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // определение кол-ва компонентов файла
 Label4.Caption:='Запись №  '+IntToStr(_Pos+1)+' из '+IntToStr(pPos);
end;

procedure TForm3.Button8Click(Sender: TObject);
var
 pPos: integer;
begin
 pPos:=FileSize(NoteFile);
 if StrToInt(Edit7.Text)>pPos
 then
  begin
   MessageDlg('Введеное число ('+Edit7.Text+') больше, чем количество записей ('+IntToStr(pPos)+') !',mtError,[mbOK],0);
   Edit7.Text:='1';
   Edit7.SetFocus;
   Edit7.SelStart:=0;
   Edit7.SelLength:=1;
   Exit;
  end;
 if StrToInt(Edit7.Text)=0 then
  begin
   MessageDlg('Введеное число ('+Edit7.Text+') меньше 1!',mtError,[mbOK],0);
   Edit7.Text:='1';
   Edit7.SetFocus;
   Edit7.SelStart:=0;
   Edit7.SelLength:=1;
   Exit;
  end;
 ClearData; // очистка окна
 Edit1.SetFocus;
 _Pos:=StrToInt(Edit7.Text);
 Seek(NoteFile,_Pos-1);
 Read(NoteFile,NoteData);
 ShowRecord; // показать запись
 if _Pos-1=FileSize(NoteFile)-1    // если номер позиции=кол-ву
 then                              // номеров, то...
  begin
   Next.Enabled:=false;
   Previous.Enabled:=true;
  end;
 if _Pos-1=0                   // если номер позиции=кол-ву
 then                          // номеров, то...
  begin
   Next.Enabled:=true;
   Previous.Enabled:=false;
  end;
 if (_Pos-1>0) and (_Pos-1<FileSize(NoteFile)-1)
 then
  begin
   Next.Enabled:=true;
   Previous.Enabled:=true;
  end;
 Delete.Enabled:=true;
 Save.Enabled:=false;
 Button2.Enabled:=true;
 pPos:=FileSize(NoteFile);
 dec(_Pos);
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // определение кол-ва компонентов файла
 Label4.Caption:='Запись №  '+IntToStr(_Pos+1)+' из '+IntToStr(pPos);
end;

procedure TForm3.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then
  begin
   Edit7.Text:='1';
   Edit7.SelStart:=0;
   Edit7.SelLength:=1;
  end;
 if (Key<'0') or (Key>'9') then Key:=#0;
 if Length(Edit7.Text)>=4 then Key:=#0;
end;

end.
