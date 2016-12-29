unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ComCtrls, AboutUnit2;

type
  TForm1 = class(TForm)
    FirstName: TEdit;
    SecondName: TEdit;
    Famelie: TEdit;
    Psevdo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label5: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FirstNameKeyPress(Sender: TObject; var Key: Char);
    procedure N3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    function CharToNum(ch:char):integer;
    function StringToNum(value:string):integer;
    function toSimple(val:integer):integer;
    function GetHeart(val:string):integer;
    function GetLichnost(val:string):integer;
    Function GetBirthday(date:TDate):integer;
    procedure SaveHtml(name:string);
    procedure Init();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  simvols:array[0..31] of char;
  rasshifr:array[0..8] of string;
  heart:array[0..9] of integer = (0,5,8,9,14,19,27,29,30,31);
  lich:array[0..21] of integer = (1,2,3,4,6,7,10,11,12,13,15,16,17,18,20,21,22,23,24,25,26,28);

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
 count:integer;
begin
 simvols[0]:='а';
 simvols[1]:='б';
 simvols[2]:='в';
 simvols[3]:='г';
 simvols[4]:='д';
 simvols[5]:='е';
 simvols[6]:='ж';
 simvols[7]:='з';
 simvols[8]:='и';
 simvols[9]:='й';
 simvols[10]:='к';
 simvols[11]:='л';
 simvols[12]:='м';
 simvols[13]:='н';
 simvols[14]:='о';
 simvols[15]:='п';
 simvols[16]:='р';
 simvols[17]:='с';
 simvols[18]:='т';
 simvols[19]:='у';
 simvols[20]:='ф';
 simvols[21]:='х';
 simvols[22]:='ц';
 simvols[23]:='ч';
 simvols[24]:='ш';
 simvols[25]:='щ';
 simvols[26]:='ъ';
 simvols[27]:='ы';
 simvols[28]:='ь';
 simvols[29]:='э';
 simvols[30]:='ю';
 simvols[31]:='€';

 for count := 0 to Length(rasshifr)-1 do
   rasshifr[count] := '';
 init;
 DateTimePicker1.date := date;
end;

function TForm1.CharToNum(ch:char):integer;
var
 count:integer;
begin
 count := 0;
 while((ch <> simvols[count])and(count < length(simvols)))do
   inc(count);
 inc(count);
 result := count mod 8;
 if(result = 0)then
   result := 8;
end;

function TForm1.StringToNum(value: string): integer;
var
 count:integer;
 name:integer;
begin
 name := 0;
 for count := 1 to Length(value) do
  if(IsCharAlpha(value[count]))then
    name := name + CharToNum(value[count]);
 result := name;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 name:integer;
 temp:string;
begin
 name := 0;
 temp := '';
 Memo1.Lines.Clear();
 temp := Famelie.Text + FirstName.Text + SecondName.Text + Psevdo.Text;
 if(Famelie.Text <> '')then
   Memo1.Lines.add(Famelie.Text);
 if(FirstName.Text <> '')then
   Memo1.Lines.add(FirstName.Text);
 if(SecondName.Text <> '')then
   Memo1.Lines.add(SecondName.Text);
 if(Psevdo.Text <> '')then
   Memo1.Lines.add(Psevdo.Text);
 if(DateToStr(DateTimePicker1.Date) <> DateToStr(Date))then
  Memo1.Lines.add(FormatDateTime('yyyy-mm-dd',DateTimePicker1.DateTime));

 if(temp <> '')then
  begin
   name := StringToNum(AnsiLowerCase(temp));
   name := toSimple(name);
   Memo1.Lines.Add('„исло вашего имени '+IntToStr(name));
   Memo1.Lines.Add('');
   Memo1.Lines.Add(rasshifr[name-1]);
   Memo1.Lines.Add('');
  end;

 if(DateToStr(DateTimePicker1.Date) <> DateToStr(Date))then
  begin
    name := GetBirthday(DateTimePicker1.date);
    Memo1.Lines.Add('„исло вашего дн€ рождени€ '+IntToStr(name));
    Memo1.Lines.Add('');
    Memo1.Lines.Add(rasshifr[name-1]);
    Memo1.Lines.Add('');
  end;

 if(Length(temp) > 0)then
  begin
    name := GetHeart(temp);
    Memo1.Lines.Add('„исло вашего внутреннего € '+IntToStr(name));
    Memo1.Lines.Add('');
    Memo1.Lines.Add(rasshifr[name-1]);
    Memo1.Lines.Add('');
  end;

 if(Length(temp) > 0)then
  begin
    name := GetLichnost(temp);
    Memo1.Lines.Add('„исло вашей личности '+IntToStr(name));
    Memo1.Lines.Add('');
    Memo1.Lines.Add(rasshifr[name-1]);
    Memo1.Lines.Add('');
  end;
 Memo1.SelStart := 0;
 SendMessage(Memo1.Handle,EM_SCROLLCARET,0,0);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 FirstName.Text := '';
 SecondName.Text := '';
 Famelie.Text := '';
 Psevdo.Text := '';
 DateTimePicker1.DateTime := Now;
 Memo1.Lines.Clear();
