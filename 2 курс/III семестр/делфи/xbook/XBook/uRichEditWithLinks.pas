{*******************************************************}
{                                                       }
{       Enchanced RichEdit Delphi Component             }
{                                                       }
{  Copyright (c) 2001, Alex Petorv, AuRoom group        }
{   Obninsk, Russia                                     }
{                                                       }
{   mailto: AKPetrov@mailru.com                         }
{   http://auroom.obninsk.ru                            }
{*******************************************************}
unit uRichEditWithLinks;
{
This component is a Rich edit with additional function: hyperlink support.

There are 2 public function for setting and resetting hyperlink attribute
And an event, fires where hyperlink was clicked.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, RichEdit;

type
  TTextRange = TTextRangeA;
  TLinkClicked = procedure (Sender: TObject;
    cpMin, cpMax: LongInt;
    const lpstrText: string
  ) of object;
  TRichEditWithLinks = class(TRichEdit)
  private
    { Private declarations }
    FLinkClicked: TLinkClicked;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure SetHyperlink(Hyperlink: Boolean; wParam: Integer);
  public
    { Public declarations }
    // Make current selection a hyperlink
    procedure SetSelectionHyperlink(Hyperlink: Boolean);
    // Make a word under cursor hyperlink
    procedure SetWordHyperlink(Hyperlink: Boolean);
  published
    { Published declarations }
    property OnHyperlinkClicked: TLinkClicked read FLinkClicked Write FLinkClicked;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Win32', [TRichEditWithLinks]);
end;

{ TRichEditWithLinks }

procedure TRichEditWithLinks.CNNotify(var Message: TWMNotify);
type
  PENLink = ^TENLink;
var
  TR: TextRange;
begin
  if (Message.NMHdr^.code=EN_LINK) then
  begin
    if (PENLink(Message.NMHdr).Msg=WM_LBUTTONDOWN) and Assigned(FLinkClicked) then
    begin
      TR.chrg := PENLink(Message.NMHdr).chrg;
      GetMem(TR.lpstrText, TR.chrg.cpMax - TR.chrg.cpMin + 2);
      try
        SendMessage(Handle, EM_GETTEXTRANGE, 0, Integer(@TR));
        FLinkClicked(Self, TR.chrg.cpMin, TR.chrg.cpMax, TR.lpstrText);
      finally
        FreeMem(TR.lpstrText);
      end;
    end;
    Message.Result := 0;
  end
  else
    inherited;
end;

procedure TRichEditWithLinks.CreateWnd;
begin
  inherited;
  // Updating Richedit EventMask.
  // Adding hyperlinks support
  SendMessage (
    Handle,
    EM_SETEVENTMASK, 0,
    SendMessage(Handle, EM_GETEVENTMASK, 0,0) or ENM_LINK
  );
end;

procedure TRichEditWithLinks.SetHyperlink(Hyperlink: Boolean;
  wParam: Integer);
var
  cf: TCharFormat;
begin
  FillChar(cf, SizeOf(cf), 0);
  cf.cbSize := SizeOf(cf);

  cf.dwMask := CFM_LINK or CFM_COLOR or CFM_UNDERLINE;
  if Hyperlink then
  begin
    cf.dwEffects := CFE_LINK or CFE_UNDERLINE;
    cf.crTextColor := COLORREF(clBlue);
  end
  else
    cf.crTextColor := Font.Color;
  SendMessage(Handle, EM_SETCHARFORMAT, wParam, integer(@cf));
end;

procedure TRichEditWithLinks.SetSelectionHyperlink(Hyperlink: Boolean);
begin
  SetHyperlink(Hyperlink, SCF_SELECTION);
end;

procedure TRichEditWithLinks.SetWordHyperlink(Hyperlink: Boolean);
begin
  SetHyperlink(Hyperlink, SCF_WORD or SCF_SELECTION);
end;

end.
