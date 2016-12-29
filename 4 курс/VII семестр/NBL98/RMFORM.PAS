unit rmform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Trenamer = class(TForm)
    Editor: TEdit;
    Button1: TButton;
    Button2: TButton;
    constructor Create(AOwner:TComponent; EditText:string); reintroduce;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  renamer: Trenamer;

implementation

{$R *.DFM}
  constructor Trenamer.Create;
  begin
    inherited Create(AOwner);
    Editor.Text:=EditText;
  end;
end.
