{-----------------------------------------------------------------------------
 Unit Name: text
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
 Description:  Kann Operationen an Text und INI Dateien durchführen
-----------------------------------------------------------------------------}

unit text;


interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, Shellapi, Gauges,
    math, ExtCtrls, StdCtrls, ComCtrls, Menus;

type TTxt=class
  private
    { Private-Deklarationen }
  function RenameFileEx(const AOldName, ANewName: string;
                          ARenameCheck: boolean = false): boolean;
  public
  procedure schreibelog;
  procedure schreibeini(pfad:string);
  procedure schreibeLaufIni;
  procedure schreibe10Ini;
  procedure leseini(pfad:string);
  procedure intxtschreiben(pfad,text:string;  vorherloschen:boolean=true);

    { Public-Deklarationen }
  end;


var  txt:TTxt;


  // für die Einstellungen rein zu speichern
  ini:tinifile;
  lauf,laufins:integer;  //laufins=laufinsgesamt genutzt für die log ini
  inibuchstabe:string;

implementation
uses unit1,Unit2, Unit4, Unit5,z,berechnung,Uanderes;




{-----------------------------------------------------------------------------
  Description:  Umbenennen von Dateien
  Procedure:    RenameFileEx
  Arguments:    const AOldName, ANewName: string; ARenameCheck: boolean = false
  Result:       boolean
  Detailed description:
-----------------------------------------------------------------------------}
function Ttxt.RenameFileEx(const AOldName, ANewName: string;   ARenameCheck: boolean = false): boolean;
var
  sh: TSHFileOpStruct;
