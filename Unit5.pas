{-----------------------------------------------------------------------------
 Unit Name: Unit5
 Description:  Infofenster
 Author:    Alexander Roth
 This unit is licensed unter the GPL3
 This license note and the original author (Alexander Roth) must not be altered.
-----------------------------------------------------------------------------}
unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gauges;

type
  Tinfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label101: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label116: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label102: TLabel;
    Label117: TLabel;
    Label105: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label7: TLabel;
    Label25: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label29: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label43: TLabel;
    Label108: TLabel;
    Button2: TButton;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label120: TLabel;
    Label15: TLabel;
    Label123: TLabel;
    Label16: TLabel;
    Label124: TLabel;
    Button4: TButton;
    Label20: TLabel;
    Label125: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Button5: TButton;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label10: TLabel;
    Labelfps: TLabel;
    Label14: TLabel;
    Labelberechprosek: TLabel;
    Label34: TLabel;
    Labelberechprobild: TLabel;
    Label13: TLabel;
    Label121: TLabel;
    Button1: TButton;
    Button3: TButton;
    Label33: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Gauge121: TGauge;
    Gauge116: TGauge;
    Gauge114: TGauge;
    Gauge115: TGauge;
    Gauge117: TGauge;
    Gauge125: TGauge;
    Gauge112: TGauge;
    Gauge113: TGauge;
    Label40: TLabel;
    Gauge130: TGauge;
    Label130: TLabel;
    Gauge120: TGauge;
    Gauge105: TGauge;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  info: Tinfo;

implementation

uses Unit1,text;

{$R *.dfm}


procedure Tinfo.Button2Click(Sender: TObject);
begin
  haupt.BAbbrechen.Click;
end;

procedure Tinfo.Button1Click(Sender: TObject);
begin
  haupt.BBerechnen.Click;
end;

procedure Tinfo.Button3Click(Sender: TObject);
begin
  haupt.Starten1Click(nil);
end;

procedure Tinfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  haupt.FormKeyDown(sender,key,shift);
end;

procedure Tinfo.Button2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  info.FormKeyDown(nil,key,shift);
end;

procedure Tinfo.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
info.FormKeyDown(nil,key,shift);
end;

procedure Tinfo.Button3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  info.FormKeyDown(nil,key,shift);
end;

procedure Tinfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  txt.schreibeini(ExtractFilePath(Application.ExeName)+'Einstellungen.ini');
end;

procedure Tinfo.Button4Click(Sender: TObject);
begin
  info.Close;
end;

procedure Tinfo.Button5Click(Sender: TObject);
begin
  haupt.BPause.Click;
end;

procedure Tinfo.FormShow(Sender: TObject);
begin
  info.Left:=0;
  info.top:=0;
end;

end.
