unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmMain = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Label2: TLabel;
    Button1: TButton;
    Label1: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

function Transliterate(s: string): string;
var
 i: integer;
 t: string;
begin
 for i:=1 to Length(s) do
  begin
   case s[i] of
        'à': t:=t+'a';
        'á': t:=t+'b';
        'â': t:=t+'v';
        'ã': t:=t+'g';
        'ä': t:=t+'d';
        'å': t:=t+'e';
        '¸': t:=t+'ye';
        'æ': t:=t+'zh';
        'ç': t:=t+'z';
        'è': t:=t+'i';
        'é': t:=t+'y';
        'ê': t:=t+'k';
        'ë': t:=t+'l';
        'ì': t:=t+'m';
        'í': t:=t+'n';
        'î': t:=t+'o';
        'ï': t:=t+'p';
        'ð': t:=t+'r';
        'ñ': t:=t+'s';
        'ò': t:=t+'t';
        'ó': t:=t+'u';
        'ô': t:=t+'f';
        'õ': t:=t+'ch';
        'ö': t:=t+'z';
        '÷': t:=t+'ch';
        'ø': t:=t+'sh';
        'ù': t:=t+'ch';
        'ú': t:=t+'''';
        'û': t:=t+'y';
        'ü': t:=t+'''';
        'ý': t:=t+'e';
        'þ': t:=t+'yu';
        'ÿ': t:=t+'ya';
        'À': T:=T+'A';
        'Á': T:=T+'B';
        'Â': T:=T+'V';
        'Ã': T:=T+'G';
        'Ä': T:=T+'D';
        'Å': T:=T+'E';
        '¨': T:=T+'Ye';
        'Æ': T:=T+'Zh';
        'Ç': T:=T+'Z';
        'È': T:=T+'I';
        'É': T:=T+'Y';
        'Ê': T:=T+'K';
        'Ë': T:=T+'L';
        'Ì': T:=T+'M';
        'Í': T:=T+'N';
        'Î': T:=T+'O';
        'Ï': T:=T+'P';
        'Ð': T:=T+'R';
        'Ñ': T:=T+'S';
        'Ò': T:=T+'T';
        'Ó': T:=T+'U';
        'Ô': T:=T+'F';
        'Õ': T:=T+'Ch';
        'Ö': T:=T+'Z';
        '×': T:=T+'Ch';
        'Ø': T:=T+'Sh';
        'Ù': T:=T+'Ch';
        'Ú': T:=T+'''';
        'Û': T:=T+'Y';
        'Ü': T:=T+'''';
        'Ý': T:=T+'E';
        'Þ': T:=T+'Yu';
        'ß': T:=T+'Ya';
      else t:=t+s[i];
   end;
  end;
 Result:=t;
end;

procedure TfmMain.Button1Click(Sender: TObject);
var
 i: integer;
begin
 Memo2.Lines.Clear;
 for i:=0 to Memo1.Lines.Count-1 do
  Memo2.Lines.Add(Transliterate(Memo1.Lines.Strings[i]));
end;

end.
 