{-----------------------------------------------------------------------------
 Unit Name: Corioliskraft
 Author:    Alexander Roth
 Date:      26-Mrz-2006
 Lizenshinweise:  Infos-->Lizensbedingungen
 Description:
-----------------------------------------------------------------------------}
program Corioliskraft;

uses
  Forms,
  Unit1 in 'Unit1.pas' {haupt},
  Unit2 in 'Unit2.pas' {about},
  Unit4 in 'Unit4.pas' {optio},
  Unit5 in 'Unit5.pas' {info},
  z in 'z.pas',
  berechnung in 'berechnung.pas',
  text in 'text.pas',
  Uanderes in 'Uanderes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Corioliskraft';
  Application.CreateForm(Thaupt, haupt);
  Application.CreateForm(Tabout, about);
  Application.CreateForm(Toptio, optio);
  Application.CreateForm(Tinfo, info);
  Application.Run;
end.