begin
  sh.Wnd := Application.Handle;
  sh.wFunc := fo_Move;

  // String muss mit #0#0 Terminiert werden, um das Listenende zu setzen
  sh.pFrom := PChar(AOldName + #0);
  sh.pTo := PChar(ANewName + #0);
  sh.fFlags := fof_Silent or fof_MultiDestFiles;
  if ARenameCheck then
    sh.fFlags := sh.fFlags or fof_RenameOnCollision;
  Result:=ShFileOperation(sh)=0;
end;





{-----------------------------------------------------------------------------
  Description:
  Procedure:    intxtschreiben
  Arguments:    pfad,text:string; vorherloschen:boolean=true
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TTxt.intxtschreiben(pfad,text:string;  vorherloschen:boolean=true);
var txt:textfile;
begin
  try
    assignfile(txt,pfad);
    if (fileexists(pfad))and(not vorherloschen) then
      append(txt)
    else
      rewrite(txt);
    writeln(txt,text);
    closefile(txt);
  except
    showmessage('Es konnte keine Datei erstellt werden!'+chr(13)+
          'Falls Sie Corioliskraft von CD Starten kopieren Sie bitte die Corioliskraft.exe auf ihre Festplatte und starten Sie erneut!');
  end;
end;




{-----------------------------------------------------------------------------
  Description:  Schreibt eine Log Datei
  Procedure:    schreibelog
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TTxt.schreibelog;
var s:string;
    i:integer;
    b:boolean;
begin
  try
    //bei forcedirectories muss man nicht überprüfen ob sie schon existiert weil er das automatisch macht
    ForceDirectories(ExtractFilePath(Application.ExeName)+'Log-Dateien\');
    //erstmal die Konstanten werte
    if lauf=0 then
      begin
      //hier werden die konstanten beschriftungen in die variablen txt geschrieben
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Kugelgeschwindigkeit.txt','Verlauf der Kugelgeschwindigkeit in cm/s',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Umläufe der Platte.txt','Welchen Teil eines Umlaufes hatte die Platte zu den Zeitpunkten',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Abstand Kugel-Drehachse.txt','Abstand Kugel-Drehachse in cm',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'x Kugelkoordinaten der blauen Spur.txt','Aufzeichnung der x Koorinaten der blauen Spur bei jedem delta t in cm',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'y Kugelkoordinaten der baluen Spur.txt','Aufzeichnung der y Koorinaten der blauen Spur bei jedem delta t in cm',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'x koordinaten der roten Spur.txt','Aufzeichnung der x Koorinaten der roten Spur bei jedem delta t in cm',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'y koordinaten der roten Spur.txt','Aufzeichnung der y Koorinaten der roten Spur bei jedem delta t in cm',true);
      intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Gespeicherte Punkte.txt','Anzahl der gespeicherte Punkte',true);

      b:=true;
      for i:=0 to 13 do
        begin
          case i of
          0:s:='Konstante Werte:';
          1:begin
            s:='';
            b:=false;
            end;
          2:s:='Anfangsgeschwindigkeit der Kugel= '+floattostr(eingabe.haupt.kugelgeschwindigkeit)+' cm/s';
          3:s:='Umlaufdauer= '+floattostr(roundto(2*pi/winkelgeschwindigkeit,-3))+' s';
          4:s:='Winkelgeschwindigkeit= '+floattostr(roundto(winkelgeschwindigkeit,-3))+' 1/s';
          5:s:='Anfangsinkel= '+floattostr(eingabe.haupt.winkel)+'°';
          6:s:='Scheibenradius= '+floattostr(eingabe.haupt.scheibenradius)+' cm';
          7:  if (eingabe.haupt.reibungein) then
                 s:='Reibungsfaktor= '+floattostr(eingabe.haupt.reibungsfaktor)
              else  s:='Reibungsfaktor= 0';
          8:if rrechts then  s:='Die Drehrichtung ist im Uhrzeigersinn' else s:='Die Drehrichtung ist gegen den Uhrzeigersinn';
          9:s:='x Auftreffkoordinaten= '+floattostr(eingabe.haupt.x)+' cm';
          10:s:='y Auftreffkoordinaten= '+floattostr(eingabe.haupt.y)+' cm';
          11:s:='Wartezeit zwischen Zufallskurven= '+floattostr(eingabe.optio.berechnungspausen)+' ms';
          12:s:='Bildfrequenzanzeige= '+inttostr(eingabe.optio.Schieberegler);
          13:s:='Delta t= '+floattostr(roundto(dt,-6));
          end;
        intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Konstante Werte.txt',s,b);
        end;
      end;

    //hier schriebt er alle variablen werte
    intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Kugelgeschwindigkeit.txt',floattostr(roundto(haupt.pixeltocm(k.geschwindigkeit.geschwindigkeit),-3)),false);
    intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Umläufe der Platte.txt',floattostr(roundto(winkelgeschwindigkeit*alldt/2/pi   ,-5)),false);
    intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Abstand Kugel-Drehachse.txt',floattostr(roundto(haupt.pixeltocm(radius),-3)),false);
    intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'x Kugelkoordinaten der blauen Spur.txt',floattostr(roundto(haupt.pixeltocm(k.schreiben.x),-3)),false);
    intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'y Kugelkoordinaten der baluen Spur.txt',floattostr(roundto(haupt.pixeltocm(k.schreiben.y),-3)),false);
    intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'Gespeicherte Punkte.txt',inttostr(lauf),false);

    if rech.rausgefallen(radius)and anderes.arraynichtleer then
      for i := 0 to lauf do
        begin
        intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'x koordinaten der roten Spur.txt',floattostr(roundto(haupt.pixeltocm(punkte[i].x),-3)),false);
        intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'y koordinaten der roten Spur.txt',floattostr(roundto(haupt.pixeltocm(punkte[i].y),-3)),false);
        end;
    if ((stop)or(abgebrochen))and anderes.arraynichtleer then
      for i := 0 to lauf do
        begin
        intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'x koordinaten der roten Spur.txt',floattostr(roundto(haupt.pixeltocm(punkte[i].x),-3)),false);
        intxtschreiben(ExtractFilePath(Application.ExeName)+'Log-Dateien\'+'y koordinaten der roten Spur.txt',floattostr(roundto(haupt.pixeltocm(punkte[i].y),-3)),false);
        end;

  except
    showmessage('Es konnte keine Log-Datei erstellt werden!'+chr(13)+
          'Falls Sie Corioliskraft von CD Starten kopieren Sie bitte die Corioliskraft.exe auf ihre Festplatte und starten Sie erneut!');
  end;
end;




{-----------------------------------------------------------------------------
  Description:  Schreibt in eine  INI
  Procedure:    schreibeini
  Arguments:    pfad:string
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TTxt.schreibeini(pfad:string);
begin
  try
  //hier schreibt er alle Einstellungen in die Ini Datei,
  // egal ob die Datei vorher schon Existiert hat, es wird einfach überschrieben
  //hier in der ersten zeile wird die Ini datei mit create kreiert
    ini:=tinifile.Create(pfad);

    //haupt
  // die sieht so aus "Am Ende zurückdrehen=1"
    ini.WriteBool('Bildschirmoptionen',optio.zurueckdrehen.Caption,optio.zurueckdrehen.Checked);
    ini.WriteBool('Bildschirmoptionen',haupt.CheckReibungsfaktor.Caption,haupt.CheckReibungsfaktor.Checked);
    ini.Writefloat('Bildschirmoptionen','verschieben.pos.x',verschieben.pos.x);
    ini.Writefloat('Bildschirmoptionen','verschieben.pos.y',verschieben.pos.y);
    ini.Writebool('Bildschirmoptionen',optio.Autopos.Caption,optio.Autopos.Checked);

  {nun werden die Zahlen aus den Editen über Strings reingeschriben
   ich nehmen writesting und nicht writefloat da ich sonst sie erst umformen müsste
   beim auslesen mache ich es auch mit strings}
    ini.Writefloat('Zahlen','eingabe.haupt.kugelgeschwindigkeit',eingabe.haupt.kugelgeschwindigkeit);
    ini.Writefloat('Zahlen','eingabe.haupt.winkel',eingabe.haupt.winkel);
    ini.Writefloat('Zahlen','eingabe.haupt.x',haupt.pixeltocm(eingabe.haupt.x));
    ini.Writefloat('Zahlen','eingabe.haupt.y',haupt.pixeltocm(eingabe.haupt.y));
    ini.Writefloat('Zahlen','eingabe.haupt.umlaufdauer',eingabe.haupt.umlaufdauer);// Das schreibe ich nochmals nach dem der radiobutton3  4  gemacht ist damit nicht nochmals umgerechnet wird
    ini.Writefloat('Zahlen','eingabe.haupt.reibungsfaktor',eingabe.haupt.reibungsfaktor);
    ini.Writefloat('Zahlen','eingabe.haupt.scheibenradius',eingabe.haupt.scheibenradius);
    //variablen
    ini.writefloat('Zahlen','k.geschwindigkeit.geschwindigkeit',k.geschwindigkeit.geschwindigkeit);
    ini.writefloat('Zahlen','k.Dx',k.Dx);
    ini.writefloat('Zahlen','k.dy',k.dy);
    ini.writefloat('Zahlen','k.schreiben.x',k.schreiben.x);
    ini.writefloat('Zahlen','k.schreiben.y',k.schreiben.y);
    ini.writefloat('Zahlen','k.auftreffen.x',k.auftreffen.x);
    ini.writefloat('Zahlen','k.auftreffen.y',k.auftreffen.y);

    ini.writefloat('Zahlen','koor.x',koor.x);
    ini.writefloat('Zahlen','koor.y',koor.y);

    ini.WriteBool('Zahlen','rrechts',rrechts);
    //optio
  //Zufallsoptionen
    ini.writefloat('Zufallsoptionen','eingabe.optio.berechnungspausen',eingabe.optio.berechnungspausen);

    ini.WriteBool('Bildschirmoptionen der Zufallsoptionen',optio.RadioButton5.Caption,optio.RadioButton5.Checked);
    ini.WriteBool('Bildschirmoptionen der Zufallsoptionen',optio.RadioButton6.Caption,optio.RadioButton6.Checked);

    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox20.Caption,optio.CheckBox20.Checked);
    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox21.Caption,optio.CheckBox21.Checked);
    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox22.Caption,optio.CheckBox22.Checked);
    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox23.Caption,optio.CheckBox23.Checked);
    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox25.Caption,optio.CheckBox25.Checked);
    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox26.Caption,optio.CheckBox26.Checked);
    ini.writeBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox12.Caption,optio.CheckBox12.Checked);

    //optio
  //Optionen für die Berechnung
    //Anzeige
    ini.WriteInteger('Berechnungsoptionen','optio.Schieberegler',optio.Schieberegler.Position);
    ini.Writebool('Berechnungsoptionen',optio.Autoaktualisieren_aus.Caption,optio.Autoaktualisieren_aus.Checked);
    //Zoom
    ini.WriteInteger('Bildschirmoptionen','optio.Zoombar',optio.Zoombar.Position);
    ini.Writebool('Bildschirmoptionen','optio.Checkzoom',optio.Checkzoom.Checked);
    ini.Writefloat('Bildschirmoptionen','darstellungsradius',darstellungsradius);
    //Schrift
    ini.WriteBool('Berechnungsoptionen',optio.CheckBox3.Caption,optio.CheckBox3.Checked);
    ini.WriteBool('Berechnungsoptionen',optio.CheckBox2.Caption,optio.CheckBox2.Checked);
    ini.WriteBool('Berechnungsoptionen',optio.CheckBox4.Caption,optio.CheckBox4.Checked);
    ini.WriteBool('Berechnungsoptionen',optio.CheckBox5.Caption,optio.CheckBox5.Checked);
    //Pfeilgrösse
    ini.WriteBool('Berechnungsoptionen',optio.CheckBox1.Caption,optio.CheckBox1.Checked);
    ini.writeBool('Berechnungsoptionen',optio.RadioButton7.Caption,optio.RadioButton7.Checked);
    ini.writeBool('Berechnungsoptionen',optio.RadioButton8.Caption,optio.RadioButton8.Checked);
    ini.writeBool('Berechnungsoptionen',optio.RadioButton9.Caption,optio.RadioButton9.Checked);
    ini.WriteInteger('Berechnungsoptionen','optio.Pfeilgroesse.Position',optio.Pfeilgroesse.Position);
    //Umlaufsdauer/Winkelgeschwindigkeit
    ini.WriteBool('Berechnungsoptionen',optio.RadioButton3.Caption,optio.RadioButton3.Checked);
    ini.WriteBool('Berechnungsoptionen',optio.RadioButton4.Caption,optio.RadioButton4.Checked);
    //logbuch
    ini.WriteBool('Berechnungsoptionen','optio.CheckBoxLog3.checked',optio.CheckBoxLog3.checked);
    ini.WriteBool('Berechnungsoptionen','optio.CheckBoxLog1.checked',optio.CheckBoxLog1.checked);
    ini.WriteBool('Berechnungsoptionen','optio.CheckBoxLog2.checked',optio.CheckBoxLog2.checked);
    //farben
    ini.WriteInteger('Berechnungsoptionen',optio.Label7.Caption,optio.Spurfarbe.selected);
    ini.WriteInteger('Berechnungsoptionen',optio.Label8.Caption,optio.aussenfarbe.selected);
    ini.WriteInteger('Berechnungsoptionen',optio.Label9.Caption,optio.kreuzfarbe.selected);

  //Fensteroptionen
    if haupt.WindowState= wsMaximized then ini.WriteString('Fensteroptionen','WindowState','wsMaximized');
    if haupt.WindowState= wsNormal  then
      begin
      ini.WriteString('Fensteroptionen','WindowState','wsNormal');
      ini.WriteInteger('Fensteroptionen','haupt.Height',haupt.Height);
      ini.WriteInteger('Fensteroptionen','haupt.Width',haupt.Width);
      end;
  //benutzerinfos
    ini.WriteFloat('benutzerinfos','delta t',dt);

    ini.Free;
  except
    showmessage('Es konnte keine Einstellungsdatei erstellt werden!'+chr(13)+
          'Falls Sie Corioliskraft von CD Starten kopieren Sie bitte die Corioliskraft.exe auf ihre Festplatte und starten Sie erneut!');
  end;
