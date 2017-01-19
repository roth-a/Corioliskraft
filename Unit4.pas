{-----------------------------------------------------------------------------
 Unit Name: Unit4
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
 Description:    Optionen
-----------------------------------------------------------------------------}
unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math, ComCtrls;

type
  Toptio = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox6: TGroupBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox26: TCheckBox;
    GroupBox1: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox5: TGroupBox;
    CheckBoxLog2: TCheckBox;
    CheckBoxLog1: TCheckBox;
    Button1: TButton;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Edit7: TEdit;
    GroupBox9: TGroupBox;
    CheckBox12: TCheckBox;
    RadioButton6: TRadioButton;
    RadioButton5: TRadioButton;
    GroupBox7: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    zurueckdrehen: TCheckBox;
    Label2: TLabel;
    GroupBox10: TGroupBox;
    Schieberegler: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    Autoaktualisieren_aus: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    GroupBox3: TGroupBox;
    Zoombar: TTrackBar;
    Checkzoom: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Autopos: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox11: TGroupBox;
    Spurfarbe: TColorBox;
    Label7: TLabel;
    Label8: TLabel;
    aussenfarbe: TColorBox;
    Label9: TLabel;
    kreuzfarbe: TColorBox;
    GroupBox12: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    RadioButton7: TRadioButton;
    Pfeilgroesse: TTrackBar;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    CheckBoxLog3: TCheckBox;
    procedure CheckzoomClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure ZoombarChange(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure SpurfarbeChange(Sender: TObject);
    procedure Autoaktualisieren_ausClick(Sender: TObject);
    procedure SchiebereglerChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  optio: Toptio;

implementation

uses Unit1,text,z,berechnung;

{$R *.dfm}




procedure Toptio.CheckzoomClick(Sender: TObject);
begin
  haupt.mrs;
  haupt.aktuali(true,false,true,true,true);
  zeichne.anfangspos;
end;


procedure Toptio.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  haupt.FormKeyDown(sender,key,shift);
end;

procedure Toptio.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  haupt.EReibungKeyPress(sender,key);
end;

procedure Toptio.Button1Click(Sender: TObject);
begin
  txt.schreibeini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
  optio.Close;
end;

procedure Toptio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  txt.schreibeini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
end;

procedure Toptio.Image2Click(Sender: TObject);
begin
  haupt.Image1Click(nil);
end;

procedure Toptio.Image1Click(Sender: TObject);
begin
  haupt.Image1Click(nil);
end;

procedure Toptio.Edit7Change(Sender: TObject);
begin
  if haupt.EingabefeldOK(optio.Edit7) then eingabe.optio.berechnungspausen:=strtofloat(optio.Edit7.text);
end;



{-----------------------------------------------------------------------------
  Description:  Wenn man an der Zoombar schiebt
  Procedure:    ZoombarChange
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Toptio.ZoombarChange(Sender: TObject);
var altradius,altx,alty:real;
begin
  if  optio.Checkzoom.Checked then exit;

  altradius:=darstellungsradius;
  altx:=verschieben.pos.x;
  alty:=verschieben.pos.y;

  zeichne.drm;

  if optio.Autopos.Checked then
    zeichne.anfangspos
  else
    begin
    verschieben.pos.x:=  verschieben.pos.x -   (  mouse.CursorPos.X -haupt.Left -4- verschieben.pos.x) *(darstellungsradius/altradius-1)  ;
    verschieben.pos.y:=  verschieben.pos.y -   (  mouse.CursorPos.y -haupt.Top -42- verschieben.pos.y) *(darstellungsradius/altradius-1)     ;
    end;

  haupt.aktuali(false,false,true,true,true);
end;




procedure Toptio.CheckBox3Click(Sender: TObject);
begin
  haupt.mrs;
end;


{-----------------------------------------------------------------------------
  Description:  Farben werden geändert
  Procedure:    SpurfarbeChange
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Toptio.SpurfarbeChange(Sender: TObject);
begin
  farben.spurfarbe:=optio.Spurfarbe.Selected;
  farben.aussenfarbe:=optio.aussenfarbe.Selected;
  farben.kreuzfarbe:=optio.kreuzfarbe.Selected;
end;



procedure Toptio.Autoaktualisieren_ausClick(Sender: TObject);
begin
  haupt.mrs;
  haupt.aktuali(false,false,true,true,true);
end;

procedure Toptio.SchiebereglerChange(Sender: TObject);
begin
  haupt.mrs;
end;


{-----------------------------------------------------------------------------
  Description:  Anfangsositionierung
  Procedure:    FormShow
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Toptio.FormShow(Sender: TObject);
begin
  //optio.Width:= optio.PageControl1.Width+8;
  optio.Height:=screen.DesktopHeight-28;
  optio.Top:=0;
  optio.Left:=0;
end;

end.                                                                            o
