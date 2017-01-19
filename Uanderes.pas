{-----------------------------------------------------------------------------
 Unit Name: Uanderes
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
-----------------------------------------------------------------------------}
unit Uanderes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,math,StdCtrls;



type
      Tsetofchar=set of char;

      Tanderes= class
        private
        public
          procedure zaehlefps;

          function bootostr(b:boolean):string;
          function boolUngleich(a,b:boolean):boolean;
          function boolGleich(a,b:boolean):boolean;

          procedure korrigiere(var s:String; const zeichen:Tsetofchar=['0'..'9','-',',']); overload;
          procedure korrigiere(var edit:Tedit; const zeichen:Tsetofchar=['0'..'9','-',',']); overload;
          procedure korrigiere(var r:real; const min,max:real);         overload;
          procedure korrigiere(var w:word; const min,max:word);         overload;
          function  ADialog(var return:integer; const cap,text:string; start,min,max:integer):boolean;    overload;
          function  ADialog(var return:string; const cap,text:string; zeichen:Tsetofchar=['0' .. '9',#22,#3,#8]):boolean;        overload;

          procedure Delay(msecs:integer);

          procedure arrayloeschen;
          function arraynichtleer:boolean;
          function berechnungsdauer:longint;
          function boolsign(a:boolean):shortint;

          function GetFileVersion(FileName: string): string;
      end;



var    anderes:Tanderes;


      //für fps
      fps:real;
      fpszeit1:longint;
      fpsbilder:integer;
implementation
uses unit1,berechnung;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    Delay
  Arguments:    msecs:integer
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tanderes.Delay(msecs:integer);
var
  FirstTickCount:longint;
begin
  FirstTickCount:=GetTickCount;
  repeat
  sleep(5);
  Application.ProcessMessages; {allowing access to other controls, etc.}
  until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;



{-----------------------------------------------------------------------------
  Description:
  Procedure:    arrayloeschen
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tanderes.arrayloeschen;
begin
  punkte:=nil;              //hier wird das Array alles gelöscht
  geradeaus:=nil;           //hier wird das Array alles gelöscht
end;


{-----------------------------------------------------------------------------
  Description:  Prüft ob array leer ist
  Procedure:    arraynichtleer
  Result:       boolean
-----------------------------------------------------------------------------}
function Tanderes.arraynichtleer:boolean;
begin
  result:=not  ((punkte=nil) or (geradeaus=nil));
end;


{-----------------------------------------------------------------------------
  Procedure:    berechnungsdauer
  Result:       longint
-----------------------------------------------------------------------------}
function Tanderes.berechnungsdauer:longint;
begin
  result:=(gettickcount-startzeitgesamt);
  if result=0 then result:=1;
end;



{-----------------------------------------------------------------------------
  Description:  Gibt den Werte eines Boolean als 1 oder -1 aus
  Procedure:    boolsign
  Arguments:    a:boolean
  Result:       shortint
  Detailed description:
-----------------------------------------------------------------------------}
function Tanderes.boolsign(a:boolean):shortint;
begin
  if a then
    result:=1
  else
    result:=-1;
end;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    bootostr
  Arguments:    b:boolean
  Result:       string
  Detailed description:
-----------------------------------------------------------------------------}
function Tanderes.bootostr(b:boolean):string;
begin
  //  if b then result:='Wahr' else result:='Falsch';
  //  if b then result:='True' else result:='False';
  if b then result:='Ja' else result:='Nein';
end;



{-----------------------------------------------------------------------------
  Description:  Vergleicht boolean  a<>b then true
  Procedure:    boolUngleich
  Arguments:    a,b:boolean
  Result:       boolean
  Detailed description:
-----------------------------------------------------------------------------}
function Tanderes.boolUngleich(a,b:boolean):boolean;
begin
  result:=true;                                              //Überprüfung durch überprüfung des Gegenteils
  if (a and b) or  (not(a) and not(b))  then result:=false;
end;

{-----------------------------------------------------------------------------
  Description:   a=b then true
  Procedure:    boolGleich
  Arguments:    a,b:boolean
  Result:       boolean
  Detailed description:
-----------------------------------------------------------------------------}
function Tanderes.boolGleich(a,b:boolean):boolean;
begin
  result:=false;                                              //Überprüfung durch überprüfung des Gegenteils
  if (a and b) or  (not(a) and not(b))  then result:=true;
end;



{-----------------------------------------------------------------------------
  Description:  FPS
  Procedure:    zaehlefps
  Arguments:    None
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tanderes.zaehlefps;
begin
//fps
fpsbilder:=fpsbilder+1;
if gettickcount-fpszeit1>100 then
  begin
  fps:=fpsbilder/(gettickcount-fpszeit1)*1000;
  fpszeit1:=gettickcount-1;
  fpsbilder:=0;
  end;
end;






{-----------------------------------------------------------------------------
  Description:  Löscht Zeichen die da nicht reinpassen
  Procedure:    korrigiere
  Arguments:    var s:String; const zeichen:Tsetofchar
  Result:       None
  Detailed description:
-----------------------------------------------------------------------------}
procedure Tanderes.korrigiere(var s:String; const zeichen:Tsetofchar=['0'..'9','-',',']);
var c : word;
begin
  c:=1;
  while c<= length(s) do
    begin
    if not(s[c] in zeichen)  then
      delete(s,c,1)
    else
      inc(c);
    end;
end;
{-----------------------------------------------------------------------------
  Description:  Direkt edite Korrigieren
  Arguments:    var edit:Tedit; const zeichen:Tsetofchar=['0'..'9','-',',']
-----------------------------------------------------------------------------}
procedure Tanderes.korrigiere(var edit:Tedit; const zeichen:Tsetofchar=['0'..'9','-',',']);
var s:string;
begin
  s:=edit.Text ;
  korrigiere(s,zeichen);
end;
{-----------------------------------------------------------------------------
  Description:  Korrigiere real Zahl
  Arguments:    var r:real; const max,min:real
-----------------------------------------------------------------------------}
procedure Tanderes.korrigiere(var r:real; const min,max:real);
begin
  if max<=min then exit;

  if r<min then r:=min;
  if r>max then r:=max;
end;
{-----------------------------------------------------------------------------
  Description:  Korrigiere Word Zahl
  Arguments:    var r:word; const max,min:word
-----------------------------------------------------------------------------}
procedure Tanderes.korrigiere(var w:word; const min,max:word);
begin
  if max<=min then exit;

  if w<min then w:=min;
  if w>max then w:=max;
end;


{-----------------------------------------------------------------------------
  Description:  Eingabedialog
  Procedure:    ADialog
  Arguments:    var return:integer; const cap,text:string; start,min,max:integer
  Result:       boolean
  Detailed description:
                Gibt true zurück wenn OK
                wenn Canel dann false

                überprüft ob das eine Integer Zahl und korrigier wenn nötig
-----------------------------------------------------------------------------}
function  Tanderes.ADialog(var return:integer; const cap,text:string; start,min,max:integer):boolean;
var temps:string;
    c:cardinal;
begin
  result:=false;
  temps:=inttostr(start);
  if dialogs.InputQuery(cap,text,temps) then
    begin
    result:=true;
    for c:=0 to length(temps) do
      if not(temps[c] in ['0' .. '9'])  then delete(temps,c,1);
    if temps='' then return:=0 else return:= strtoint(temps);
    if return>max then return:=max;
    if return<min then return:=min;
    end;
end;
{-----------------------------------------------------------------------------
  Description:  Gibt String zurück und prüft auf Zeichen
  Arguments:    var return:string; const cap,text:string; zeichen:Tsetofchar
-----------------------------------------------------------------------------}
function  Tanderes.ADialog(var return:string; const cap,text:string; zeichen:Tsetofchar=['0' .. '9',#22,#3,#8]):boolean;
var c:cardinal;
begin
  result:=false;
  if dialogs.InputQuery(cap,text,return) then
    begin
    result:=true;
    for c:=0 to length(return) do
      if not(return[c] in zeichen)  then delete(return,c,1);
    end;
end;




{-----------------------------------------------------------------------------
  Description:
  Procedure:    GetFileVersion
  Arguments:    FileName: string
  Result:       string
  Detailed description:
-----------------------------------------------------------------------------}
function Tanderes.GetFileVersion(FileName: string): string;
//var fi: TJclFileVersionInfo;
begin
//  fi:=TJclFileVersionInfo.Create(FileName);
//  try
//    result:=fi.FileVersion;
//  finally
//    fi.free;
//  end;
end;



end.
