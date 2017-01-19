object about: Tabout
  Left = 230
  Top = 170
  BorderStyle = bsDialog
  Caption = 'Information zu Corioliskraft'
  ClientHeight = 465
  ClientWidth = 625
  Color = clMenu
  TransparentColorValue = clNavy
  Constraints.MaxHeight = 492
  Constraints.MaxWidth = 633
  Constraints.MinHeight = 492
  Constraints.MinWidth = 633
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object TabSheetControl: TPageControl
    Left = 0
    Top = 0
    Width = 625
    Height = 465
    ActivePage = Information
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Information: TTabSheet
      Caption = 'Information'
      object Memo1: TMemo
        Left = 0
        Top = 4
        Width = 617
        Height = 433
        BorderStyle = bsNone
        Color = clBtnFace
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Dies ist ein Freewareprogramm.'
          'Unver'#228'nderte Ver'#246'ffentlichungen sind erw'#252'nscht.'
          ''
          'Wir danken Ihnen f'#252'r ihr Interesse.'
          ''
          
            'Dieses Programm wurde f'#252'r eine Jugend-Forscht-Arbeit entwickelt,' +
            ' welche '
          
            'eine Gemeinschaftsarbeit von Alexander Roth, Andreas Mock und St' +
            'ephan Kr'#246'ger ist.'
          'Programmiert wurde die Software von Alexander Roth.'
          
            'Durch die Jugend-Forscht-Arbeit und dieses Programm haben wir de' +
            'n 1. Preis im Fach '
          
            'Physik auf Regional- und auf Landesebene in Rheinland-Pfalz gewo' +
            'nnen.'
          
            'Bei der Preisverleihung auf Bundesebene erhielten wir den Preis ' +
            'der Deutschen '
          'Physikalischen Gesellschaft.'
          ''
          'Diese Komponenten/Units benutze ich in meinem Programm:'
          '- Jedi Komponenten'
          '- Indy Komponenten'
          'Einen riesigen Dank den Autoren'
          ''
          'Kontakt:'
          'roth-a@gmx.de')
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnDblClick = Memo1DblClick
      end
    end
    object Links: TTabSheet
      Caption = 'Links'
      ImageIndex = 1
      object Label2: TLabel
        Left = 224
        Top = 232
        Width = 147
        Height = 24
        Caption = 'Jugend Forscht'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Homepage: TLabel
        Left = 176
        Top = 88
        Width = 224
        Height = 20
        Cursor = crHandPoint
        Caption = 'Meine Homepage besuchen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = HomepageClick
      end
      object jugendforscht: TLabel
        Left = 208
        Top = 280
        Width = 183
        Height = 20
        Cursor = crHandPoint
        Caption = 'www.jugend-forscht.de'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = jugendforschtClick
      end
      object jugendforschtrlp: TLabel
        Left = 200
        Top = 328
        Width = 209
        Height = 20
        Cursor = crHandPoint
        Caption = 'www.jugend-forscht-rlp.de'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = jugendforschtrlpClick
      end
      object Label1: TLabel
        Left = 272
        Top = 32
        Width = 49
        Height = 24
        Caption = 'Links'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object EmailKontakt: TLabel
        Left = 200
        Top = 136
        Width = 199
        Height = 20
        Cursor = crHandPoint
        Caption = 'Email an Alexander Roth'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        OnClick = EmailKontaktClick
      end
      object Label3: TLabel
        Left = 184
        Top = 376
        Width = 245
        Height = 20
        Cursor = crHandPoint
        Caption = 'jugendforscht.fiz-karlsruhe.de/'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = Label3Click
      end
    end
    object TabLizenz: TTabSheet
      Caption = 'Lizenzbedingungen'
      ImageIndex = 2
      object Memo3: TMemo
        Left = 0
        Top = 200
        Width = 617
        Height = 233
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Corioliskraft '#8211' Endbenutzer-Lizenzvereinbarungen'
          ''
          
            'Lesen Sie diese Lizenzvereinbarungen sorgf'#228'ltig, bevor Sie das P' +
            'rogramm '
          'Corioliskraft installieren oder in anderer Form '
          
            'darauf zugreifen. Sie m'#252'ssen dieser Lizenz zustimmen, wenn Sie C' +
            'orioliskraft '
          'verwenden wollen.'
          ''
          '1. Lizenzstatus, Inhaberschaft'
          
            'Corioliskraft geht nicht in Ihren Besitz '#252'ber, sondern wird lize' +
            'nziert. Corioliskraft ist '
          'durch das Urheberrecht gesch'#252'tzt. '
          
            'Das Eigentum und alle geistigen Schutzrechte an Corioliskraft so' +
            'wie der '
          'm'#246'glicherweise enthaltenen Dokumentation und aller '
          
            'ihrer Bestandteile verbleiben bei dem Hersteller Alexander Roth.' +
            ' Der Lizenznehmer '
          'erkennt diese Eigentums- und Schutzrechte '
          'an.'
          ''
          '2. Lizenzeinr'#228'umung'
          
            'Der Hersteller gew'#228'hrt Ihnen unter der Voraussetzung, dass Sie a' +
            'lle Punkte dieser '
          'Vereinbarung einhalten, das Recht, '
          
            'Corioliskraft f'#252'r ausschlie'#223'lich private und nicht gewerbliche Z' +
            'wecke frei zu nutzen. '
          'Dieses Recht umfasst die folgende '
          'Rechte und Einschr'#228'nkungen:'
          
            '* Installation, Verwendung. Sie sind berechtigt, Corioliskraft a' +
            'uf einer beliebigen '
          'Anzahl Ihrer Computer zu installieren und '
          'zu verwenden.'
          
            '* Weitergabe, Vertrieb. Eine Weitergabe von Corioliskraft an Dri' +
            'tte ist zul'#228'ssig, sofern '
          'sie unter Ber'#252'cksichtigung dieser '
          
            'Lizenzvereinbarungen verl'#228'uft und Corioliskraft in unver'#228'ndertem' +
            ' Zustand '
          'weitergegeben wird. Corioliskraft darf nicht gegen '
          'Geb'#252'hren jeglicher '
          
            'Art vertrieben werden, au'#223'er zum Selbstkostenpreis. Corioliskraf' +
            't darf nicht vermietet '
          'werden. Die Ver'#246'ffentlichung von '
          
            'Corioliskraft in einem anderen Medium als dem Internet bedarf de' +
            'r Genehmigung des '
          'Herstellers.'
          
            '* Zur'#252'ckentwicklung. Corioliskraft darf keiner Form von Zur'#252'cken' +
            'twicklung (Reverse '
          'Engineering), Dekompilierung oder '
          'Disassemblierung unterzogen werden.'
          
            '* K'#252'ndigung. Diese Lizenz gilt auf unbestimmte Zeit und ist so l' +
            'ange g'#252'ltig bis sie '
          'widerrufen wird. Sie k'#246'nnen die Lizenz '
          
            'jederzeit beendigen, indem Sie alle Kopien von Corioliskraft ver' +
            'nichten. Diese Lizenz '
          'endet unverz'#252'glich, ohne dass es einer '
          
            'expliziten K'#252'ndigung des Herstellers bedarf, wenn Sie gegen dies' +
            'e '
          'Lizenzvereinbarungen versto'#223'en. Bei Beendigung der Lizenz '
          
            'sind Sie verpflichtet alle Kopien von Corioliskraft zu vernichte' +
            'n.'
          
            '* Versionen. Diese Lizenz gilt f'#252'r alle Versionen (auch die vorh' +
            'erigen) des Programms '
          'Corioliskraft. '
          ''
          ''
          '3. Gew'#228'hrleistungsausschluss'
          
            'Der Hersteller erhebt keine Lizenzgeb'#252'hr f'#252'r diese Version von C' +
            'orioliskraft. Daher '
          'wird Ihnen Corioliskraft ohne jede '
          
            'Gew'#228'hrleistung zur Verf'#252'gung gestellt. Keine Gew'#228'hrleistung wird' +
            ' insbesondere f'#252'r '
          'die Sach- und Rechtsm'#228'ngelfreiheit von '
          
            'Corioliskraft '#252'bernommen. Sie benutzen Corioliskraft in Hinsicht' +
            ' auf Qualit'#228't und '
          'Funktion auf eigene Gefahr. Sollten Ihnen '
          
            'durch Corioliskraft nachweislich Sch'#228'den irgendwelcher Art entst' +
            'ehen, tr'#228'gt der '
          'Lizenzgeber keine etwaigen Kosten. '
          
            'Corioliskraft ist auf Virenfreiheit '#252'berpr'#252'ft worden. Dennoch '#252'b' +
            'ernimmt der Hersteller '
          'keine Gew'#228'hrleistung f'#252'r die Freiheit '
          
            'von Viren. Sie sind deshalb aufgefordert, Corioliskraft selbst a' +
            'uf Virenfreiheit zu '
          #252'berpr'#252'fen, bzw. Corioliskraft auf eigene '
          
            'Gefahr zu nutzen. Dieser Ausschluss der Gew'#228'hrleistung stellt ei' +
            'nen wesentlichen Teil '
          'der Lizenzvereinbarungen dar. Wenn Sie '
          
            'sich mit diesem Gew'#228'hrleistungsausschluss nicht einverstanden er' +
            'kl'#228'ren, ist Ihnen die '
          'Nutzung von Corioliskraft untersagt.'
          '')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Memo2: TMemo
        Left = 0
        Top = 8
        Width = 609
        Height = 185
        Alignment = taCenter
        BorderStyle = bsNone
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'Dies ist ein Freeware-Programm.'
          ''
          'Ver'#246'ffentlichungen und unver'#228'nderte Vervielf'#228'ltigungen '
          'sind ausdr'#252'cklich erw'#252'nscht.'
          ''
          'Alle Rechte sind dem Programmierer Alexander Roth vorbehalten.'
          'F'#252'r Sch'#228'den wird nicht gehaftet.'
          'Jegliche Ver'#228'nderung des Programms ist untersagt.'
          'Genaue Lizenzdetails finden Sie in dem unten aufgef'#252'hrten Feld.'
          ''
          'Viel Spass mit dem Programm.')
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
    object TabUpdate: TTabSheet
      Caption = 'Updates'
      ImageIndex = 3
      object LInternetState: TLabel
        Left = 16
        Top = 112
        Width = 585
        Height = 41
        AutoSize = False
        Caption = 'Bitte checke ob ein Update vorhanden ist'
        WordWrap = True
      end
      object LHomepage: TLabel
        Left = 24
        Top = 200
        Width = 232
        Height = 36
        Cursor = crHandPoint
        Caption = 'www.roth.22o.de'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -32
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        Visible = False
        OnClick = HomepageClick
      end
      object Label4: TLabel
        Left = 16
        Top = 345
        Width = 593
        Height = 65
        AutoSize = False
        Caption = 
          'Du hast einen Fehler entdeckt?  Es w'#228're sehr freundlich, wenn du' +
          ' mir eine kurze E-Mail schreiben w'#252'rdest in der mir das Problem ' +
          'beschreibst. Ich versuche dann diesen Fehler so schnell wie m'#246'gl' +
          'ich zu beheben.'
        WordWrap = True
      end
      object Label5: TLabel
        Left = 376
        Top = 384
        Width = 103
        Height = 19
        Cursor = crHandPoint
        Caption = 'roth-a@gmx.de'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        OnClick = EmailKontaktClick
      end
      object BCheckUpdate: TButton
        Left = 16
        Top = 48
        Width = 273
        Height = 33
        Caption = 'Pr'#252'fen ob Update vorhanden'
        TabOrder = 0
        OnClick = BCheckUpdateClick
      end
    end
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 556
    Top = 3
  end
end
