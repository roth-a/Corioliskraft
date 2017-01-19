{-----------------------------------------------------------------------------
 Unit Name: Unit1
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
 Description:
    Hauptform Unit
-----------------------------------------------------------------------------}
unit Unit1;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, Shellapi, Gauges,  math, ExtCtrls, StdCtrls, ComCtrls, Menus,strutils,
  ActnList, StdActns;

type
  Thaupt = class(TForm)
    BBerechnen: TButton;
    EGeschwindigkeit: TEdit;
    EAuftreffenx: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    EAuftreffeny: TEdit;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    EUmlaufdauer: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    EWinkel: TEdit;
    BAbbrechen: TButton;
    Label12: TLabel;
    Label13: TLabel;
    EScheibenradius: TEdit;
    MainMenu1: TMainMenu;
    fh1: TMenuItem;
    Ausfhren1: TMenuItem;
    Stoppen1: TMenuItem;
    Einstellungen1: TMenuItem;
    Speichern1: TMenuItem;
    AusDatei1: TMenuItem;
    Standardwerte1: TMenuItem;
    Alleswiederstellen1: TMenuItem;
    Zufallskurven1: TMenuItem;
    Starten1: TMenuItem;
    berdasProgramm1: TMenuItem;
    Info1: TMenuItem;
    Optionen1: TMenuItem;
    Spurzurckverfolgen1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BAktualisieren: TButton;
    Version1: TMenuItem;
    Aktualisieren1: TMenuItem;
    Infos1: TMenuItem;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    Memo1: TMemo;
    Hilfe1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    Standardkurve: TMenuItem;
    EReibung: TEdit;
    CheckReibungsfaktor: TCheckBox;
    Bildspeichern1: TMenuItem;
    JugendForschtArbeit1: TMenuItem;
    Kurzfassung1: TMenuItem;
    Memo2: TMemo;
    BPause: TButton;
    Zufallswerte1: TMenuItem;
    Informationsfenster1: TMenuItem;
    Lizenz1: TMenuItem;
    BOptionen: TButton;
    BUmlaufdauer: TButton;
    Pause1: TMenuItem;
    SaveDialog2: TSaveDialog;
    Ansicht1: TMenuItem;
    Autozoom1: TMenuItem;
    ReinzoomenMausradrauf1: TMenuItem;
    RauszoomenMausradrunter1: TMenuItem;
    BildverschiebenmitrechteMaustaste1: TMenuItem;
    AutopositionKlickMausrad1: TMenuItem;
    PopupMenu1: TPopupMenu;
    hi1: TMenuItem;
    Abbrechen1: TMenuItem;
    Pause2: TMenuItem;
    Zufallskurven2: TMenuItem;
    Optionen2: TMenuItem;
    Infofenster1: TMenuItem;
    berdasProgramm2: TMenuItem;
    Update1: TMenuItem;
    ActionList1: TActionList;
    AcOpenFile: TAction;
    AcSaveFile: TAction;
    AcUpdate: TAction;
    AcBildSpeichern: TAction;
    AcSpurZurueck: TAction;
    AcRandom: TAction;
    AcStarte: TAction;
    AcBerechnen: TAction;
    AcOptionen: TAction;
    AcLizenz: TAction;
    AcVersion: TAction;
    AcHilfe: TAction;
    AcInfo: TAction;
    AcPause: TAction;
    AcInformationen: TAction;
    AcESC: TAction;
    AcMeineAnsicht: TAction;
    AcStandartansicht: TAction;
    AcReset: TAction;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BBerechnenClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BAbbrechenClick(Sender: TObject);
    procedure EWinkelChange(Sender: TObject);
    procedure EScheibenradiusChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BUmlaufdauerClick(Sender: TObject);
    procedure Ausfhren1Click(Sender: TObject);
    procedure Stoppen1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure Starten1Click(Sender: TObject);
    procedure Alleswiederstellen1Click(Sender: TObject);
    procedure Speichern1Click(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure AusDatei1Click(Sender: TObject);
    procedure OpenDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure BAktualisierenClick(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Version1Click(Sender: TObject);
    procedure Aktualisieren1Click(Sender: TObject);
    procedure Spurzurckverfolgen1Click(Sender: TObject);
    procedure Infos1Click(Sender: TObject);
    procedure Hilfe1Click(Sender: TObject);
    procedure EAuftreffenyChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure CheckReibungsfaktorClick(Sender: TObject);
    procedure Bildspeichern1Click(Sender: TObject);
    procedure SaveDialog2CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Kurzfassung1Click(Sender: TObject);
    procedure BPauseClick(Sender: TObject);
    procedure Zufallswerte1Click(Sender: TObject);
    procedure Informationsfenster1Click(Sender: TObject);
    procedure Lizenz1Click(Sender: TObject);
    procedure BOptionenClick(Sender: TObject);
    procedure EReibungKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure EGeschwindigkeitChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EReibungChange(Sender: TObject);
    procedure EUmlaufdauerChange(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Autozoom1Click(Sender: TObject);
    procedure ReinzoomenMausradrauf1Click(Sender: TObject);
    procedure RauszoomenMausradrunter1Click(Sender: TObject);
    procedure AutopositionKlickMausrad1Click(Sender: TObject);
    procedure StandardkurveClick(Sender: TObject);
    procedure hi1Click(Sender: TObject);
    procedure Abbrechen1Click(Sender: TObject);
    procedure Pause2Click(Sender: TObject);
    procedure Zufallskurven2Click(Sender: TObject);
    procedure Optionen2Click(Sender: TObject);
    procedure Infofenster1Click(Sender: TObject);
    procedure berdasProgramm2Click(Sender: TObject);
    procedure Update1Click(Sender: TObject);
    procedure AcMeineAnsichtExecute(Sender: TObject);
    procedure AcStandartansichtExecute(Sender: TObject);
    procedure AcResetExecute(Sender: TObject);

//    procedure StopFlicker(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;  private

  private
    procedure WMDROPFILES (var Msg: TMessage); message WM_DROPFILES;
    procedure DragAndDrop(Dateiname:string);
    procedure mausmittelklick;
    procedure meineansicht;
    procedure standardansicht;
    function EingabeFelderOK:boolean;
    { Private-Deklarationen }
  public
    procedure Standardwerte;
    procedure aktuali(bdrm,bRefreshKoor,bRefresh,bVorZeichnen,bcanvaszeichnen:boolean);
    procedure wdrss(schreibgeschutzt:boolean);
    procedure mrs ;
    procedure RefreshKoor;

    function bildx(relativx:real):real;
    function bildy(relativy:real):real;
    function pixeltocm(pixelradius:real):real;
    function cmtopixel(cmradius:real):real;
//    function hauptx(relativx:real):real;            //benötige ich eigendlich nicht da ich nie von den relativ koordinaten direkt auf die canbvas ziehcne sondern erst auf das bild
//    function haupty(relativy:real):real;
    function pythagoras(x,y:real):real;
    function relx(hauptx:real):real;
    function rely(haupty:real):real;
    function EingabefeldOK(edit:Tedit):boolean;
    Function CRound (aValue, aGranularity : Extended): Extended;   overload;
    Function CRound (aValue : Extended): integer;overload;
    { Public-Deklarationen }
  end;


var
  haupt: Thaupt;

  version:string ='5.0.6';


  eingabe: record
    haupt:record
      kugelgeschwindigkeit,
      winkel,
      x,
      y,
      reibungsfaktor,
      umlaufdauer,
      scheibenradius:real;
      reibungein:boolean;
      end;
    optio:record
      berechnungspausen:real;
      pfeilgroesse,schieberegler:integer;
      checkbox1,radiobutton7,radiobutton8,radiobutton9,
      Autoaktualisieren_aus:boolean;
      end;
    end;
  schliessen,maushaltend,amstarten:boolean;
implementation

uses Unit2, Unit4, Unit5,z,berechnung,text,Uanderes;
{$R *.dfm}





{
Die Umrechnung lautet so:
Von Absoluten system zu relativem(angepasstem koordinatensysterm): x:=x-mittex
Vom Relativem zum Absolutem: x:=x+mittex
Bei y sind beide Umrwechnungen gleich: y:=-y+mittey}



     //benötige ich eigendlich nicht da ich nie von den relativ koordinaten direkt auf die canbvas ziehcne sondern erst auf das bild
{function Thaupt.hauptx(relativx:real):real;
  begin result:= darstellungsradius+verschieben.pos.x +relativx*zeichne.strecken;      end;

function Thaupt.haupty(relativy:real):real;
  begin result:=  darstellungsradius  +  verschieben.pos.y  -  relativy*zeichne.strecken;     end;

}
{-----------------------------------------------------------------------------
  Description:  Rechnet von der Form Position in die Relativposion auf dem Bild um
  Procedure:    relx
  Detailed description:
-----------------------------------------------------------------------------}
function Thaupt.relx(hauptx:real):real;
  begin result:= (hauptx-verschieben.pos.x-darstellungsradius)/zeichne.strecken;      end;

function Thaupt.rely(haupty:real):real;
  begin result:=(-haupty+verschieben.pos.y+darstellungsradius   )/zeichne.strecken;     end;

{-----------------------------------------------------------------------------
  Description:  Rechnet von der Relativ in die Bildposition um
  Procedure:    bildx
  Detailed description:
      Man kann so wenn man z.B. die Kugelposition kennt dann kann man damit an diese Stelle was aufs Bild malen
-----------------------------------------------------------------------------}
function THaupt.bildx(relativx:real):real;
  begin     result:=relativx*zeichne.strecken+darstellungsradius ;      end;

function THaupt.bildy(relativy:real):real;
  begin        result:=darstellungsradius-relativy*zeichne.strecken;      end;

{-----------------------------------------------------------------------------
  Description:  Rechnet von Pixeln in cm um
  Procedure:    pixeltocm
  Detailed description:
-----------------------------------------------------------------------------}
function THaupt.pixeltocm(pixelradius:real):real;
  begin       result:=pixelradius/200*22.5;      end;
{-----------------------------------------------------------------------------
  Description:  Von cm to Pixel
  Procedure:    cmtopixel
  Detailed description:
-----------------------------------------------------------------------------}
function THaupt.cmtopixel(cmradius:real):real;
  begin       result:=cmradius*200/22.5;       end;

{-----------------------------------------------------------------------------
  Description:  Einfacher Pythagoras
  Procedure:    pythagoras
  Arguments:    x,y:real
  Result:       real
  Detailed description:
-----------------------------------------------------------------------------}
function THaupt.pythagoras(x,y:real):real;
  begin   result:=sqrt(sqr(x)+sqr(y));   end;

{-----------------------------------------------------------------------------
  Description:  Korrektes runden
  Procedure:    CRound
  Arguments:    aValue, aGranularity : Extended
  Result:       Extended
  Detailed description:         Falls ich es mal brauchen sollte
-----------------------------------------------------------------------------}
Function THaupt.CRound (aValue, aGranularity : Extended) : Extended;
Begin
  Result := int (aValue/aGranularity + 0.5)*aGranularity;
End;

Function THaupt.CRound (aValue: Extended) : integer;
Begin
  Result := trunc(aValue + 0.5);
End;


{-----------------------------------------------------------------------------
  Description:
  Procedure:    FormMouseMove
  Arguments:    Sender: TObject; Shift: TShiftState; X, Y: Integer
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  self.StatusBar1.Panels[0].Text:= 'x:= '+floattostr(roundto((   pixeltocm(relx(x))    ),-1));
  self.StatusBar1.Panels[1].Text:= 'y:= '+floattostr(roundto((     pixeltocm(rely(y))        ),-1));
  self.StatusBar1.Panels[2].Text:='A. Entfernung: '+floattostr(roundto(   pythagoras( pixeltocm(relx(x)), pixeltocm(rely(y))   ) ,-1))+' cm';
end;


{-----------------------------------------------------------------------------
  Description:  Dreht die Scheibe auf Ursprungsposition zurück
  Procedure:    RefreshKoor
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.RefreshKoor;
begin
  koor.y:=0;
  koor.x :=-r;
  anderes.arrayloeschen;
end;



{-----------------------------------------------------------------------------
  Procedure:    Standardwerte
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.Standardwerte;
begin
  //variablen
  koor.x:=0 ; koor.y := -r;
  k.auftreffen.x:=-r;
  k.auftreffen.y:=0;
  rrechts:=true;

  //self
  self.WindowState:=wsmaximized;
  //self.Height:=nh;
  //self.Width:=nw;
  optio.zurueckdrehen.Checked:=true;
  self.CheckReibungsfaktor.Checked:=true;
  self.EGeschwindigkeit.Text:='100';
  self.EWinkel.Text:='0';
  self.EAuftreffeny.Text:='0';
  if optio.RadioButton3.Checked then self.EUmlaufdauer.Text:='2' else self.EUmlaufdauer.Text:='3,14';
  self.EScheibenradius.Text:=floattostr(roundto(  pixeltocm(200),-2));
  self.EReibung.Text:='1';
  self.EAuftreffenx.Text:=floattostr(roundto(- pixeltocm(r),-1));
  //about muss nicht gemacht werden da Info feld
  //zufalls optio
  optio.Edit7.Text:='1400';          //bleibt gleich
  optio.RadioButton5.Checked:=true; //auf form3.rb1
  optio.RadioButton6.Checked:=false; //auf form3.rb2
  optio.CheckBox20.Checked:=true;  //1
  optio.CheckBox21.Checked:=true;  //2
  optio.CheckBox22.Checked:=true;   //3
  optio.CheckBox23.Checked:=true;   //4
  optio.CheckBox25.Checked:=true;   //6
  optio.CheckBox26.Checked:=true;   //7
  optio.CheckBox12.Checked:=true;   //9


  //allgemneine optio
  optio.Schieberegler.Position:=4;
  optio.Autoaktualisieren_aus.Checked:=false;
  optio.Autopos.Checked:=true;

  optio.RadioButton3.Checked:=true;
  optio.RadioButton4.Checked:=false;

  optio.CheckBox3.Checked:=true;
  optio.CheckBox2.Checked:=true;
  optio.CheckBox4.Checked:=true;
  optio.CheckBox5.Checked:=true;

  optio.CheckBoxLog3.Checked:=true;
  optio.CheckBoxLog1.Checked:=false;
  optio.CheckBoxLog2.Checked:=false;
  //zoomen
  optio.Checkzoom.Checked:=true;
  optio.Zoombar.Position:= 9;
  //geschwindigkeitspfeile
  optio.CheckBox1.Checked:=false;
  optio.RadioButton7.Checked:=true;
  optio.RadioButton8.Checked:=false;
  optio.RadioButton9.Checked:=false;
  optio.Pfeilgroesse.Position:=10;
  //farben
  optio.Spurfarbe.DefaultColorColor:=clred;
  optio.Spurfarbe.NoneColorColor:=clred;
  optio.Spurfarbe.Selected:=clred;
  farben.spurfarbe:=clred;

  optio.aussenfarbe.DefaultColorColor:=clnavy;
  optio.aussenfarbe.NoneColorColor:=clnavy;
  optio.aussenfarbe.Selected:=clnavy;
  farben.aussenfarbe:=clnavy;

  optio.kreuzfarbe.DefaultColorColor:=clgreen;
  optio.kreuzfarbe.NoneColorColor:=clgreen;
  optio.kreuzfarbe.Selected:=clgreen;
  farben.kreuzfarbe:=  clgreen;

  self.mrs;
  stop:=true; abgebrochen:=true;

  self.aktuali(true,true,true,true,true);

  self.Canvas.TextOut(self.Width div 2-200, self.Height div 2-100, 'Komplette Standartwerte wiederhergestellt');
end;



{-----------------------------------------------------------------------------
  Procedure:    meineansicht
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.meineansicht;
begin
  //self
  self.WindowState:=wsmaximized;
  optio.zurueckdrehen.Checked:=true;
  self.CheckReibungsfaktor.Checked:=true;
  //zufalls optio
  optio.Edit7.Text:='1400';          //bleibt gleich
  optio.RadioButton5.Checked:=true; //auf form3.rb1
  optio.RadioButton6.Checked:=false; //auf form3.rb2
  optio.CheckBox20.Checked:=true;  //1
  optio.CheckBox21.Checked:=true;  //2
  optio.CheckBox22.Checked:=true;   //3
  optio.CheckBox23.Checked:=true;   //4
  optio.CheckBox25.Checked:=true;   //6
  optio.CheckBox26.Checked:=true;   //7
  optio.CheckBox12.Checked:=true;   //9


  //allgemneine optio
  optio.Schieberegler.Position:=3;
  optio.Autoaktualisieren_aus.Checked:=false;
  optio.Autopos.Checked:=false;

  optio.RadioButton3.Checked:=true;
  optio.RadioButton4.Checked:=false;

  optio.CheckBox3.Checked:=false;
  optio.CheckBox2.Checked:=false;
  optio.CheckBox4.Checked:=false;
  optio.CheckBox5.Checked:=false;

  optio.CheckBoxLog3.Checked:=true;
  optio.CheckBoxLog1.Checked:=false;
  optio.CheckBoxLog2.Checked:=false;
  //zoomen
  optio.Checkzoom.Checked:=false;
  self.mausmittelklick;
  //geschwindigkeitspfeile
  optio.CheckBox1.Checked:=true;
  optio.RadioButton7.Checked:=false;
  optio.RadioButton8.Checked:=false;
  optio.RadioButton9.Checked:=true;
  optio.Pfeilgroesse.Position:=5;
  //farben
  optio.Spurfarbe.DefaultColorColor:=clred;
  optio.Spurfarbe.NoneColorColor:=clred;
  optio.Spurfarbe.Selected:=clred;
  farben.spurfarbe:=clred;

  optio.aussenfarbe.DefaultColorColor:=clnavy;
  optio.aussenfarbe.NoneColorColor:=clnavy;
  optio.aussenfarbe.Selected:=clnavy;
  farben.aussenfarbe:=clnavy;

  optio.kreuzfarbe.DefaultColorColor:=clgreen;
  optio.kreuzfarbe.NoneColorColor:=clgreen;
  optio.kreuzfarbe.Selected:=clgreen;
  farben.kreuzfarbe:=  clgreen;

  self.mrs;

  self.Canvas.TextOut(self.Width div 2-100, self.Height div 2-100, 'Expertenansicht');
end;



{-----------------------------------------------------------------------------
  Procedure:    standardansicht
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure THaupt.standardansicht;
begin
  //self
  self.WindowState:=wsmaximized;
  optio.zurueckdrehen.Checked:=true;
  self.CheckReibungsfaktor.Checked:=true;
  //zufalls optio
  optio.Edit7.Text:='1400';          //bleibt gleich
  optio.RadioButton5.Checked:=true; //auf form3.rb1
  optio.RadioButton6.Checked:=false; //auf form3.rb2
  optio.CheckBox20.Checked:=true;  //1
  optio.CheckBox21.Checked:=true;  //2
  optio.CheckBox22.Checked:=true;   //3
  optio.CheckBox23.Checked:=true;   //4
  optio.CheckBox25.Checked:=true;   //6
  optio.CheckBox26.Checked:=true;   //7
  optio.CheckBox12.Checked:=true;   //9


  //allgemneine optio
  optio.Schieberegler.Position:=4;
  optio.Autoaktualisieren_aus.Checked:=false;
  optio.Autopos.Checked:=true;

  optio.RadioButton3.Checked:=true;
  optio.RadioButton4.Checked:=false;

  optio.CheckBox3.Checked:=true;
  optio.CheckBox2.Checked:=true;
  optio.CheckBox4.Checked:=true;
  optio.CheckBox5.Checked:=true;

  optio.CheckBoxLog3.Checked:=true;
  optio.CheckBoxLog1.Checked:=false;
  optio.CheckBoxLog2.Checked:=false;
  //zoomen
  optio.Checkzoom.Checked:=true;
  //geschwindigkeitspfeile
  optio.CheckBox1.Checked:=false;
  optio.RadioButton7.Checked:=true;
  optio.RadioButton8.Checked:=false;
  optio.RadioButton9.Checked:=false;
  optio.Pfeilgroesse.Position:=10;
  //farben
  optio.Spurfarbe.DefaultColorColor:=clred;
  optio.Spurfarbe.NoneColorColor:=clred;
  optio.Spurfarbe.Selected:=clred;
  farben.spurfarbe:=clred;

  optio.aussenfarbe.DefaultColorColor:=clnavy;
  optio.aussenfarbe.NoneColorColor:=clnavy;
  optio.aussenfarbe.Selected:=clnavy;
  farben.aussenfarbe:=clnavy;

  optio.kreuzfarbe.DefaultColorColor:=clgreen;
  optio.kreuzfarbe.NoneColorColor:=clgreen;
  optio.kreuzfarbe.Selected:=clgreen;
  farben.kreuzfarbe:=  clgreen;

  self.mrs;

  self.Canvas.TextOut(self.Width div 2-100, self.Height div 2-100, 'Standardansicht');
end;


{-----------------------------------------------------------------------------
  Description:  während dem rechnen setzte schreibgeschützt
  Procedure:    wdrss
  Arguments:    schreibgeschutzt:boolean
  Result:       None
-----------------------------------------------------------------------------}
procedure Thaupt.wdrss(schreibgeschutzt:boolean);
begin
  self.EGeschwindigkeit.ReadOnly:=   schreibgeschutzt;
  self.EAuftreffenx.ReadOnly:=   schreibgeschutzt;
  self.EAuftreffeny.ReadOnly:=   schreibgeschutzt;
  self.EUmlaufdauer.ReadOnly:=   schreibgeschutzt;
  self.EWinkel.ReadOnly:=   schreibgeschutzt;
  self.EScheibenradius.ReadOnly:=   schreibgeschutzt;
  self.EReibung.ReadOnly:=   schreibgeschutzt;
  self.CheckReibungsfaktor.Enabled:=not schreibgeschutzt;

  if schreibgeschutzt then
    begin
    self.EGeschwindigkeit.color:=clgraytext;
    self.StatusBar1.Color:=cllime;
    end
  else
    begin
    self.EGeschwindigkeit.color:=clwhite;
    self.StatusBar1.Color:=clbtnface;
    end;
end;




{-----------------------------------------------------------------------------
  Procedure:    Button1Click
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.BBerechnenClick(Sender: TObject);
begin
  if (stop) then
    rech.drehen;
  if pause then
    self.BPause.Click;
end;



{-----------------------------------------------------------------------------
  Description:  markierungen richtig setzten
  Procedure:    mrs
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure thaupt.mrs ;
begin
  //self

  self.Image1.Visible:=rrechts;
  self.Image2.Visible:=not rrechts;
  optio.Image1.Visible:=rrechts;
  optio.Image2.Visible:=not rrechts;
    //reibung
  eingabe.haupt.reibungein:=self.CheckReibungsfaktor.Checked;
  self.EReibung.Visible:= self.CheckReibungsfaktor.Checked;

  //optio
  eingabe.optio.schieberegler:=optio.Schieberegler.Position;
  eingabe.optio.pfeilgroesse:=optio.Pfeilgroesse.Position;
  eingabe.optio.checkbox1:=optio.CheckBox1.Checked;
  eingabe.optio.radiobutton7:=optio.RadioButton7.Checked;
  eingabe.optio.radiobutton8:=optio.RadioButton8.Checked;
  eingabe.optio.radiobutton9:=optio.RadioButton9.Checked;
  eingabe.optio.Autoaktualisieren_aus:=optio.Autoaktualisieren_aus.Checked;


  optio.Zoombar.Enabled := not optio.Checkzoom.Checked;

  optio.checkbox2.Visible:=optio.checkbox3.Checked ;
  optio.checkbox4.Visible:=optio.checkbox3.Checked ;
  optio.checkbox5.Visible:=optio.checkbox3.Checked;
    //die pfeile
  optio.Pfeilgroesse.Visible:=optio.CheckBox1.Checked;
  optio.Label10.Visible:=     optio.CheckBox1.Checked;
  optio.Label11.Visible:=     optio.CheckBox1.Checked;
  optio.RadioButton7.Visible:=optio.CheckBox1.Checked;
  optio.RadioButton8.Visible:=optio.CheckBox1.Checked;
  optio.RadioButton9.Visible:=optio.CheckBox1.Checked;

  //umlaufsdauer/winkelgeschwindigkeit
  if (optio.RadioButton3.Checked) then
    begin
  //hier rechnet er die Winkelgeschwindigkeit in Umlaufsdauer und umgekehrt
    if (self.BUmlaufdauer.caption='Winkelgeschwindigkeit:') then self.EUmlaufdauer.Text:=floattostr(roundto(2*pi/strtofloat(self.EUmlaufdauer.text),-4));
    self.BUmlaufdauer.caption:='Umlaufsdauer:';
    self.Label8.Caption:='s';
    end;
  if (optio.RadioButton4.Checked)then
    begin
  //hier rechnet er die Winkelgeschwindigkeit in Umlaufsdauer und umgekehrt
    if (self.BUmlaufdauer.caption='Umlaufsdauer:') then self.EUmlaufdauer.Text:=floattostr(roundto(2*pi/strtofloat(self.EUmlaufdauer.text),-4));
    self.BUmlaufdauer.caption:='Winkelgeschwindigkeit:';
    self.Label8.Caption:='1/s';
    end;
end;







{-----------------------------------------------------------------------------
  Description:
  Procedure:    FormMouseDown
  Arguments:    Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer
  Result:       None
  Detailed description:
    wird ausgeführt wenn eine/auch die rechte/mittlere/linke Taste der Maus runtergeht
-----------------------------------------------------------------------------}
procedure Thaupt.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //hier fragt er nach ob der Punkt noch innerhalb des Radius ist und ob stop auch true ist
  if  (pythagoras( relx(x)  , rely(y)  ) <=r) and (stop)and(shift=[ssleft]) then
    begin
    stop:=false;
    //hier unten muss ich nicht mehr aktualisieren da automatisch die onchange procedure aufgerufen wird die das aktualissiert, passiert zwar zweimal ist aber da es so schnell geht nciht wichtig
    EAuftreffenx.Text:=floattostr(roundto(    pixeltocm(relx(x))    ,-1));
    EAuftreffeny.Text:=floattostr(roundto(     pixeltocm(rely(y))    ,-1));

    //  Hier bewerte ich die globalen variablen neu
    k.auftreffen.x:=relx(x);    //k.auftreffen ist realtiv, also im angepassten koordinatensystem
    k.auftreffen.y:=rely(y);

    self.StatusBar1.Panels[3].Text:='Entfernung: '+floattostr(roundto(
          pythagoras(   pixeltocm(relx(x))  ,  pixeltocm(rely(y))  )
          ,-1))+' cm';
    //speichert den Aktuell gesetzten Punkt in das record ab
    // tipp um auf einen befehl zu kommen einfach strg+klicken auf befehl

    z.click:=true;

    stop:=true;
    self.aktuali(true,true,true,true,true);
    end;

  //damit man das bild verschieben kann
  if (button=mbright) and not (optio.Autopos.Checked) then
    begin
    verschieben.mousedown.x:=x;
    verschieben.mousedown.y:=y;
    end;
  if button=mbmiddle then     self.mausmittelklick;
end;



{-----------------------------------------------------------------------------
  Description:
  Procedure:    FormClose
  Arguments:    Sender: TObject; var Action: TCloseAction
  Result:       None
  Detailed description:
      wir dausgeführt wenn das Programm geschlossen wird
-----------------------------------------------------------------------------}
procedure Thaupt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  schliessen:=true;
  stop:=true;

  bild.Free;

  //hier schreibt er alle Einstellungen in dei Ini Datei,
  txt.schreibeini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
  //hier stoppt er alles radikal und beendet das Programm
  halt;
end;



{-----------------------------------------------------------------------------
  Description:  das ist der Stop button
  Procedure:    BAbbrechenClick
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.BAbbrechenClick(Sender: TObject);
begin
  if pause then self.Pause1.Click;

  stop:=true;
  abgebrochen:=true;
end;


{-----------------------------------------------------------------------------
  Description:  das ist wenn der Winekl geändert wird
  Procedure:    Edit5Change
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.EWinkelChange(Sender: TObject);
begin
  if (eingabefelderOK) then
    begin
    eingabe.haupt.winkel:=strtofloat(self.EWinkel.text);

    if abs(eingabe.haupt.winkel)>=360 then
      begin
      self.EWinkel.text :=floattostr(round(eingabe.haupt.winkel) mod 360);
      self.EWinkel.SelectAll;
      eingabe.haupt.winkel:=strtofloat(self.EWinkel.text);
      end;

    z.click:=true;
    if stop then self.aktuali(true,true,true,true,true);
    end;
end;



{-----------------------------------------------------------------------------
  Description:  Create  Create  Create  Create  Create  Create  Create  Create  Create  Create  Create  Create
  Procedure:    FormCreate
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormCreate(Sender: TObject);
var    stelle:byte;
begin
  version:=anderes.getfileversion(Application.ExeName);
  //hier wird jetzt die punkte weggemacht bis auf den 1. damit es auch schön aussieht
  stelle:=pos('.',version)+1;
  repeat
    stelle:=posex('.',version,stelle);
    delete(version,stelle,1);
  until  posex('.',version,stelle)=0;
  for stelle:=0 to 3 do
    if AnsiLastChar(version)='0' then delete(version,length(version),1);

  randomize;
  amstarten:=true;

  DragAcceptFiles(self.Handle, true);

  verschieben.aktivieren:=false;
  schliessen:=false;
  z.click:=true;
  //erst mal die Bild Klasse creieren
  bild:=Tbitmap.Create;
  self.DoubleBuffered:=true;
  bild.PixelFormat:=pf32bit;
  //dies hat mir ein Forum mitglied geraten, da es sonst nicht auf englischen systemen läuft
  DecimalSeparator := ',';
end;



{-----------------------------------------------------------------------------
  Description:  Größenänderung
  Procedure:    FormResize
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormResize(Sender: TObject);
begin
  //k.auftreffen.x:=(strtofloat(edit2.Text)*200/22.5);
  //k.auftreffen.y:=(strtofloat(edit3.Text)*200/22.5);

  //größenänderung bei der breite der statusbar
  self.StatusBar1.Panels[0].Width:=round(self.Width*60/nw);
  self.StatusBar1.Panels[1].Width:=round(self.Width*60/nw);
  self.StatusBar1.Panels[2].Width:=round(self.Width*150/nw);
  self.StatusBar1.Panels[3].Width:=round(self.Width*140/nw);
  self.StatusBar1.Panels[4].Width:=round(self.Width*120/nw);
  self.StatusBar1.Panels[5].Width:=round(self.Width*50/nw);

  //zeige die größe des Fensters an
  self.Canvas.Font.Size:=25;
  self.Canvas.TextOut(self.Width-500,200,'Fenstergröße: '+inttostr(self.Width)+' x '+inttostr(self.Height));
  self.Canvas.TextOut(self.Width-500,250,'Bildgröße: '+floattostr(roundto(darstellungsradius*2,-1))+' x '+floattostr(roundto(darstellungsradius*2,-1)));

  if (not schliessen)and(optio.Autopos.Checked) then zeichne.anfangspos;
  self.aktuali(true,false,true,true,true);
end;



{-----------------------------------------------------------------------------
  Description:  Wechseln der Anzeige von Umlaufdauer zu Winkelgeschwindigkeit und zurück
  Procedure:    BUmlaufdauerClick
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.BUmlaufdauerClick(Sender: TObject);
begin
  if optio.RadioButton3.Checked then
    optio.RadioButton4.Checked:=true
  else
    optio.RadioButton3.Checked:=true;
  self.mrs;
end;




procedure Thaupt.Ausfhren1Click(Sender: TObject);
begin
  self.BBerechnen.Click;
end;

procedure Thaupt.Stoppen1Click(Sender: TObject);
begin
  BAbbrechen.Click;
end;

procedure Thaupt.Info1Click(Sender: TObject);
begin
  about.show;
  txt.schreibeini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
end;

procedure Thaupt.Starten1Click(Sender: TObject);
begin
  if stop then rech.Zufallskurven;
end;

procedure Thaupt.Alleswiederstellen1Click(Sender: TObject);
begin
  Standardwerte;
end;

procedure Thaupt.Speichern1Click(Sender: TObject);
begin
  self.SaveDialog1.Execute;
end;

{-----------------------------------------------------------------------------
  Procedure:    SaveDialog1CanClose
  Arguments:    Sender: TObject; var CanClose: Boolean
-----------------------------------------------------------------------------}
procedure Thaupt.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  if pos('.ini',self.SaveDialog1.FileName)>0 then
    txt.schreibeini(self.SaveDialog1.FileName)
  else
    txt.schreibeini(self.SaveDialog1.FileName+'.ini');
end;


procedure Thaupt.AusDatei1Click(Sender: TObject);
begin
  self.OpenDialog1.Execute;
end;


procedure Thaupt.OpenDialog1CanClose(Sender: TObject;  var CanClose: Boolean);
begin
  txt.leseini(self.openDialog1.FileName);
  self.aktuali(true,false,true,true,true);
end;


procedure Thaupt.Bildspeichern1Click(Sender: TObject);
begin
  self.SaveDialog2.Execute;
end;

procedure Thaupt.SaveDialog2CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  zeichne.zeichnebmp(self.SaveDialog2.FileName);
end;

{-----------------------------------------------------------------------------
  Procedure:    BAktualisierenClick
-----------------------------------------------------------------------------}
procedure Thaupt.BAktualisierenClick(Sender: TObject);
begin
  if not stop then exit;
  z.click:=true;
  self.aktuali(true,true,true,true,true);
end;


procedure Thaupt.Optionen1Click(Sender: TObject);
begin
  optio.Show;
  optio.TabSheet2.Show;
end;


{-----------------------------------------------------------------------------
  Description:
  Procedure:    FormKeyDown
  Arguments:    Sender: TObject; var Key: Word; Shift: TShiftState
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //showmessage(inttostr(ord(key)));


  //jetzt alles in einer Actionlist gekapselt
{  if (ord(key) = 120)then self.BBerechnen.Click;                                 //120 = f9
  if ord(key) = 122 then  self.Starten1.Click;                                //121 = f11
  if ord(key) = 90 then self.Zufallswerte1.Click;                             //90=z
  if ord(key) = 82 then self.Spurzurckverfolgen1.Click;                       //82=R}
//  if (shift<>[ssCtrl])and(ord(key) = 83) then  self.Bildspeichern1Click(nil); //83=s
//  if (shift<>[ssCtrl])and(ord(key) = 85) then  self.Update1.Click;      //85=u
//  if (shift=[ssCtrl])and(ord(key) = 83) then  self.Speichern1Click(nil);      //strg + s
//  if (shift=[ssCtrl])and(ord(key) = 79) then  self.AusDatei1Click(nil);       //strg + o
{  if (shift<>[ssCtrl])and(ord(key) = 79) then self.BOptionen.Click;         //79=o
  if ord(key) = 76 then self.Lizenz1.Click;                                   //76=L
  if (shift<>[ssCtrl])and(ord(key) = 86) then  self.Version1.Click;                                 //86=v   öffnet versionsfeld
  if (ord(key) = 112)then self.Hilfe1.Click;                                  //112 = f1
  if ord(key) = 65 then  self.Info1.Click;                                    //65=a   öffnet info feld
  if ord(key) = 80 then  self.BPause.Click;                                  //80=p   pause
  if ord(key) = 73 then  self.Informationsfenster1.Click;                     //73=i   öffnet informationsfenster
  if (Key=VK_ESCAPE) then self.BAbbrechen.Click;                                 //escape

  if (shift=[ssCtrl]) and (ord(key) = 119) then self.meineansicht;              //strg + F8
  if (shift=[ssCtrl]) and (ord(key)=118) then self.standardansicht; //strg + F7
  if (shift=[ssCtrl]) and (ord(key)=116) then self.Alleswiederstellen1.Click; //strg + F7}
end;



procedure Thaupt.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key='.' then key:=',';  //hier wandelt er den punkt in ein komma
end;



procedure Thaupt.Version1Click(Sender: TObject);
begin
  showmessage('Version  '+version);
end;

procedure Thaupt.Aktualisieren1Click(Sender: TObject);
begin
  self.BAktualisieren.Click;
end;


{-----------------------------------------------------------------------------
  Procedure:    Spurzurckverfolgen1Click
  Arguments:    Sender: TObject
-----------------------------------------------------------------------------}
procedure Thaupt.Spurzurckverfolgen1Click(Sender: TObject);
begin
  if not stop then exit;
  rech.saas(false);
  self.aktuali(true,true,true,true,true);
end;

{-----------------------------------------------------------------------------
  Description:  Öffen von Form2
  Procedure:    Infos1Click
-----------------------------------------------------------------------------}
procedure Thaupt.Infos1Click(Sender: TObject);
begin
  optio.Show;
  optio.TabSheet1.Show;
end;

{-----------------------------------------------------------------------------
  Description:
  Procedure:    Hilfe1Click
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
    hier das wird ausgeführ wenn man "Über das Programm" --> "Hilfe" klickt
-----------------------------------------------------------------------------}
procedure Thaupt.Hilfe1Click(Sender: TObject);
begin
  //Hier wird die Datei Readme mit dem Notepad ausgeführt
  //Die Readme wird "self.on activate" erstellt
  ShellExecute(handle, 'open',PChar('notepad.exe'), pchar(ExtractFilePath(Application.ExeName)+'Readme.txt'), nil, SW_SHOW);
end;


{-----------------------------------------------------------------------------
  Description:  Ändern der Auftreffkoordinaten
  Procedure:    EAuftreffenyChange
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.EAuftreffenyChange(Sender: TObject);
begin
  if eingabefelderOK then
    begin
    k.auftreffen.x:=cmtopixel(strtofloat(EAuftreffenx.text));
    k.auftreffen.y:=cmtopixel(strtofloat(EAuftreffeny.text));

    eingabe.haupt.x:=k.auftreffen.x;
    eingabe.haupt.y:=k.auftreffen.y;
    end;

  if stop then self.aktuali(true,true,true,true,true);
end;


{-----------------------------------------------------------------------------
  Description:  Drehrichtung ändern
  Procedure:    Image1Click
  Arguments:    Sender: TObject
-----------------------------------------------------------------------------}
procedure Thaupt.Image1Click(Sender: TObject);
begin
  if stop then
    begin
    rrechts:=not rrechts;
    self.mrs;
    end;
end;



procedure Thaupt.CheckReibungsfaktorClick(Sender: TObject);
begin
  mrs;
end;



procedure Thaupt.Kurzfassung1Click(Sender: TObject);
begin
  txt.intxtschreiben(ExtractFilePath(Application.ExeName)+'Kurzfassung der Jugend Forscht Arbeit.txt',memo2.text,true);
  ShellExecute(handle, 'open',PChar('notepad.exe'), pchar(ExtractFilePath(Application.ExeName)+'Kurzfassung der Jugend Forscht Arbeit.txt'), nil, SW_SHOW);
end;




{-----------------------------------------------------------------------------
  Description:  Pause
  Procedure:    BPauseClick
  Arguments:    Sender: TObject
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.BPauseClick(Sender: TObject);
begin
  if stop then exit;

  pause:=not pause;

  if pause then
    begin
    self.BPause.Caption:='Weiter';
    self.Pause2.Caption:='Weiter';
    self.Cursor:=crhourglass;
    info.Cursor:=crhourglass;
    end
  else
    begin
    self.BPause.Caption:='Pause';
    self.Pause2.Caption:=   'Pause';
    self.Cursor:=crdefault;
    info.Cursor:=crdefault;
    end;

  while pause do anderes.delay(10);
end;



{-----------------------------------------------------------------------------
  Description:
  Procedure:    Zufallswerte1Click
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.Zufallswerte1Click(Sender: TObject);
begin
  if not stop then exit;
  //das hin und her mit stop und click mache ich damit er das bild nachher nur einmal zeichnet und sonst nicht zwischendurch
  z.click:=false;
  stop:=false;

  rech.zufallswerte;

  stop:=true;
  z.click:=true;

  self.aktuali(true,true,true,true,true);
end;


{-----------------------------------------------------------------------------
  Description:  Info fenster zeigen
  Procedure:    Informationsfenster1Click
-----------------------------------------------------------------------------}
procedure Thaupt.Informationsfenster1Click(Sender: TObject);
begin
  info.show;
end;


procedure Thaupt.Lizenz1Click(Sender: TObject);
begin
  about.Show;
  about.TabSheetControl.ActivePage:=about.TabLizenz;
end;


procedure Thaupt.BOptionenClick(Sender: TObject);
begin
  self.Infos1Click(nil);
end;



procedure Thaupt.EReibungKeyPress(Sender: TObject; var Key: Char);
begin
  //showmessage(inttostr(ord(key)));
  if not(key in ['0' .. '9', ',' ,'-' ,#8,#22,#3])  then
      key := #0;
end;


{-----------------------------------------------------------------------------
  Description:
  Procedure:    FormShow
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormShow(Sender: TObject);
var x1,x2:integer;
begin
  stop:=false;
  self.Caption:='Corioliskraft   '+version+'   -   Simulation eines Kugelverlaufs im zweidimensionalen rotienden System';
  about.Caption:='Information  zu  Corioliskraft  '+version;
  //hier schreibt er alle einstellungen in die Felder aus ini
  txt.leseini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
  stop:=true; abgebrochen:=true; pause:=false;
  mrs;

  //hier schreibt er die readme
  txt.intxtschreiben(ExtractFilePath(Application.ExeName)+'Readme.txt',memo1.text,true);

  //hier das ist um den Buchstaben bei den ini Dateien festzulegen
  //hier das muss er unbedingt nach leseini tun sonst funktioniert es nicht
  if optio.CheckBoxLog2.Checked then
    for x1:=65 to 90 do
      for x2:=65 to 90 do
        begin
        inibuchstabe:=chr(x1)+chr(x2);
        if (not fileexists(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+inibuchstabe+'0.ini')) then break;
  //              begin  x1:=100; x2:=100; end;
        end;
  {  begin
    x1:=65;
    while x1<=90 do
      begin
      x2:=65;
      while x2<=90 do
        begin
        inibuchstabe:=chr(x1)+chr(x2);
        if (not fileexists(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+inibuchstabe+'0.ini')) then
                begin  x1:=100; x2:=100; end;
        inc(x2);
        end;
      inc(x1);
      end;
    end;}

  amstarten:=false;
  self.BBerechnen.SetFocus;

  zeichne.anfangspos;
  self.aktuali(true,true,true,true,true);
end;



procedure Thaupt.Pause1Click(Sender: TObject);
begin
  self.BPause.Click;
end;


{-----------------------------------------------------------------------------
  Description:  Wichitg damit es nicht flackert
  Procedure:    FormPaint
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormPaint(Sender: TObject);
begin
  self.aktuali(true,false,false,true,true);
end;



{-----------------------------------------------------------------------------
  Description:  Prüfen ob ein ein Eingabefeld ok ist
  Procedure:    EingabefeldOK
  Arguments:    edit:Tedit
  Result:       boolean
  Detailed description:
-----------------------------------------------------------------------------}
function THaupt.EingabefeldOK(edit:Tedit):boolean;
begin
  result:=true;

  //hier werden die , die nach dem 1. kommen rausgeschnitten
  if (pos(',',edit.text)>0)  then     //wenn überhaupt ein komma drin ist
      edit.Text:= leftstr(edit.Text,pos(',',edit.text))+                 // so der linke teil des feldes wird addiert mit dem
                stringreplace(                                       //hier werden die kommas rausgeschnitten
                               rightstr(edit.Text,       length(edit.text)-  pos(',',edit.text))      //dieser rechte teil wird ermittelt indem man die position des erstenkommas als like schnittstelle angibt
                               ,',','',[rfReplaceAll]);   //dann wird hier das zu ersetztende zeichen(,); das'' angegeben und gesagt dass alle kommas danach ersetzt werden sollen

  if (Edit.text='')or(Edit.text='-')        then  result:=false;

  //if result=false then showmessage('Du hast einen Fehler bei deiner Eingabe gemacht!'+chr(13)+'Bitte korrigiere, sonst kann es zu Fehlern kommen!!!');
end;




{-----------------------------------------------------------------------------
  Description:  Prüft alle eingabefelder
  Procedure:    EingabeFelderOK
  Arguments:    None
  Result:       boolean
  Detailed description:
-----------------------------------------------------------------------------}
function THaupt.EingabeFelderOK:boolean;
begin
  result:=true;
    if (not EingabefeldOK(self.EGeschwindigkeit))
      or (not EingabefeldOK(self.EAuftreffenx))
      or (not EingabefeldOK(self.EAuftreffeny))
      or (not EingabefeldOK(self.EUmlaufdauer))
      or (not EingabefeldOK(self.EWinkel))
      or (not EingabefeldOK(self.EScheibenradius))
      or (not EingabefeldOK(self.EReibung)) then result:=false;
end;




{-----------------------------------------------------------------------------
  Procedure:    EGeschwindigkeitChange
-----------------------------------------------------------------------------}
procedure Thaupt.EGeschwindigkeitChange(Sender: TObject);
begin
  if self.EingabefeldOK(self.EGeschwindigkeit) then eingabe.haupt.kugelgeschwindigkeit:=strtofloat(self.EGeschwindigkeit.text);
end;



{-----------------------------------------------------------------------------
  Procedure:    EReibungChange
-----------------------------------------------------------------------------}
procedure Thaupt.EReibungChange(Sender: TObject);
begin
  if self.EingabefeldOK(self.EReibung) then eingabe.haupt.reibungsfaktor:=strtofloat(self.EReibung.text);
end;



{-----------------------------------------------------------------------------
  Procedure:    EUmlaufdauerChange
-----------------------------------------------------------------------------}
procedure Thaupt.EUmlaufdauerChange(Sender: TObject);
begin
  if  (self.EingabefeldOK(self.EUmlaufdauer))and(strtofloat(self.EUmlaufdauer.text) = 0)and not amstarten then
    showmessage('Dieser Wert darf nicht 0 sein, da sich sonst die Platte unendlich schnell drehen würde.'+#13#10+ 'Bitte ändern Sie diesen Wert!');

  if optio.RadioButton3.Checked then
    if self.EingabefeldOK(self.EUmlaufdauer) then eingabe.haupt.umlaufdauer:=strtofloat(self.EUmlaufdauer.text)
  else
    if self.EingabefeldOK(self.EUmlaufdauer) then eingabe.haupt.umlaufdauer:=2*pi/strtofloat(self.EUmlaufdauer.text);
end;


{-----------------------------------------------------------------------------
  Procedure:    EScheibenradiusChange
-----------------------------------------------------------------------------}
procedure Thaupt.EScheibenradiusChange(Sender: TObject);
begin
  if not self.EingabefeldOK(self.EScheibenradius) then exit;

  if cmtopixel(strtofloat(self.EScheibenradius.Text))=0 Then exit;

  r:= cmtopixel(strtofloat(self.EScheibenradius.Text));
  eingabe.haupt.scheibenradius:=r;

  self.BAktualisieren.Click;
end;



{-----------------------------------------------------------------------------
  Description:
  Procedure:    aktuali
  Arguments:    bdrm,bRefreshKoor,bRefresh,bVorZeichnen,bcanvaszeichnen:boolean
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.aktuali(bdrm,bRefreshKoor,bRefresh,bVorZeichnen,bcanvaszeichnen:boolean);
begin
  if  schliessen or amstarten then exit;

  self.mrs;

  if bdrm then zeichne.drm;
  if bRefreshKoor then self.RefreshKoor;
  if bRefresh then self.Refresh;
  if bVorZeichnen then zeichne.VorZeichnen;
  if bcanvaszeichnen then zeichne.canvaszeichnen;
end;


{-----------------------------------------------------------------------------
  Description:  Zum verschieben
  Procedure:    FormMouseUp
  Arguments:    Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not (button=mbRight)  then exit;
  //damit man das bild verschieben kann

  if  not(optio.Autopos.Checked) then
    begin
    verschieben.mouseup.x:= x;
    verschieben.mouseup.y :=y;
    verschieben.diff.x:= -verschieben.mousedown.x+ verschieben.mouseup.x         ;
    verschieben.diff.y:= -verschieben.mousedown.y+ verschieben.mouseup.y         ;

    verschieben.aktivieren:= self.pythagoras(verschieben.diff.x,verschieben.diff.y)>0  ;
    end;

  if not verschieben.aktivieren then
    self.PopupMenu1.Popup(mouse.CursorPos.X,mouse.CursorPos.y);

  self.aktuali(false,false,true,true,true);
end;


{-----------------------------------------------------------------------------
  Description:  Zoomen
  Procedure:    FormMouseWheel
  Arguments:    Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  optio.Zoombar.Position:=optio.Zoombar.Position+round(wheeldelta/120);
end;


procedure Thaupt.Autozoom1Click(Sender: TObject);
begin
  optio.Show;
  optio.Checkzoom.SetFocus;
end;


procedure Thaupt.ReinzoomenMausradrauf1Click(Sender: TObject);
begin
  optio.Zoombar.Position:=optio.Zoombar.Position+5;
end;

procedure Thaupt.RauszoomenMausradrunter1Click(Sender: TObject);
begin
  optio.Zoombar.Position:=optio.Zoombar.Position-5;
end;

procedure Thaupt.AutopositionKlickMausrad1Click(Sender: TObject);
begin
  self.mausmittelklick;
end;


{-----------------------------------------------------------------------------
  Description:  keine Standartwerte, aber eine Standartkurve
  Procedure:    StandardkurveClick
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.StandardkurveClick(Sender: TObject);
begin
  //variablen
  koor.x:=0 ; koor.y := -r;
  k.auftreffen.x:=-r;
  k.auftreffen.y:=0;
  rrechts:=true;

  self.EGeschwindigkeit.Text:='100';
  self.EWinkel.Text:='0';
  self.EAuftreffenx.Text:=floattostr(roundto(- pixeltocm(r),-1));
  self.EAuftreffeny.Text:='0';
  if optio.RadioButton3.Checked then self.EUmlaufdauer.Text:='2' else self.EUmlaufdauer.Text:='3,14';
  self.EScheibenradius.Text:=floattostr(roundto(  pixeltocm(200),-2));
  self.EReibung.Text:='1';
end;



procedure Thaupt.mausmittelklick;
begin
  optio.Zoombar.Position:= round((self.Height-150)/2     *9/200);
  zeichne.anfangspos;
end;

procedure Thaupt.hi1Click(Sender: TObject);
begin
  self.BBerechnen.Click;
end;

procedure Thaupt.Abbrechen1Click(Sender: TObject);
begin
  self.BAbbrechen.Click;
end;

procedure Thaupt.Pause2Click(Sender: TObject);
begin
  self.BPause.Click;
end;

procedure Thaupt.Zufallskurven2Click(Sender: TObject);
begin
  self.Starten1Click(nil);
end;

procedure Thaupt.Optionen2Click(Sender: TObject);
begin
  self.BOptionen.Click;
end;

procedure Thaupt.Infofenster1Click(Sender: TObject);
begin
  self.Informationsfenster1Click(nil);
end;

procedure Thaupt.berdasProgramm2Click(Sender: TObject);
begin
  self.Info1Click(nil);
end;




{-----------------------------------------------------------------------------
  Description:  Um den Drag'n'Drop zu bekommen
  Procedure:    WMDROPFILES
  Arguments:    var Msg: TMessage
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure THaupt.WMDROPFILES (var Msg: TMessage);
var i, anzahl, size: integer;
  Dateiname: PChar;
begin
  inherited;
  anzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, Dateiname, 255);
  for i := 0 to (anzahl - 1) do
  begin
    size := DragQueryFile(Msg.WParam, i , nil, 0) + 1;
    Dateiname:= StrAlloc(size);
    DragQueryFile(Msg.WParam,i , Dateiname, size);

    if lowercase(RightStr(StrPas(Dateiname),4))='.ini' then
      DragAndDrop(StrPas(Dateiname));           //hier wird meine procedure aufgerufen

    StrDispose(Dateiname);
  end;
  DragFinish(Msg.WParam);
end;



{-----------------------------------------------------------------------------
  Description:  Bei Drag'n'Drop wird hier das ausgeführt
  Procedure:    DragAndDrop
  Arguments:    Dateiname:string
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.DragAndDrop(Dateiname:string);
begin
  stop:=true;
  abgebrochen:=true;
  txt.leseini(Dateiname);
  self.aktuali(true,false,true,true,true);
end;



{-----------------------------------------------------------------------------
  Description:
  Procedure:    Update1Click
  Arguments:    Sender: TObject
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Thaupt.Update1Click(Sender: TObject);
begin
  about.Show;
  about.TabSheetControl.ActivePage:=about.TabUpdate;
  about.BCheckUpdate.Click;
end;

procedure Thaupt.AcMeineAnsichtExecute(Sender: TObject);
begin
  self.meineansicht;
end;

procedure Thaupt.AcStandartansichtExecute(Sender: TObject);
begin
  self.standardansicht
end;

procedure Thaupt.AcResetExecute(Sender: TObject);
begin
  self.Alleswiederstellen1.Click;
end;


end.

