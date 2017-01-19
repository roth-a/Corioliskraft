{-----------------------------------------------------------------------------
 Unit Name: berechnung
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
 Description:
-----------------------------------------------------------------------------}
unit berechnung;


interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, Shellapi, Gauges,
    math, ExtCtrls, StdCtrls, ComCtrls, Menus,z;

type Trech=class
  private
  function deltatbeginn:real;
  function deltat:real;
  procedure schreibeinfofenster;
    { Private-Deklarationen }
  public
  procedure zufallswerte;
  procedure Zufallskurven;
  procedure saas(inrichtung:boolean);  //Spur an Anfang  setzten
  procedure drehen;
  function rausgefallen(radius:real):boolean;
    { Public-Deklarationen }
  end;


const
        nh :integer = 554;    //normal height
        nw:integer = 728;     //normal  width

type   tpunkte=record
         x,y:real;
       end;

const dtmax:real=1/1000;



var  Rech:Trech;

    stop,abgebrochen : boolean;
    koor : record x,y : real;end;
    // hier das sind die hauptsächlich für drehen genutzt
    winkelgeschwindigkeit,mentfernung,radius,blauweg,rotweg,weg,
    Dt,alldt ,  r  ,fr :real;     //fr = Reibungsfaktor
    k:record
      geschwindigkeit:record
        x,y,geschwindigkeit: real;
        realtivgeschwindigkeit:real;
        relativ:z.TKoordinaten;
        end;
      Dx,dy:real;
      schreiben:z.TKoordinaten;
      auftreffen:z.TKoordinaten;
    end;
    rrechts,pause:boolean; //richtungRechts
    punkte,geradeaus :array of tpunkte;
    startzeitgesamt:longint;

implementation
uses unit1,Unit2, Unit4, Unit5,text,Uanderes;




{-----------------------------------------------------------------------------
  Description:  Berechnet dt währen des Drehens
  Procedure:    deltat
  Arguments:    None
  Result:       real
  Detailed description:
-----------------------------------------------------------------------------}
function Trech.deltat:real;
var s:real;
begin
  s:=1/
      haupt.pythagoras((k.geschwindigkeit.relativ.x)*dt,(k.geschwindigkeit.relativ.y)*dt )
      /10000;

  result:=dt+(s-dt)*10/100;

  if result>dtmax then result:=dtmax;
end;



{-----------------------------------------------------------------------------
  Description:  Berechnet dt am Anfang
  Procedure:    deltatbeginn
  Arguments:    None
  Result:       real
  Detailed description:
-----------------------------------------------------------------------------}
function TRech.deltatbeginn:real;         //die betrachtungsdifferenz zwischen den berechnungen
begin
alldt:=0;
  if  eingabe.haupt.kugelgeschwindigkeit<>0 then
      result:=sqrt(eingabe.haupt.umlaufdauer)/power(abs(eingabe.haupt.kugelgeschwindigkeit),0.3)/500
  else
      result:=sqrt(eingabe.haupt.umlaufdauer)/power(0.1,0.3)/500            ;
  result:=result/2;
end;






