{-----------------------------------------------------------------------------
 Unit Name: Unit2
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
 Description:
      About über das Programm
-----------------------------------------------------------------------------}
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,Shellapi, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,winInet;

type
  Tabout = class(TForm)
    TabSheetControl: TPageControl;
    Information: TTabSheet;
    Memo1: TMemo;
    Links: TTabSheet;
    Label2: TLabel;
    Homepage: TLabel;
    jugendforscht: TLabel;
    jugendforschtrlp: TLabel;
    Label1: TLabel;
    TabLizenz: TTabSheet;
    EmailKontakt: TLabel;
    Label3: TLabel;
    TabUpdate: TTabSheet;
    LInternetState: TLabel;
    LHomepage: TLabel;
    BCheckUpdate: TButton;
    IdHTTP1: TIdHTTP;
    Memo3: TMemo;
    Memo2: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    procedure Memo1DblClick(Sender: TObject);
    procedure HomepageClick(Sender: TObject);
    procedure jugendforschtClick(Sender: TObject);
    procedure jugendforschtrlpClick(Sender: TObject);
    procedure Memo2DblClick(Sender: TObject);
    procedure EmailKontaktClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BCheckUpdateClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  about: Tabout;

implementation

uses Unit1,uanderes;

{$R *.dfm}



procedure Tabout.Memo1DblClick(Sender: TObject);
begin
  close;
end;

procedure Tabout.HomepageClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', ('http://www.roth.22o.de'), nil, nil, SW_ShowNormal);
end;

procedure Tabout.jugendforschtClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', ('http://www.jugend-forscht.de'), nil, nil, SW_ShowNormal);
end;

procedure Tabout.jugendforschtrlpClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', ('http://www.jugend-forscht-rlp.de'), nil, nil, SW_ShowNormal);
end;

procedure Tabout.Memo2DblClick(Sender: TObject);
begin
  haupt.Lizenz1Click(nil);
end;

procedure Tabout.EmailKontaktClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', ('mailto:roth-a@gmx.de'), nil, nil, SW_SHOWNA);
end;

procedure Tabout.Label3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', ('http://jugendforscht.fiz-karlsruhe.de/'), nil, nil, SW_ShowNormal);
end;


procedure Tabout.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  haupt.FormKeyDown(sender,key,shift);
end;

procedure Tabout.BCheckUpdateClick(Sender: TObject);
var s:string;
    i:integer;
begin
  If  InternetGetConnectedState(nil, 0) then
    try
      s:= IdHTTP1.Get('http://www.alexander.byto.de/MeineProgramme/VersionCorioliskraft.txt');
      anderes.korrigiere(s,['.','0'..'9']);
      If s <> version then
        begin
        about.LInternetState.Caption:='Es ist eine neue Version '+s+' verfügbar. Bitte downloade sie doch';
        about.LHomepage.Visible:=true;
        end
      else
        begin
        about.LInternetState.Caption:='Du hast bereits die neuste Version';
        about.LHomepage.Visible:=false;
        end;
    except
      about.LInternetState.Caption:='Ich habe wohl etwas an meiner Homepage geändert. Bitte besuche sie doch und lade das neuste Programm runter';
      about.LHomepage.Visible:=true;
    end
  else
    about.LInternetState.Caption:='Verbinde dich bitte mit dem Internet, damit diese Update Prüfung gemacht werden kann.';
end;

procedure Tabout.FormActivate(Sender: TObject);
begin
  about.TabSheetControl.ActivePage:=Information;
end;

end.