end;





{-----------------------------------------------------------------------------
  Description:  Liest aus einer INI
  Procedure:    leseini
  Arguments:    pfad:string
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TTxt.leseini(pfad:string);
begin
  try
    if fileexists(pfad) then
      begin
      ini:=tinifile.Create(pfad);



      //Fensteroptionen
      if ini.ReadString('Fensteroptionen','WindowState','wsNormal')='wsMaximized' then  haupt.WindowState:=wsMaximized;
      if ini.ReadString('Fensteroptionen','WindowState','wsNormal')='wsNormal'  then
        begin
        haupt.WindowState:=wsnormal;
        haupt.Height:=ini.readInteger('Fensteroptionen','haupt.Height',haupt.Height);
        haupt.Width:=ini.readInteger('Fensteroptionen','haupt.Width',haupt.Width);
        end;


      //haupt
    //nun werden vie sachen wieder ausgelesen
    // die sieht so aus "Am Ende zurückdrehen=1"
      optio.zurueckdrehen.Checked:=ini.readBool('Bildschirmoptionen',optio.zurueckdrehen.Caption,true);
      haupt.CheckReibungsfaktor.Checked:=ini.readBool('Bildschirmoptionen',haupt.CheckReibungsfaktor.Caption,true);
      optio.Autopos.Checked:=ini.readBool('Bildschirmoptionen',optio.Autopos.Caption,true);

    {nun werden die Zahlen aus den Editen über Strings reingeschriben
     ich nehmen readsting und nicht readfloat da ich sonst sie erst umformen müsste
     beim auslesen mache ich es auch mit strings}
      haupt.EGeschwindigkeit.text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.kugelgeschwindigkeit',100));
      haupt.EScheibenradius.text:=floattostr(haupt.pixeltocm(ini.readfloat('Zahlen','eingabe.haupt.scheibenradius',200)));
      haupt.EAuftreffenx.text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.x', strtofloat(haupt.EScheibenradius.text) ));
      haupt.EAuftreffeny.text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.y',0));
      haupt.EUmlaufdauer.text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.umlaufdauer',2)); //Das mache ich nochmal bei radiobutton 3   4   damit nicht umgerechnet wird
      haupt.EReibung.Text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.reibungsfaktor',1));
                //ganz wichtig das der winkel nach den anderen feldern steht, da sonst der kreiszeichnen nicht zustande käme
      haupt.EWinkel.text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.winkel',0));
      eingabe.haupt.winkel:=ini.readfloat('Zahlen','eingabe.haupt.winkel',0);

      //variablen
      k.geschwindigkeit.geschwindigkeit:=ini.readfloat('Zahlen','k.geschwindigkeit.geschwindigkeit',100*200/22.5);
      k.Dx:=ini.readfloat('Zahlen','k.Dx',-200);
      k.Dy:=ini.readfloat('Zahlen','k.dy',0);
      k.schreiben.x:=ini.readfloat('Zahlen','k.schreiben.x',0);
      k.schreiben.y:=ini.readfloat('Zahlen','k.schreiben.y',0);
      k.auftreffen.x:=ini.readfloat('Zahlen','k.auftreffen.x',-200);
      k.auftreffen.y:=ini.readfloat('Zahlen','k.auftreffen.y',0);

      koor.x:=ini.readfloat('Zahlen','koor.x',-200);
      koor.y:=ini.readfloat('Zahlen','koor.y',0);

      rrechts:=ini.readBool('Zahlen','rrechts',true);
      //optio

    //Zufallsoptionen
      optio.Edit7.Text:=floattostr(ini.readfloat('Zufallsoptionen','eingabe.optio.berechnungspausen',1400));

      optio.RadioButton5.Checked:= ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.RadioButton5.Caption,true);
      optio.RadioButton6.Checked:= ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.RadioButton6.Caption,false);

      optio.CheckBox20.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox20.Caption,true);
      optio.CheckBox21.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox21.Caption,true);
      optio.CheckBox22.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox22.Caption,true);
      optio.CheckBox23.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox23.Caption,true);
      optio.CheckBox25.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox25.Caption,true);
      optio.CheckBox26.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox26.Caption,true);
      optio.CheckBox12.Checked:=ini.readBool('Bildschirmoptionen der Zufallsoptionen',optio.CheckBox12.Caption,true);
      //optio
    //Optionen für die Berechnung
      //Anzeige
      optio.Schieberegler.Position:=ini.ReadInteger('Berechnungsoptionen','optio.Schieberegler',4);
      eingabe.optio.schieberegler:=  optio.Schieberegler.Position;
      optio.Autoaktualisieren_aus.Checked:=ini.readbool('Berechnungsoptionen',optio.Autoaktualisieren_aus.Caption,false);
      //Zoom
      optio.Zoombar.Position:=ini.readInteger('Bildschirmoptionen','optio.Zoombar',optio.Zoombar.Position);
      optio.Checkzoom.Checked:=ini.readbool('Bildschirmoptionen','optio.Checkzoom',true);
      darstellungsradius:=ini.readfloat('Bildschirmoptionen','darstellungsradius',200);
      //Schrift
      optio.CheckBox3.Checked:=ini.readBool('Berechnungsoptionen',optio.CheckBox3.Caption,false);
      optio.CheckBox2.Checked:=ini.readBool('Berechnungsoptionen',optio.CheckBox2.Caption,true);
      optio.CheckBox4.Checked:=ini.readBool('Berechnungsoptionen',optio.CheckBox4.Caption,true);
      optio.CheckBox5.Checked:=ini.readBool('Berechnungsoptionen',optio.CheckBox5.Caption,true);
      //Pfeilgrösse
      optio.CheckBox1.Checked:=ini.readBool('Berechnungsoptionen',optio.CheckBox1.Caption,false);
      optio.RadioButton7.Checked:=ini.readBool('Berechnungsoptionen',optio.RadioButton7.Caption,true);
      optio.RadioButton8.Checked:=ini.readBool('Berechnungsoptionen',optio.RadioButton8.Caption,false);
      optio.RadioButton9.Checked:=ini.readBool('Berechnungsoptionen',optio.RadioButton9.Caption,false);
      optio.Pfeilgroesse.Position:=ini.readInteger('Berechnungsoptionen','optio.Pfeilgroesse.Position',5);
      eingabe.optio.pfeilgroesse:=  optio.Pfeilgroesse.Position;
      eingabe.optio.RadioButton7:=  optio.RadioButton7.checked;
      eingabe.optio.RadioButton8:=  optio.RadioButton8.checked;
      eingabe.optio.RadioButton9:=  optio.RadioButton9.checked;
      //Umlaufsdauer/Winkelgeschwindigkeit
                                //wichtig ist hier dass erst geschrieben wird und falls eine Umrechnung ansteht kann diese danach gemacht werden
      haupt.EUmlaufdauer.text:=floattostr(ini.readfloat('Zahlen','eingabe.haupt.umlaufdauer',2));
      optio.RadioButton3.Checked:=ini.readBool('Berechnungsoptionen',optio.RadioButton3.Caption,true);
      optio.RadioButton4.Checked:=ini.readBool('Berechnungsoptionen',optio.RadioButton4.Caption,false);
      //logbuch
      optio.CheckBoxLog3.checked:=ini.readBool('Berechnungsoptionen','optio.CheckBoxLog3.checked',false);
      optio.CheckBoxLog1.checked:=ini.readBool('Berechnungsoptionen','optio.CheckBoxLog1.checked',false);
      optio.CheckBoxLog2.checked:=ini.readBool('Berechnungsoptionen','optio.CheckBoxLog2.checked',false);
      //farben
      optio.Spurfarbe.Selected:=ini.readinteger('Berechnungsoptionen',optio.Label7.Caption,255);
      optio.aussenfarbe.Selected:=ini.readinteger('Berechnungsoptionen',optio.Label8.Caption,8388608);
      optio.kreuzfarbe.Selected:=ini.readinteger('Berechnungsoptionen',optio.Label9.Caption,32768);
      optio.SpurfarbeChange(nil);

      //verschiebe koordinaten für die darstellung
      verschieben.pos.x:=ini.readfloat('Bildschirmoptionen','verschieben.pos.x',0);
      verschieben.pos.y:=ini.readfloat('Bildschirmoptionen','verschieben.pos.y',0);

      ini.Free;
      end
    else
      begin
      if pfad=(ExtractFilePath(Application.ExeName)+'Einstellungen.ini') then
        begin
        haupt.standardwerte;
        schreibeini(pfad);

        if application.MessageBox('Hallo,'+chr(13)+'ich bitte dich jetzt die Hilfe zu lesen, weil ich weiss, dass du sonst nie lesen würdest.'+chr(13)+'Doch in der Hilfe Datei sind viele kleine Raffinessen erklärt die dir das Arbeiten mit diesem Programm erleichtern.'+chr(13)+'Ich habe sie kurz gehalten, damit es sich schnell durchlesen lässt.'
                                              ,'Erststart',mb_iconinformation+ mb_yesno) =6 then
          haupt.Hilfe1Click(nil);
        end
      //hier diese meldung kommt wenn ich die Ini datei von irgenwo lesen will und sie existiert garnicht
      //wenn es allerding die standart ini ist schreibt übergeht er diese einfach
      else showmessage('Datei existiert nicht');
      end;
  except
    showmessage('Es konnte keine Einstellungsdatei erstellt werden!'+chr(13)+
          'Falls Sie Corioliskraft von CD Starten kopieren Sie bitte die Corioliskraft.exe auf ihre Festplatte und starten Sie erneut!');
  end;