{-----------------------------------------------------------------------------
  Description:  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen  Drehen
  Procedure:    drehen
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TRech.drehen;
var
  j,tempint:integer;
  neux,neuy:real;
  c,s:real;
begin
  //alls ganz erstes
  if (haupt.pythagoras(eingabe.haupt.x,eingabe.haupt.y )>eingabe.haupt.scheibenradius+1) then
    begin
    showmessage('Die Kugel befindet sich außerhalb der Scheibe. '+chr(13)+'Bitte ändern Sie die Koordinaten!'+chr(13)+'Bitte drücken Sie gleich ESC.');
    exit;
    end;



  click:=false;

  haupt.aktuali(true,true,false,true,false);

  stop:=false; abgebrochen:=false;
  if not eingabe.haupt.reibungein then  fr:=0   else   fr:=eingabe.haupt.reibungsfaktor;
  saas(true);
  k.geschwindigkeit.geschwindigkeit := haupt.cmtopixel(eingabe.haupt.kugelgeschwindigkeit);     {400 pix/45 cm = x pix /1 cm                                                                 x = 400/0,45
                                                                            x=400/45     }
  winkelgeschwindigkeit:=2*pi/eingabe.haupt.umlaufdauer;   //brauch hier keine fallunterscheidung weil umlaufdauer immer umlaufdauer ist

  //hier wird die ini-Log datei geschrieben
  if optio.CheckBoxLog2.Checked then txt.schreibeLaufIni;
  //hier wird die 10 ini-Log datei geschrieben
  if optio.CheckBoxLog3.Checked then txt.schreibe10Ini;

  //hier hab ich aufpassen müssen ob ich nicht etwas überschriebe oder unnütz weil es nachher noch geschrieben wird
  neux:=0; neuy :=0;
  startzeitgesamt:=gettickcount;
  anderes.arrayloeschen; //hier wird das Array alles gelöscht
  setlength(punkte,1000);
  setlength(geradeaus,1000);
  lauf:=-1;
  mentfernung:=10000000;
  haupt.Gauge1.Progress:=0;
  blauweg:=0; rotweg:=0;

  koor.x:= -r; koor.y:=0;
  punkte[0].x:= k.auftreffen.x;     //beide werte sind im koordinatensystem und damit relativ
  punkte[0].y:= k.auftreffen.y;
  k.schreiben.x:= punkte[0].x;
  k.schreiben.y:= punkte[0].y;
  if not eingabe.haupt.reibungein then        //checkbox3 ist die reibung
    begin
    geradeaus[0].x:= punkte[0].x;
    geradeaus[0].y:= punkte[0].y;
    geradeaus[1].x:= punkte[0].x;
    geradeaus[1].y:= punkte[0].y;
    end;
  saas(true);
  k.geschwindigkeit.x:=  k.geschwindigkeit.geschwindigkeit*cos(eingabe.haupt.winkel *pi/180);
  k.geschwindigkeit.y:=  k.geschwindigkeit.geschwindigkeit*sin(eingabe.haupt.winkel*pi/180);

  radius:=haupt.pythagoras(punkte[0].x,punkte[0].y);

  haupt.wdrss(true);

  dt:=deltatbeginn;

  //beginn der Schleife
  while (not rausgefallen(radius))and (not stop)and(not abgebrochen)and anderes.arraynichtleer do
    begin
    inc(lauf);

    if lauf mod 1000 = 0 then
      begin
      setlength(punkte,lauf+1000);
      if eingabe.haupt.reibungein then setlength(geradeaus,lauf+1000);
      end;

    //hier beschriftet er die status bar  und danach das infofenster
  //  if lauf>=2 then rotweg:=rotweg+haupt.pythagoras(punkte[lauf-2].x-punkte[lauf-1].x,punkte[lauf-2].y-punkte[lauf-1].y);//hier subtrahiere ich die jeweiligen Punkte und erhalte die Phythagorasstrecke  ||||| Rotweg ist in Pixeln

    //hier schreibt er den Radius für die Schleifenabfrage in die Variable
    radius:=sqrt(sqr(k.schreiben.x+k.Dx)+sqr(k.schreiben.y+k.dy));

  //die neuen Koordinaten für das Kreuz berechnen
    c:=cos(winkelgeschwindigkeit*Dt);
    s:=sin(winkelgeschwindigkeit*Dt);
    neux:=  koor.x*c   + anderes.boolsign(rrechts) *koor.y*s;
    neuy:=  koor.y*c   - anderes.boolsign(rrechts) *koor.x*s;
    koor.x:=neux;
    koor.y:=neuy;


    //klar: dt(delta t (zeit)) * geschwindigkeit = strecke
    //hier werden die Relativen Geschwindigkeiten in die Variablen geschrieben
    k.geschwindigkeit.relativ.x:= (k.geschwindigkeit.x   - anderes.boolsign(rrechts) *k.schreiben.y*winkelgeschwindigkeit);
    k.geschwindigkeit.relativ.y:= (k.geschwindigkeit.y   + anderes.boolsign(rrechts) *k.schreiben.x*winkelgeschwindigkeit);

    k.geschwindigkeit.realtivgeschwindigkeit:=haupt.pythagoras(k.geschwindigkeit.relativ.x,k.geschwindigkeit.relativ.y);
  // hier wird die Geschwindigkeit um einen Bestmmten betrag veringert.
    k.geschwindigkeit.x:=k.geschwindigkeit.x  -  k.geschwindigkeit.relativ.x*fr*dt;
    k.geschwindigkeit.y:=k.geschwindigkeit.y  -  k.geschwindigkeit.relativ.y*fr*dt;

    k.geschwindigkeit.geschwindigkeit:=sqrt(sqr(k.geschwindigkeit.x)+sqr(k.geschwindigkeit.y));
    k.Dx:=Dt*k.geschwindigkeit.x;
    k.Dy:=Dt*k.geschwindigkeit.y;

    //neuen Punkt zeichnen und lauf erhöhen
    k.schreiben.x:= k.schreiben.x + k.Dx;  //erhöht um die jeweiligen weg
    k.schreiben.y:= k.schreiben.y + k.dy;
    punkte[lauf].x:=  k.schreiben.x;
    punkte[lauf].y:=  k.schreiben.y;
    blauweg:=blauweg+sqrt(sqr(k.Dx)+sqr(k.dy));

      //hier das muss über die drehung der anderen, damit die Kurven nicht verfälscht sind     ; doch die zeichnung sollte direkt dhinter geschiehen
    if eingabe.haupt.reibungein then tempint:=lauf  else tempint:=1;
    geradeaus[tempint].x:=punkte[lauf].x;
    geradeaus[tempint].y:=punkte[lauf].y;


    application.ProcessMessages;
    if stop then break;
  //jetzt zeichnet er sie; diese Abrage ist nötig damit er nicht jedes mal zeichnet sondern nur beim ~~20 mal
    if  (eingabe.optio.Schieberegler =0)
        or (lauf mod round(power(eingabe.optio.Schieberegler,2)) =0)
           then
      begin
      if eingabe.optio.Schieberegler =0 then sleep(20);
      zeichne.canvaszeichnen;
      schreibeinfofenster;
      end;

      //das berechne ich hier damit es nicht immer wiederholt gerrechnet werden muss;         ausserdemn macht es das übersichtlich
    c:=cos(winkelgeschwindigkeit*Dt);
    s:=sin(winkelgeschwindigkeit*Dt);
    //hier beginnt er die Punkte zu drehen und zu zeichnen
    for j := 0 to lauf do
      begin
      //hier dreht er die Punkte in eine Bestimmte Richtung
      neux := punkte[j].x*c  + anderes.boolsign(rrechts) *punkte[j].y*s;
      neuy := punkte[j].y*c  - anderes.boolsign(rrechts) *punkte[j].x*s;
      punkte[j].x:=neux;
      punkte[j].y:=neuy;
      end;

    if optio.CheckBoxLog1.Checked then Txt.schreibelog;

    alldt:=alldt+dt;
    dt:=deltat;
    end;
  {ende der Schleife
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

  //fier das führt er erst aus wenn alle Punkte schon berechnet sind
  if (optio.zurueckdrehen.Checked)and(not stop)and (not abgebrochen) then
    begin
    j:=0;
    sleep(300);
    c:=cos(winkelgeschwindigkeit*allDt);
    s:=sin(winkelgeschwindigkeit*allDt);
    while (j<lauf) do
      begin
  //zurückdrehen von der spur
      neux := punkte[j].x*c   - anderes.boolsign(rrechts) *punkte[j].y*s;
      neuy := punkte[j].y*c   + anderes.boolsign(rrechts) *punkte[j].x*s;
      punkte[j].x:=neux;
      punkte[j].y:=neuy;
      inc(j);
      end;

    haupt.mrs;
    end;


  zeichne.canvaszeichnen;
  schreibeinfofenster;

  haupt.Gauge1.Progress:=100;
  info.Label124.Caption:=inttostr(anderes.berechnungsdauer)+' ms';
  haupt.wdrss(false);
  stop:=true;
end;






{-----------------------------------------------------------------------------
  Description:  Schreibt info und Taskleiste
  Procedure:    schreibeinfofenster
  Detailed description:
-----------------------------------------------------------------------------}
procedure TRech.schreibeinfofenster;
var tempi:integer;
begin
  if lauf = 0 then
    begin
    //hier beschriftet er das infofenster aber nur die konstanten werte
    info.Label101.Caption:=floattostr(eingabe.haupt.kugelgeschwindigkeit)+' cm/s';
    info.Label103.Caption:=floattostr(roundto(2*pi/winkelgeschwindigkeit,-2))+' s';
    info.Label104.Caption:=floattostr(roundto(winkelgeschwindigkeit,-2))+' 1/s';
    info.Label107.Caption:=floattostr(eingabe.haupt.winkel)+'°';
    info.Label106.Caption:=floattostr(fr);
    info.Label109.Caption:=floattostr(roundto(haupt.pixeltocm(eingabe.haupt.scheibenradius),-2))+' cm';
    if rrechts then  info.Label108.Caption:='Im Uhrzeigersinn' else info.Label108.Caption:='Gegen den Uhrzeigersinn';
    info.Label112.Caption:=floattostr(roundto(haupt.pixeltocm(eingabe.haupt.x),-1))+' cm';
    info.Gauge112.Progress:=round(eingabe.haupt.x/eingabe.haupt.scheibenradius*50)+50;
    info.Label113.Caption:=floattostr(roundto(haupt.pixeltocm(eingabe.haupt.y),-1))+' cm';
    info.Gauge113.Progress:=round(eingabe.haupt.y/eingabe.haupt.scheibenradius*50)+50;
    info.Label110.Caption:=floattostr(eingabe.optio.berechnungspausen)+' ms';
    if optio.CheckBoxLog2.Checked then info.Label123.Caption:=inibuchstabe+inttostr(laufins-1)+'.ini' //hier muss minus 1 hin weil laufins vor dem infofenster schon erhöht wird
      else info.Label123.Caption:='keine Protokollierung';
    end;

  info.Label121.Caption:= floattostr(roundto(dt*1000,-3))+' ms';
  info.Gauge121.Progress:=round(dt/dtmax*100);
  info.Label125.Caption:=inttostr(eingabe.optio.Schieberegler);
  info.Gauge125.Progress:=round(eingabe.optio.Schieberegler/optio.Schieberegler.Max*100);

  //jetzt kommen die variablen
  haupt.StatusBar1.Panels[4].Text:='Umdrehungen = '+floattostr(roundto(  winkelgeschwindigkeit*alldt/2/pi   ,-2));
  haupt.StatusBar1.Panels[5].Text:='A. Gesch. der Kugel= '+floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.geschwindigkeit),-1))+' cm/s';

  info.Label102.Caption:=floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.geschwindigkeit),-1))+' cm/s';
  info.Label105.Caption:=floattostr(roundto(  winkelgeschwindigkeit*alldt/2/pi   ,-2));
  info.Gauge105.Progress:=round(winkelgeschwindigkeit*alldt/2/pi*100) mod 100;
  if lauf=0 then
    begin
    info.Label114.Caption:=floattostr(roundto(haupt.pixeltocm(k.schreiben.x),-1))+' cm';
    info.Label115.Caption:=floattostr(roundto(haupt.pixeltocm(k.schreiben.y),-1))+' cm';
    end
  else
    begin
    if anderes.arraynichtleer then
      begin
      info.Label114.Caption:=floattostr(roundto(haupt.pixeltocm(punkte[lauf-1].x),-1))+' cm';
      info.Gauge114.Progress:=round(punkte[lauf-1].x/eingabe.haupt.scheibenradius*50)+50;
      info.Label115.Caption:=floattostr(roundto(haupt.pixeltocm(punkte[lauf-1].y),-1))+' cm';
      info.Gauge115.Progress:=round(punkte[lauf-1].y/eingabe.haupt.scheibenradius*50)+50;
      end;
    end;
  info.Label116.Caption:=floattostr(roundto(haupt.pixeltocm(mentfernung),-1))+' cm';
  info.Gauge116.Progress:=round(mentfernung/eingabe.haupt.scheibenradius*100);
  info.Label117.Caption:=floattostr(roundto(haupt.pixeltocm(radius),-1))+' cm';
  info.Gauge117.Progress:=round(radius/eingabe.haupt.scheibenradius*100);
  if eingabe.haupt.reibungein then  tempi:=lauf*2 else tempi:= lauf+2;
  info.Label120.Caption:=inttostr(tempi) ;
  info.Gauge120.Progress:=round(tempi/200);    //das ist so weil lauf/20000  *100
  info.Label124.Caption:=floattostr(roundto(anderes.berechnungsdauer/1000,-2))+' s';

  // hier schaut er ob das Klickkästchen auch angekreuzt ist und die Enfernung auch ncht größer ist als die vorherige.
  if (radius<mentfernung)then
    begin
    mentfernung:=radius;
    haupt.StatusBar1.Panels[3].Text:='Minimalentfernung: '+floattostr(roundto(mentfernung/888.889*100,-1))+' cm';
    end;

  //hier macht er die prozente mit der gauge
  if (not eingabe.haupt.reibungein)or ((haupt.Gauge1.Progress<95)and(eingabe.haupt.reibungein))
  then haupt.Gauge1.Progress:=round(k.geschwindigkeit.geschwindigkeit*alldt*100/weg);

  info.Label35.Caption:=floattostr(roundto(haupt.pixeltocm( k.geschwindigkeit.realtivgeschwindigkeit  ),-1));
  info.Label22.Caption:=floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.relativ.x),-1))+' cm/s';
  info.Label27.Caption:=floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.relativ.y),-1))+' cm/s';
  info.Label30.Caption:= floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.x),-1))+' cm/s';
  info.Label32.Caption:= floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.y),-1))+' cm/s';

  info.Label37.Caption:= floattostr(roundto(haupt.pixeltocm( k.geschwindigkeit.realtivgeschwindigkeit*dt  )*10,-4))+' mm';
  info.Label39.Caption:= floattostr(roundto(haupt.pixeltocm( k.geschwindigkeit.geschwindigkeit *dt  )*10,-4))+' mm';

  if eingabe.haupt.kugelgeschwindigkeit<>0 then
    begin
    info.label130.Caption:=inttostr(round(
            (eingabe.haupt.kugelgeschwindigkeit-haupt.pixeltocm(k.geschwindigkeit.geschwindigkeit))
            /eingabe.haupt.kugelgeschwindigkeit*100))+'%';
    info.gauge130.Progress:=abs(100-round(
            (eingabe.haupt.kugelgeschwindigkeit-haupt.pixeltocm(k.geschwindigkeit.geschwindigkeit))
            /eingabe.haupt.kugelgeschwindigkeit*100));
    end
  else
    begin
    info.label130.Caption:='-unendlich';
    info.gauge130.Progress:=0;
    end;


  info.Labelfps.Caption:= floattostr(roundto(fps,-2));
  info.Labelberechprosek.Caption:=floattostr(roundto(  lauf/anderes.berechnungsdauer*1000  ,-2 ));
  info.Labelberechprobild.Caption:=floattostr(roundto(  lauf/(fps*anderes.berechnungsdauer/1000) ,-2  ));