end;

function TForm1.toSimple(val: integer): integer;
var
 temp:string;
 count:integer;
 return:integer;
begin
 return := 0;
 temp := IntToStr(val);
 for count := 1 to Length(temp) do
    return := return + StrToInt(temp[count]);
 if(Length(IntToStr(return))>1)then
     return := toSimple(return);
 Result := return;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.FirstNameKeyPress(Sender: TObject; var Key: Char);
begin
if(ischaralpha(key))then
 if not(key in ['ј'..'я'])then
   if not(key in ['а'..'€']) then
      key := #0
end;        

function TForm1.GetBirthday(date: TDate): integer;
var
 temp:string;
 count: integer;
 value: integer;
begin
 value := 0;
 temp := FormatDateTime('ddmmyyyy',date);
 for count := 1 to Length(temp) do
     value := value + StrToInt(temp[count]);
 result := toSimple(value);
end;

function TForm1.GetHeart(val: string): integer;
var
  i,j:integer;
  return:integer;
begin
  return := 0;
  for i := 1 to Length(val) do
    for j := 0 to Length(heart)-1 do
      if(val[i] = simvols[heart[j]])then
        return := return + CharToNum(val[i]);

  Result := toSimple(return);
end;

function TForm1.GetLichnost(val: string): integer;
var
  i,j:integer;
  return:integer;
begin
  return := 0;

  for i := 1 to Length(val) do
    for j := 0 to Length(lich)-1 do
      if(val[i] = simvols[lich[j]])then
        return := return + CharToNum(val[i]);

  Result := toSimple(return);
end;

procedure TForm1.Init;
var
 f:TextFile;
 temp:string;
 count:integer;
begin
  count := 0;
  AssignFile(f,'russhifrovka.txt');
  Reset(f);
  while(not eof(f))do
    begin
      Readln(f,temp);
      if(AnsiPos('@',temp)>0)then
        begin
          inc(count);
        end
         else
           rasshifr[count] := rasshifr[count]+ ' ' +temp ;
    end;
  CloseFile(f);
end;

procedure TForm1.N3Click(Sender: TObject);
var
   s:TSaveDialog;
begin
  if(Memo1.Lines.Count > 0)then
   begin
   s := TSaveDialog.Create(Application);
  try
   s.Filter := 'HTML file *.html|*.html';
   if s.Execute then
     begin
      if ExtractFileExt(s.FileName) = '' then
         s.FileName := s.FileName + '.html';
       SaveHtml(s.FileName);
     end;
  finally
   s.Free();
   s := nil;
  end;
 end; 
end;

procedure TForm1.SaveHtml(name: string);
var
 f:TextFile;
 count:integer;
 temp:string;
begin
  AssignFile(f,name);
  Rewrite(f);
  Writeln(f,'<html> <head> </head><body>');
  Writeln(f,'<p>'+FirstName.Text+'</p>');
  Writeln(f,'<p>'+SecondName.Text+'</p>');
  Writeln(f,'<p>'+Famelie.Text+'</p>');
  Writeln(f,'<p>'+Psevdo.Text+'</p>');
  Writeln(f,'<p>');
  count := 0;
  while(Memo1.Lines.Count > count)do
    begin
     temp := ''+Memo1.Lines.Strings[count]+'';
     if(AnsiPos('„исло ваш',temp) > 0)then
        temp := '<p>'+temp;
     Writeln(f,temp);
     inc(count);
    end;
  Writeln(f,'</p>');
  Writeln(f,'</body></html>');
  CloseFile(f);
end;

procedure TForm1.N6Click(Sender: TObject);
begin
 Form2 := TForm2.Create(Application);
 try
   form2.ShowModal;
 finally
  form2.free();
  form2 := nil; 
 end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 N3.Click;
end;

end.