end;




{-----------------------------------------------------------------------------
  Description:  Schreibt immer weiter INIs
  Procedure:    schreibeLaufIni
  Arguments:    None
  Result:       None
  Detailed description:
      Die INIs sind mit Numemrn Buchstaben durchnummerriert
        Suche nach "inibuchstabe"
-----------------------------------------------------------------------------}
procedure TTxt.schreibeLaufIni;
var path:string;
begin
  path:=ExtractFilePath(Application.ExeName)+'Log-Dateien\';

  ForceDirectories(path);
  txt.schreibeini(path+inibuchstabe+inttostr(laufins)+'.ini');
  inc(laufins);
end;




{-----------------------------------------------------------------------------
  Description:  Schreibt dauern eine neue INi und löscht dann die letzte
  Procedure:    schreibe10Ini
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure TTxt.schreibe10Ini;
const zusatz='.letztes';
var path:string;
    i:integer;
begin
  path:=ExtractFilePath(Application.ExeName)+'Log-Dateien\';

  ForceDirectories(path);

  if FileExists(path+'10'+zusatz+'.ini') then
    DeleteFile(path+'10'+zusatz+'.ini');

  for i:=9 downto 1 do
    if FileExists(path+inttostr(i)+zusatz+'.ini') then
      txt.RenameFileEx(path+inttostr(i)+zusatz+'.ini'+ #0,path+inttostr(i+1)+zusatz+'.ini'+ #0);

  txt.schreibeini(path+'1'+zusatz+'.ini');
end;


end.