end;




{-----------------------------------------------------------------------------
  Description:  Spur an Anfang  setzten
  Procedure:    saas
  Arguments:    inrichtung:boolean
  Result:       None
  Detailed description:
      Setzt die Kugel entgegengesetzt der Richtung an den Rand
-----------------------------------------------------------------------------}
procedure TRech.saas(inrichtung:boolean);
var x,y,px1,py1:real;
begin
  //hier wird das x,y für inrichtung berechnet
  x:=500/r*cos(eingabe.haupt.winkel*pi/180);
  y:=500/r*sin(eingabe.haupt.winkel*pi/180);
  //wenn allerdings not inrichtung ist dann wird das negativiert
  if not inrichtung then    begin    x:=-x;    y:=-y;    end;
    weg:=0;
    px1:=k.auftreffen.x;
    py1:=k.auftreffen.y;
  while(sqrt(sqr(px1)+sqr(py1))<=r-sqrt(sqr(x)+sqr(y)))and(not inrichtung)
    or (sqrt(sqr(px1)+sqr(py1))<=r+0.3)and(inrichtung) do
    begin
    weg:=weg+sqrt(sqr(x)+sqr(y));
    px1:=px1+x;
    py1:=py1+y;
    end;

  if not inrichtung then
    begin
    haupt.EAuftreffenx.Text:=floattostr(roundto(haupt.pixeltocm(px1),-1));
    haupt.EAuftreffeny.Text:=floattostr(roundto(haupt.pixeltocm(py1),-1));
    k.auftreffen.x:= px1;
    k.auftreffen.y:= py1;
    end
  else
    if (eingabe.haupt.reibungein)and(eingabe.haupt.reibungsfaktor>=1)   //hier mache ich noch die Bedingung mit dem >=1 hinzu weil sonst der weg sehr verkürzt würde wäre die reibung 0,1
      then weg:=weg*eingabe.haupt.reibungsfaktor;
