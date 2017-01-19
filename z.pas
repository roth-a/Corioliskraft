{-----------------------------------------------------------------------------
 Unit Name: z
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
 Description:
    Ist die Unit um zu Zeichnen
-----------------------------------------------------------------------------}

unit z;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, Shellapi, Gauges,
    math, ExtCtrls, StdCtrls, ComCtrls, Menus;


type Tzeichne=class
  private

    procedure zeichnekreis(punknt1x,punknt1y,punknt2x,punknt2y:real;farbe:Tcolor);  overload;
    procedure zeichnekreis(Punkt:Trect;farbe:Tcolor);  overload;
    procedure zeichnekreis(mitte:Tpoint;radius:real;farbe:Tcolor);  overload;
    procedure zeichnekreis(x,y,radius:real;farbe:Tcolor);  overload;
    procedure zeichnekreis(punkt1,punkt2:Tpoint;farbe:Tcolor); overload;

    procedure zeichnelinie(anfangx,anfangy,endex,endey:real;farbe:Tcolor);
    procedure zeichnepixel(x,y:real;farbe:Tcolor);
    procedure schrift;
{    procedure zeichnepixel(x,y:real);
    function PunktLiegtDrin(x,y:real):boolean;}
    Procedure zeichnepfeil;
    procedure canzeichnenAktualisierenAus;
    { Private-Deklarationen }
  public
    procedure anfangspos;
    Procedure verschiebepos;
    function strecken:real;
    procedure canvaszeichnen;
    procedure drm;    //darstellungs Radius regeln
    procedure kreiszeichnen;
    procedure VorZeichnen;
    procedure kreuzzeichnen;
    procedure kugelzeichnen(x,y:real);
    Procedure winkelpfeil(grad:real);
    procedure  arzeichnen;
    procedure zeichnebmp(filename:string);
    procedure loeschebild;
    { Public-Deklarationen }
  end;

  Tbildpos=record
    top,right:byte ;
    end;
  TKoordinaten=record
    x,y:real;
    end;


var   zeichne:Tzeichne;

      pfeil:record
        bezugskoordinaten,rueckgabekoordinaten:Tkoordinaten;
        laenge,si,co,alpha:real;
      end;

      farben :record
        spurfarbe, aussenfarbe, kreuzfarbe : Tcolor;
      end;
      bild:TBitmap;
      click,
      GroesseVonFormx,GroesseVonFormy:boolean;
      darstellungsradius:real;

      bildpos:Tbildpos = (top:0;right:18)  ;

      verschieben:record
        mousedown,mouseup,diff,pos:TKoordinaten;
        aktivieren:boolean;
      end;


implementation
uses unit1,Unit2, Unit4, Unit5,berechnung,text,unit3,Uanderes;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    VorZeichnen
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TZeichne.VorZeichnen;
begin
  GroesseVonFormx:=false;
  GroesseVonFormy:=false;

  if round(darstellungsradius)*2+2> haupt.Width then
    begin
    GroesseVonFormx:=true;
    bild.Width:=haupt.Width;
    end;
  if round(darstellungsradius)*2+2> haupt.Height then
    begin
    bild.Height:=haupt.Height;
    GroesseVonFormy:=true;
    end;

//  if  not(round(darstellungsradius)*2+2> haupt.Height) and not(round(darstellungsradius)*2+2> haupt.Width) then
  if  (round(darstellungsradius)*2+2< haupt.Height) and (round(darstellungsradius)*2+2< haupt.Width) then
    begin
    bild.Height:=round(darstellungsradius)*2+2;
    bild.Width:=bild.Height;
    end;
end;



{-----------------------------------------------------------------------------
  Description:  Löscht das bmp Bild
  Procedure:    loeschebild
-----------------------------------------------------------------------------}
procedure Tzeichne.loeschebild;
begin
  bild.Canvas.Brush.Color:=clbtnface;
  bild.Canvas.FillRect(bild.Canvas.ClipRect);
end;