end;




{-----------------------------------------------------------------------------
  Description:  Prüft ob die Kugel rausgefallen ist
  Procedure:    rausgefallen
  Arguments:    radius:real
  Result:       boolean
  Detailed description:
-----------------------------------------------------------------------------}
function TRech.rausgefallen(radius:real):boolean;
begin
  result:= not (radius-1<=R);
end;




{-----------------------------------------------------------------------------
  Description:  Endlosschleife um Zufallskurven zu berechnen
  Procedure:    Zufallskurven
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TRech.Zufallskurven;
begin
  stop := false; abgebrochen:=false;
  //haupt.leseini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
  //das heißt wenn abgebrochen =false and stop=false
  while (not abgebrochen)and(not stop) do
    begin
    click:=false;
    zufallswerte;
    //ausführen der Kurvenberechnung
    Rech.drehen;
    if not abgebrochen then stop:=false;
    //else stop := true ist nicht nötig da stop automatisch nach drehen true ist und nch stop ja auch
    //warte die jeweiligen Millisekunden die in optio.edit7 stehen
    if not stop then anderes.Delay(round(eingabe.optio.berechnungspausen));
    end;
  stop:=true;   abgebrochen:=true;
end;





{-----------------------------------------------------------------------------
  Description:  Berechnet zufällige Werte und schreibt sie in die Felder
  Procedure:    zufallswerte
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TRech.zufallswerte;
var x,y:real;
begin
  x:=0;
  y:=0;
  if optio.CheckBox20.Checked then haupt.EGeschwindigkeit.Text := floattostr(randomrange(50,4000)/10);
  if optio.CheckBox21.Checked then  haupt.EWinkel.Text := floattostr(randomrange(0,359));
  if optio.CheckBox22.Checked then
    begin
      if optio.RadioButton5.Checked then
        begin
        x:= randomrange(round(r/sqrt(2)),round(-r/sqrt(2)));
        y:= randomrange(round(r/sqrt(2)),round(-r/sqrt(2)));
       end;
      if optio.RadioButton6.Checked then
        begin
        x:= 0;
        y:= 0;
        end;
    haupt.EAuftreffenx.text:=floattostr(roundto(haupt.pixeltocm(x),-1));
    haupt.EAuftreffeny.text:=floattostr(roundto(haupt.pixeltocm(y),-1));
    k.auftreffen.x:=x;
    k.auftreffen.y:=y;
    end;
  if optio.CheckBox23.Checked then
    if optio.RadioButton3.Checked then haupt.EUmlaufdauer.Text := floattostr(randomrange(5,400)/100)
                                  else haupt.EUmlaufdauer.Text := floattostr(roundto(2*pi/randomrange(5,400)*100,-2));

  if optio.CheckBox25.Checked then
        begin
        haupt.CheckReibungsfaktor.Checked:=true;
        haupt.EReibung.Text := floattostr(randomrange(1,20)/10);
        end;
  rrechts:=   (optio.CheckBox26.Checked) and(random>0.5)   ;
  //  if (optio.CheckBox11.Checked)and (random>0.5) then optio.zurueckdrehen.Checked:=true else optio.zurueckdrehen.Checked:=false;
  if  optio.CheckBox12.Checked then    rech.saas(false);    //Spur an anfang setzten
  haupt.mrs;
end;






end.