{-----------------------------------------------------------------------------
  Description:  Zeichnet auf die Canvas
  Procedure:    canvaszeichnen
  Arguments:    None
  Result:       None
  Detailed description:
                         zeichnet das Bild neu aufs BMP und presst es auf die Canvas
-----------------------------------------------------------------------------}
procedure Tzeichne.canvaszeichnen;
begin
  if eingabe.optio.Autoaktualisieren_aus then
    begin
    zeichne.canzeichnenAktualisierenAus;
    exit;
    end;

  loeschebild;

  zeichne.kreuzzeichnen;
  zeichne.kreiszeichnen;
  if eingabe.optio.checkbox1 then zeichne.zeichnepfeil;

  if click then
    begin
    zeichne.winkelpfeil(eingabe.haupt.winkel)    ;
    zeichne.kugelzeichnen(k.auftreffen.x,k.auftreffen.y);
    end
  else
    begin
    zeichne.arzeichnen;
    if anderes.arraynichtleer then  zeichne.kugelzeichnen(punkte[lauf].x,punkte[lauf].y);
    end;

  zeichne.verschiebepos;

  //hier muss ich die fälle unterscheiden je nachdem welche grösse so gros ist wie die form und welche noch kleiner ist und diese strecke des bildes in der form sich befindet
  if  GroesseVonFormx and GroesseVonFormy then
    BitBlt(haupt.Canvas.Handle,0,0, bild.Width, bild.Height, bild.canvas.Handle,0 ,0,srccopy);
  if  GroesseVonFormx and not GroesseVonFormy then
    BitBlt(haupt.Canvas.Handle,0,round(verschieben.pos.y), bild.Width, bild.Height, bild.canvas.Handle,0 ,0,srccopy);
  if  not GroesseVonFormx and GroesseVonFormy then
    BitBlt(haupt.Canvas.Handle,round(verschieben.pos.x),0, bild.Width, bild.Height, bild.canvas.Handle,0 ,0,srccopy);
  if  not GroesseVonFormx and not GroesseVonFormy then
    BitBlt(haupt.Canvas.Handle,round(verschieben.pos.x),round(verschieben.pos.y), bild.Width, bild.Height, bild.canvas.Handle,0 ,0,srccopy);

  anderes.zaehlefps;
end;




{-----------------------------------------------------------------------------
  Description:  Zeichnet die Canvas ohne zu löschen
  Procedure:    canzeichnenAktualisierenAus
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.canzeichnenAktualisierenAus;
begin
  if lauf =0 then zeichne.loeschebild;

  zeichne.kreiszeichnen;
  zeichne.arzeichnen;


  zeichne.verschiebepos;

  //zeichne.
  BitBlt(haupt.Canvas.Handle,round(verschieben.pos.x),round(verschieben.pos.y), bild.Width, bild.Height, bild.canvas.Handle,  0,0,srccopy);

  anderes.zaehlefps;
end;






{-----------------------------------------------------------------------------
  Description:  Zeichnet den Kreis
  Procedure:    kreiszeichnen
-----------------------------------------------------------------------------}
procedure Tzeichne.kreiszeichnen;
begin
  zeichne.zeichnekreis(0,0,r,farben.kreuzfarbe);      //platte zeichnen
end;




{-----------------------------------------------------------------------------
  Description:  Schreibt die Beschreibungen dran
  Procedure:    schrift
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.schrift;
begin
//hier positioniert er die labels

  if (optio.CheckBox4.Checked)and anderes.arraynichtleer then       //spuranfang,spurende
    begin
    bild.Canvas.Font.Color:=farben.spurfarbe;
    bild.Canvas.TextOut(round(haupt.bildx(punkte[0].x)),round(haupt.bildy(punkte[0].y)),'Spuranfang');
    bild.Canvas.TextOut(round(haupt.bildx(punkte[lauf].x)),round(haupt.bildy(punkte[lauf].y)-15),'Spurende');
    end;
  if (optio.CheckBox5.Checked) then      //y,x
    begin
    bild.Canvas.Font.Color:=farben.kreuzfarbe;
    bild.Canvas.TextOut(round(haupt.bildx(koor.x)),round(haupt.bildy(koor.y)),'x-Achse');
    bild.Canvas.TextOut(round(haupt.bildx(koor.y)),round(haupt.bildx(koor.x)),'y-Achse');
    end;
  if (optio.CheckBox2.Checked)and anderes.arraynichtleer then      //beschreibung
    begin
    bild.Canvas.Font.Color:=farben.spurfarbe;
    bild.Canvas.TextOut(round(haupt.bildx(punkte[round(lauf/2)].x)),round(haupt.bildy(punkte[round(lauf/2)].y)),'Diese Spur sieht ein sich mitdrehender Betrachter auf der Scheibe.');
    bild.Canvas.Font.Color:=farben.aussenfarbe;
    bild.Canvas.TextOut(round(haupt.bildx(geradeaus[round(lauf/2)].x)),round(haupt.bildy(geradeaus[round(lauf/2)].y)),'Diese Spur sieht ein Betrachter ausserhalb der Scheibe.');
    bild.Canvas.Font.Color:=farben.kreuzfarbe;
    bild.Canvas.TextOut(round(haupt.bildx(koor.x/2)),round(haupt.bildy(koor.y/2)),'Dies ist das Koordinatensystem, das auf der sich drehenden Scheibe liegt');

    bild.Canvas.Font.Color:=farben.aussenfarbe;
    bild.Canvas.TextOut(round(haupt.bildx(punkte[round(lauf)].x)),round(haupt.bildy(punkte[round(lauf)].y)),'Diese Kugel wird von aussen über die Platte gerollt.');
    end;
end;



{-----------------------------------------------------------------------------
  Description:
  Procedure:    kreuzzeichnen
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
Procedure Tzeichne.kreuzzeichnen;
begin
//koor ist der Punkt -r|0   also linke ecke der y achse

  //horizontal
  zeichnelinie(   koor.x*strecken+darstellungsradius,
                  -koor.y*strecken+darstellungsradius,
                  darstellungsradius - koor.x*strecken,
                  darstellungsradius+koor.y*strecken,
                  farben.kreuzfarbe);
  //vertikal
  zeichnelinie(   -koor.y*strecken+darstellungsradius,
                  -koor.x*strecken+darstellungsradius,
                  darstellungsradius+koor.y*strecken,
                  darstellungsradius+koor.x*strecken,
                  farben.kreuzfarbe);

  if (optio.CheckBox3.Checked)and(not click) then schrift;
end;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    kugelzeichnen
  Arguments:    x,y:real
-----------------------------------------------------------------------------}
procedure Tzeichne.kugelzeichnen(x,y:real);      //reale Koordinaten
const rkugel=3;
begin
  z.zeichne.zeichnekreis(x,y,rkugel,clblack);
end;




{-----------------------------------------------------------------------------
  Description:  Zeichnet den Winkelpfeil
  Procedure:    winkelpfeil
  Arguments:    grad:real
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
Procedure Tzeichne.winkelpfeil(grad:real);
var x,y:real;
begin
  //hier addiere ich 90 damit es auf der x Achse anfängt
  x:= 70*sin((grad+90)*pi/180);
  y:= 70*cos((grad+90)*pi/180);
  zeichnelinie(   haupt.bildx(k.auftreffen.x),
                  haupt.bildy(k.auftreffen.y),
                  haupt.bildx(k.auftreffen.x+x),
                  haupt.bildy(k.auftreffen.y-y),
                  farben.aussenfarbe);
end;





{-----------------------------------------------------------------------------
  Description:  Zeichnet die Punkte des Arrays
  Procedure:    arzeichnen
  Arguments:    None
  Result:       None
  Detailed description:   Zeichnet sowohl rot als auch blaue Array
-----------------------------------------------------------------------------}
procedure Tzeichne.arzeichnen;              //array zeichnen
var j:integer;
begin
  if not anderes.arraynichtleer then exit;

  if (eingabe.haupt.reibungein) then
    for j:=0 to lauf do
      begin
      zeichnepixel(punkte[j].x*strecken+darstellungsradius,darstellungsradius-punkte[j].y*strecken,farben.spurfarbe);
      zeichnepixel(geradeaus[j].x*strecken+darstellungsradius,darstellungsradius-geradeaus[j].y*strecken,farben.aussenfarbe);
      end
  else
    begin
    for j:=0 to lauf do    zeichnepixel(punkte[j].x*strecken+darstellungsradius,darstellungsradius-punkte[j].y*strecken,farben.spurfarbe);
    zeichnelinie(   geradeaus[0].x*strecken+darstellungsradius,
                    darstellungsradius-geradeaus[0].y*strecken,
                    geradeaus[1].x*strecken+darstellungsradius,
                    darstellungsradius-geradeaus[1].y*strecken,
                    farben.aussenfarbe);
    end;
end;





{-----------------------------------------------------------------------------
  Description:  Zeichnet ein bmp und speichert es in eine Datei
  Procedure:    zeichnebmp
  Arguments:    filename:string
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnebmp(filename:string);
var zwischenspeicher:real;
    input:integer;
begin
  if not anderes.ADialog(input,'Bildgröße angeben','Gib hier die Kantenlänge des Bildes in Pixeln an',
          round(darstellungsradius),0,5000) then      exit;

  zwischenspeicher:=darstellungsradius;
  darstellungsradius:=input;

  if  (darstellungsradius=zwischenspeicher)and(eingabe.optio.Autoaktualisieren_aus) then
    begin

    end
  else
    begin
    bild.Width:=round(darstellungsradius)*2+2;
    bild.Height:=bild.Width  ;

    bild.Canvas.Brush.Color:=clwhite;
    bild.Canvas.FillRect(bild.Canvas.ClipRect);

    zeichne.kreiszeichnen;
    zeichne.kreuzzeichnen;
    zeichne.arzeichnen;
    end;

  if pos('.bmp',filename)>0 then bild.SaveToFile(filename) else bild.SaveToFile(filename+'.bmp');

  darstellungsradius:=zwischenspeicher;
end;




{-----------------------------------------------------------------------------
  Description:  Streckfaktor
  Procedure:    strecken
  Arguments:    None
  Result:       real
  Detailed description:
-----------------------------------------------------------------------------}
function TZeichne.strecken:real;
begin
  result:=(darstellungsradius/r);
end;




{-----------------------------------------------------------------------------
  Description:  darstellungs Radius machen
  Procedure:    drm
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.drm;
begin
  if schliessen then exit;

  if optio.Checkzoom.Checked then
    darstellungsradius:= (haupt.Height-150)/2
  else
    darstellungsradius:=200/9*optio.Zoombar.Position;
end;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    anfangspos
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.anfangspos;
begin
  drm;

  //damit er es am anfang in der startposition hat
  verschieben.pos.x:= haupt.Width-2*round(darstellungsradius)- bildpos.right ;
  verschieben.pos.y:= bildpos.top;

  haupt.aktuali(false,false,true,true,false);
end;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    verschiebepos
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
Procedure Tzeichne.verschiebepos;
begin
  with verschieben do
    begin
    if aktivieren then
      begin
      pos.x:=pos.x+diff.x;
      pos.y:=pos.y+diff.y ;
      diff.x:=0;
      diff.y:=0;
      aktivieren:=false;
      end;

  //  if GroesseVonFormx then pos.x:=0;
  //  if GroesseVonFormy then pos.y:=0;

    //hier das macht er damit das bild in die richtige position kommet wenn es überhauptnichtmehr auf der Form zu sehen ist.
    if (pos.x+round(darstellungsradius)*2+2  < 0 )
      or  (pos.x  > haupt.width )
      or  (pos.y+round(darstellungsradius)*2+2  < 0 )
      or  (pos.y  > haupt.height )
    then zeichne.anfangspos;
    end;
end;





{-----------------------------------------------------------------------------
  Description:  Dreht die Pfeilkoordinaten
  Procedure:    pfeildrehen
  Arguments:    dx,dy:real
  Result:       None
  Detailed description:
    Wichtig es wird mit
      pfeil.si:=sin(pfeil.alpha*pi/180);
      pfeil.co:=cos(pfeil.alpha*pi/180);
    gedreht. Wird in Pfeilzeichenen berechnet
-----------------------------------------------------------------------------}
procedure pfeildrehen(dx,dy:real);
begin
  pfeil.rueckgabekoordinaten.x:=  pfeil.bezugskoordinaten.x + ( dx * pfeil.co  -  dy * pfeil.si)
                                                                *zeichne.strecken*eingabe.optio.pfeilgroesse/40;
  pfeil.rueckgabekoordinaten.y:=  pfeil.bezugskoordinaten.y +  (dy * pfeil.co  +  dx * pfeil.si)
                                                                  *zeichne.strecken*eingabe.optio.pfeilgroesse/40;
end;




{-----------------------------------------------------------------------------
  Description:  Zeichnet einen Pfeil
  Procedure:    Pfeilzeichnen
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Pfeilzeichnen;
var spreizen,laenge:real;
    z1,z2,z3,z4:Tkoordinaten;
begin
  pfeil.si:=sin(pfeil.alpha*pi/180);
  pfeil.co:=cos(pfeil.alpha*pi/180);

  spreizen:=15;
  laenge:=30;

  //ansatzpunkt
  pfeildrehen(0,0);
  z1.x:=pfeil.rueckgabekoordinaten.x;
  z1.y:=pfeil.rueckgabekoordinaten.y;

  //speispitze
  pfeildrehen(pfeil.laenge,0);
  z2.x:=pfeil.rueckgabekoordinaten.x;
  z2.y:=pfeil.rueckgabekoordinaten.y;
  //obere spfeilhälfte
  pfeildrehen(pfeil.laenge-laenge,spreizen);
  z3.x:=pfeil.rueckgabekoordinaten.x;
  z3.y:=pfeil.rueckgabekoordinaten.y;
  //untere spfeilhälfte
  pfeildrehen(pfeil.laenge-laenge,-spreizen);
  z4.x:=pfeil.rueckgabekoordinaten.x;
  z4.y:=pfeil.rueckgabekoordinaten.y;

  //erst von der pfeilspitze zum ansatzpuntk
  zeichne.zeichnelinie(     z2.x,
                            z2.y,
                            z1.x,
                            z1.y,
                            bild.Canvas.Pen.Color   );
  //dann von der pfeilspitze zur oberen Pfeilhälfte
  zeichne.zeichnelinie(     z2.x,
                            z2.y,
                            z3.x,
                            z3.y,
                            bild.Canvas.Pen.Color   );
  //dann von der pfeilspitze zur unteren Pfeilhälfte
  zeichne.zeichnelinie(     z2.x,
                            z2.y,
                            z4.x,
                            z4.y,
                            bild.Canvas.Pen.Color   );
end;





{-----------------------------------------------------------------------------
  Description:  Zeichnet alle Pfeile
  Procedure:    zeichnePfeil
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
Procedure Tzeichne.zeichnePfeil;
var ausgangspunkt,v:Tkoordinaten;
begin
//anfangsbedingungen
  if not anderes.arraynichtleer then exit;

  ausgangspunkt.x:=punkte[lauf].x;
  ausgangspunkt.y:=punkte[lauf].y;

  pfeil.bezugskoordinaten.x:=haupt.bildx(ausgangspunkt.x);
  pfeil.bezugskoordinaten.y:=haupt.bildy(ausgangspunkt.y);

  //wichtig hier die unterschiedliche behandlung der beiden bezugssysteme
  if eingabe.optio.RadioButton7 then
    begin
    v.x:=k.geschwindigkeit.x ;
    v.y:=k.geschwindigkeit.y ;
    bild.Canvas.Pen.Color:=farben.aussenfarbe;
    end;
  if eingabe.optio.RadioButton8 then
    begin
    v.x:=-k.geschwindigkeit.relativ.x;
    v.y:=-k.geschwindigkeit.relativ.y;
    bild.Canvas.Pen.Color:=farben.spurfarbe;
    end;
  if eingabe.optio.RadioButton9 then
    begin
    v.x:=-k.geschwindigkeit.relativ.x*fr;
    v.y:=-k.geschwindigkeit.relativ.y*fr;
    bild.Canvas.Pen.Color:=farben.spurfarbe;
    end;

//x pfeil zeichnen
  pfeil.laenge:= abs(v.x/5)*strecken;

  if v.x  >=  0  then
    pfeil.alpha:=0
  else   pfeil.alpha:=180  ;

  pfeilzeichnen;

//y pfeil zeichnen
  if -v.y  >=  0  then
    pfeil.alpha:=90
  else   pfeil.alpha:=270  ;

  pfeil.laenge:= abs(v.y/5)*strecken;

  pfeilzeichnen;
end;






{-----------------------------------------------------------------------------
  Description:  Zeichnet eine einfache Linie
  Procedure:    zeichnelinie
  Arguments:    anfangx,anfangy,endex,endey:real;
                farbe:Tcolor
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnelinie(anfangx,anfangy,endex,endey:real;farbe:Tcolor);
var verschiebenx,verschiebeny:real;
begin
if not GroesseVonFormx then  verschiebenx:=0
else   verschiebenx:=verschieben.pos.x;

if not GroesseVonFormy then  verschiebeny:=0
else   verschiebeny:=verschieben.pos.y;


bild.Canvas.Pen.Color := farbe;
bild.Canvas.MoveTo(round(anfangx+verschiebenx),round(anfangy+verschiebeny));
bild.Canvas.LineTo(round(endex+verschiebenx),round(endey+verschiebeny));
end;




{-----------------------------------------------------------------------------
  Description:  Zeichnet einen Kreis
  Procedure:    zeichnekreis
  Arguments:    punknt1x,punknt1y,punknt2x,punknt2y:real;
                farbe:Tcolor
  Result:       None
  Detailed description: das sind alles die overload kreiszeichne routinen
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnekreis(punknt1x,punknt1y,punknt2x,punknt2y:real;farbe:Tcolor);
var verschiebenx,verschiebeny:real;
begin
  if not GroesseVonFormx then  verschiebenx:=0
  else   verschiebenx:=verschieben.pos.x;

  if not GroesseVonFormy then  verschiebeny:=0
  else   verschiebeny:=verschieben.pos.y;
  bild.Canvas.Pen.Color:=farbe;
  bild.Canvas.Brush.Style:=bsclear;

  {zeichnepixel(
              ((round(punknt2x-punknt1x)div 2)+punknt1x)*strecken+darstellungsradius,
              -((round(punknt2y-punknt1y)div 2)+punknt1y)*strecken+darstellungsradius
              ,farbe);}
  bild.Canvas.Ellipse(round(punknt1x*strecken+darstellungsradius+verschiebenx),
                       round(punknt1y*strecken+darstellungsradius+verschiebeny),
                       round(punknt2x*strecken+darstellungsradius+verschiebenx),
                       round(punknt2y*strecken+darstellungsradius+verschiebeny)           );
end;
{-----------------------------------------------------------------------------
  Arguments:    punkt1,punkt2:Tpoint;
                farbe:Tcolor
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnekreis(punkt1,punkt2:Tpoint;farbe:Tcolor);
begin
  zeichne.zeichnekreis(punkt1.x,punkt1.y,punkt2.x,punkt2.y,farbe);
end;
{-----------------------------------------------------------------------------
  Arguments:    Punkt:Trect;
                farbe:Tcolor
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnekreis(Punkt:Trect;farbe:Tcolor);
begin
  zeichne.zeichnekreis(punkt.Left,punkt.Top,punkt.Right,punkt.Bottom,farbe);
end;
{-----------------------------------------------------------------------------
  Arguments:    mitte:Tpoint;
                radius:real;
                farbe:Tcolor
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnekreis(mitte:Tpoint;radius:real;farbe:Tcolor);
begin
  zeichne.zeichnekreis((-radius+mitte.x),-(radius+mitte.y),(radius+mitte.x),(radius-mitte.y),farbe);
end;
{-----------------------------------------------------------------------------
  Arguments:    x,y,
                radius:real;
                farbe:Tcolor
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnekreis(x,y,radius:real;farbe:Tcolor);
begin
  zeichne.zeichnekreis((-radius+x),-(radius+y),(radius+x),(radius-y),farbe);
end;





{-----------------------------------------------------------------------------
  Procedure:    zeichnepixel
  Arguments:    x,y:real;
                farbe:Tcolor
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tzeichne.zeichnepixel(x,y:real;farbe:Tcolor);
var verschiebenx,verschiebeny:real;
begin
  if not GroesseVonFormx then  verschiebenx:=0
  else   verschiebenx:=verschieben.pos.x;

  if not GroesseVonFormy then  verschiebeny:=0
  else   verschiebeny:=verschieben.pos.y;

  bild.Canvas.Pixels[round(x+verschiebenx),round(y+verschiebeny)]:=farbe;
end;




end.
